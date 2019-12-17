<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date, java.util.Calendar, java.util.GregorianCalendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>성별 차량 추천</title>
</head>
<body>

<%
	String user_id = request.getHeader("Cookie");
	
	if(user_id != null){
	   Cookie[] cookies = request.getCookies();
	   for(Cookie c:cookies)
	      if(c.getName().equals("ID")){
	         
	    	  user_id = c.getValue();
	      }
	}
	
	System.out.println(user_id);
%>


	<h2>회원 차량 추천</h2>
	<br><hr>
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
%>

	<form action = "SearchRecommend.jsp" method = "POST">
	Brand Name :
	<select name="Brand_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Brand_Name FROM MAKE GROUP BY Brand_Name ORDER BY Brand_Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Brand_Name = rs.getString(1);
     %>
     <option value="<%=Brand_Name%>"><%=Brand_Name%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>

	Model Name :
	<select name="Model_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Model_Name, Bname FROM MODEL ORDER BY Bname";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Model_Name = rs.getString(1);
        String BName = rs.getString(2);
     %>
     <option value="<%=Model_Name%>"><%=Model_Name%>(<%=BName%>)</option>
     
     <%
      	}
 
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>

	Detailed Model Name :
	<select name="Detailed_Model_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Detailed_Model_Name, Mname FROM DETAILED_MODEL ORDER BY Mname";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Detailed_Model_Name = rs.getString(1);
        String Mname= rs.getString(2);
     %>
     <option value="<%=Detailed_Model_Name%>"><%=Detailed_Model_Name%>(<%=Mname%>)</option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
	
	<input type = "submit" value = "차량 검색하기"/>
	
	</form>

<%
	String sex = null;
	Date date = new Date();
	String sql_id = "SELECT SEX, Bdate FROM ACCOUNT WHERE ID='"+user_id +"'";
	
	
	pstmt = conn.prepareStatement(sql_id);
	rs = pstmt.executeQuery();
	while(rs.next()){
		
		sex = rs.getString(1);
		date = rs.getDate(2);
	}
	int age;
	Calendar birth = new GregorianCalendar();
	Calendar today = new GregorianCalendar();
	
	
	birth.setTime(date);
	today.setTime(new Date());
	
	int factor =0;
	if( today.get(Calendar.YEAR) < birth.get(Calendar.YEAR) ){
		factor = -1;
	}
	
	age = today.get(Calendar.YEAR) - birth.get(Calendar.YEAR) + factor;
	int ma_age = age/10 * 10;
	
	System.out.println(sex);
	
	if(sex.equals("F")){
		
	
%>



	<br><br>
	<h2>여성 고객이 가장 많이 구매한 차량 순위</h2>

<%	
	//판매중인 모든 차량의 정보 출력
	String sql = "SELECT vehicle.brand_name, vehicle.Mname, vehicle.DMname, COUNT(*) "
			+ "FROM VEHICLE, BUY, ACCOUNT "
			+ "WHERE vehicle.vehicle_number = buy.vehicle_number AND account.id = buy.accid AND account.bdate is not null AND "
			+ "TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), account.bdate)/12) < " + Integer.toString((ma_age + 10)) +" AND "
			+ "TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), account.bdate)/12) >= " + Integer.toString(ma_age) + " AND "
			+ "account.sex is not null AND account.sex = 'F' "
			+ "GROUP BY vehicle.brand_name, vehicle.Mname, vehicle.DMname ORDER BY COUNT(*) desc";
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");

	
	out.println("<th>" + "Ranking" + "</th>");
	out.println("<th>" + "Brand Name" + "</th>");
	out.println("<th>" + "Model Name" + "</th>");
	out.println("<th>" + "Dtail Name" + "</th>");
	/*
	for(int i=1; i<= cnt; i++){
			
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	*/
	
	int number =1;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + number + "</td>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");

		out.println("</tr>");
			
		number++;
	}
	out.println("</table>");
		
	
	
	}
	else if(sex.equals("M")){
		
	
%>	
	<br><br>
	
<h2>남성 고객이 가장 많이 구매한 차량 순위</h2>


<%	


	//판매중인 모든 차량의 정보 출력
	String sql = "SELECT vehicle.brand_name, vehicle.Mname, vehicle.DMname, COUNT(*) "
			+ "FROM VEHICLE, BUY, ACCOUNT "
			+ "WHERE vehicle.vehicle_number = buy.vehicle_number AND account.id = buy.accid AND account.bdate is not null AND "
			+ "TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), account.bdate)/12) < " + Integer.toString((ma_age + 10)) +" AND "
			+ "TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), account.bdate)/12) >= " + Integer.toString(ma_age) + " AND "
			+ "account.sex is not null AND account.sex = 'M' "
			+ "GROUP BY vehicle.brand_name, vehicle.Mname, vehicle.DMname ORDER BY COUNT(*) desc";
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	out.println("<table border=\"1\">");

	
	out.println("<th>" + "Ranking" + "</th>");
	out.println("<th>" + "Brand Name" + "</th>");
	out.println("<th>" + "Model Name" + "</th>");
	out.println("<th>" + "Dtail Name" + "</th>");
	/*
	for(int i=1; i<= cnt; i++){
			
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	*/
	
	int number2 =1;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + number2 + "</td>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		
		out.println("</tr>");
			
		number2++;
	}
	out.println("</table>");
	
	

	}
	


	rs.close();
	pstmt.close();
	conn.close();

%>		
	
	
	
</body>
</html>