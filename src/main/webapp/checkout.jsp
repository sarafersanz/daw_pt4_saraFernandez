<%-- Página de confirmación del pedido --%>
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
<title>Confirmación</title>
</head>



<body id="LoginForm">
	<div class="container h-100">
		<div class="row h-100 justify-content-center text-center">
			<div class="col-10">
				<div class="row pt-5">
					<div class="col-12 text-center justify-content-center">
						<h1 class="pt-5 display-3">Tienda Libros: Confirmación</h1>
					</div>
				</div>
				<hr />
				<%
				if (request.getAttribute("compra") != null) {
					out.println("<div class='alert alert-success' role='alert'><p>" + request.getAttribute("compra") + "</p></div>");
					out.println(
					"<br><form action='shopping'><button type='submit' class='btn button'>Seguir comprando</button></form>");
				} else if (request.getAttribute("errorCompra") != null) {
					out.println(
					"<div class='alert alert-danger' role='alert'><p>" + request.getAttribute("errorCompra") + "</p></div>");
				} else {
				%>

				<div class="row justify-content-center align-items-center">
					<div class="col-12 pt-5">
						<h3>Vas a comprar los siguientes libros:</h3>
					</div>
					<div class="col-12 pt-3">
						<table class="table table-striped">
							<thead class="thead-dark">
								<tr>
									<th scope="col">Autor</th>
									<th scope="col">Título</th>
									<th scope="col">Precio</th>
									<th scope="col">Cantidad</th>
								</tr>
							</thead>
							<tbody>
								<%
								// Muestra los elementos del carrito
								ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
								for (ElementoPedido item : cesta) {
								%>
								<tr>
									<td><%=item.getTitulo()%></td>
									<td><%=item.getAutor()%></td>
									<td class="text-right"><%=item.getPrecio()%> €</td>
									<td class="text-right"><%=item.getCantidad()%></td>
								</tr>
								<%
								}
								%>
								<tr>
									<th colspan="2">Total</th>
									<th class="text-right"><%=request.getAttribute("precioTotal")%> €</th>
									<th class="text-right"><%=request.getAttribute("cantidadTotal")%></th>
								</tr>
							</tbody>

						</table>
						<br> <input type="submit" name="volver"
							value="Seguir comprando" onclick="location.href='shopping'"
							class="btn button" /> <br>
					</div>
					<div class="col-12 pt-3">
						<form name="checkoutForm" action="shopping" method="POST">
							<input type="hidden" name="todo" value="confirm" /> <input
								type="submit" name="confirmar" value="Confirmar pedido"
								class="btn btn-success" />
						</form>
					</div>
				</div>
				<%
				}
				%>
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