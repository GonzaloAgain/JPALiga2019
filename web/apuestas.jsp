<%-- 
    Document   : apuestas
    Created on : 05-feb-2019, 18:59:50
    Author     : Usuario
--%>

<%@page import="entities.InfoApuesta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //List listaApuestas= (List) request.getAttribute("infoapuestas");
    String nombrePartido = (String) request.getAttribute("nombrepartido");
%>
<h6> <%=nombrePartido%> </h6>
    
