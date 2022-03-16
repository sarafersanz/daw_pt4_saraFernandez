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
<title>Gestión Tienda Libros</title>
</head>
<body id="LoginForm">
	<div class="container h-100">
		<div class="row text-center justify-content-center">
			<div class="col-10">
				<div class="row pt-5 justify-content-center">
					<div class="col-12 text-center">
						<h1 class="pt-5 display-3">Gestión Tienda Libros</h1>
					</div>
					<nav
						class="navbar navbar-expand-lg navbar-light bg-orange mt-5 rounded-top rounded-bottom">
						<a class="navbar-brand" href="#">Gestión Tienda</a>
						<button class="navbar-toggler" type="button"
							data-toggle="collapse" data-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>

						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav mr-auto">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
									role="button" data-toggle="dropdown" aria-expanded="false">
										Autores </a>
									<div class="dropdown-menu bg-orange-opacity"
										aria-labelledby="navbarDropdown">
										<form name="autoresForm" action="gestion" method="POST">
											<input type="hidden" name="todo" value="autores">
											<button type="submit" class="dropdown-item"
												value="Ver Autores">Ver Autores</button>
										</form>
									</div></li>
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
									role="button" data-toggle="dropdown" aria-expanded="false">
										Editoriales </a>
									<div class="dropdown-menu bg-orange-opacity"
										aria-labelledby="navbarDropdown">
										<form name="editorialesForm" action="gestion" method="POST">
											<input type="hidden" name="todo" value="editoriales">
											<button type="submit" class="dropdown-item"
												value="Ver Editoriales">Ver Editoriales</button>
										</form>
									</div></li>
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
									role="button" data-toggle="dropdown" aria-expanded="false">
										Libros </a>
									<div class="dropdown-menu bg-orange-opacity"
										aria-labelledby="navbarDropdown">
										<form name="librosForm" action="gestion" method="POST">
											<input type="hidden" name="todo" value="altalibros">
											<button type="submit" class="dropdown-item"
												value="Ver Libros">Alta</button>
										</form>
										<form name="librosForm" action="gestion" method="POST">
											<input type="hidden" name="todo" value="modificarlibros">
											<button type="submit" class="dropdown-item"
												value="Ver Libros">Modificación</button>
										</form>
										<form name="librosForm" action="gestion" method="POST">
											<input type="hidden" name="todo" value="libros">
											<button type="submit" class="dropdown-item"
												value="Ver Libros">Ver Libros</button>
										</form>
									</div></li>
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
									role="button" data-toggle="dropdown" aria-expanded="false">
										Pedido </a>
									<div class="dropdown-menu bg-orange-opacity"
										aria-labelledby="navbarDropdown">
										<form name="librosForm" action="gestion" method="POST">
											<input type="hidden" name="todo" value="pedidos-pendientes">
											<button type="submit" class="dropdown-item"
												value="Actualizar pedidos">Pedidos pendientes</button>
										</form>
										<form name="librosForm" action="gestion" method="POST">
											<input type="hidden" name="todo" value="pedidos">
											<button type="submit" class="dropdown-item"
												value="Actualizar pedidos">Ver pedidos</button>
										</form>
									</div></li>
								<li class="nav-item" style="text-align: center;">
									<form name="logoutForm" action="gestion" method="POST">
										<input type="hidden" name="todo" value="logout">
										<button type="submit" class="nav-link no-style">Salir</button>
									</form>
								</li>
							</ul>
						</div>
					</nav>
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