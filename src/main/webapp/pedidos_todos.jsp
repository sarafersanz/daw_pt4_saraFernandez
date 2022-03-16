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
<title>Pedidos</title>
</head>
<body>
	<div class="container h-100 pt-4">
		<div
			class="row text-center justify-content-center align-items-center pt-3">
			<div class="col-8 text-center">
				<h1 class="display-4 pb-4">Pedidos</h1>

				<table class="table table-striped">
					<thead class="thead-dark">
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Fecha</th>
							<th scope="col">Total</th>
							<th scope="col">Estado</th>
							<th scope="col">Usuario</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (int i = 0; i < Pedidos_todos.tamano(); i++) {
						%>
						<tr>
							<td><%=Pedidos_todos.getId(i)%></td>
							<td><%=Pedidos_todos.getFecha(i)%></td>
							<td><%=Pedidos_todos.getTotal(i)%> €</td>
							<td><%=Pedidos_todos.getEstado(i)%></td>
							<td><%=Pedidos_todos.getUsuario(i)%></td>
						</tr>
						<%
						}
						%>
					</tbody>
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