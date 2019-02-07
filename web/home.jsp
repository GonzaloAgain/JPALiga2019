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
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
                <a href="#" data-target="mobile-demo" class="sidenav-trigger"><i class="material-icons">menu</i></a>
                <ul class="right hide-on-med-and-down">
                <% 
                    if (user == null){
                %>
                       <li><a class="waves-effect waves-light btn">Login</a></li> 
                <%
                    } else {
                 %>
                        <li><h5>Hola, Usuario </h5></li>
                        <li><a class="waves-effect waves-light btn"><i class="material-icons left">exit_to_app</i>Log Out</a></li>
                <%  }   %>  
                </ul>
              </div>
            </nav>
                
            <!--Esto es el dropbox de los huevos // Hay que mirar un par de cosillas -->
            <div class="container">
              <div class="row">
                <div class="input-field col s6 offset-s3">
                    <select onchange='window.location="Controller?op=jornada"'>
                      <option value="" disabled selected>Choose your option</option>
                       <% 
                           for(int i=0;i<jornadas.size();i++){ 
                            jornada = (Jornada)jornadas.get(i);
                       %>
                       <option value="<%=jornada.getIdjornada() %>"><%=jornada.getNombre() %> (<%=jornada.getFechainicio() %> - <%=jornada.getFechafin() %>)</option>
                       <% } %>
                    </select>
                    <label>Selecciona jornada</label>
                 </div>
              </div>
            </div>
            
        </div>
<<<<<<< Updated upstream
        
    <h1>hello work Materialize Offline</h1>
    
    <div class="input-field col s12">
      <select>
        <option value="" disabled selected>Choose your option</option>
        <option value="1">Option 1</option>
        <option value="2">Option 2</option>
        <option value="3">Option 3</option>
      </select>
      <label>Materialize Select</label>
    </div>



      <!--JavaScript at end of body for optimized loading-->
      <script type="text/javascript" src="js/jquery-3.3.1.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript" src="js/myjs.js"></script>
    </body>
  </html>
