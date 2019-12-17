
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>판매, 구입 차량의 세부정보</title>
</head>
<body>
	<h2>차량 세부 정보</h2>
	<br><hr><br>
	
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
	
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	
%>

	
<%
	String vehicle_number = request.getParameter("Vehicle_Number");
	String sql = "SELECT VEHICLE.Vehicle_Number, VEHICLE.Mileage, VEHICLE.MName, VEHICLE.DMName, VEHICLE.Brand_Name, VEHICLE.Category, VEHICLE.Price, VEHICLE.Production_Date, "
			+ "c.Name, f.Name, t.Trasmission_Type, VEHICLE.Engine_Displacement "
			+ "FROM VEHICLE, "
			+ "COLOR c, FUEL f, TRANSMISSION t "
			+ "WHERE "
			+ "VEHICLE.Ccode = c.Code AND VEHICLE.Fcode = f.Code AND VEHICLE.Tcode = t.Code "
			+ "AND VEHICLE.Vehicle_Number = '" + vehicle_number + "'";
			

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	
	out.println("<table border=\"1\">");

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
	
	if(number == 1){
		
%>
	<script>
 		alert("정확한 차량번호를 입력해주세요.");
 		history.go(-1);
 	</script>
<%		
	}
	//옵션 출력
	sql = "SELECT a.Option_Name, m.Option_Classification "
			+ "FROM ADDED_OPTION a, VEHICLE, MAIN_OPTION m "
			+ "WHERE "
			+ "VEHICLE.Vehicle_Number = a.Vehicle_Number "
			+ "AND a.Option_Name = m.Option_Name "
			+ "AND VEHICLE.Vehicle_Number = '" + vehicle_number + "'";
	
	System.out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
%>
<br><br><br><br>
<%	

	out.println("<table border=\"1\">");

	out.println("<th>" + "Option" + "</th>");
	out.println("<tr>");
	
	while(rs.next()){
	
		out.println("<td>" + rs.getString(1) + "( " + rs.getString(2) + ")" + "</td>");
	

	}
	out.println("</tr>");
	out.println("</table>");
	
	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
	
	
</body>
</html>