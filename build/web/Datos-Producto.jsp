<%-- 
    Document   : Datos-Producto
    Created on : 28/06/2022, 11:56:56 AM
    Author     : gcamo
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Lote"%>
<%@page import="Entidades.Categoria"%>
<%@page import="Entidades.Producto"%>
<%@page import="Entidades.Proveedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    #oculta{
        display:none;
    }
</style>
<!-- Content -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Default box -->
            <div class="card">

                <div class="card-body">

                    <div class="alert alert-info alert-styled-left text-blue-800 content-group d-flex justify-content-between">
                        <div> <span class="btn text-semibold text-light"><i class="icon fas fa-user"></i>Lista de Productos</span></div>
                        <div><button type="button" class="btn btn-outline-light btn-block" data-toggle="modal" data-target="#modal-nuevo"><i class="fa fa-user-plus"></i> Nuevo Producto</button></div>


                    </div>

                    <!-- /.card-header -->
                    <div class="card-body">
                        <table id="tablaProductos" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Categoria</th>
                                    <th>Reg.Sanitario</th>
                                    <th>Cod Med</th>
                                    <th>Medicamento</th>
                                    <th>Precio Compra</th>
                                    <th>Precio Venta</th>
                                    <th>Concentracion</th>
                                    <th>Stock</th>
                                    <th>Dias para Vencer</th>
                                    <th>Fecha Vencimiento</th>
                                    <th>Proveedor</th>
                                </tr>
                            </thead>
                            <tbody id="tbProductos">
                                <%if (session.getAttribute("listaProductos") != null) {
                                        List<Lote> lstLotes = (List<Lote>) session.getAttribute("listaProductos");
                                        for (int i = 0; i < lstLotes.size(); i++) {
                                            Lote lot = lstLotes.get(i);
                                %>

                                <tr data-idcodigo="<%=lot.getId_lote()%>" data-idcategoria="<%=lot.getCategoria().getId_categoria()%>" data-idproducto="<%=lot.getProducto().getId_producto()%>">
                                    <td><%=lot.getCategoria().getDes_categoria()%></td>
                                    <td><%=lot.getProducto().getReg_sanitario()%></td>     

                                    <td><%=lot.getProducto().getId_producto()%></td>
                                    <td><%=lot.getProducto().getNombre_producto()%></td>

                                    <td><%=lot.getProducto().getPrecio_compra()%></td>
                                    <td><%=lot.getProducto().getPrecio_venta()%></td>

                                    <td><%=lot.getProducto().getConcentracion_producto()%></td>
                                    <td><%=lot.getStock()%></td>

                                    <td>
                                        <%

                                            SimpleDateFormat dtf = new SimpleDateFormat("dd-MM-yyyy");
                                            Calendar calendar = Calendar.getInstance();
                                            Date dateObj = calendar.getTime();
                                            String formattedDate = dtf.format(dateObj);
                                            String fechaInicial = formattedDate;

                                            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                                            
                                            Date fechaobj = new SimpleDateFormat("yyyy-MM-dd").parse(lot.getFecha_vencimiento());     
                                            String fechaTexto = formatter.format(fechaobj);

                                            String[] fechaI = fechaInicial.split("-");
                                            String[] fechaF = fechaTexto.split("-");

                                            Calendar cal = Calendar.getInstance();

                                            cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(fechaI[0]));
                                            cal.set(Calendar.MONTH, Integer.parseInt(fechaI[1]));
                                            cal.set(Calendar.YEAR, Integer.parseInt(fechaI[2]));
                                            Date firstDate = cal.getTime();

                                            cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(fechaF[0]));
                                            cal.set(Calendar.MONTH, Integer.parseInt(fechaF[1]));
                                            cal.set(Calendar.YEAR, Integer.parseInt(fechaF[2]));
                                            Date secondDate = cal.getTime();

                                            long diferencia = secondDate.getTime() - firstDate.getTime();

                                            out.println(String.valueOf((diferencia / 1000 / 60 / 60 / 24)));

                                        %>
                                    </td>
                                    <td><%=lot.getFecha_vencimiento()%></td>

                                    <td><%=lot.getProveedor().getNom_persona()%></td>

                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.card-body -->
                </div>
                <!-- /.card -->

            </div>
            <!-- /.card-body -->

        </div>
        <!-- /.card -->
    </div>
</div>
<!-- /.content -->

<div class="modal fade" id="modal-nuevo" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Nuevo Producto</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"> <i class="fas fa-window-close"></i></span>
                </button>
            </div>
            <form name="frmnuevo" method="post">
                <div class="modal-body">

                    <div class="alert alert-info alert-styled-left text-blue-800 content-group modal-title">
                        <span class="text-semibold">Estimado usuario</span>
                        Los campos con <span class="text-danger"> * </span> son necesarios.
                    </div>                
                    <div class="row mt-3">
                        <div class="col-lg-3 col-6">
                            <label for="uname" class="font-weight-light">Categoria</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-address-book"></i></span>
                                </div>
                                <select class="form-control" name="descate" id="descaten">
                                    <%if (session.getAttribute("listadeCategorias") != null) {
                                            List<Categoria> lstCategoria = (List<Categoria>) session.getAttribute("listadeCategorias");
                                            for (int i = 0; i < lstCategoria.size(); i++) {
                                                Categoria Cate = lstCategoria.get(i);
                                    %>
                                    <option value="<%=Cate.getId_categoria()%>"><%=Cate.getDes_categoria()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select> 
                            </div>        
                        </div>                       
                        <div class="col-lg-3 col-6">
                            <!-- small box -->
                            <label for="uname" class="font-weight-light">Categoria</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                                </div>
                                <input type="text" class="form-control"  id="txtnomn" placeholder="Ingrese Nombres" name="nombres" required>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <!-- small box -->
                            <label for="uname" class="font-weight-light">Apellidos:</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                                </div>
                                <input type="text" class="form-control"  id="txtapen" placeholder="Ingrese Apellidos" name="apellidos" required>
                                <div class="valid-feedback">Válido.</div>
                                <div class="invalid-feedback">Por favor llena este campo.</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <!-- small box -->
                            <label for="uname" class="font-weight-light">Tipo Documento</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="far fa-address-card"></i></span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <!-- small box -->

                            <label for="uname" class="font-weight-light">Numero Documento</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-address-card "></i></span>
                                </div>
                                <input type="text" class="form-control"  id="txtnumeron" placeholder="Ingrese Apellidos" name="numerodocumento" required>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-6">
                            <!-- small box -->
                            <label for="uname" class="font-weight-light">Nacionalidad</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-flag"></i></span>
                                </div>
                                <select class="form-control" name="nacion" id="txtnacion">
                                    <option>Seleccione una Nacionalidad</option>
                                    <option value="Peruana">Perú</option>
                                    <option value="Venezolana">Venezuela</option>
                                </select>    
                                <!--<input type="text" class="form-control"  id="txtnacion" placeholder="Ingrese Apellidos" name="nacionalidad" required> -->
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <label for="uname" class="font-weight-light">Empresa</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-building"></i></span>
                                </div>
                                <input type="text" class="form-control"  id="txtempresan" placeholder="Ingrese Apellidos" name="empresa" required>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <label for="uname" class="font-weight-light">Email</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-at"></i></span>
                                </div>
                                <input type="text" class="form-control"  id="txtemailn" placeholder="Ingrese Correo" name="email" required>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <label for="uname" class="font-weight-light">Teléfono</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-phone"></i></span>
                                </div>
                                <input type="text" class="form-control" id="txttelfn" placeholder="Ingrese Telefono" name="telf" required>
                            </div>
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-6">
                            <label for="uname" class="font-weight-light">Dirección</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-map-marked-alt"></i></span>
                                </div>
                                <input type="text" class="form-control" id="txtdirn" placeholder="Ingrese Direccion" name="direccion" required>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <label for="uname" class="font-weight-light">Sexo</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-venus-mars "></i></span>
                                </div>
                                <select class="form-control" name="sexo" id="sexon">
                                    <option>Seleccione un Sexo</option>
                                    <option value="M">Masculino</option>
                                    <option  value="F">Femenino</option>
                                </select>   
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <label for="uname" class="font-weight-light">Fecha Nac.</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                                <input type="date" class="form-control"  id="txtedadn" placeholder="Ingrese Fecha de Nacimiento" name="edad" required>
                            </div>
                        </div>         
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="Agregar()">Agregar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script>
    $(document).ready(function () {

        var table;
        table = $('#tablaProductos').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "responsive": true,
            language: {
                "processing": "Procesando...",
                "lengthMenu": "Mostrar _MENU_ registros",
                "zeroRecords": "No se encontraron resultados",
                "emptyTable": "Ningún dato disponible en esta tabla",
                "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                "infoFiltered": "(filtrado de un total de _MAX_ registros)",
                "search": "Buscar:",
                "infoThousands": ",",
                "loadingRecords": "Cargando...",
                "paginate": {
                    "first": "Primero",
                    "last": "Último",
                    "next": "Siguiente",
                    "previous": "Anterior"
                },
                "aria": {
                    "sortAscending": ": Activar para ordenar la columna de manera ascendente",
                    "sortDescending": ": Activar para ordenar la columna de manera descendente"
                },
                "buttons": {
                    "copy": "Copiar",
                    "colvis": "Visibilidad",
                    "collection": "Colección",
                    "colvisRestore": "Restaurar visibilidad",
                    "copyKeys": "Presione ctrl o u2318 + C para copiar los datos de la tabla al portapapeles del sistema. <br \/> <br \/> Para cancelar, haga clic en este mensaje o presione escape.",
                    "copySuccess": {
                        "1": "Copiada 1 fila al portapapeles",
                        "_": "Copiadas %d fila al portapapeles"
                    },
                    "copyTitle": "Copiar al portapapeles",
                    "csv": "CSV",
                    "excel": "Excel",
                    "pageLength": {
                        "-1": "Mostrar todas las filas",
                        "_": "Mostrar %d filas"
                    },
                    "pdf": "PDF",
                    "print": "Imprimir"
                },
                "autoFill": {
                    "cancel": "Cancelar",
                    "fill": "Rellene todas las celdas con <i>%d<\/i>",
                    "fillHorizontal": "Rellenar celdas horizontalmente",
                    "fillVertical": "Rellenar celdas verticalmentemente"
                },
                "decimal": ",",
                "searchBuilder": {
                    "add": "Añadir condición",
                    "button": {
                        "0": "Constructor de búsqueda",
                        "_": "Constructor de búsqueda (%d)"
                    },
                    "clearAll": "Borrar todo",
                    "condition": "Condición",
                    "conditions": {
                        "date": {
                            "after": "Despues",
                            "before": "Antes",
                            "between": "Entre",
                            "empty": "Vacío",
                            "equals": "Igual a",
                            "notBetween": "No entre",
                            "notEmpty": "No Vacio",
                            "not": "Diferente de"
                        },
                        "number": {
                            "between": "Entre",
                            "empty": "Vacio",
                            "equals": "Igual a",
                            "gt": "Mayor a",
                            "gte": "Mayor o igual a",
                            "lt": "Menor que",
                            "lte": "Menor o igual que",
                            "notBetween": "No entre",
                            "notEmpty": "No vacío",
                            "not": "Diferente de"
                        },
                        "string": {
                            "contains": "Contiene",
                            "empty": "Vacío",
                            "endsWith": "Termina en",
                            "equals": "Igual a",
                            "notEmpty": "No Vacio",
                            "startsWith": "Empieza con",
                            "not": "Diferente de"
                        },
                        "array": {
                            "not": "Diferente de",
                            "equals": "Igual",
                            "empty": "Vacío",
                            "contains": "Contiene",
                            "notEmpty": "No Vacío",
                            "without": "Sin"
                        }
                    },
                    "data": "Data",
                    "deleteTitle": "Eliminar regla de filtrado",
                    "leftTitle": "Criterios anulados",
                    "logicAnd": "Y",
                    "logicOr": "O",
                    "rightTitle": "Criterios de sangría",
                    "title": {
                        "0": "Constructor de búsqueda",
                        "_": "Constructor de búsqueda (%d)"
                    },
                    "value": "Valor"
                },
                "searchPanes": {
                    "clearMessage": "Borrar todo",
                    "collapse": {
                        "0": "Paneles de búsqueda",
                        "_": "Paneles de búsqueda (%d)"
                    },
                    "count": "{total}",
                    "countFiltered": "{shown} ({total})",
                    "emptyPanes": "Sin paneles de búsqueda",
                    "loadMessage": "Cargando paneles de búsqueda",
                    "title": "Filtros Activos - %d"
                },
                "select": {
                    //    "cells": {
                    // 	   "1": "1 celda seleccionada",
                    // 	   "_": "%d celdas seleccionadas"
                    //    },
                    //    "columns": {
                    // 	   "1": "1 columna seleccionada",
                    // 	   "_": "%d columnas seleccionadas"
                    //    },
                    "rows": {
                        "1": "1 fila seleccionada",
                        "_": "%d filas seleccionadas"
                    }
                },
                "thousands": ".",
                "datetime": {
                    "previous": "Anterior",
                    "next": "Proximo",
                    "hours": "Horas",
                    "minutes": "Minutos",
                    "seconds": "Segundos",
                    "unknown": "-",
                    "amPm": [
                        "AM",
                        "PM"
                    ],
                    "months": {
                        "0": "Enero",
                        "1": "Febrero",
                        "10": "Noviembre",
                        "11": "Diciembre",
                        "2": "Marzo",
                        "3": "Abril",
                        "4": "Mayo",
                        "5": "Junio",
                        "6": "Julio",
                        "7": "Agosto",
                        "8": "Septiembre",
                        "9": "Octubre"
                    },
                    "weekdays": [
                        "Dom",
                        "Lun",
                        "Mar",
                        "Mie",
                        "Jue",
                        "Vie",
                        "Sab"
                    ]
                },
                "editor": {
                    "close": "Cerrar",
                    "create": {
                        "button": "Nuevo",
                        "title": "Crear Nuevo Registro",
                        "submit": "Crear"
                    },
                    "edit": {
                        "button": "Editar",
                        "title": "Editar Registro",
                        "submit": "Actualizar"
                    },
                    "remove": {
                        "button": "Eliminar",
                        "title": "Eliminar Registro",
                        "submit": "Eliminar",
                        "confirm": {
                            "_": "¿Está seguro que desea eliminar %d filas?",
                            "1": "¿Está seguro que desea eliminar 1 fila?"
                        }
                    },
                    "error": {
                        "system": "Ha ocurrido un error en el sistema (<a target=\"\\\" rel=\"\\ nofollow\" href=\"\\\">Más información&lt;\\\/a&gt;).<\/a>"
                    },
                    "multi": {
                        "title": "Múltiples Valores",
                        "info": "Los elementos seleccionados contienen diferentes valores para este registro. Para editar y establecer todos los elementos de este registro con el mismo valor, hacer click o tap aquí, de lo contrario conservarán sus valores individuales.",
                        "restore": "Deshacer Cambios",
                        "noMulti": "Este registro puede ser editado individualmente, pero no como parte de un grupo."
                    }
                },
                "info": "Mostrando _START_ a _END_ de _TOTAL_ registros"

            }
        });
    });
</script> 

<script>

    $('#tbProductos').on('click', 'tr td', function (evt) {

        var target, codigo, iddocumento, idcargo, idestado, nom, ape, td, nd, edad, nacio, empresa, email, telf, dir, sex, cargo, estado, usu, clave;
        target = $(event.target);
        codigo = target.parent().data('idcodigo');
        iddocumento = target.parent().data('iddocumento');
        idcargo = target.parent().data('idcargo');
        idestado = target.parent().data('idestado');

        nom = target.parent("tr").find("td").eq(0).html();
        ape = target.parent("tr").find("td").eq(1).html();
        nd = target.parent("tr").find("td").eq(3).html();
        edad = target.parent("tr").find("td").eq(4).html();
        nacio = target.parent("tr").find("td").eq(6).html();
        empresa = target.parent("tr").find("td").eq(7).html();
        email = target.parent("tr").find("td").eq(8).html();
        telf = target.parent("tr").find("td").eq(9).html();
        dir = target.parent("tr").find("td").eq(10).html();
        sex = target.parent("tr").find("td").eq(11).html();
        cargo = target.parent("tr").find("td").eq(12).html();
        usu = target.parent("tr").find("td").eq(14).html();
        clave = target.parent("tr").find("td").eq(15).html();


        $("#txtnom").val(nom);
        $("#txtape").val(ape);
        $("#txtnumero").val(nd);
        $("#txtedad").val(edad);
        $("#txtnacio").val(nacio);
        $("#txtempresa").val(empresa);
        $("#txtemail").val(email);
        $("#txttelf").val(telf);
        $("#txtdir").val(dir);
        $("#sexo").val(sex);
        $("#txtusu").val(usu);
        $("#txtclave").val(clave);
        $("#tipodoc").val(iddocumento);
        $("#descargo").val(idcargo);
        $("#estado").val(idestado);
        $("#txtcodigo").val(codigo);

        $("#modal-editar").modal('show');
    });

    function Actualizar() {


        Swal.fire({
            title: '<strong style="color:black;font-family:OswaldLight;">¿ Desea Modificar los datos del Registro ?</strong>',
            text: 'Asegurese de que todos los datos sean los correctos',
            // type: 'question',
            imageUrl: 'ICONOS/logobiomed.png',
            imageAlt: 'Biomed Centro Medico',
            imageWidth: '100px',
            allowOutsideClick: false,
            showCancelButton: true,
            confirmButtonColor: '#1F4E79',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.value) {

                $('body').removeClass('modal-open');
                $('.modal-backdrop').remove();
                $('#modal-nuevo').hide();
                $('#modal-nuevo').removeClass('show');
                var id = document.getElementById("txtcodigo").value;
                var nombres = document.getElementById("txtnom").value;
                var apellidos = document.getElementById("txtape").value;
                var tpdoc = document.getElementById("tipodoc").value;
                var numero = document.getElementById("txtnumero").value;
                var edad = document.getElementById("txtedad").value;
                var nacio = document.getElementById("txtnacio").value;
                var empresa = document.getElementById("txtempresa").value;
                var correo = document.getElementById("txtemail").value;
                var telf = document.getElementById("txttelf").value;
                var dir = document.getElementById("txtdir").value;
                var sexo = document.getElementById("sexo").value;
                var cargo = document.getElementById("descargo").value;
                var estado = document.getElementById("estado").value;
                var usu = document.getElementById("txtusu").value;
                var clave = document.getElementById("txtclave").value;


                jQuery.ajax({
                    url: 'ControladorCliente?menu=Cliente&accion=Editar&id=' + id +
                            '&nom=' + nombres + '&ape=' + apellidos + '&tpdoc=' + tpdoc +
                            '&numero=' + numero + '&edad=' + edad + '&nacio=' + nacio + '&empresa=' + empresa +
                            '&correo=' + correo + '&telf=' + telf + '&dire=' + dir + '&sexo=' + sexo +
                            '&cargo=' + cargo + '&estado=' + estado + '&usu=' + usu + '&clave=' + clave,
                    type: 'POST',
                    dataType: 'html',
                    data: $("#frmodi").serialize(),
                    beforeSend: function () {
                        Swal.fire({
                            html: 'El registro se está Modificando, espere un momento por favor....<br><i class="fa fa-spinner fa-pulse" style="font-size:50px;margint-top:10px;"></i> ',
                            imageUrl: 'ICONOS/logobiomed.png',
                            imageAlt: 'Biomed',
                            imageWidth: '100px',
                            allowOutsideClick: false,
                            showConfirmButton: false

                        });
                    }
                }).done(function (res) {

                    if (res !== "") {

                        buscar_datos();


                        Swal.fire({
                            title: '<strong>Felicidades</strong>',
                            text: "El Registro se ha modificado con éxito",
                            type: 'success',
                            allowOutsideClick: false,
                            showCancelButton: false,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Ok',
                            cancelButtonText: 'No, Cancelar'
                        });


                    } else {
                        console.log(res);

                    }






                })
                        .fail(function (resp) {
                            console.log(resp.responseText);
                        })
                        ;




            } else {
                return false;

            }
        });




    }
    function Agregar() {


        Swal.fire({
            title: '<strong style="color:black;font-family:OswaldLight;">¿ Desea Agregar el Registro ?</strong>',
            text: 'Asegurese de que todos los datos sean los correctos',
            // type: 'question',
            imageUrl: 'ICONOS/logobiomed.png',
            imageAlt: 'Biomed Centro Medico',
            imageWidth: '100px',
            allowOutsideClick: false,
            showCancelButton: true,
            confirmButtonColor: '#1F4E79',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.value) {


                var nombres = document.getElementById("txtnomn").value;
                var apellidos = document.getElementById("txtapen").value;
                if (nombres === "" || apellidos === "") {
                    Swal.fire({
                        title: '<strong>Atención</strong>',
                        text: "Los campos no pueden estar vacíos",
                        type: 'warning'

                    });
                } else {

                    var tpdoc = document.getElementById("tipodocn").value;
                    var numero = document.getElementById("txtnumeron").value;
                    var edad = document.getElementById("txtedadn").value;
                    var nacio = document.getElementById("txtnacion").value;
                    var empresa = document.getElementById("txtempresan").value;
                    var correo = document.getElementById("txtemailn").value;
                    var telf = document.getElementById("txttelfn").value;
                    var dir = document.getElementById("txtdirn").value;
                    var sexo = document.getElementById("sexon").value;
                    var cargo = document.getElementById("descargon").value;
                    var estado = document.getElementById("estadon").value;
                    var usu = document.getElementById("txtusun").value;
                    var clave = document.getElementById("txtclaven").value;


                    jQuery.ajax({
                        url: 'ControladorCliente?menu=Cliente&accion=Agregar&nom=' + nombres +
                                '&ape=' + apellidos + '&tpdoc=' + tpdoc +
                                '&numero=' + numero + '&edad=' + edad + '&nacio=' + nacio + '&empresa=' + empresa +
                                '&correo=' + correo + '&telf=' + telf + '&dire=' + dir + '&sexo=' + sexo +
                                '&cargo=' + cargo + '&estado=' + estado + '&usu=' + usu + '&clave=' + clave,
                        type: 'POST',
                        dataType: 'html',
                        data: $("#frmodi").serialize(),
                        beforeSend: function () {
                            Swal.fire({
                                html: 'El registro se está Insertando, espere un momento por favor....<br><i class="fa fa-spinner fa-pulse" style="font-size:50px;margint-top:10px;"></i> ',
                                imageUrl: 'ICONOS/logobiomed.png',
                                imageAlt: 'Biomed',
                                imageWidth: '100px',
                                allowOutsideClick: false,
                                showConfirmButton: false

                            });
                        }
                    }).done(function (res) {

                        if (res !== "") {
                            $('body').removeClass('modal-open');
                            $('.modal-backdrop').remove();
                            $('#modal-nuevo').hide();
                            $('#modal-nuevo').removeClass('show');
                            buscar_datos();

                            console.log(res);
                            Swal.fire({
                                title: '<strong>Felicidades</strong>',
                                text: "El Registro se ha insertado con éxito",
                                type: 'success',
                                allowOutsideClick: false,
                                showCancelButton: false,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Ok',
                                cancelButtonText: 'No, Cancelar'
                            });


                        } else {
                            Swal.fire({
                                title: '<strong>Error</strong>',
                                text: "El Registro con el mismo numero de identificación ya existe",
                                type: 'error',
                                allowOutsideClick: false,
                                showCancelButton: false,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Ok',
                                cancelButtonText: 'No, Cancelar'
                            });

                        }






                    })
                            .fail(function (resp) {
                                console.log(resp.responseText);
                            })
                            ;


                }

            } else {
                return false;

            }
        });




    }
    function Eliminar() {


        Swal.fire({
            title: '<strong style="color:black;font-family:OswaldLight;">¿ Desea Eliminar el Registro ?</strong>',
            text: 'El dato será quitado de la lista',
            // type: 'question',
            imageUrl: 'ICONOS/logobiomed.png',
            imageAlt: 'Biomed Centro Medico',
            imageWidth: '100px',
            allowOutsideClick: false,
            showCancelButton: true,
            confirmButtonColor: '#1F4E79',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si',
            cancelButtonText: 'No'
        }).then((result) => {
            if (result.value) {

                $('body').removeClass('modal-open');
                $('.modal-backdrop').remove();
                $('#modal-editar').hide();
                $('#modal-editar').removeClass('show');

                var id = document.getElementById("txtcodigo").value;


                jQuery.ajax({
                    url: 'ControladorCliente?menu=Cliente&accion=Eliminar&id=' + id,
                    type: 'POST',
                    dataType: 'html',
                    data: $("#frmodi").serialize(),
                    beforeSend: function () {
                        Swal.fire({
                            html: 'El registro se está eliminando, espere un momento por favor....<br><i class="fa fa-spinner fa-pulse" style="font-size:50px;margint-top:10px;"></i> ',
                            imageUrl: 'ICONOS/logobiomed.png',
                            imageAlt: 'Biomed',
                            imageWidth: '100px',
                            allowOutsideClick: false,
                            showConfirmButton: false

                        });
                    }
                }).done(function (res) {

                    if (res !== "") {

                        buscar_datos();


                        Swal.fire({
                            title: '<strong>Felicidades</strong>',
                            text: "El Registro ha sido eliminado con éxito",
                            type: 'success',
                            allowOutsideClick: false,
                            showCancelButton: false,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Ok',
                            cancelButtonText: 'No, Cancelar'
                        });


                    } else {
                        console.log(res);

                    }






                })
                        .fail(function (resp) {
                            console.log(resp.responseText);
                        })
                        ;




            } else {
                return false;

            }
        });




    }

</script>
