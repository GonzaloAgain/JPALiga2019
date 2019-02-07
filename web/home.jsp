<%-- 
    Document   : home
    Created on : 30-ene-2019, 12:34:11
    Author     : Diurno
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
      <!--Mycss-->
      <link type="text/css" rel="stylesheet" href="css/mycss.css"  media="screen,projection"/>
      <!--Let browser know website is optimized for mobile-->
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>JSP Page</title>
    </head>

    <body>
        <% List partidos = (List) session.getAttribute("partidos");
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
            <li><h5>Hola, Usuario </h5></li>
            <li><a class="waves-effect waves-light btn"><i class="material-icons left">exit_to_app</i>Log Out</a></li>
          </ul>
        </div>
      </nav>

      <ul class="sidenav" id="mobile-demo">
        <li><h5>Hola, Usuario </h5></li>
        <li><a class="waves-effect waves-light btn"><i class="material-icons left">exit_to_app</i>Log Out</a></li>
      </ul>



      <!--Esto es el dropbox de los huevos // Hay que mirar un par de cosillas -->
      <div class="container">
        <div class="row">
          <form method="post">
            <div class="input-field col s6 offset-s3">
              <select onchange='window.location="Controller?op="+this.value'>
                <option value="" disabled selected>Choose your option</option>
                 <% for(int i=0;i<jornadas.size();i++){ 
                 jornada = (Jornada)jornadas.get(i);
                 }%>
                 <option value="<%=jornada.getIdjornada() %>"><%=jornada.getNombre() %>(<%=jornada.getFechainicio() %> - <%=jornada.getFechafin() %>)</option>
              </select>
              <label>Selecciona jornada</label>
            </div>
          </form>
        </div>
      </div>

      <div class="row">

        <table class="centered responsive-table">
          <% if(user==null){ %>
          <tbody>
          <% for (int i = 0;i<partidos.size();i++){
          partido = (Partido)partidos.get(i);
          %>
          <tr>
            <td colspan="2"><%=partido.getLocal().getEscudo() %></td>
            <td><h4><%=partido.getLocal().getNombre() %></h4></td>
            <td><h4><%=partido.getGoleslocal()%> - <%=partido.getGolesvisitante() %></h4></td>
            <td><h4><%=partido.getVisitante().getNombre() %></h4></td>
            <td colspan="2"><%=partido.getVisitante().getEscudo() %></td>
          </tr>
          <%} %>
          </tbody>
          <% } %>
          <!-- if login != null show table with buttons -->
          <% if(user != null){ %>
          <tbody>
          <% for (int i = 0;i<partidos.size();i++){
          partido = (Partido)partidos.get(i);
          %>
          <tr>
            <td><button data-target="modal-listaApuestas" data-id="<%=partido.getIdjornada() %>" class="btn modal-trigger"><i class="small material-icons">info</i></button></td>
            <td><%=partido.getLocal().getEscudo() %></td>
            <td><h4><%=partido.getLocal().getNombre() %></h4></td>
            <td><h4><%=partido.getGoleslocal()%> - <%=partido.getGolesvisitante() %></h4></td>
            <td><h4><%=partido.getVisitante().getNombre() %></h4></td>
            <td><%=partido.getVisitante().getEscudo() %></td>
            <td><button data-target="modal-apostar" data-id="<%=partido.getIdjornada() %>" data-whatever="<%=partido.getLocal().getNombre()%> - <%=partido.getVisitante().getNombre()%>" class="btn modal-trigger">Apostar</button></td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>



    <!-- Modal Lista Apuestas -->
    <div id="modal-listaApuestas" class="modal m6">
      <div class="modal-content center">
        <h4 class="blue lighten-2" id="tituloApuestas">Información apuestas actuales</h4>
        <div id="div-apuestas">
          <!--Se rellena con ajax-->
        </div>
      </div>
      <div class="modal-footer">
        <a href="#!" class="modal-close waves-effect waves-light btn"><i class="material-icons left">fullscreen_exit</i>Aceptar</a>
      </div>
    </div>


    <!-- Modal Apostar -->
    <div id="modal-apostar" class="modal">
      <form action="Controller?op=apostar" method="post">
        <div class="modal-content">
          <h4>Apuesta</h4>
          <h5 id="partido" class="center">Partido</h5>
          <div class="row">
            <div class="input-field col m6">
              <input id="gLocal" type="text" name="gLocal" class="validate">
              <label for="gLocal" class="blue-text text-lighten-3">Goles Local</label>
            </div>
            <div class="input-field col m6">
              <input id="gVisitante" type="text" name="gVisitante" class="validate">
              <label for="gVisitante" class="blue-text text-lighten-3">Goles Visitante</label>
            </div>
            <div>
              <input type="hidden" id="idPartido" name="idPartido">
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button class="waves-effect waves-light btn"><i class="material-icons left">person</i>Apostar</button>
          <a href="#!" class="modal-close waves-effect waves-light btn"><i class="material-icons left">cancel</i>Cancelar</a>
        </div>
      </form>
    </div>

      <!--JavaScript at end of body for optimized loading-->
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <!--JQuery-->
      <script type="text/javascript" src="js/jquery-3.3.1.js"></script>
      <!--Myjs-->
      <script type="text/javascript" src="js/myjs.js"></script>
    </body>
  </html>
