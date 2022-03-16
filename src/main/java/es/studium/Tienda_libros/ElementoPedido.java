package es.studium.Tienda_libros;

public class ElementoPedido
{
	private int idLibro;
	private int cantidad;
	public ElementoPedido(int idLibro, int cantidad)
	{
		this.idLibro = idLibro;
		this.cantidad = cantidad;
	}
	public int getIdLibro()
	{
		return idLibro;
	}
	public void setIdLibro(int idLibro)
	{
		this.idLibro = idLibro;
	}
	public int getCantidad()
	{
		return cantidad;
	}
	public void setCantidad(int cantidad)
	{
		this.cantidad = cantidad;
	}
	
	public int getId()
	{
		return Tienda_libros.getId(idLibro);
	}
	
	public String getAutor()
	{
		return Tienda_libros.getAutor(idLibro);
	}
	public String getTitulo()
	{
		return Tienda_libros.getTitulo(idLibro);
	}
	public double getPrecio()
	{
		return Tienda_libros.getPrecio(idLibro);
	}
	
}
