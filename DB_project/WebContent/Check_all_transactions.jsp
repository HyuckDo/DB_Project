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
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	%>
	<h2>관리자 페이지 - 내역 확인</h2>
	<hr>
	<form>
		<select name="user_transactions">
			<option value="none">선택하세요</option>
			<option value="buy">구매내역</option>
			<option value="sell">판매내역</option>
		</select>
		<input type="submit" value="검색">	
	</form>
		<%
		String search_type = request.getParameter("user_transactions");
		if(search_type != null && !search_type.equals("none")){
			ResultSet rs = null;
			out.println("<table border=\"1\">");
			
			try{
				StringBuffer sb = new StringBuffer();
				
				if(search_type.equals("buy"))
				{
					out.println("<caption>구매 내역</caption>");
					sb.append("SELECT * FROM BUY B ORDER BY B.BDATE");
				}
				else if(search_type.equals("sell"))
				{
					out.println("<caption>판매 내역</caption>");
					sb.append("SELECT * FROM SELL S ORDER BY S.SDATE");	
				}
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
		}
		
	%>
</body>
</html>