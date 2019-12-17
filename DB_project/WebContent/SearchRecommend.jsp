<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��õ ���� �˻�</title>
</head>
<body>
	<h2>�˻� �� ����</h2>
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
	<form action = "detail_vehicle.jsp" method = "POST">
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
     <option value="<%=Model_Name%>"><%=Model_Name%></option>
     <%
      }
      } catch (SQLException se) {
       System.out.println(se.getMessage());
      }
     %>
 	</select>

	Production Date: <input type = "text" name = "Production_Date">
	Price: <input type = "text" name = "Price">

	<input type = "submit" value = "���γ��� �˻��ϱ�"/>

	</form>



<br><br>
<%	
	//���� �˻�
	String[] data = new String[3];
	String add_data = "";
	
	String sql =  "SELECT DISTINCT VEHICLE.MName, VEHICLE.DMName, VEHICLE.Production_Date, f.Name, VEHICLE.Price, VEHICLE.Vehicle_Number "
					+ "FROM VEHICLE, "
					+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S, FUEL f, COLOR c, TRANSMISSION tr, CATEGORY ca "
					+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
					+ "AND VEHICLE.Fcode = f.Code ";
			

	data[0] = request.getParameter("Brand_Name");
	data[1] = request.getParameter("Model_Name");
	data[2] = request.getParameter("Detailed_Model_Name");

	
	
	if(data[0] != "") { // ������
		
		add_data +=  "AND VEHICLE.Brand_Name = '" + data[0] + "' "; 
	
	}
	if(data[1] != "") { // ��
		
		add_data +=  "AND VEHICLE.MName = '" + data[1] + "' "; 
	
	}
	if(data[2] != "") { // ī�װ���
	
		add_data +=  "AND VEHICLE.DMName = '" + data[2] + "' "; 
	
	}
		
	sql = sql.concat(add_data);
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");

	
	out.println("<th>" + "Number" + "</th>");
	out.println("<th>" + "Model Name" + "</th>");
	out.println("<th>" + "Dtail Name" + "</th>");
	out.println("<th>" + "Production Date" + "</th>");
	out.println("<th>" + "Fuel" + "</th>");
	out.println("<th>" + "Price" + "</th>");
	out.println("<th>" + "Vehicle_Number" + "</th>");
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
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		Date mgrStartDate = rs.getDate(3);
		String strMSDate = sdfDate.format(mgrStartDate);
		out.println("<td>" + strMSDate + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
		out.println("</tr>");
			
		number++;
	}
	out.println("</table>");
	
	if(number == 1){
%>
	<script>
 		alert("������ �����ϴ�. ��Ȯ�� ������ �Է����ּ���.");
 		//location.href="SearchVehicle.jsp";
 		history.go(-1);
 	</script>
<%	
	}
	
	
	
	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
	
	
</body>
</html>