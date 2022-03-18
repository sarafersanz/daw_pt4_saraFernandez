package es.studium.Tienda_libros;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 * Servlet implementation class ServletControladorGestion
 */
@WebServlet("/gestion")
public class ServletControladorGestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static DataSource pool;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletControladorGestion() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init(ServletConfig conf) throws ServletException
	{
		super.init(conf);
		Autores.cargarDatos();
		Editoriales.cargarDatos();
		Tienda_libros.cargarDatos();
		Pedidos.cargarDatos();
		//Pedidos_todos.cargarDatos();
		
		try
		{
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tiendalibros");
			if(pool == null)
			{
				throw new ServletException("DataSource desconocida 'mysql_tiendalibros'");
			}
		}
		catch(NamingException ex){
			System.err.println("SQL exception: " + ex.getMessage());
		}

	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		// Recupera la sesi�n actual o crea una nueva si no existe
		HttpSession session = request.getSession(true);
		request.setCharacterEncoding("UTF-8");
		String nextPage = "";
		String todo = request.getParameter("todo");
		if(todo==null)
		{
			//Primer acceso, redirigir a gestion.jsp
			nextPage = "/gestion.jsp";
		}
		else if(todo.equals("altalibros")) {

			nextPage = "/altaLibros.jsp";
		}
		else if(todo.equals("agregarlibro")) {

			String titulo = request.getParameter("titulo");
			Float precio = Float.parseFloat(request.getParameter("precio"));
			//Recuperar id del autor seleccionado

			int idAutor = Integer.parseInt(request.getParameter("idAutor"));

			//recuperar id de la editorial seleccionada

			int idEditorial = Integer.parseInt(request.getParameter("idEditorial"));
	
			try
			{

				// Obtener una conexi�n del pool
				conn = pool.getConnection();
				stmt = conn.createStatement();

				//Insertar nuevo libro
				stmt.executeUpdate("INSERT INTO libros(id_libro, titulo_libro, precio_libro, id_autorFK, id_EditorialFK) VALUES(null, '" + titulo + "', " + precio + ", " + idAutor + ", " + idEditorial + ");");

			}
			catch(Exception e) {
				e.printStackTrace();
				String errorLibroAlta = "El libro no se ha podido dar de alta";
				request.setAttribute("errorLibroAlta", errorLibroAlta);
				nextPage="/altaLibros.jsp";
			}
			finally
			{
				try
				{
					// Cerramos el resto de recursos
					if(stmt != null)
					{
						stmt.close();
					}
					if(conn != null)
					{
						conn.close();
					}
				}
				catch(Exception ex)
				{
					ex.printStackTrace();
				}
			}

			String altaLibro = "El libro se ha dado de alta correctamente";
			request.setAttribute("altaLibro", altaLibro);
			nextPage="/altaLibros.jsp";
		}
		else if(todo.equals("modificarlibros")) {
			nextPage = "/modificarLibros.jsp";
		}
		else if(todo.equals("modificarlibro")){

			int id = Integer.parseInt(request.getParameter("id"));
			String titulo = request.getParameter("titulo");
			Float precio = Float.parseFloat(request.getParameter("precio"));

			try
			{

				// Obtener una conexi�n del pool
				conn = pool.getConnection();
				stmt = conn.createStatement();

				//Actualizamos el libro
				stmt.executeUpdate("UPDATE libros SET titulo_libro='" + titulo + "', precio_libro=" + precio + " WHERE id_libro=" + id + ";");

			}catch(Exception e) {
				e.printStackTrace();
			}
			finally
			{
				try
				{
					// Cerramos el resto de recursos
					if(stmt != null)
					{
						stmt.close();
					}
					if(conn != null)
					{
						conn.close();
					}
				}
				catch(Exception ex)
				{
					ex.printStackTrace();
					String errorLibroModificar = "El libro no se ha podido modificar";
					request.setAttribute("errorLibroModificar", errorLibroModificar);
					nextPage="/modificarLibros.jsp";
				}
			}
			String modificarLibro = "El libro se ha modificado correctamente";
			request.setAttribute("modificarLibro", modificarLibro);
			nextPage="/modificarLibros.jsp";
		}
		else if(todo.equals("autores")) {
			nextPage = "/autores.jsp";
		}
		else if(todo.equals("editoriales")) {
			nextPage = "/editoriales.jsp";
		}
		else if(todo.equals("libros")) {
			Tienda_libros.cargarDatos();
			nextPage = "/libros.jsp";
		}
		else if(todo.equals("pedidos-pendientes")) {
			nextPage = "/pedidos.jsp";
		}
		else if(todo.equals("cambioestado")) {
			int id = Integer.parseInt(request.getParameter("id"));
			ArrayList<String> nuevosEstados = new ArrayList<String>();
			try
			{

				// Obtener una conexi�n del pool
				conn = pool.getConnection();
				stmt = conn.createStatement();

				stmt.executeUpdate("UPDATE pedidos SET estado_pedido=1 WHERE id_pedido=" + id +";");

				Pedidos.cargarDatos();

				session.setAttribute("nuevosEstados", nuevosEstados);

			}catch(Exception e) {
				e.printStackTrace();
			}
			finally
			{
				try
				{
					// Cerramos el resto de recursos
					if(stmt != null)
					{
						stmt.close();
					}
					if(conn != null)
					{
						conn.close();
					}
				}
				catch(Exception ex)
				{
					ex.printStackTrace();
				}
				nextPage = "/pedidos.jsp";
			}
		}
		else if(todo.equals("detalles")) {
			int id = Integer.parseInt(request.getParameter("id"));
			
			Detalles.cargarDatos(id);
			
			nextPage = "/detalles.jsp";
		}
		else if(todo.equals("detalles_todos")) {
			int id = Integer.parseInt(request.getParameter("id"));
			
			Detalles.cargarDatos(id);
			
			nextPage = "/detalles_todos.jsp";
		}
		else if(todo.equals("pedidos")) {
			Pedidos_todos.cargarDatos();
			nextPage = "/pedidos_todos.jsp";
		}
		else if(todo.equals("logout")) {
			session.invalidate();
			nextPage = "/index.jsp";
		}

		ServletContext servletContext = getServletContext();
		RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher(nextPage);
		requestDispatcher.forward(request, response);	
	}	
}