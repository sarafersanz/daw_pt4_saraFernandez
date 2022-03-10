package es.studium.Tienda_libros;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.Iterator;

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

@WebServlet("/shopping")
public class ServletControlador extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	// Pool de conexiones a la base de datos
			private DataSource pool;
	
	public void init(ServletConfig conf) throws ServletException
	{
		super.init(conf);
		try {
			Tienda_libros.cargarDatos();
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
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
	ServletException, IOException
	{
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
	ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		// Recupera la sesión actual o crea una nueva si no existe
		HttpSession session = request.getSession(true);
		// Recupera el carrito de la sesión actual
		@SuppressWarnings("unchecked")
		ArrayList<ElementoPedido> elCarrito = (ArrayList<ElementoPedido>)
		session.getAttribute("carrito");
		// Determina a qué página jsp se redirigirá
		String nextPage = "";
		String todo = request.getParameter("todo");
		if(todo==null)
		{
			// Primer acceso, redirigir a tienda.jsp
			nextPage = "/tienda.jsp";
		}
		else if(todo.equals("add"))
		{
			// Mandado por order.jsp con los parámetros idLibro y cantidad
			// Creamos un elementoPedido y lo añadimos al carrito
			ElementoPedido nuevoElementoPedido = new ElementoPedido(
					Integer.parseInt(request.getParameter("idLibro")),
					Integer.parseInt(request.getParameter("cantidad")));
			if(elCarrito==null)
			{
				// El carrito está vacío
				elCarrito = new ArrayList<>();
				elCarrito.add(nuevoElementoPedido);
				// Enlazar el carrito con la sesión
				session.setAttribute("carrito", elCarrito);
			}
			else
			{
				// Comprueba si el libro está ya en el carrito
				// Si lo está, actualizamos la cantidad
				// Si no está, lo añadimos
				boolean encontrado = false;
				Iterator<ElementoPedido> iter = elCarrito.iterator();
				while(!encontrado&&iter.hasNext())
				{
					ElementoPedido unElementoPedido = (ElementoPedido)iter.next();
					if(unElementoPedido.getIdLibro() == nuevoElementoPedido.getIdLibro())
					{
						unElementoPedido.setCantidad(unElementoPedido.getCantidad() +
								nuevoElementoPedido.getCantidad());
						encontrado = true;
					}
				}
				if(!encontrado)
				{
					// Lo añade al carrito
					elCarrito.add(nuevoElementoPedido);
				}
			}
			// Volvemos a order.jps para seguir con la compra
			nextPage = "/tienda.jsp";
		}
		else if(todo.equals("remove"))
		{
			// Enviado por order.jsp con el parámetro indiceElemento
			// Borra el elemento indiceElemento del carrito
			int indiceCarrito = Integer.parseInt(request.getParameter("indiceElemento"));
			elCarrito.remove(indiceCarrito);
			// Vuelve a order.jsp para seguir con la compra
			nextPage = "/tienda.jsp";
		}
		else if (todo.equals("checkout"))
		{
			// Enviado por order.jsp
			// Calcula el precio total de todos los elementos del carrito
			double precioTotal = 0;
			int cantidadTotalOrdenada = 0;
			for(ElementoPedido item: elCarrito)
			{
				double precio = item.getPrecio();
				int cantidadOrdenada = item.getCantidad();
				precioTotal += precio * cantidadOrdenada;
				cantidadTotalOrdenada += cantidadOrdenada;
			}
			// Da formato al precio con dos decimales
			StringBuilder sb = new StringBuilder();
			Formatter formatter = new Formatter(sb);
			formatter.format("%.2f", precioTotal);
			formatter.close();
			// Coloca el precioTotal y la cantidadtotal en el request
			request.setAttribute("precioTotal", sb.toString());
			request.setAttribute("cantidadTotal", cantidadTotalOrdenada+"");
			// Conectar a la BD y crear un pedido con los datos de elCarrito
			// Redirige a checkout.jsp
			nextPage = "/checkout.jsp";
		}
		ServletContext servletContext = getServletContext();
		RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher(nextPage);
		requestDispatcher.forward(request, response);
	}
}