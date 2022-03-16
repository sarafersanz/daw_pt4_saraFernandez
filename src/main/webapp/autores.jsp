<%-- Página de órdenes de pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.Tienda_libros.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="site.css" rel="stylesheet">
<title>Autores</title>
</head>
<body>
	<div class="container h-100 pt-4">
		<div
			class="row text-center justify-content-center align-items-center pt-3">
			<div class="col-6 text-center">
				<h1 class="pb-4 display-4">Autores</h1>
				<table class="table table-striped pt-4">
					<thead class="thead-dark">
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Nombre</th>
							<th scope="col">Apellidos</th>
						</tr>
					</thead>
					<%
					for (int i = 0; i < Autores.tamano(); i++) {
					%>
					<tr>
						<td><%=Autores.getId(i)%></td>
						<td><%=Autores.getAutor(i)%></td>
						<td><%=Autores.getApellidos(i)%></td>
					</tr>
					<%
					}
					%>
				</table>
				<button type="button" class="btn button"
					onclick="location.href='gestion.jsp';">Volver al Menú</button>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="validation.js"></script>
</body>
</html>