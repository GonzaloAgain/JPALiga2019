/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import entities.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jpautil.JPAUtil;

/**
 *
 * @author Gonzalo
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        
        String op;
        String sql;
        List lhl;
        List lh;
        Boolean logeado = false;
        Query query;
        EntityManager em = null;
        
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }
        
        op = request.getParameter("op");
        
        if (op.equals("inicio")) {
            String idjornada = (String) request.getParameter("idjornada");
            String nombre = (String) request.getParameter("nombre");
            String fechainicio = (String) request.getParameter("fechainicio");
            String fechafin = (String) request.getParameter("fechafin");
            
            sql = "SELECT j FROM Jornada j WHERE j.idjornada = :idjornada";
            query = em.createQuery(sql);
            query.setParameter(1,nombre);
            query.setParameter(2,fechainicio);
            query.setParameter(3,fechafin);
            List todasLasJornadas = query.getResultList();
            fechainicio = fechainicio.replace("/", "-");
            fechafin = fechafin.replace("/", "-");
            
//            Jornada jornada = new Jornada();
//            jornada.setNombre(nombre);
//            jornada.setFechainicio(fechafin);
//            jornada.setFechafin(fechafin);
//            em.persist(jornada);
            
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        }else if(op.equals("jornadas")){
            String hora = (String) request.getParameter("hora");
            String escudo = (String) request.getParameter("escudo");
            String local = (String) request.getParameter("local");
            String visitante = (String) request.getParameter("visitante");
            String goleslocal = (String) request.getParameter("goleslocal");
            String golesvisitante = (String) request.getParameter("golesvisitante");
            hora = hora.replace("/", "-");
            
            sql = "SELECT p FROM Partido p WHERE p.fecha = :fecha";
            query = em.createQuery(sql);
            query.setParameter(1,escudo);
            query.setParameter(2,local);
            query.setParameter(3,goleslocal);
            query.setParameter(4,golesvisitante);
            query.setParameter(5,visitante);
            List todosLosPartidos = query.getResultList();
            
            dispatcher = request.getRequestDispatcher("jornadas.jsp");
            dispatcher.forward(request, response);
        }       
        
        if (op.equals("login")) {
            String nombre = (String) request.getParameter("nombre");
            String dni = (String) request.getParameter("dni"); 
            Usuario user = (Usuario) em.find(Usuario.class, dni);
            
            if (user == null){
                Usuario usuario = new Usuario(dni);
                usuario.setNombre(nombre);
                em.persist(usuario);
                logeado = true;
            } else {
                logeado = true;
            }
            
            session.setAttribute("islogueado", logeado);
            session.setAttribute("nombreuser", nombre); 
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("logout")){
            logeado = false;
            session.setAttribute("islogueado", logeado);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        } else if (op.equals("apostar")){
            
        }
    }
}
