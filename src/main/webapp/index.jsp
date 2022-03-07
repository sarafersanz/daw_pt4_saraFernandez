<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<h1>Tienda Libros</h1>
	<hr />
	<br />
	<h2>Acceso</h2>
	<form method="get" action="login">
		<table>
			<tr>
				<td>Introduce tu nombre de usuario:</td>
				<td><input type="text" name="usuario" /></td>
			</tr>
			<tr>
				<td>Introduce tu clave:</td>
				<td><input type="password" name="password" /></td>
			</tr>
		</table>
		<br />
		<% 
			if(request.getAttribute("respuesta")!=null)
			{
				out.println("Error:" +request.getAttribute("respuesta"));
			}
			%>
		<br /> <br /> <input type="submit" name="Acceder" /> <input
			type="reset" name="Cancelar" />

	</form>
</body>
</html>