<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� �ȸ� ����</title>
</head>
<body>
	<h2>���� ���� �ȸ� ����</h2>
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

	<form action = "SearchRecommend.jsp" method = "POST">
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

	Model Name :
	<select name="Model_Name">
     <option value="" selected></option>
     <%

      try {
    
       String sql = "SELECT Model_Name, Bname FROM MODEL ORDER BY Bname";

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
	
	<input type = "submit" value = "���� �˻��ϱ�"/>
	
	</form>

	<br><br>

<%	
	//�Ǹ����� ��� ������ ���� ���
	String sql = "SELECT vehicle.brand_name, vehicle.Mname, vehicle.DMname, COUNT(*) "
			+ "FROM VEHICLE, BUY, ACCOUNT "
			+ "WHERE vehicle.vehicle_number = buy.vehicle_number AND account.id = buy.accid "
			+ "GROUP BY vehicle.brand_name, vehicle.Mname, vehicle.DMname ORDER BY COUNT(*) desc";
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	
	out.println("<table border=\"1\">");

	
	out.println("<th>" + "Ranking" + "</th>");
	out.println("<th>" + "Brand Name" + "</th>");
	out.println("<th>" + "Model Name" + "</th>");
	out.println("<th>" + "Dtail Name" + "</th>");
	/*
	for(int i=1; i<= cnt; i++){
			
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	*/
	
	int number =1;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + number + "</td>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("</tr>");
			
		number++;
	}
	out.println("</table>");
	
	
	
	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
	
	
</body>
</html>