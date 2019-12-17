<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내정보</title>
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
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		Cookie c = cookies[0];
		String id = c.getValue();
	}
	   String query = "SELECT * from ACCOUNT where ID =" + "'"+request.getParameter("id")+"'";
      
   	System.out.println(query);
	pstmt = conn.prepareStatement(query);
   	rs = pstmt.executeQuery(query);
    rs.next();
	String pw = rs.getString(2);
	String nm=rs.getString(3);
	String te=rs.getString(4);
	String jo=rs.getString(5);
	String ad=rs.getString(6);
	String bd=rs.getString(7);
	String cl=rs.getString(8);
	String se=rs.getString(9);
	   

 
   	if((request.getParameter("id")).equals(rs.getString(1)) && (request.getParameter("pw")).equals(rs.getString(2))) 
   	{
   		

   	
   	rs.close();
   	pstmt.close();
   	conn.close();

	%>

</body>
</html>