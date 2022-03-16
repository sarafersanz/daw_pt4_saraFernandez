package es.studium.Tienda_libros;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;
/**
 * Encapsula la comunicación con la base de datos 
 * Almacena títulos, autores y precios en tres tablas
 */
public class Tienda_libros
{
	static ArrayList<Libro> tabla = new ArrayList<Libro>();
	private static DataSource pool;
	public static void cargarDatos() throws ServletException
	{
		tabla.clear();
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
	
		// Creamos objetos para la conexión
		Connection conn = null;
		Statement stmt = null;
		try
		{
			conn = pool.getConnection();
			// Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Ejecutar las sentencias
			String sqlStr = "SELECT l.id_libro, l.titulo_libro, a.nombre_autor, a.apellidos_autor, l.precio_libro  FROM libros as l, autores as a where l.id_autorFK = a.id_autor ORDER BY a.nombre_autor, a.apellidos_autor ASC";
			ResultSet rs = stmt.executeQuery(sqlStr);
			Libro libro;
			while(rs.next())
			{
				libro = new Libro(rs.getInt("id_libro"), rs.getString("titulo_libro"),
						rs.getString("nombre_autor"), rs.getString("apellidos_autor"), rs.getDouble("precio_libro"));
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
	 * Devuelve el número de libros obtenidos
	 */
	public static int tamano()
	{
		return tabla.size();
	}
	/**
	 * Devuelve el id del libro identificado con id_libro
	 */
	public static int getId(int id_libro)
	{
		return tabla.get(id_libro).getId();
	}
	/**
	 * Devuelve el título del libro identificado con id_libro
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
	 * Devuelve los apellidos del libro identificado con id_libro
	 */
	public static String getApellidos(int id_libro)
	{
		return tabla.get(id_libro).getApellidos();
	}
	/**
	 * Devuelve el precio del libro identificado con id_libro
	 */
	public static double getPrecio(int id_libro)
	{
		return tabla.get(id_libro).getPrecio();
	}
}