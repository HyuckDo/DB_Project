<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>
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
	
	
	String id = request.getParameter("Id");
	String pw = request.getParameter("Pw");
	String te = request.getParameter("phone1")+"-"+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	String nm = request.getParameter("Name");
	String jo = request.getParameter("job");
	String ad = request.getParameter("address");
	String bd = request.getParameter("bdate1")+"-"+request.getParameter("bdate2")+"-"+request.getParameter("bdate3");
	String se = request.getParameter("sex");
	String bd1 = request.getParameter("bdate1");
	String bd2 = request.getParameter("bdate2");
	String bd3 = request.getParameter("bdate3");
	String err_msg = null;
	if(id.length() < 3 || pw.length() < 3 || nm.length() < 1 || te.length() < 10){%>
		<script>alert("�ߺ��Ǵ� ���̵� �ų� ���ǿ� �������� �ʽ��ϴ�."); window.history.back();</script>
		<% 
	 }

	else {
		String query = "SELECT id from ACCOUNT where ID =" + "'"+request.getParameter("Id")+"'";
		
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery(query);
		try {
			
			if(jo.length() == 0 || ad.length() == 0 || bd.length() < 3 || se.length() == 0) {
			query = "insert into account values('"+id+"', '"+pw+"', '"+nm+"', '"+te+"', '"+jo+"', '"+ad+"', '', 1, '"+se+"')";
			
		}
		else {
			query = "insert into account values('"+id+"', '"+pw+"', '"+nm+"', '"+te+"', '"+jo+"', '"+ad+"', '"+bd+"', 2, '"+se+"')";
		
		}
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery(query);%>
		
		<script>alert("ȸ�������� �Ϸ� �Ǿ����ϴ�.");
		location.href = "unlogin_main.html";</script>
		<%
		}catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());%>
			<script>alert("���̵� �ߺ� �ǰų� ��Ŀ� ���� �ʽ��ϴ�."); window.history.back(); </script> 
		<%
		}
	}




   	
   	conn.close();

	%>
</body>
</html>