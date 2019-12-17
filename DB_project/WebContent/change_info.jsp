<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	String serverIP = "155.230.36.61";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "s2011097047";
	String pass = "2011097047";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);


%>


<%	
	String id = request.getParameter("id");
	String pw = request.getParameter("pass");
	String nm = request.getParameter("name");
	String te = request.getParameter("tell");
	String jo = request.getParameter("job");
	String ad = request.getParameter("address");
	String bd = request.getParameter("date");
	int cl = 0;
	
	String sql = "select * from ACCOUNT where ID = '" + id + "'";
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	
	while(rs.next()){
		
		int cla = rs.getInt(8);
		cl = cla;	
	}
	
	if(jo != null && ad != null && bd != null){
		cl = 2;
		sql= "UPDATE account SET Class = '"+ cl +"'" 
				+ "where ID = '"+ id +"'";
	}
	
	
	//회원 정보 수정
	sql = "UPDATE account SET ID = '"+ id +"', " + "Password = '" + pw + "', " 
				+ "Name = '" + nm + "', " + "Tell = '" + te + "', " + "Job = '" + jo + "', " 
				+ "Address = '" + ad + "', " + "Bdate = '" + bd + "', " + "Class = " + cl + " "
				+ "where ID = '"+ id +"'";
	
	
	
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
          alert("회원 정보가 수정되었습니다.");
          location.href="mypage.html";
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
	
	
	
	
	
	
	
	
	rs.close();
	pstmt.close();
	conn.close();

%>



</body>
</html>