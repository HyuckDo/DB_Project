<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ ������</title>
</head>
<body>
	<h2>������ ������ - ���� �߰��ϱ�</h2>
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
<%! 
	public String print_out_abc(){
		return "abc called";
	}
	public String print_out_bcd(HttpServletRequest request){
		String stt = request.getParameter("user_maker");
		return "bcd called";
	}
%>
	<form name="input_form" method="post" action="">
		����� ID:
		<input type="text" name="user_id">
		<br />
		<h4>
			������ȣ:
			<input type="text" name="user_veichle_number"> <br />
		</h4>
		<h4>
			������:
			<select id="user_maker" onchange="maker_clicked(this);">
				<option value="abc">abc</option>
				<option value="bcd">bcd</option>
			</select>
			<br />
		</h4>
		<h4>
			������: <script type="text/javascript">
				function maker_clicked(obj){
					
					var maker_select = obj.value;
					if(maker_select=='abc'){
						var st = "<%=print_out_abc()%>";	
					} 
					else if(maker_select=='bcd'){
						var st = "<%=print_out_bcd(request)%>";
					}
					alert(st);
				}
				</script><br />
		</h4>
			�󼼸�: <br />
			����Ÿ�: <input type="text" name="user_mileage"> <br />
			��������: 
			<select>
				<option value="light-weight" selected>����</option>
				<option value="midsize">(��)������</option>
				<option value="full-size">������</option>
				<option value="suv">SUV</option>
				<option value="truck">Ʈ��</option>
			</select> <br />
			����: <input type="text" name="user_price"> <br />
			��������: <%
			Date date = new Date();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
			String strDate = simpleDate.format(date);
			out.println("<input type=\"date\" name =\"user_manufacture\"min=\"1970-01-01\" max=\"" + strDate+"\" >");
		%> <br />
		
		
	</form>
</body>
</html>