<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>판매할 차량 등록</title>
</head>
<body>

	<h2>판매할 차량의 정보를 입력 해주세요.</h2>
	<br><hr>
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
	
	<form action = "Insert_Vehicle.jsp" method = "POST">
	
	Vehicle Number : <input type = "text" name = "Vehicle_Number">
	&nbsp;&nbsp;
	Mileage : <input type = "text" name = "Mileage"> 마일
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
     %>
     <option value="<%=Model_Name%>"><%=Model_Name%>(<%=BName%>)</option>
     
     <%
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
     %>
     <option value="<%=Detailed_Model_Name%>"><%=Detailed_Model_Name%>(<%=Mname%>)</option>
     <%
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
     %>
     <option value="<%=Brand_Name%>"><%=Brand_Name%></option>
     <%
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
     %>
     <option value="<%=Category%>"><%=Category%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>


<br><br><br><br>
	Price : <input type = "text" name = "Price"> 만원
	&nbsp;&nbsp;
	
	Production Date : <%
		Date date = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String strDate = simpleDate.format(date);
		out.println("<input type=\"date\" name=\"Production_Date\" min=\"1980-01-01\" max=\""+ strDate + "\">&nbsp;\n");
	%>
	COLOR :
	<select name="Color">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Name FROM COLOR GROUP BY Name ORDER BY Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String CName = rs.getString(1);
     %>
     <option value="<%=CName%>"><%=CName%></option>
     <%
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
    
       String sql = "SELECT Name FROM FUEL GROUP BY Name ORDER BY Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String FName = rs.getString(1);
     %>
     <option value="<%=FName%>"><%=FName%></option>
     <%
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
    
       String sql = "SELECT Trasmission_Type FROM TRANSMISSION GROUP BY Trasmission_Type ORDER BY Trasmission_Type";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Trasmission_Type = rs.getString(1);
     %>
     <option value="<%=Trasmission_Type%>"><%=Trasmission_Type%></option>
     <%
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
    
       String sql = "SELECT Engine_Displacement FROM ENGINE_DISPLACEMENT GROUP BY Engine_Displacement ORDER BY Engine_Displacement";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Engine_Displacement = rs.getString(1);
     %>
     <option value="<%=Engine_Displacement%>"><%=Engine_Displacement%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>

	<br><br><br>
	<input type = "submit" value = "등록하기"/>

	</form>



</body>
</html>