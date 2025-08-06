<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sorry something went wrong</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> 

</head>
<body>
	<div class="container text-center">
		<img src="images/system.png" class="img-fluid">
		<h3 class="display-3">Sorry! something went wrong</h3>
		<%= exception %><br>
		<a href="./index.jsp" ><button class = "btn-primary-background btn-lg text-white mt-3">Home</button></a>
		
		
	</div>
</body>
</html>