<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������</title>
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
	
	<form action = "change_info.jsp" method="post">
	
	
	

	<%
	String pw="";
	String nm="";
	String te="";
	String jo="";
	String ad="";
	String bd="";
	String cl="";
	
	String id = request.getHeader("Cookie");
	
	if(id != null){
		Cookie[] cookies = request.getCookies();
		for(Cookie c:cookies)
			if(c.getName().equals("ID")){
				
				id = c.getValue();
			}
		String query = "SELECT * from ACCOUNT where ID =" + "'"+ id +"'";
	
	   
      
   	
	pstmt = conn.prepareStatement(query);
   	rs = pstmt.executeQuery(query);
    rs.next();
    id = rs.getString(1);
	pw = rs.getString(2);
	nm=rs.getString(3);
	te=rs.getString(4);
	jo=rs.getString(5);
	ad=rs.getString(6);
	bd=rs.getString(7);
	
	if(jo == null){
		jo="";
	}
	if(ad == null){
		ad="";
	}
	if(bd == null){
		bd="";
	}
	
	}
%>

		
	
	���̵�:<input type ="text" name = "id" value = "<%=id%>"><br>
	��й�ȣ:<input type ="text" name = "pass"><br>
	�̸�:<input type ="text" name = "name" value = <%=nm%>><br>
	��ȭ��ȣ:<input type ="text" name = "tell" value = <%=te%>><br>
	����:<input type ="text" name = "job" value = <%=jo%>><br>
	�ּ�:<input type ="text" name = "address" value = <%=ad%>><br>
	�������<input type ="text" name = "date" value = <%=bd%>><br>
	
	


	<input type ="submit" value = "�����ϱ�"><br>

 </form>


<% 	
 
   	conn.close();

	%>

</body>
</html>