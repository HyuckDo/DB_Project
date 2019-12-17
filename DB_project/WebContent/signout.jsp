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
				<script>alert("관리자가 1명이므로 삭제 할 수 없습니다.");
				window.history.back();</script>
			<%}
		}
	else{
		sql = "Delete from ACCOUNT where ID = '"+id+"'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		%>
		<script>alert("회원탈퇴 하였습니다.");
		location.href = "unlogin_main.html";</script>
	<%}

}
%>
</body>
</html>