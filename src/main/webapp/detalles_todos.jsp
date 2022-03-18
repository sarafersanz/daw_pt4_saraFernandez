<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.Tienda_libros.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="site.css" rel="stylesheet">
<title>Detalles</title>
</head>

<body>
	<div class="container h-100">
		<div class="row h-100 justify-content-center text-center">
			<div class="col-10">
				<div class="row pt-5">
					<div class="col-12 text-center justify-content-center">
						<h1 class="pt-5 display-3">Detalles del Pedido</h1>
					</div>
				</div>
				<hr />
				<div class="row justify-content-center align-items-center">
					<div class="col-12 pt-3">
						<table class="table table-striped">
							<thead class="thead-dark">
								<tr>
									<th scope="col">Título</th>
									<th scope="col">Autor</th>
									<th scope="col">Apellidos</th>
									<th scope="col">Editorial</th>
									<th scope="col">Cantidad</th>
									<th scope="col">Precio</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (int i = 0; i < Detalles.tamano(); i++) {
								%>
								<tr>
									<td><%=Detalles.getTitulo(i)%></td>
									<td><%=Detalles.getNombre(i)%></td>
									<td><%=Detalles.getApellidos(i)%></td>
									<td><%=Detalles.getEditorial(i)%></td>
									<td class="text-right"><%=Detalles.getCantidad(i)%></td>
									<td class="text-right"><%=Detalles.getPrecio(i)%> €</td>
								</tr>
								<%
									}
								%>
							</tbody>

						</table>
						<br> <input type="submit" name="volver" value="Volver"
							onclick="location.href='pedidos_todos.jsp'" class="btn button" /> <br>
					</div>
				</div>
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