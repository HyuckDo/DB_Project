<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Ǹ����� ����</title>
</head>
<body>
	<h2>���� ���� �˻�</h2>
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
	<form action = "main.html" method = "POST">
   	
	<input type = "submit" value = "Ȩ���� ����"/>

	</form>
	
<h3>------ ���� �̸�(Model Name)���� �˻��ϱ� ------ </h3>

	<form action = "SearchModel.jsp" method = "POST">
   	Model Name :
	<select name="Model_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Model_Name FROM MODEL GROUP BY Model_Name ORDER BY Model_Name";

       pstmt = conn.prepareStatement(sql);
       rs = pstmt.executeQuery();
       while (rs.next()) {
        String Model_Name = rs.getString(1);
     %>
     <option value=<%=Model_Name%>><%=Model_Name%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	
	<input type = "submit" value = "�˻��ϱ�"/>

	</form>


<h3>------ �����纰(Brand Name)���� �˻��ϱ� ------</h3>

	<form action = "SearchBrand.jsp" method = "POST">
   
   	<!-- 
   	Country :
   	<select name = "country">
			<option value = "" selected></option>
			<option value = "KOR">����</option>
			<option value = "!KOR">����</option>
			<option value = "TOTAL">��� ����</option>
		</select>
   	 -->
   	
   	&nbsp;&nbsp;&nbsp;&nbsp;
	
	
	
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
     <option value=<%=Brand_Name%>><%=Brand_Name%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	
	<input type = "submit" value = "�˻��ϱ�"/>

	</form>



<h3>------ ���� �������� �˻��ϱ� ------ </h3>

	<form action = "Searchalldata.jsp" method = "POST">
   	
   	
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
     <option value=<%=Category%>><%=Category%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	
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
     <option value=<%=FName%>><%=FName%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	
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
     <option value=<%=Trasmission_Type%>><%=Trasmission_Type%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	
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
     <option value=<%=CName%>><%=CName%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>
 	
 	
	<input type = "submit" value = "�˻��ϱ�"/>

	</form>



</body>
</html>