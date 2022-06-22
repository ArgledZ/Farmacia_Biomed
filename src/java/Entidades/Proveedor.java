
package Entidades;

import java.util.Date;

/**
 *
 * @author Gustavo
 */
public class Proveedor extends Persona {
    
    private String observacion;

    public Proveedor() {
    }

 

    public Proveedor(String observacion, int Id_persona, String Nom_persona, String Ape_persona, Tipodocumento tipodocumento, int Numero_identicacion, int Edad_persona, String Nacioalidad_persona, String Empresa_persona, String Correo_persona, String Telf_persona, String Fecha_naci_persona, String Dir_persona, String Sex_persona) {
        super(Id_persona, Nom_persona, Ape_persona, tipodocumento, Numero_identicacion, Edad_persona, Nacioalidad_persona, Empresa_persona, Correo_persona, Telf_persona, Fecha_naci_persona, Dir_persona, Sex_persona);
        this.observacion = observacion;
    }
    
    public Proveedor(int proveedor) {
       this.Id_persona=proveedor;
    }


    public Proveedor(String proveedor) {
       this.Nom_persona=proveedor;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }
    
    public String toString()
    {
    return Nom_persona;
    }
    
    
    @Override
    public boolean equals(Object obj)
    {
        return this.Nom_persona.equals(((Proveedor) obj).Nom_persona);
    } 
    
}
