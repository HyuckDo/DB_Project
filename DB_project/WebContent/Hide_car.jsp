<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date" %>
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
	String url ="jdbc:oracle:thin:@" + serverIP +":" + portNum + ":" + strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
%>
	<form>
	차량번호:<input type="text" name="vehicle_number"><br />
	이유: <input type="text" name="reason"><br />
	<input type="submit">
	</form>
	
<%
	String number = request.getParameter("vehicle_number");
	String reason = request.getParameter("reason");
	if(number != null && !number.equals("")){
		StringBuffer sb = new StringBuffer();
		try{
			if(reason != null) {
				sb.append("INSERT INTO HIDEN_LIST VALUES(\'"+number+"\', \'"+reason + "\')");
			}
			else {
				sb.append("INSERT INTO HIDEN_LIST VALUES(\'"+number+"\', null)");
			}
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(sb.toString());
			conn.commit();
		}	
		catch(SQLException e){
			System.out.println(e.toString());
			conn.rollback();
		}
		finally{
			conn.setAutoCommit(true);
		}
	}

%>
</body>
</html>