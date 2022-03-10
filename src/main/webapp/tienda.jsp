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
<title>Tienda</title>
</head>

<body id="LoginForm">
	<div class="container h-100">
		<div class="row h-100 text-center justify-content-center">
			<div class="col-10">
				<div class="row pt-5">
					<div class="col-12 text-center">
						<h1 class="pt-5 display-3">Tienda Libros</h1>
					</div>
				</div>
				<hr />
				<div class="row justify-content-center align-items-center">
					<div class="col-12 pt-5">
						<h3>Elegir un libro y la cantidad:</h3>
					</div>

					<div class="col-12 pt-3">
						<form name="AgregarForm" action="shopping" method="POST">
							<input type="hidden" name="todo" value="add" />
							Título: 
							<select name="idLibro">
								<%
								// Scriplet 1: Carga los libros en el SELECT
								for (int i = 0; i < Tienda_libros.tamano(); i++) {
									out.println("<option value='" + i + "'>");
									out.println(Tienda_libros.getTitulo(i) + " | " + Tienda_libros.getAutor(i) + " | " + Tienda_libros.getPrecio(i));
									out.println("</option>");
								}
								%>
							</select> 
							Cantidad: <input type="text" name="cantidad" size="10" value="1" />
							<input type="submit" value="Añadir a la cesta" class="btn button" />
						</form>
					</div>
				</div>
				<%
				// Scriplet 2: Chequea el contenido de la cesta
				ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
				if (cesta != null && cesta.size() > 0) {
				%>
				<div class="row justify-content-center align-items-center">
					<div class="col-12 pt-5">
						<h3>Tu cesta contiene:</h3>
					</div>
					<div class="col-12 pt-3">
						<table class="table">
							<thead class="thead-dark">
								<tr>
									<th scope="col">Autor</th>
									<th scope="col">Título</th>
									<th scope="col">Precio</th>
									<th scope="col">Cantidad</th>
									<th scope="col">&nbsp;</th>
								</tr>
							</thead>
							<tbody>
								<%
								// Scriplet 3: Muestra los libros del carrito
								for (int i = 0; i < cesta.size(); i++) {
									ElementoPedido elementoPedido = cesta.get(i);
								%>
								<tr>
									<form name="borrarForm" action="shopping" method="POST">
										<input type="hidden" name="todo" value="remove" /> <input
											type="hidden" name="indiceElemento" value="<%=i%>" />
										<td><%=elementoPedido.getTitulo()%></td>
										<td><%=elementoPedido.getAutor()%></td>
										<td class="text-right"><%=elementoPedido.getPrecio()%> €</td>
										<td class="text-right"><%=elementoPedido.getCantidad()%></td>
										<td><input type="submit" value="Eliminar de la cesta"
											class="btn button" /></td>
									</form>
								</tr>
									<%
									}
									%>
							</tbody>
						</table>
					</div>
					<div class="col-12 pt-3">
						<form name="checkoutForm" action="shopping" method="POST">
							<input type="hidden" name="todo" value="checkout" /> <input
								type="submit" value="Confirmar compra" class="btn button" />
						</form>
					</div>
						<%
						}
						%>
				</div>
			</div>
		</div>
	</div>
</body>

</html>