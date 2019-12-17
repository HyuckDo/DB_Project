<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>COMP322: Introduction to Databases</title>
</head>
<body>

	<%
		String serverIP = "155.230.36.61";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "s2011097047";
		String pass = "2011097047";
		String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		
		
	%>
	
   
	<%   
	   String query = "SELECT id,password,Class from ACCOUNT where ID =" + "'"+request.getParameter("id")+"'";
      
   	System.out.println(query);
	pstmt = conn.prepareStatement(query);
   	rs = pstmt.executeQuery(query);
    rs.next();
	String id = rs.getString(1);
    String cl = rs.getString(3);
	%>   

	<%
   	if((request.getParameter("id")).equals(rs.getString(1)) && (request.getParameter("pw")).equals(rs.getString(2))) 
   	{%>
   		<%  Cookie UserId = null;
   			UserId = new Cookie("ID", id);
   			UserId.setMaxAge(12*60*60);
   			UserId.setPath("/");
   		%>
   		   		<script>location.href = "login_main.html"; </script>
   	<%} else {%>
   		<script>alert('아이디 혹은 비밀번호가 틀립니다.'); window.history.back();</script>
   	<% }%>
   	
   

	<%  

   	
   	rs.close();
   	pstmt.close();
   	conn.close();

	%>

</body>
</html>