<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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

String id = request.getHeader("Cookie");
String sql;
String cl;
if(id != null){
	Cookie[] cookies = request.getCookies();
	for(Cookie c:cookies)
		if(c.getName().equals("ID")){
			
			id = c.getValue();
		}
	sql = "select Class from ACCOUNT where ID = '" + id + "'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.next();
	cl = rs.getString(1);
	
	if(cl.equals("0")) {
		sql = "select count(Class) from ACCOUNT where Class = '"+0+"'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
		rs.next();
		String num = rs.getString(1);
			if(num.contentEquals("1")) {%>
				<script>alert("�����ڰ� 1���̹Ƿ� ���� �� �� �����ϴ�.");
				window.history.back();</script>
			<%}
		}
	else{
		sql = "Delete from ACCOUNT where ID = '"+id+"'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		%>
		<script>alert("ȸ��Ż�� �Ͽ����ϴ�.");
		location.href = "unlogin_main.html";</script>
	<%}

}
%>
</body>
</html>