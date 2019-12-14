<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>차량 세부 정보</title>
</head>
<body>
	<h2>차량 세부 정보</h2>
<%
	
	//lab server
	String serverIP = "155.230.36.61";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "s2011097047";
	String pass = "2011097047";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
%>


<%

	PreparedStatement pstmt;
	ResultSet rs;


	String sql = "SELECT VEHICLE.Vehicle_Number, VEHICLE.Mileage, VEHICLE.MName, VEHICLE.DMName, VEHICLE.Brand_Name, VEHICLE.Category, VEHICLE.Price, VEHICLE.Production_Date, "
			+ "c.Name, f.Name, t.Trasmission_Type, VEHICLE.Engine_Displacement "
			+ "FROM VEHICLE, "
			+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S, "
			+ "COLOR c, FUEL f, TRANSMISSION t "
			+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
			+ "AND VEHICLE.Ccode = c.Code AND VEHICLE.Fcode = f.Code AND VEHICLE.Tcode = t.Code "
			+ "AND VEHICLE.MName = '" + request.getParameter("Model_Name") +"' "
			+ "AND VEHICLE.Production_Date = '" + request.getParameter("Production_Date") +"' "
			+ "AND VEHICLE.Price = '" + request.getParameter("Price") +"'";
			

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	out.println("<th>" + "Number" + "</th>");
	out.println("<th>" + "Vehicle Number" + "</th>");
	out.println("<th>" + "Mileage" + "</th>");
	out.println("<th>" + "Model Name" + "</th>");
	out.println("<th>" + "Detail Name" + "</th>");
	out.println("<th>" + "Brand Name" + "</th>");
	out.println("<th>" + "Category" + "</th>");
	out.println("<th>" + "Price" + "</th>");
	out.println("<th>" + "Production Date" + "</th>");
	out.println("<th>" + "Color" + "</th>");
	out.println("<th>" + "Fuel" + "</th>");
	out.println("<th>" + "Trasmission" + "</th>");
	out.println("<th>" + "Engine Displacement" + "</th>");
	
	int number =1;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + number + "</td>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
		out.println("<td>" + rs.getString(7) + "</td>");
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		Date mgrStartDate = rs.getDate(8);
		String strMSDate = sdfDate.format(mgrStartDate);
		out.println("<td>" + strMSDate + "</td>");
		out.println("<td>" + rs.getString(9) + "</td>");
		out.println("<td>" + rs.getString(10) + "</td>");
		out.println("<td>" + rs.getString(11) + "</td>");
		out.println("<td>" + rs.getString(12) + "</td>");
		out.println("</tr>");
			
		number++;
	}
	out.println("</table>");
	
	sql = "SELECT COUNT(*) "
			+ "FROM ADDED_OPTION a, VEHICLE, MAIN_OPTION m, "
			+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S "
			+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
			+ "AND VEHICLE.MName = '" + request.getParameter("Model_Name") +"' "
			+ "AND VEHICLE.Production_Date = '" + request.getParameter("Production_Date") +"' "
			+ "AND VEHICLE.Price = '" + request.getParameter("Price") +"'"
			+ "AND S.Vehicle_Number = a.Vehicle_Number "
			+ "AND a.Option_Name = m.Option_Name";
	
	rs = pstmt.executeQuery(sql);
	while(rs.next()) {
		
		int has_option = rs.getInt(1);
		if(has_option != 0){
			out.printf("option: ");
		}
		else if(has_option ==0) {
			out.println("차량이 없습니다. 정확한 차량의 정보를 입력해주세요.");
		}
	
	}
	
	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
	
	
</body>
</html>