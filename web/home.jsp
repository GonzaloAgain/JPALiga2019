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
            String idjornadita =(String) session.getAttribute("idJornada");
            

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
                        <li><a data-target="modal-login" class="waves-effect waves-light btn modal-trigger">Login <i class="material-icons right">account_circle</i></a></li>
                      
                <%
                    } else {
                 %>
                        <li><h5>Hola, <%=user.getNombre()%> </h5></li>
                        <li><a href="Controller?op=logout" class="waves-effect waves-light btn"><i class="material-icons left">exit_to_app</i>Log Out</a></li>
                <%  }   %>  
                </ul>
              </div>
            </nav>
                
            <ul class="sidenav" id="mobile-demo">
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
            <div class="container">
                <div class="row">
                    <div class="input-field col s8 offset-s2">
                        <select id="selectjornada" onchange='window.location="Controller?op=jornada&idJornada="+this.value'>
                        <option value="" selected>Selecciona una jornada</option>
                         <% for(int i=0;i<jornadas.size();i++){ 
                         jornada = (Jornada)jornadas.get(i);
                         %>
                         <option value="<%=jornada.getIdjornada() %>"><%=jornada.getNombre() %>(<%=jornada.getFechainicio() %> - <%=jornada.getFechafin() %>)</option>
                         <%}%>
                      </select>
                    </div>
                </div>
            </div>  
               
            <div class="row">
                <% if(idjornadita=="" || idjornadita==null){ %>
                    <img class="col s12" src="img/bg.jpg">
                <% }else{ %>
                    <table class="centered responsive-table">
                      <% if(user==null){ %>
                            <tbody>
                                <% for (int i = 0;i<partidos.size();i++){
                                    partido = (Partido)partidos.get(i);
                                %>
                                    <tr>
                                        <td colspan="2"><img src="<%=partido.getLocal().getEscudo() %>"/></td>
                                        <td><h5><%=partido.getLocal().getNombre() %></h5></td>
                                        <td><h6><%=partido.getGoleslocal() %> - <%=partido.getGolesvisitante() %></h6></td>
                                        <td><h5><%=partido.getVisitante().getNombre() %></h5></td>
                                        <td colspan="2"><img src="<%=partido.getVisitante().getEscudo() %>"/></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        <!-- if login != null show table with buttons -->
                      <% } else { %>
                            <tbody>
                                <% for (int i = 0;i<partidos.size();i++){
                                    partido = (Partido)partidos.get(i);
                                %>
                                    <tr>
                                      <td><button id="boton-apuestas" data-target="modal-listaApuestas" data-id="<%=partido.getIdpartido()%>" class="btn modal-trigger"><i class="small material-icons">info</i></button></td>
                                      <td><img src="<%=partido.getLocal().getEscudo() %>"/></td>
                                      <td><h5><%=partido.getLocal().getNombre() %></h5></td>
                                      <td><h6><%=partido.getGoleslocal() %> - <%=partido.getGolesvisitante() %></h6></td>
                                      <td><h5><%=partido.getVisitante().getNombre() %></h5></td>
                                      <td><img src="<%=partido.getVisitante().getEscudo() %>"/></td>
                                      <td><button data-target="modal-apostar" data-id="<%=partido.getIdpartido()%>" data-nom="<%=partido.getLocal().getNombre()%> - <%=partido.getVisitante().getNombre()%>" class="btn modal-trigger">Apostar</button></td>
                                    </tr>
                                <% }} %>
                            </tbody>
                    </table>
                <% } %>
            </div>
        </div>
      
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
              <h5 id="partido" class="center"></h5>
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
      <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript" src="js/myjs.js"></script>
      
      <% if(idjornadita!=null){ %>
        <script type="text/javascript">
            $('#selectjornada').val('<%= idjornadita %>')
        </script>
      <% } %>
    </body>
  </html>
