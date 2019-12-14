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
	<h2>관리자 페이지 - 숨겨진 차량 열람</h2>
	<hr>
	<%
		String serverIP = "155.230.36.61";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "s2011097047";
		String pass = "2011097047";
		String url ="jdbc:oracle:thin:@" + serverIP +":" + portNum + ":" + strSID;
		
		Connection conn = null;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		
		ResultSet rs = null;
		
		out.println("<table border=\"1\">");
		out.println("<caption>숨겨진 차량</caption>");
		try{
			StringBuffer sb = new StringBuffer();
			sb.append("SELECT V.VEHICLE_NUMBER, V.MNAME, V.DMNAME, S.ACCID, S.SDATE FROM HIDEN_LIST H, VEHICLE V, SELL S WHERE\n");
			sb.append("V.VEHICLE_NUMBER = S.VEHICLE_NUMBER AND V.VEHICLE_NUMBER = H.VEHICLE_NUMBER");
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(sb.toString());
			ResultSetMetaData rsmd = rs.getMetaData();	
			int columns = rsmd.getColumnCount();
			
			for(int i = 1; i<=columns; i++) {
				out.println("<th>" + rsmd.getColumnName(i)+"</th>");
			}
			while(rs.next()) {
				out.println("<tr>");
				for(int i = 1; i<=columns; i++)
				{
					int type = rsmd.getColumnType(i);
					
					if(type == Types.VARCHAR || type == Types.CHAR)
					{
						out.println("<td>" + rs.getString(i) + "</td>");
					}
					else if(type == Types.DATE || type == Types.TIMESTAMP)
					{
						SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
						Date DateType = rs.getDate(i);
						String rs_strDate = sdfDate.format(DateType);
						out.println("<td>"+rs_strDate+"</td>");
						out.println("</tr>");
					}
					else if(type == Types.NUMERIC)
					{
						Double d = rs.getDouble(i);
						out.println("<td>"+d.toString()+"</td>");
					}
					else
					{
						out.println("<td>" + rs.getString(i) + "</td>");
					}
				}
				out.println("</tr>");
		}
	}
	catch(SQLException e) {
		System.err.println(e.getMessage());
	}
	%>
	
</body>
</html>