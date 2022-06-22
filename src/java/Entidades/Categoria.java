
package Entidades;

/**
 *
 * @author Gustavo
 */
public class Categoria {
    
     private int id_categoria;
    private String des_categoria;

    public Categoria() {
    }
    public Categoria(int id_categoria) {
      this.id_categoria = id_categoria;
    }
    public Categoria(String des_categoria) {
      this.des_categoria = des_categoria;
    }
    public Categoria(int id_categoria, String des_categoria) {
        this.id_categoria = id_categoria;
        this.des_categoria = des_categoria;
    }

 
   

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getDes_categoria() {
        return des_categoria;
    }

    public void setDes_categoria(String des_categoria) {
        this.des_categoria = des_categoria;
    }

     @Override
    public String toString()
    {
    return des_categoria;
    }
    
    @Override
    public boolean equals(Object obj)
    {
        return this.des_categoria.equals(((Categoria) obj).des_categoria);
    }
    
    
}
