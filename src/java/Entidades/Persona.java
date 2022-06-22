
package Entidades;

/**
 *
 * @author Gustavo
 */
public class Persona {
     int Id_persona;
    String Nom_persona;
    private String Ape_persona;
    private Tipodocumento tipodocumento;
    private int Numero_identicacion;
    private int Edad_persona;
    private String Nacioalidad_persona;
    private String Empresa_persona;
    private String Correo_persona;
    private String Telf_persona;
    private String Fecha_naci_persona;
    private String Dir_persona;
    private String Sex_persona;

    public Persona() {
        tipodocumento= new Tipodocumento();
    
    }

    public Persona(int Id_persona, String Nom_persona, String Ape_persona, Tipodocumento tipodocumento, int Numero_identicacion, int Edad_persona, String Nacioalidad_persona, String Empresa_persona, String Correo_persona, String Telf_persona, String Fecha_naci_persona, String Dir_persona, String Sex_persona) {
        this.Id_persona = Id_persona;
        this.Nom_persona = Nom_persona;
        this.Ape_persona = Ape_persona;
        this.tipodocumento = tipodocumento;
        this.Numero_identicacion = Numero_identicacion;
        this.Edad_persona = Edad_persona;
        this.Nacioalidad_persona = Nacioalidad_persona;
        this.Empresa_persona = Empresa_persona;
        this.Correo_persona = Correo_persona;
        this.Telf_persona = Telf_persona;
        this.Fecha_naci_persona = Fecha_naci_persona;
        this.Dir_persona = Dir_persona;
        this.Sex_persona = Sex_persona;
    }

    public int getId_persona() {
        return Id_persona;
    }

    public void setId_persona(int Id_persona) {
        this.Id_persona = Id_persona;
    }

    public String getNom_persona() {
        return Nom_persona;
    }

    public void setNom_persona(String Nom_persona) {
        this.Nom_persona = Nom_persona;
    }

    public String getApe_persona() {
        return Ape_persona;
    }

    public void setApe_persona(String Ape_persona) {
        this.Ape_persona = Ape_persona;
    }

    public Tipodocumento getTipodocumento() {
        return tipodocumento;
    }

    public void setTipodocumento(Tipodocumento tipodocumento) {
        this.tipodocumento = tipodocumento;
    }

    public int getNumero_identicacion() {
        return Numero_identicacion;
    }

    public void setNumero_identicacion(int Numero_identicacion) {
        this.Numero_identicacion = Numero_identicacion;
    }

    public int getEdad_persona() {
        return Edad_persona;
    }

    public void setEdad_persona(int Edad_persona) {
        this.Edad_persona = Edad_persona;
    }

    public String getNacioalidad_persona() {
        return Nacioalidad_persona;
    }

    public void setNacioalidad_persona(String Nacioalidad_persona) {
        this.Nacioalidad_persona = Nacioalidad_persona;
    }

    public String getEmpresa_persona() {
        return Empresa_persona;
    }

    public void setEmpresa_persona(String Empresa_persona) {
        this.Empresa_persona = Empresa_persona;
    }

    public String getCorreo_persona() {
        return Correo_persona;
    }

    public void setCorreo_persona(String Correo_persona) {
        this.Correo_persona = Correo_persona;
    }

    public String getTelf_persona() {
        return Telf_persona;
    }

    public void setTelf_persona(String Telf_persona) {
        this.Telf_persona = Telf_persona;
    }

    public String getFecha_naci_persona() {
        return Fecha_naci_persona;
    }

    public void setFecha_naci_persona(String Fecha_naci_persona) {
        this.Fecha_naci_persona = Fecha_naci_persona;
    }

    public String getDir_persona() {
        return Dir_persona;
    }

    public void setDir_persona(String Dir_persona) {
        this.Dir_persona = Dir_persona;
    }

    public String getSex_persona() {
        return Sex_persona;
    }

    public void setSex_persona(String Sex_persona) {
        this.Sex_persona = Sex_persona;
    }

    
    
}
