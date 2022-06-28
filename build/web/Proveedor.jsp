<%-- 
    Document   : Proveedor
    Created on : 21/06/2022, 09:09:15 PM
    Author     : gcamo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuario")!= null){

%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema de Farmacia</title>
        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="dist/plugins/fontawesome-free/css/all.min.css">
        <!-- overlayScrollbars -->
        <link rel="stylesheet" href="dist/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/adminlte.min.css?v=1.3">
        <!-- ICONO EN NAVEGADOR -->
        <link rel="shortcut icon" href="ICONOS/logobiomed.png" />
        <!-- DATA TABLES -->
        <link rel="stylesheet" href="dist/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="dist/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
        <link rel="stylesheet" href="dist/plugins/datatables-buttons/css/buttons.bootstrap4.min.css"> 

        <!--Fuentes  -->
        <link rel="stylesheet" href="css/fuentes.css">
        <!-- Alertas -->
        <link rel="stylesheet" href="css/sweetalert2.css"> 
        <script src="js/sweetalert2019.js" ></script> 
    </head>
    <body>
        <body class="hold-transition sidebar-mini layout-fixed" style="font-family:OswaldLight;">
        <!-- Site wrapper -->
        <div class="wrapper">
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <!-- Left navbar links -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                    </li>

                </ul>


                <!-- Right navbar links -->
                <ul class="navbar-nav ml-auto">


                    <li class="nav-item dropdown user-menu">
                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            <img src="ICONOS/avatar.png" class="user-image img-circle elevation-2" alt="User Image">
                            <span class="d-none d-md-inline">${msg1} ${msg2}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="left: inherit; right: 0px;">
                            <!-- User image -->
                            <li class="user-header bg-primary">
                                <img src="ICONOS/avatar.png" class="img-circle elevation-2" alt="User Image">

                                <p>
                                    ${msg1} ${msg2}
                                    <small>Member since Nov. 2012</small>
                                </p>
                            </li>
                            <!-- Menu Body -->

                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <button name="accion" value="salir"  class="btn btn-default btn-flat float-left">Perfil</button>
                                <form action="validar" method="POST">
                                    <button name="accion" value="salir"  class="btn btn-default btn-flat float-right">Salir</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                            <i class="fas fa-expand-arrows-alt"></i>
                        </a>
                    </li>

                </ul>
            </nav>

            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-light-cyan elevation-1">
                <!-- Brand Logo -->
                <a href="#" class="brand-link">
                    <img src="ICONOS/logobiomed.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                    <span class="brand-text font-weight-light">Farmacia V.2.0</span>
                </a>

                <!-- Sidebar -->
                <div class="sidebar">
                    <!-- Sidebar user (optional) -->
                    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                        <div class="image">
                            <img src="ICONOS/avatar.png" class="img-circle elevation-2" alt="User Image">
                        </div>
                        <div class="info">
                            <a href="#" class="d-block">${msg1}</a>
                        </div>
                    </div>

                    <!-- SidebarSearch Form -->
                    <div class="form-inline">
                        <div class="input-group" data-widget="sidebar-search">
                            <input class="form-control form-control-sidebar" type="search" placeholder="Buscar" aria-label="Buscar">
                            <div class="input-group-append">
                                <button class="btn btn-sidebar">
                                    <i class="fas fa-search fa-fw"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar Menu -->
                    <nav class="mt-2">
                        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <!-- Add icons to the links using the .nav-icon class
                                 with font-awesome or any other icon font library -->

                            <li class="nav-item">
                                <a href="Principal.jsp" class="nav-link">
                                    <i class="nav-icon fas fa-desktop"></i> Inicio</a>

                            </li>

                            <li class="nav-header">MANTENIMIENTO</li>
                            <li class="nav-item">

                                <a href="Controladorempleado?menu=Empleados" class="nav-link">
                                    <i class="nav-icon fas fa-users"></i>
                                    <p>
                                        Empleados

                                    </p>
                                </a>
                            </li>
                            
                            <li class="nav-item">

                                <a href="ControladorCliente?menu=Clientes" class="nav-link">
                                    <i class="nav-icon fas fa-users"></i>
                                    <p>
                                        Clientes

                                    </p>
                                </a>
                            </li>
                            
                            <li class="nav-item">

                                <a href="ControladorProducto?menu=Productos" class="nav-link">
                                    <i class="nav-icon fas fa-users"></i>
                                    <p>
                                        Productos

                                    </p>
                                </a>
                            </li>
                            
                            <li class="nav-item">

                                <a href="ControladorProveedor?menu=Proveedores" class="nav-link">
                                    <i class="nav-icon fas fa-users"></i>
                                    <p>
                                        Prooveedores

                                    </p>
                                </a>
                            </li>

                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-chart-pie"></i>
                                    <p>
                                        Charts
                                        <i class="right fas fa-angle-left"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="../charts/chartjs.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>ChartJS</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../charts/flot.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Flot</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../charts/inline.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Inline</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../charts/uplot.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>uPlot</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-tree"></i>
                                    <p>
                                        UI Elements
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="../UI/general.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>General</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../UI/icons.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Icons</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../UI/buttons.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Buttons</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../UI/sliders.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Sliders</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../UI/modals.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Modals & Alerts</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../UI/navbar.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Navbar & Tabs</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../UI/timeline.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Timeline</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../UI/ribbons.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Ribbons</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-edit"></i>
                                    <p>
                                        Forms
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="../forms/general.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>General Elements</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../forms/advanced.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Advanced Elements</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../forms/editors.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Editors</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../forms/validation.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Validation</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-table"></i>
                                    <p>
                                        Tables
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="../tables/simple.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Simple Tables</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../tables/data.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>DataTables</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../tables/jsgrid.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>jsGrid</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-header">EXAMPLES</li>
                            <li class="nav-item">
                                <a href="../calendar.html" class="nav-link">
                                    <i class="nav-icon far fa-calendar-alt"></i>
                                    <p>
                                        Calendar
                                        <span class="badge badge-info right">2</span>
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="../gallery.html" class="nav-link">
                                    <i class="nav-icon far fa-image"></i>
                                    <p>
                                        Gallery
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="../kanban.html" class="nav-link">
                                    <i class="nav-icon fas fa-columns"></i>
                                    <p>
                                        Kanban Board
                                    </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon far fa-envelope"></i>
                                    <p>
                                        Mailbox
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="../mailbox/mailbox.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Inbox</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../mailbox/compose.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Compose</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../mailbox/read-mail.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Read</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-book"></i>
                                    <p>
                                        Pages
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="../examples/invoice.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Invoice</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/profile.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Profile</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/e-commerce.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>E-commerce</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/projects.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Projects</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/project-add.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Project Add</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/project-edit.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Project Edit</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/project-detail.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Project Detail</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/contacts.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Contacts</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/faq.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>FAQ</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/contact-us.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Contact us</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon far fa-plus-square"></i>
                                    <p>
                                        Extras
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>
                                                Login & Register v1
                                                <i class="fas fa-angle-left right"></i>
                                            </p>
                                        </a>
                                        <ul class="nav nav-treeview">
                                            <li class="nav-item">
                                                <a href="../examples/login.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Login v1</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="../examples/register.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Register v1</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="../examples/forgot-password.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Forgot Password v1</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="../examples/recover-password.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Recover Password v1</p>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>
                                                Login & Register v2
                                                <i class="fas fa-angle-left right"></i>
                                            </p>
                                        </a>
                                        <ul class="nav nav-treeview">
                                            <li class="nav-item">
                                                <a href="../examples/login-v2.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Login v2</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="../examples/register-v2.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Register v2</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="../examples/forgot-password-v2.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Forgot Password v2</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="../examples/recover-password-v2.html" class="nav-link">
                                                    <i class="far fa-circle nav-icon"></i>
                                                    <p>Recover Password v2</p>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/lockscreen.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Lockscreen</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/legacy-user-menu.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Legacy User Menu</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/language-menu.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Language Menu</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/404.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Error 404</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/500.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Error 500</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/pace.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Pace</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../examples/blank.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Blank Page</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../../starter.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Starter Page</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-search"></i>
                                    <p>
                                        Search
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="../search/simple.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Simple Search</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="../search/enhanced.html" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Enhanced</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-header">MISCELLANEOUS</li>
                            <li class="nav-item">
                                <a href="../../iframe.html" class="nav-link">
                                    <i class="nav-icon fas fa-ellipsis-h"></i>
                                    <p>Tabbed IFrame Plugin</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="https://adminlte.io/docs/3.1/" class="nav-link">
                                    <i class="nav-icon fas fa-file"></i>
                                    <p>Documentation</p>
                                </a>
                            </li>
                            <li class="nav-header">MULTI LEVEL EXAMPLE</li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="fas fa-circle nav-icon"></i>
                                    <p>Level 1</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon fas fa-circle"></i>
                                    <p>
                                        Level 1
                                        <i class="right fas fa-angle-left"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Level 2</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>
                                                Level 2
                                                <i class="right fas fa-angle-left"></i>
                                            </p>
                                        </a>
                                        <ul class="nav nav-treeview">
                                            <li class="nav-item">
                                                <a href="#" class="nav-link">
                                                    <i class="far fa-dot-circle nav-icon"></i>
                                                    <p>Level 3</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="#" class="nav-link">
                                                    <i class="far fa-dot-circle nav-icon"></i>
                                                    <p>Level 3</p>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="#" class="nav-link">
                                                    <i class="far fa-dot-circle nav-icon"></i>
                                                    <p>Level 3</p>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Level 2</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="fas fa-circle nav-icon"></i>
                                    <p>Level 1</p>
                                </a>
                            </li>
                            <li class="nav-header">LABELS</li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon far fa-circle text-danger"></i>
                                    <p class="text">Important</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon far fa-circle text-warning"></i>
                                    <p>Warning</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nav-icon far fa-circle text-info"></i>
                                    <p>Informational</p>
                                </a>
                            </li>
                        </ul>
                    </nav>
                    <!-- /.sidebar-menu -->
                </div>
                <!-- /.sidebar -->
            </aside>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>Mantenimiento a Clientes</h1>

                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="#">Inicio</a></li>
                                    <li class="breadcrumb-item active">Clientes</li>
                                </ol>
                            </div>
                        </div>
                    </div><!-- /.container-fluid -->
                </section>

                <!-- Main content -->
                <section class="content" id="respuesta">

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <footer class="main-footer">
        <div class="float-right d-none d-sm-block">
            <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2022 Farmacia Biomed</strong> Todos los derechos reservados.
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
   
    
    

    <!-- ./wrapper -->

<!-- Main content -->
     <script src="dist/plugins/jquery/jquery.min.js"></script>
       <!-- Bootstrap 4 -->
    <script src="dist/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- overlayScrollbars -->
    <script src="dist/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
    <!-- DataTables  & Plugins -->
    <script src="dist/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="dist/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="dist/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script src="dist/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
    <script src="dist/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
    <script src="dist/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
    <script src="dist/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
    <script src="dist/plugins/datatables-buttons/js/buttons.print.min.js"></script>
    <script src="dist/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js?v=1.0"></script>
    
   <!-- jQuery -->

 <script>
$(document).ready(function(){
           buscar_datos();  
          
      });

 function buscar_datos(){
  jQuery.ajax({
    url:'Datos-Cliente.jsp',
    type:'POST',
    dataType:'html',
   
    beforeSend:function(){
       }
  })
  .done(function(respuesta){
     
      $("#respuesta").html(respuesta);
          
  })
  .fail(function(resp){
    console.log(resp.responseText);
  })
 ;
} 

    </script>




    </body>
</html>
<%
    }else{

 response.sendRedirect("index.jsp");
}
%>