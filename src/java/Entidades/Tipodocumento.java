
package Entidades;

/**
 *
 * @author Gustavo
 */
public class Tipodocumento {
    
    private int Id_tipo_documento;
    private String Des_tipo_documento;

    public Tipodocumento() {
    }
    
    public Tipodocumento(int Id_tipo_documento) {
      this.Id_tipo_documento = Id_tipo_documento;   
    }

    public Tipodocumento(int Id_tipo_documento, String Des_tipo_documento) {
        this.Id_tipo_documento = Id_tipo_documento;
        this.Des_tipo_documento = Des_tipo_documento;
    }

    public int getId_tipo_documento() {
        return Id_tipo_documento;
    }

    public void setId_tipo_documento(int Id_tipo_documento) {
        this.Id_tipo_documento = Id_tipo_documento;
    }

    public String getDes_tipo_documento() {
        return Des_tipo_documento;
    }

    public void setDes_tipo_documento(String Des_tipo_documento) {
        this.Des_tipo_documento = Des_tipo_documento;
    }
    
    @Override
    public String toString()
    {
    
    return Des_tipo_documento;
    }
    
    @Override
     public boolean equals(Object obj)
    {
        return this.Id_tipo_documento == ((Tipodocumento) obj).Id_tipo_documento;
    }
}
