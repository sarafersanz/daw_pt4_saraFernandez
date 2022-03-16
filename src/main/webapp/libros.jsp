<%-- Página de órdenes de pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.Tienda_libros.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="site.css" rel="stylesheet">
<title>Libros</title>
</head>
<body>
	<div class="container h-100 pt-4">
		<div
			class="row text-center justify-content-center align-items-center pt-3">
			<div class="col-8 text-center">
				<h1 class="display-4">Libros</h1>
				<table class="table table-striped mt-4">
					<thead class="thead-dark">
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Título</th>
							<th scope="col">Autor</th>
							<th scope="col">Apellidos</th>
							<th scope="col">Precio</th>
						</tr>
					</thead>
					<%
					for (int i = 0; i < Tienda_libros.tamano(); i++) {
					%>
					<tr>
						<td><%=Tienda_libros.getId(i)%></td>
						<td><%=Tienda_libros.getTitulo(i)%></td>
						<td><%=Tienda_libros.getAutor(i)%></td>
						<td><%=Tienda_libros.getApellidos(i)%></td>
						<td><%=Tienda_libros.getPrecio(i)%> €</td>
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
</body>
</html>