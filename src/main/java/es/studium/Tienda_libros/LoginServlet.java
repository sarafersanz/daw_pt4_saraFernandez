package es.studium.Tienda_libros;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

@WebServlet(
		name = "LoginServlet",
		urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	// Pool de conexiones a la base de datos
	ServletContext servletContext = null;
	private DataSource pool;
	Connection conn = null;
	Statement stmt = null;
	
	public LoginServlet()
	{
		super();
	}
	public void init(ServletConfig config) throws ServletException
	{
		try
		{
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tiendalibros");
			servletContext = config.getServletContext();
			if(pool == null)
			{
				throw new ServletException("DataSource desconocida 'mysql_tiendalibros'");
			}
		}
		catch(NamingException ex){}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String nextPage = null;
		try
		{
			// Obtener una conexión del pool
			conn = pool.getConnection();
			stmt = conn.createStatement();
			
			// Recuperar los parámetros usuario y password de la petición request
			String usuario = request.getParameter("usuario");
			String password = request.getParameter("password");
			
			// Validar los parámetros de la petición request
			if(usuario.length()==0)
			{
				nextPage = "/index.jsp";
				request.setAttribute("respuesta", "Credenciales incorrectas");
			}
			else if(password.length()==0)
			{
				nextPage = "/index.jsp";
				request.setAttribute("respuesta", "Credenciales incorrectas");
			}
			else
			{
				// Verificar que existe el usuario y su correspondiente clave
				StringBuilder sqlStr = new StringBuilder();
				sqlStr.append("SELECT * FROM usuarios WHERE ");
				sqlStr.append("STRCMP(usuarios.nombre_usuario, '").append(usuario).append("') = 0");
				sqlStr.append(" AND STRCMP(usuarios.clave_usuario, MD5('").append(password).append("')) = 0");
				ResultSet rset = stmt.executeQuery(sqlStr.toString());
				if(!rset.next())
				{
					// Si el resultset  está vacío
					nextPage = "/index.jsp";
					request.setAttribute("respuesta", "Credenciales incorrectas");
				}
					// Si el resultset no está vacío
				else
				{
					// Si los datos introducidos son correctos
					// Crear una sesión nueva y guardar el usuario como variable de sesión
					// Primero, invalida la sesión si ya existe
					HttpSession session = request.getSession(false);
					if(session != null)
					{
						session.invalidate();
						
					}
					session = request.getSession(true);
					synchronized(session)
					{
						session.setAttribute("usuario", usuario);
						int tipo = rset.getInt("tipo_usuario");
						if(tipo == 0) {
							nextPage = "/tienda.jsp";
						}else {
							nextPage = "/gestion.jsp";
						}
					}

				}
			}

		}
		catch(SQLException ex)
		{
			nextPage = "index.jsp";
		}
		finally
		{
			// Cerramos objetos
			try
			{
				if(stmt != null)
				{
					stmt.close();
				}
				if(conn != null)
				{
					// Esto devolvería la conexión al pool
					conn.close();
				}
			}
			catch(SQLException ex){}
		}
		// Redireccionamiento
		RequestDispatcher requestDispatcher =
				servletContext.getRequestDispatcher(nextPage);
		requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
