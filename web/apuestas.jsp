<%-- 
    Document   : apuestas
    Created on : 05-feb-2019, 18:59:50
    Author     : Usuario
--%>

<%@page import="entities.InfoApuesta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List listaApuestas= (List) request.getAttribute("infoapuestas");
    String nombrePartido = (String) request.getAttribute("nombrepartido");
    if(listaApuestas.size()==0){
%>
    <h6> <%=nombrePartido%> </h6>
    <p>No tiene apuestas</p>
<%}else{ %>
<h6><%=nombrePartido%></h6>
<table>
    <thead>
      <tr>
          <th>Apuesta</th>
          <th>Numero de puestas</th>
      </tr>
    </thead>

    <tbody>
        <% InfoApuesta informacion=null;
          for(int i=0;i<listaApuestas.size();i++){
              informacion=(InfoApuesta) listaApuestas.get(i);
      %>
      <tr>
        <td><%=informacion.getGolesLocal()%> - <%=informacion.getGolesVisitante()%></td>
        <td><%=informacion.getNumeroApuestas()%></td>
      </tr>
      <%}%>
    </tbody>
</table>
<%}%>
