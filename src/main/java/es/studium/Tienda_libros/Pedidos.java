package es.studium.Tienda_libros;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class Pedidos {

	private static ArrayList<String> ids = new ArrayList<String>();
	private static ArrayList<String> fechas = new ArrayList<String>();
	private static ArrayList<String> totales = new ArrayList<String>();
	private static ArrayList<String> estados = new ArrayList<String>();
	private static ArrayList<String> usuarios = new ArrayList<String>();

	private static DataSource pool;

	public static void cargarDatos() throws ServletException
	{
		ids.clear();
		fechas.clear();
		totales.clear();
		estados.clear();
		usuarios.clear();
		
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
			String sqlStr = "SELECT p.id_pedido, p.fecha_pedido, p.total_pedido, IF(p.estado_pedido = '0', 'PENDIENTE', 'ENVIADO') as estado_pedido, u.nombre_usuario FROM pedidos as p, usuarios as u WHERE p.estado_pedido = 0 and u.id_usuario = p.id_usuarioFK ORDER BY p.id_pedido DESC";
			ResultSet rs = stmt.executeQuery(sqlStr);
			// Recoger los resultados y procesarlos
			int cont = 0;
			while(rs.next())
			{
				ids.add(cont, rs.getString("id_pedido"));
				fechas.add(cont, rs.getString("fecha_pedido"));
				totales.add(cont, rs.getString("total_pedido"));
				estados.add(cont, rs.getString("estado_pedido"));
				usuarios.add(cont, rs.getString("nombre_usuario"));
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
		return fechas.size();
	}

	public static String getId(int idpedido)
	{
		return ids.get(idpedido);
	}

	public static String getFecha(int idpedido)
	{
		return fechas.get(idpedido);
	}

	public static String getTotal(int idpedido)
	{
		return totales.get(idpedido);
	}
	public static String getEstado(int idpedido)
	{
		return estados.get(idpedido);
	}
	public static String getUsuario(int idpedido)
	{
		return usuarios.get(idpedido);
	}
}