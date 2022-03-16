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
<title>Alta libros</title>
</head>
<body>
<body>
	<div class="container h-100 pt-4">
		<div class="row text-center justify-content-center align-items-center pt-3">
			<div class="col-6 text-center">
				<h1 class="display-4">Alta libros</h1>
					<hr />
				<%
					if (request.getAttribute("altaLibro") != null) {
						out.println("<div class='alert alert-success' role='alert'><p>" + request.getAttribute("altaLibro") + "</p></div>");
					} else if (request.getAttribute("errorLibroAlta") != null) {
						out.println(
						"<div class='alert alert-danger' role='alert'><p>" + request.getAttribute("errorLibroAlta") + "</p></div>");
					} else {
					%>
				<form name="AgregarLibroForm" action="gestion" method="POST"
					class="needs-validation" novalidate>
					<input type="hidden" name="todo" value="agregarlibro">
					<div class="form-group">
						<label for="titleInput">Título: </label> <input type="text"
							class="form-control" id="titleInput" name="titulo" placeholder="Título" required>
					</div>
					<div class="form-group">
						<label for="priceInput">Precio: </label> <input type="number"
							class="form-control" step="0.01" id="priceInput" name="precio"
							placeholder="Precio" required>
					</div>
					<div class="form-group">
						<label for="autorInput">Autor: </label> <select
							class="form-control custom-select" id="exampleFormControlSelect1"
							name="idAutor" required>
							<option value="">Elegir un autor...</option>
							<%
								// Scriplet 1: Carga los autores en el SELECT
								for (int i = 0; i < Autores.tamano(); i++) {
									out.println("<option value='" + Autores.getId(i) + "'>");
									out.println(Autores.getAutor(i) + " " + Autores.getApellidos(i));
									out.println("</option>");
								}
								%>
						</select>
					</div>
					<div class="form-group">
						<label for="editorialInput">Editorial: </label> <select
							class="form-control custom-select" id="exampleFormControlSelect1"
							name="idEditorial" required>
							<option value="">Elegir una editorial...</option>
							<%
								// Scriplet 1: Carga las editoriales en el SELECT
								for (int i = 0; i < Editoriales.tamano(); i++) {
									out.println("<option value='" + Editoriales.getId(i) + "'>");
									out.println(Editoriales.getEditorial(i));
									out.println("</option>");
								}
								%>
						</select>
					</div>
					<div class="form-group pt-3">
						<button type="submit" class="btn btn-success">Agregar libro</button>
					</div>
				</form>
				<%
					}
					%>
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