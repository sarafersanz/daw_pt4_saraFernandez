<%-- Página de órdenes de pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.Tienda_libros.*"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="site.css" rel="stylesheet">

<title>Login</title>
</head>

<body id="LoginForm">
	<div class="container h-100">
		<div class="row justify-content-center align-items-center h-100 pb-5">
			<div class="col-12">
				<h1 class="pb-5 text-center display-4">Formulario
					Login</h1>
				<div class="login-form">
					<div class="main-div">
						<div class="panel">
							<h2>Login</h2>
							<p class="pt-2">Por favor, introduzca su usuario y contraseña</p>
						</div>
						<form id="Login" method="GET" action="login">

							<div class="form-group">


								<input type="text" name="usuario" class="form-control"
									id="inputUsuario" placeholder="Nombre de usuario">

							</div>

							<div class="form-group">

								<input type="password" name="password" class="form-control"
									id="inputPassword" placeholder="Contraseña">
							</div>
							<%
							if (request.getAttribute("respuesta") != null) {
								out.println("Error:" + request.getAttribute("respuesta"));
							}
							%>
							<button type="submit" name="Acceder" class="btn btn-primary">Login</button>

						</form>
					</div>
					<p class="botto-text">By: Sara Fernández Sánchez</p>
				</div>
			</div>
		</div>
	</div>
</body>

</html>