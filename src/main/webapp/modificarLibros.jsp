<%@page import="jdk.internal.misc.FileSystemOption"%>
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
<title>Modificar Libros</title>
</head>
<body>
	<div class="container h-100 pt-4">
		<div
			class="row text-center justify-content-center align-items-center pt-3">
			<div class="col-6 text-center">
				<h1 class="display-4">Modificar libros</h1>
				<hr />
				<%
				if (request.getAttribute("modificarLibro") != null) {
					out.println("<div class='alert alert-success' role='alert'><p>" + request.getAttribute("modificarLibro")
					+ "</p></div>");
				} else if (request.getAttribute("errorLibroModificar") != null) {
					out.println("<div class='alert alert-danger' role='alert'><p>" + request.getAttribute("errorLibroModificar")
					+ "</p></div>");
				} else {
				%>
				<label for="libroInput" class="h4">Libro: </label>
				<form name="ModificarLibroSelect" action="modificarLibros.jsp"
					method="POST" class="needs-validation form-inline" novalidate>
					<input type="hidden" name="todo" value="modificarlibro">
					<div class="form-group">

						<select class="form-control custom-select"
							id="exampleFormControlSelect1" name="idLibro" required>
							<%
							// Scriplet 1: Carga los libros en el SELECT
							for (int i = 0; i < Tienda_libros.tamano(); i++) {
								out.println("<option value='" + i + "'>");
								out.println(Tienda_libros.getTitulo(i));
								out.println("</option>");
							}
							%>
						</select>
					</div>
					<div style="margin-left: 10px;">
						<button type="submit" class="btn button">Seleccionar</button>
					</div>
				</form>

				<%
				String todo = request.getParameter("todo");
				if (todo.equals("modificarlibro")) {
				%>


				<form name="ModificarLibroForm" action="gestion" method="POST"
					class="needs-validation" novalidate>
					<input type="hidden" name="todo" value="modificarlibro"> <input
						type="hidden" name="id"
						value="<%=Tienda_libros.getId(Integer.parseInt(request.getParameter("idLibro")))%>" />

					<div class="form-group">
						<label for="titleInput">Título: </label> <input type="text"
							class="form-control" id="titleInput" name="titulo"
							value="<%=Tienda_libros.getTitulo(Integer.parseInt(request.getParameter("idLibro")))%>"
							required>
					</div>
					<div class="form-group">
						<label for="priceInput">Precio: </label> <input type="number"
							class="form-control" step="0.01" id="priceInput" name="precio"
							value="<%=Tienda_libros.getPrecio(Integer.parseInt(request.getParameter("idLibro")))%>"
							required>
					</div>
					<button type="submit" class="btn btn-success"
						value="modificarlibro">Modificar libro</button>
				</form>
				<%
				}
				}
				%>
				<br>
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