<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.text.*, java.sql.*, java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자 페이지</title>
</head>
<body>
	
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
	
	PreparedStatement pstmt ;
	ResultSet rs;
	
	
    SimpleDateFormat Bnum = new SimpleDateFormat("yyMMdd");
    SimpleDateFormat Bdat = new SimpleDateFormat("yyyy-MM-dd");

%>
	
<%	
	// 차량 구매 날짜 추가
	String Snumber = null;
	String today = Bnum.format(new java.util.Date());
	String c_vehicle_number = null;
	
	String Vehicle_Number = request.getParameter("Vehicle_Number");
	String Mileage = request.getParameter("Mileage");
	String Model_name = request.getParameter("Model_Name");
	String DMname = request.getParameter("Detailed_Model_Name");
	String Brand_name = request.getParameter("Brand_Name");
	String Category = request.getParameter("Category");
	String price = request.getParameter("Price");
	String Production_date = request.getParameter("Production_Date");
	String color = request.getParameter("Color");
	String fuel = request.getParameter("Fuel");
	String Trans = request.getParameter("Transmission");
	String engine_dis = request.getParameter("Engine_Displacement");
	String user_id = request.getParameter("User_id");
		
	String sql = "UPDATE VEHICLE SET VEHICLE_NUMBER='" + Vehicle_Number + "', "  //Vehicle_Number
			+ "MILEAGE =" + Integer.parseInt(Mileage) + ", "						//Mileage
			+ "MNAME ='" + Model_name + "', "										//Mname
			+ " DMNAME = '"+ DMname + "', " //Dtail_model_Name
			+ " BRAND_NAME='" + Brand_name + "', "	//Brand_Name
			+ " CATEGORY = '" + Category + "', "  //Category
			+ " PRICE = "+ Integer.parseInt(price) + ", " // price
			+ " PRODUCTION_DATE = TO_DATE('" + Production_date + "', 'yyyy-mm-dd')"; //Production_date
			
		
			String scolor = "SELECT COLOR.Code, COLOR.Name FROM COLOR";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(scolor);

			while(rs.next()) {
				int code = rs.getInt(1);
				String color_c = rs.getString(2);
				if(color_c.equals(color) == true) {
					color = "" + code + "";
				}
			}				
			sql = sql + ",  CCODE =" + Integer.parseInt(color) + ", "; // Ccode
		
			scolor = "SELECT FUEL.Code, FUEL.Name FROM FUEL";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(scolor);

			while(rs.next()) {
				int code = rs.getInt(1);
				String fuel_c = rs.getString(2);
				if(fuel_c.equals(fuel) == true) {
					fuel = "" + code + "";
				}
			}	
			sql = sql + " FCODE =" + Integer.parseInt(fuel) + ", "; // Fcode
			

			
			scolor = "SELECT TRANSMISSION.Code, TRANSMISSION.Trasmission_Type FROM TRANSMISSION";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(scolor);

			while(rs.next()) {
				int code = rs.getInt(1);
				String tran_c = rs.getString(2);
				if(tran_c.equals(Trans) == true) {
					Trans = "" + code + "";
				}
			}	
			sql = sql + " TCODE=" + Integer.parseInt(Trans) + ", "; //Tcode

			sql = sql + " ENGINE_DISPLACEMENT=" + Integer.parseInt(engine_dis) + " WHERE VEHICLE_NUMBER = '"+Vehicle_Number +"'"; //Engine_Displacement
		
			System.out.println(sql);

			
			String lock = "lock table vehicle in exclusive mode";
			int res = 0;
			try
			{
				conn.setAutoCommit(false);
				pstmt.execute(lock);
				res = pstmt.executeUpdate(sql);
				conn.commit();
				conn.setAutoCommit(true);
				System.out.println(res);
			}
			catch(SQLException e)
			{
				conn.rollback();
				System.out.println(e.toString());
			}
				
				
			if(res == 1) {
%>
				<script>
					alert("차량을 수정 했습니다.");
					location.href="main.html";
				</script>
			<%} 
			else
			{
			%>
			<script>
					alert("error!");
					//location.href="main.html";
					history.go(-1);
				</script>
			<%} %>
</body>
</html>