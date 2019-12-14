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

<h2>관리자 페이지 - 제조사별 매출 확인</h2>
<hr>
<%!
public ResultSet get_make(String sales_start, String sales_end, String country_code, Connection conn){
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
	StringBuffer nested_sb = new StringBuffer();
	nested_sb.append("SELECT COUNTRY as temp_country, Brand_name as temp_brand, \n");
	nested_sb.append("CASE WHEN country=\'KOR\' THEN 1\n");
	nested_sb.append("WHEN NOT country='KOR' THEN 2 END as is_kor FROM MAKE M\n");
	
	sb.append("SELECT BRAND_NAME, SUM(PRICE) as Total FROM\n(");
	sb.append(nested_sb.toString());
	sb.append("), VEHICLE V, BUY B WHERE IS_KOR = "+ country_code + " AND\n");
	sb.append("V.VEHICLE_NUMBER = B.VEHICLE_NUMBER AND\n");
	sb.append("V.BRAND_NAME = TEMP_BRAND AND\n");
	sb.append("B.Bdate >= TO_DATE(\'"+ sales_start+"\', \'yyyy-mm-dd\') AND\n");
	sb.append("B.Bdate <= TO_DATE(\'"+sales_end+"\', \'yyyy-mm-dd\') \nGROUP BY BRAND_NAME");
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
<form action="#" method="post">
<h4>국내/국외 및 기간을 선택해주세요.</h4>
<select name="sales_make">
	<option value="-1" selected>선택</option>
	<option value="1">국내</option>
	<option value="0">국외</option>
</select>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strDate = simpleDate.format(date);
	out.println("<input type=\"date\" name =\"sales_start\"min=\"2010-01-01\" max=\"" + strDate+"\" >");
	out.println("<input type=\"date\" name =\"sales_end\"min=\"2010-01-01\" max=\"" + strDate+"\" >");

%>
<input type="submit" value="검색">
</form>

<%
	String search_type = request.getParameter("sales_make");
	String start_date = request.getParameter("sales_start");
	String end_date = request.getParameter("sales_end");
	if(start_date != null && !start_date.equals("") && end_date != null && !end_date.equals("") && search_type !=null && !search_type.equals("-1")){
		ResultSet rs = get_make(start_date, end_date, search_type, conn);
		try {
			ResultSetMetaData rsmd = rs.getMetaData();
			int columns = rsmd.getColumnCount();
			out.println("<table border=\"1\">");
			String country = null;
			if(search_type.equals("1")){
				country = "국내";
			}
			else if(search_type.equals("0")){
				country = "국외";
			}
			out.println("<caption>"+start_date +" ~ " + end_date +"("+country+")</caption>");
			
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