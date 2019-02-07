<%-- 
    Document   : home
    Created on : 07-feb-2019, 0:12:33
    Author     : Gonzalo
--%>

<%@page import="entities.Jornada"%>
<%@page import="entities.Usuario"%>
<%@page import="entities.Partido"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
  <html>
    <head>
      <!--Import Google Icon Font-->
      <link href="css/fonts.css" rel="stylesheet">
      <!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link type="text/css" rel="stylesheet" href="css/mycss.css"/>

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="ISO-8859-1"/>
    </head>

    <body>
        <% 
            List partidos = (List) session.getAttribute("partidos");
            Partido partido;
            Usuario user = (Usuario) session.getAttribute("usuario");
            List jornadas = (List) session.getAttribute("jornadas");
            Jornada jornada = null;
        %>
        <div class="container">
            <nav>
              <div class="nav-wrapper blue">
                <img src="img/liga.png" class="brand-logo responsive-img"/>
                <a href="#" data-target="mobile-demo" class="sidenav-trigger"><i class="material-icons">Menu</i></a>
                <ul class="right hide-on-med-and-down">
                <% 
                    if (user == null){
                %>
                       <li><button data-target="modal-login" class="btn modal-trigger">Login</button></li> 
                <%
                    } else {
                 %>
                        <li><h5>Hola, <%=user.getNombre()%> </h5></li>
                        <li><a href="Controller?op=logout" class="waves-effect waves-light btn"><i class="material-icons left">exit_to_app</i>Log Out</a></li>
                <%  }   %>  
                </ul>
              </div>
            </nav>
                
                
            <!-- Modal Login -->
        <div id="modal-login" class="modal">
            <form action="Controller?op=login" method="post">
                <div class="modal-content">
                    <h4>Login & Register</h4>
                    <div class="row">
                      <div class="input-field col m12">
                        <input id="dni" name="dni" type="text" class="validate">
                        <label for="dni" class="blue-text text-lighten-3">DNI</label>
                      </div>
                      <div class="input-field col m12">
                        <input id="nombre" name="nombre" type="text" class="validate">
                        <label for="nombre" class="blue-text text-lighten-3">Nombre</label>
                      </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="waves-effect waves-light btn"><i class="material-icons left">person</i>Login & Register</button>
                    <a href="#!" class="modal-close waves-effect waves-light btn"><i class="material-icons left">cancel</i>Cancelar</a>
                </div>
            </form>
        </div>    
                
        </div>
       
      <!--JavaScript at end of body for optimized loading-->
      <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript" src="js/myjs.js"></script>
    </body>
  </html>
