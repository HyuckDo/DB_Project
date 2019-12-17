<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date, java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자 페이지</title>
</head>
<h2>차량 정보 수정하기</h2>
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
<body>
	<%
		String vehicle_number = request.getParameter("vehicle_number");
		ResultSet rs = null;
		ArrayList <String> col_array = new ArrayList<String>();
		ArrayList <Integer> col_types = new ArrayList<Integer>();
		ArrayList <String> col_values = new ArrayList<String>();
		try{
			String query = "SELECT * FROM VEHICLE WHERE VEHICLE_NUMBER = \'" + vehicle_number + "\'";
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int col_cnt = rsmd.getColumnCount();
			if(rs.next())
			{
				for(int i=1; i<=col_cnt; i++)
				{
					col_array.add(rsmd.getColumnName(i));
					col_types.add(rsmd.getColumnType(i));
					col_values.add(rs.getString(i));
				}
			}
		}
		catch(SQLException e)
		{
			System.err.println(e.getMessage());
		}
	%>
	<form action = "Modify_car_send.jsp" method = "POST">
	
	Vehicle Number : <input type="text" value="<%=vehicle_number%>" name="Vehicle_Number" readonly>
	&nbsp;&nbsp;
	Mileage : <input type = "text" name = "Mileage" value=<%=col_values.get(col_array.indexOf("MILEAGE"))%>> 마일
	&nbsp;&nbsp;
	
	Model Name :
	<select name="Model_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Model_Name, Bname FROM MODEL ORDER BY Model_Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Model_Name = rs.getString(1);
        String BName = rs.getString(2);
        if(col_values.get(col_array.indexOf("MNAME")).equals(Model_Name)){
     %>
     <option value="<%=Model_Name%>" selected><%=Model_Name%>(<%=BName%>)</option>
     
     <%
        }
        else
        {
       %>
       <option value="<%=Model_Name%>"><%=Model_Name%>(<%=BName%>)</option>
	<%
        }
       }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
	
<br><br><br><br>


	Detailed Model Name :
	<select name="Detailed_Model_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Detailed_Model_Name, Mname FROM DETAILED_MODEL ORDER BY Mname";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Detailed_Model_Name = rs.getString(1);
        String Mname= rs.getString(2);
        if(col_values.get(col_array.indexOf("DMNAME")).equals(Detailed_Model_Name))
        {
        %>
        <option value="<%=Detailed_Model_Name%>"selected><%=Detailed_Model_Name%>(<%=Mname%>)</option>	
     <%
        }
     else
     {
    %>
    	<option value="<%=Detailed_Model_Name%>"><%=Detailed_Model_Name%>(<%=Mname%>)</option>
    <%	 
     }
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
	&nbsp;&nbsp;

	Brand Name :
	<select name="Brand_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Brand_Name FROM MAKE GROUP BY Brand_Name ORDER BY Brand_Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Brand_Name = rs.getString(1);
        if(col_values.get(col_array.indexOf("BRAND_NAME")).equals(Brand_Name))
        {
     %>
     <option value="<%=Brand_Name%>" selected><%=Brand_Name%></option>
     <%
        }
        else
        {
        	%>
        	<option value="<%=Brand_Name%>"><%=Brand_Name%></option>
        	<%
        }
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	&nbsp;&nbsp;
 	
 	
 	Vehicle Category :
	<select name="Category">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Category FROM CATEGORY GROUP BY Category ORDER BY Category";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Category = rs.getString(1);
        if(col_values.get(col_array.indexOf("CATEGORY")).equals(Category))
        {
     %>
     <option value="<%=Category%>" selected><%=Category%></option>
     <%
        }
        else
        {
        	%>
        	<option value="<%=Category%>"><%=Category%></option>
        	<%
        }
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>


<br><br><br><br>
	Price : <input type = "text" name = "Price" value=<%=col_values.get(col_array.indexOf("PRICE"))%>> 만원
	&nbsp;&nbsp;
	
	Production Date : <%
		Date date = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String strDate = simpleDate.format(date);
		out.println("<input type=\"date\" value=\""+col_values.get(col_array.indexOf("PRODUCTION_DATE")).substring(0,10)+ "\" name=\"Production_Date\" min=\"1980-01-01\" max=\""+ strDate + "\">&nbsp;\n");
		System.out.println(col_values.get(col_array.indexOf("PRODUCTION_DATE")).substring(0,10));
	%>
	COLOR :
	<select name="Color">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Name, Code FROM COLOR ORDER BY Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String CName = rs.getString(1);
        String CCode = rs.getString(2);
        if(col_values.get(col_array.indexOf("CCODE")).equals(CCode)){
     %>
     <option value="<%=CName%>" selected><%=CName%></option>
     <%
       }
        else{
        	%>
        	<option value="<%=CName%>"><%=CName%></option>
        	<%
        }
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	
 <br><br><br><br>	
 	Fuel :
	<select name="Fuel">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Name, Code FROM FUEL ORDER BY Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String FName = rs.getString(1);
        String FCode = rs.getString(2);
        if(col_values.get(col_array.indexOf("FCODE")).equals(FCode)){
     %>
     <option value="<%=FName%>" selected><%=FName%></option>
     <%
        }
        else
        {
        	%>
        	<option value="<%=FName%>"><%=FName%></option>
        	<%
        }
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	&nbsp;&nbsp;
 	Transmission :
	<select name="Transmission">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Trasmission_Type, Code FROM TRANSMISSION ORDER BY Trasmission_Type";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Trasmission_Type = rs.getString(1);
        String TCode = rs.getString(2);
        if(col_values.get(col_array.indexOf("TCODE")).equals(TCode)){ 
     %>
     <option value="<%=Trasmission_Type%>" selected><%=Trasmission_Type%></option>
     <%
        }
        else{
        	%> 
        	<option value="<%=Trasmission_Type%>"><%=Trasmission_Type%></option>
        	<%
        }
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
	&nbsp;&nbsp;

	Engine_Displacement :
	<select name="Engine_Displacement">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Engine_Displacement FROM ENGINE_DISPLACEMENT ORDER BY Engine_Displacement";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Engine_Displacement = rs.getString(1);
        if(col_values.get(col_array.indexOf("ENGINE_DISPLACEMENT")).equals(Engine_Displacement)){
     %>
     <option value="<%=Engine_Displacement%>" selected><%=Engine_Displacement%></option>
     <%
        }
        else
        {
        	%>
        	<option value="<%=Engine_Displacement%>"><%=Engine_Displacement%></option>
        	<%
        }
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
	&nbsp;&nbsp;
	<br><br><br>
	<input type = "submit" value = "등록하기"/>

	</form>
	
</body>
</html>