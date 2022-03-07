package es.studium.Tienda_libros;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class Tienda_libros
{
	static ArrayList<Libro> tabla = new ArrayList<Libro>();
	private static DataSource pool;
	public static void cargarDatos() throws ServletException
	{
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
			ex.printStackTrace();
		}
	
		// Creamos objetos para la conexi�n
		Connection conn = null;
		Statement stmt = null;
		try
		{
			/*// Paso 1: Cargamos el driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Paso 2: Conectarse a la base de datos utilizando un objeto de la clase Connection
			String userName = "servletUser";
			String password = "Studium2022;";
			// URL de la base de datos
			String url = "jdbc:mysql://localhost:3306/tienda_libros?serverTimezone=UTC";*/
		
			conn = pool.getConnection();
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias
			String sqlStr = "SELECT * FROM libros, autores where id_autorFK = id_autor";
			ResultSet rs = stmt.executeQuery(sqlStr);
			Libro libro;
			while(rs.next())
			{
				libro = new Libro(rs.getInt("id_libro"), rs.getString("nombre_autor"),
						rs.getString("titulo_libro"), rs.getDouble("precio_libro"));
				tabla.add(libro);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
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
	}
	/**
	 * Devuelve el n�mero de libros obtenidos
	 */
	public static int tamano()
	{
		return tabla.size();
	}
	/**
	 * Devuelve el t�tulo del libro identificado con id_libro
	 */
	public static String getTitulo(int id_libro)
	{
		return tabla.get(id_libro).getTitulo();
	}
	/**
	 * Devuelve el autor del libro identificado con id_libro
	 */
	public static String getAutor(int id_libro)
	{
		return tabla.get(id_libro).getAutor();
	}
	/**
	 * Devuelve el precio del libro identificado con id_libro
	 */
	public static double getPrecio(int id_libro)
	{
		return tabla.get(id_libro).getPrecio();
	}
}