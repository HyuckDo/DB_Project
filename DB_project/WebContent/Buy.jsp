<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import = "java.util.*, java.text.*" %>
<%@ page import = "java.net.*" %>





<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>차량 구매하기</title>
</head>
<body>
	
<%
 	//쿠키 값
	String user_id = request.getHeader("Cookie");
	
	if(user_id != null){
	   Cookie[] cookies = request.getCookies();
	   for(Cookie c:cookies)
	      if(c.getName().equals("ID")){
	         
	    	  user_id = c.getValue();
	      }
	}
	
%>	
	
	
<%
	
	//lab server
	String serverIP = "155.230.36.61";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "s2011097047";
	String pass = "2011097047";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	PreparedStatement pstmt;
	ResultSet rs;
	
	
    SimpleDateFormat Bnum = new SimpleDateFormat("yyMMdd");
    SimpleDateFormat Bdat = new SimpleDateFormat("yyyy-MM-dd");

%>
	
<%	
	// 차량 구매 날짜 추가
	String Bnumber = null;
	String today = Bnum.format(new java.util.Date());
	String c_vehicle_number = null;
	
	String sql = "SELECT COUNT(*) FROM BUY WHERE BUY.Bdate = '" + today +"'";
	
	String vehicle_number = request.getParameter("Vehicle_Number");
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	
	while(rs.next()) {
		int count = rs.getInt(1);	
		
		Bnumber = today + Integer.toString(count+1);	
	}
		
	
	//입력한 차량 번호 유무 판단
	sql = "SELECT COUNT(*) "
			+ "FROM VEHICLE, "
			+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S "
			+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
			+ "AND S.Vehicle_Number = '" + vehicle_number +"' ";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	while(rs.next()) {
		
		int count = rs.getInt(1);
		System.out.println(count);
		
		if(count == 0){
				
%>
		<script>
			alert("차량번호를 잘못 입력하였거나 판매 중인 차량이 아닙니다.");
			history.go(-1);
		</script>
<%		
		}
	}
	
	sql = "SELECT S.Vehicle_Number "
			+ "FROM VEHICLE, "
			+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S "
			+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
			+ "AND S.Vehicle_Number = '" + vehicle_number +"' ";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	
	while(rs.next()) {
	
	
		c_vehicle_number = rs.getString(1);
	
		if(c_vehicle_number.equals(vehicle_number) == true) {
			sql = "INSERT INTO BUY VALUES('" + Bnumber + "', '"
					+ user_id + "', '"
					+ vehicle_number + "', '"
					+ today + "'"
					+ ")";
			int res = 0;
			try
			{
				String lock = "lock table buy in exclusive mode";
				conn.setAutoCommit(false);
				pstmt.execute(lock);
				res = pstmt.executeUpdate(sql);
				System.out.println(res);
				conn.commit();
			}
			catch(SQLException e)
			{
				conn.rollback();
				System.out.println(e.toString());
				%>
				<script>
					alert("이미 구매 되었거나 로그인이 필요합니다.");
					history.go(-1);
				</script>
<%
				
			}
			finally{
				conn.setAutoCommit(true);
			}
			
			
			if(res == 1) {
%>
				<script>
					alert("차량이 성공적으로 구매되었습니다.");
					location.href="login_main.html";
				</script>
<%
			}
			
		}
	}
	
	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
</body>
</html>