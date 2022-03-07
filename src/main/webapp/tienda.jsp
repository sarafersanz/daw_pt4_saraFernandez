<%-- Página de órdenes de pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.Tienda_libros.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pedido</title>
</head>
<body>
	<h1>Tienda Libros</h1>
	<hr />
	<br />
	<p>
		<strong>Elegir un libro y la cantidad:</strong>
	</p>
	<form name="AgregarForm" action="shopping" method="POST">
		<input type="hidden" name="todo" value="add">
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
		Cantidad:
		<input type="text" name="cantidad" size="10" value="1">
		<input type="submit" value="Añadir a la cesta">
	</form>
	<hr />
	<br />
	<%
	// Scriplet 2: Chequea el contenido de la cesta
	ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
	if (cesta != null && cesta.size() > 0) {
	%>
	<p>
		<strong>Tu cesta contiene:</strong>
	</p>
	<table border="1">
		<tr>
			<th>Autor</th>
			<th>Título</th>
			<th>Precio</th>
			<th>Cantidad</th>
			<th>&nbsp;</th>
		</tr>
		<%
		// Scriplet 3: Muestra los libros del carrito
		for (int i = 0; i < cesta.size(); i++) {
			ElementoPedido elementoPedido = cesta.get(i);
		%>
		<tr>
			<form name="borrarForm" action="shopping" method="POST">
				<input type="hidden" name="todo" value="remove"> <input
					type="hidden" name="indiceElemento" value="<%=i%>">
				<td><%=elementoPedido.getTitulo()%></td>
				<td><%=elementoPedido.getAutor()%></td>
				<td align="right"><%=elementoPedido.getPrecio()%> €</td>
				<td align="right"><%=elementoPedido.getCantidad()%></td>
				<td><input type="submit" value="Eliminar de la cesta"></td>
			</form>
		</tr>
		<%
		}
		%>
	</table>
	<br />
	<form name="checkoutForm" action="shopping" method="POST">
		<input type="hidden" name="todo" value="checkout"> <input
			type="submit" value="Confirmar compra">
	</form>
	<%
}
%>
</body>
</html>