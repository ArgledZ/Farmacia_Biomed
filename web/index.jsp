<%-- 
    Document   : index
    Created on : 15 jun. 2022, 13:57:46
    Author     : Gustavo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Clinica Biomed - Resultados en Linea</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
   
   
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />   
<link rel="Shortcut Icon" href="ICONOS/images.jpg">  
<link rel="stylesheet" type="text/css" href="css/styleresultados.css?v=1.0">
<link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/sweetalert2.css"> 
<script src="js/sweetalert2019.js" ></script>

       <script>
  function valida(){
                var login = document.getElementById("usuario").value;
                var pass = document.getElementById("contrasena").value;
                if(login == "" || pass=="" ){
                Swal.fire({
                    title: '<strong style="color:black;font-family:OswaldLight;">Atención </strong>',
                    text:"Debes ingresar un usuario y contraseña",
                    type: 'warning',
                    allowOutsideClick:false,
                    showCancelButton: false,
                    confirmButtonColor: '#DB0000',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'ok',
                    cancelButtonText: 'No, Cancelar',
                  });
                }else{
                    
                   document.frmMnt.action = "validar?accion=Ingresar&usuario=" + login +"&contrasena=" + pass ;
                    document.frmMnt.submit();
                }
            }
    </script>


  </head>
  <body>
    <div class="container" >
      <div class="forms-container">
        <div class="signin-signup">
         <!------------>
       
         <div class="wrapper">
        
          <div class="title">
    ACCESO AL SISTEMA</div>
            
    <form id="frmMnt" name="frmMnt" method="POST" >
    <img src="ICONOS/images.jpg" style="width:100px">
            <div class="field">
              <input type="text" name="usuario" id="usuario" >
              <label><i class="fa fa-user"></i> Usuario</label>
            </div>
             <div class="field">
              <input type="password" name="contrasena" id="contrasena" >
              <label><i class="fa fa-key"></i> Contraseña</label>
            </div>
    
             <div class="field">
              <input type="button" name="accion" value="Ingresar" id="btnIngresar" onclick="valida()">
         
            </div>
            
          
          
    </form>

   
    <div>
<center>
<img src="ICONOS/gusoft.png" class="imgres" alt="">
<br>
<span style="font-size:14px;"> <a href="https://www.facebook.com/Gusoft/"> Software de gestión comercial y de servicios Gusoft Technology </a></span>
 </center>
 </div>




    </div>

 

         <!-------------------->
          
        </div>
      </div>

      <div class="panels-container">
        <div class="panel left-panel">
          <div class="content">
            <h1 class="titulo">CLÍNICA BIOMED</h1>
            
          
            <p>
            &copy; 2021 Clinica Biomed | Todos los derechos reservados |  Úbicanos en: AV.Batangrande Mza.15 –Lte.6,7 - A Cel.979505192 - Tel (074) 316689
            </p>
           
          </div>
          <img src="ICONOS/acceso.svg" class="image" alt="" />
        </div>
     
      </div>
    </div>

    <script src="js/jquery.min.js"></script>
   

  
  </body>
</html>


