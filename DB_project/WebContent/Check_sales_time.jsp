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

<h2>관리자 페이지 - 시간별 매출 확인</h2>
<hr>
<form action="#" method="post">
<h4>매출의 종류와 매출과 기간을 정해주세요.</h4>
<select name="sales_monyear">
	<option value="Month" selected>월별</option>
	<option value="Year">년도별</option>
</select>
<%!
	public ResultSet get_month(String sales_start, String sales_end, Connection conn) {
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		StringBuffer nested_sb = new StringBuffer();
		nested_sb.append("SELECT TO_DATE(EXTRACT(YEAR FROM B.BDATE) || \'-\' || EXTRACT(MONTH FROM B.BDATE), \'yyyy-mm\') as temp_date, V.PRICE FROM BUY B, VEHICLE V\n");
		nested_sb.append("WHERE B.VEHICLE_NUMBER = V.VEHICLE_NUMBER AND\n");
		nested_sb.append("B.BDATE >= TO_DATE(\'" + sales_start +"\', \'yyyy-mm\') AND\n");
		nested_sb.append("B.BDATE < TO_DATE(\'" + sales_end +"\', \'yyyy-mm\')");
		sb.append("SELECT EXTRACT(YEAR FROM temp_date) || \'-\' || EXTRACT(MONTH FROM temp_date) as year_month, SUM(price) AS SALES FROM\n(\n");
		sb.append(nested_sb.toString());
		sb.append(") GROUP BY temp_date ORDER BY temp_date");
		try{
			Statement stmt = conn.createStatement();
			System.out.println(sb.toString());
			rs = stmt.executeQuery(sb.toString());
		}
		catch(SQLException e){
			System.err.println(e.getMessage());
		}
		return rs;
	}
	public ResultSet get_year(String sales_start, String sales_end, Connection conn) {
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		StringBuffer nested_sb = new StringBuffer();
		nested_sb.append("SELECT EXTRACT(YEAR FROM B.BDATE) as years, V.PRICE FROM BUY B, VEHICLE V\n");
		nested_sb.append("WHERE B.VEHICLE_NUMBER = V.VEHICLE_NUMBER AND\n");
		nested_sb.append("B.BDATE >= TO_DATE(\'" + sales_start +"\', \'yyyy\') AND\n");
		nested_sb.append("B.BDATE < TO_DATE(\'" + sales_end +"\', \'yyyy\')");
		sb.append("SELECT years, SUM(price) AS SALES FROM\n(\n");
		sb.append(nested_sb.toString());
		sb.append(") GROUP BY years ORDER BY years");
		try{
			Statement stmt = conn.createStatement();
			System.out.println(sb.toString());
			rs = stmt.executeQuery(sb.toString());
		}
		catch(SQLException e){
			System.err.println(e.getMessage());
		}
		return rs;
	}
%>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strDate = simpleDate.format(date);
	out.println("<input type=\"date\" name =\"sales_start\"min=\"2010-01-01\" max=\"" + strDate+"\" >");
	out.println("<input type=\"date\" name =\"sales_end\"min=\"2010-01-01\" max=\"" + strDate+"\" >");

%>
<input type="submit" value="검색">
</form>
<br>
<!-- Get parameter and search DB -->
<%
	String search_type = request.getParameter("sales_monyear");
	String start_date = request.getParameter("sales_start");
	String end_date = request.getParameter("sales_end");
	if(start_date != null && !start_date.equals("") && end_date != null && !end_date.equals("")){
		String end_year = end_date.split("-")[0];
		String end_month = end_date.split("-")[1];
		int month = Integer.parseInt(end_month);
		int year = Integer.parseInt(end_year);
		ResultSet rs = null;
		out.println("<table border=\"1\">");
		if(search_type.equals("Month"))
		{
			if(month < 12)
			{
				month += 1;
			}
			else if(month == 12){
				year += 1;
				month = 1;
			}
			start_date = String.format("%s-%s", start_date.split("-")[0], start_date.split("-")[1]); 
			end_date = String.format("%04d-%02d", year, month);
			rs = get_month(start_date, end_date, conn);
			out.println("<caption>"+start_date + " ~ " + end_date + " 월별"+ "</caption>");
		}
		else if(search_type.equals("Year")){
			year += 1;
			start_date = start_date.split("-")[0];
			end_date = String.format("%04d", year);
			rs = get_year(start_date, end_date, conn);
			out.println("<caption>"+start_date + " ~ " + end_date + " 년도별"+ "</caption>");
		}
		
		try {
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