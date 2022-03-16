package es.studium.Tienda_libros;
/**
 * @author Alvca
 * Libro 
 * * Representa un libro 
 * * Incluye identificador del libro, título, autor y precio
 */
public class Libro
{
	private int id;
	private String titulo;
	private String autor;
	private String apellidos;
	private double precio;
	public Libro()
	{
		setId(0);
		titulo = "";
		autor = "";
		apellidos = "";
		precio = 0.0;
	}
	public Libro(int i, String t, String a, String ap, double p)
	{
		setId(i);
		titulo = t;
		autor = a;
		apellidos = ap;
		precio = p;
	}
	public String getTitulo()
	{
		return titulo;
	}
	public String getAutor()
	{
		return autor;
	}
	public String getApellidos()
	{
		return apellidos;
	}
	public double getPrecio()
	{
		return precio;
	}
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
}
