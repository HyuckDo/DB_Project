<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import = "java.util.*, java.text.*" %>
<%@ page import = "java.net.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �����ϱ�</title>
</head>
<body>
	
<%
 
    // ��Ű�� ��������
    Cookie[] cookies = request.getCookies() ;
     
    if(cookies != null){
         
        for(int i=0; i < cookies.length; i++){
            Cookie c = cookies[i] ;
             
            // ����� ��Ű �̸��� �����´�
            String cName = c.getName();
             
            // ��Ű���� �����´�
            String cValue = c.getValue() ;
             
             
        }
    }
 
%>		
	
	
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
	// ���� ���� ��¥ �߰�
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
	
		
	String sql = "INSERT INTO VEHICLE VALUES('" + Vehicle_Number + "', "  //Vehicle_Number
			+ Integer.parseInt(Mileage) + ", '"						//Mileage
			+ Model_name + "', '"										//Mname
			+ DMname + "', '" //Dtail_model_Name
			+ Brand_name + "', '"	//Brand_Name
			+ Category + "', "  //Category
			+ Integer.parseInt(price) + ", '" // price
			+ Production_date + "', "; //Production_date
			
		
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
			sql = sql + "" + Integer.parseInt(color) + ", "; // Ccode
		
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
			sql = sql + "" + Integer.parseInt(fuel) + ", "; // Fcode
			

			
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
			sql = sql + "" + Integer.parseInt(Trans) + ", "; //Tcode

			sql = sql + Integer.parseInt(engine_dis) + ")"; //Engine_Displacement
		
			System.out.println(sql);

			
			String lock = "lock table vehicle in exclusive mode";
			int res = 0;
			try
			{
				conn.setAutoCommit(false);
				pstmt.execute(lock);
				res = pstmt.executeUpdate(sql);
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
					alert("������ ��� �߽��ϴ�.");
					//location.href="main.html";
					history.go(-1);
				</script>
<%
			}
			
			sql = "SELECT COUNT(*) FROM SELL WHERE Sdate = '" + today +"'";
			

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				int count = rs.getInt(1);	
				
				Snumber = today + Integer.toString(count+1);	
			}
				

			// sell�� ������ ����
			sql = "INSERT INTO SELL VALUES('" + Snumber + "', '"
					//	+ AccId + "', '"
						+ "sdlkjlk123" + "', '"	
						+ Vehicle_Number + "', '"
						+ today + "'"
						+ ")";
			
			
			System.out.println(sql);
			
				String sell_lock = "lock table sell in exclusive mode";
				try
				{
					conn.setAutoCommit(false);
					pstmt.execute(sell_lock);
					res = pstmt.executeUpdate(sql);
					System.out.println(res);
					conn.commit();
					conn.setAutoCommit(true);
				}
				catch(SQLException e)
				{
					conn.rollback();
					System.out.println(e.toString());
				}
				

	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
</body>
</html>