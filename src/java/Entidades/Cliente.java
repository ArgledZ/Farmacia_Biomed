
package Entidades;

import java.util.Date;

/**
 *
 * @author gcamo
 */
public class Cliente extends Persona {
    
    private Date fec_regis_cliente;
    private int puntos;

    public Cliente() {
    }

 

    public Cliente(Date fec_regis_cliente, int puntos, int Id_persona, String Nom_persona, String Ape_persona, Tipodocumento tipodocumento, int Numero_identicacion, int Edad_persona, String Nacioalidad_persona, String Empresa_persona, String Correo_persona, String Telf_persona, String Fecha_naci_persona, String Dir_persona, String Sex_persona) {
        super(Id_persona, Nom_persona, Ape_persona, tipodocumento, Numero_identicacion, Edad_persona, Nacioalidad_persona, Empresa_persona, Correo_persona, Telf_persona, Fecha_naci_persona, Dir_persona, Sex_persona);
        this.fec_regis_cliente = fec_regis_cliente;
        this.puntos = puntos;
    }

    public Date getFec_regis_cliente() {
        return fec_regis_cliente;
    }

    public void setFec_regis_cliente(Date fec_regis_cliente) {
        this.fec_regis_cliente = fec_regis_cliente;
    }

    public int getPuntos() {
        return puntos;
    }

    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }

  

    
    
}
