package es.studium.Tienda_libros;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class Autores {
	
	private static ArrayList<String> ids = new ArrayList<String>();
	private static ArrayList<String> autores = new ArrayList<String>();
	private static ArrayList<String> apellidos = new ArrayList<String>();
	
	private static DataSource pool;
	
	public static void cargarDatos() throws ServletException
	{
		try
		{
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool =
					(DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tiendalibros");
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
			conn = pool.getConnection();
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias
			String sqlStr = "SELECT autores.id_autor, autores.nombre_autor, autores.apellidos_autor FROM autores ORDER BY nombre_autor, apellidos_autor ASC;";
			ResultSet rs = stmt.executeQuery(sqlStr);
			// Paso 5: Recoger los resultados y procesarlos
			int cont = 0;
			while(rs.next())
			{
				ids.add(cont, rs.getString("id_autor"));
				autores.add(cont, rs.getString("nombre_autor"));
				apellidos.add(cont, rs.getString("apellidos_autor"));
				cont++;
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
	
	
	public static int tamano()
	{
		return autores.size();
	}
	
	public static String getId(int idautor)
	{
		return ids.get(idautor);
	}
	
	public static String getAutor(int idautor)
	{
		return autores.get(idautor);
	}
	public static String getApellidos(int idautor)
	{
		return apellidos.get(idautor);
	}
	
}