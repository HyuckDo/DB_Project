<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import = "java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �����ϱ�</title>
</head>
<body>
	
	<form action = "main.html" method = "POST">
   	
	<input type = "submit" value = "Ȩ���� ����"/>

	</form>
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
	// ���� ���� ��¥ �߰�
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
		
	
	//�Է��� ���� ��ȣ ���� �Ǵ�
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
			alert("������ȣ�� �߸� �Է��Ͽ��ų� �Ǹ� ���� ������ �ƴմϴ�.");
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
				//	+ AccId + "', '"
					+ "sdlkjlk123" + "', '"	
					+ vehicle_number + "', '"
					+ today + "'"
					+ ")";
			
			int res = pstmt.executeUpdate(sql);
			System.out.println(res);
			
			
			if(res == 1) {
%>
				<script>
					alert("������ ���������� ���ŵǾ����ϴ�.");
					location.href="main.html";
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