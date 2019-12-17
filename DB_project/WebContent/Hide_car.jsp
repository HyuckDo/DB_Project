<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>관리자 페이지</title>
</head>
<body>
<h2>관리자 페이지 - 차량 숨기기 관리</h2>
	<hr>
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
	<select name="hide_type">
		<option value="hide"> 차량 숨기기 </option>
		<option value="reveal"> 차량 드러내기 </option>
	</select>
	차량번호:<input type="text" name="vehicle_number">  
	이유: <input type="text" name="reason">  
	<input type="submit">
	</form>
	
<%
	String number = request.getParameter("vehicle_number");
	String reason = request.getParameter("reason");
	String hide_type = request.getParameter("hide_type");
	if(hide_type != null && !hide_type.equals("") && number != null && !number.equals("")){
		StringBuffer sb = new StringBuffer();
		try{
			if(hide_type.equals("hide"))
			{
				if(reason != null) {
					sb.append("INSERT INTO HIDEN_LIST VALUES(\'"+number+"\', \'"+reason + "\')");
				}
				else {
					sb.append("INSERT INTO HIDEN_LIST VALUES(\'"+number+"\', null)");
				}
			}
			else if(hide_type.equals("reveal"))
			{
				sb.append("DELETE FROM HIDEN_LIST WHERE VEHICLE_NUMBER = '"+ number + "'");
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