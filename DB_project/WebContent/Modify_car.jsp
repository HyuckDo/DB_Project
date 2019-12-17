<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자 페이지</title>
</head>
<body>
	<h2>관리자 페이지 - 차량 정보 수정하기</h2>
	<hr>
	<form action="Modify_car_detail_info.jsp" method="POST">
		차량 번호를 입력하세요: <input type="text" name="vehicle_number">
		<input type="submit" value="검색">
	</form>
</body>
</html>