package es.studium.Tienda_libros;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class Detalles {

	private static ArrayList<String> titulos = new ArrayList<String>();
	private static ArrayList<String> nombres = new ArrayList<String>();
	private static ArrayList<String> apellidos = new ArrayList<String>();
	private static ArrayList<String> editoriales = new ArrayList<String>();
	private static ArrayList<String> cantidades = new ArrayList<String>();
	private static ArrayList<String> precios = new ArrayList<String>();

	private static DataSource pool;

	public static void cargarDatos(int id) throws ServletException
	{
		titulos.clear();
		nombres.clear();
		apellidos.clear();
		editoriales.clear();
		cantidades.clear();
		precios.clear();
		
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
			// Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Ejecutar las sentencias
			String sqlStr = "SELECT l.titulo_libro, a.nombre_autor, a.apellidos_autor, e.nombre_editorial, pl.cantidad_pedido_libro, l.precio_libro FROM libros as l, pedidos_libros as pl, autores as a, editoriales as e WHERE a.id_autor=l.id_autorFK AND e.id_editorial=l.id_editorialFK AND l.id_libro=pl.id_libroFK AND pl.id_pedidoFK=" + id + " ;";
			ResultSet rs = stmt.executeQuery(sqlStr);
			// Recoger los resultados y procesarlos
			while(rs.next())
			{
				titulos.add(rs.getString("titulo_libro"));
				nombres.add(rs.getString("nombre_autor"));
				apellidos.add(rs.getString("apellidos_autor"));
				editoriales.add(rs.getString("nombre_editorial"));
				cantidades.add(rs.getString("cantidad_pedido_libro"));
				precios.add(rs.getString("precio_libro"));
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
		return titulos.size();
	}

	public static String getTitulo(int id)
	{
		return titulos.get(id);
	}

	public static String getNombre(int id)
	{
		return nombres.get(id);
	}

	public static String getApellidos(int id)
	{
		return apellidos.get(id);
	}
	public static String getEditorial(int id)
	{
		return editoriales.get(id);
	}
	public static String getCantidad(int id)
	{
		return cantidades.get(id);
	}
	public static String getPrecio(int id)
	{
		return precios.get(id);
	}
}
