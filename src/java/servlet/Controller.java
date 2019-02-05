/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import entities.Jornada;
import entities.Partido;
import entities.Porra;
import entities.PorraPK;
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
        Query query;
        EntityManager em = null;
        Usuario user = null;
        
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }
        
        op = request.getParameter("op");
        
        if (op.equals("inicio")) {
            sql = "select j from jornada j";
            query = em.createQuery(sql);
            List jornadas = query.getResultList();
            session.setAttribute("jornadas",jornadas);
            
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
            user = em.find(Usuario.class, dni);
            
            if (user == null){
                Usuario nuevoUsuario = new Usuario(dni);
                nuevoUsuario.setNombre(nombre);
                em.persist(nuevoUsuario);
                user = nuevoUsuario;
            }
            
            session.setAttribute("usuario", user);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("logout")){
            session.setAttribute("usuario", null);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        } else if (op.equals("apostar")){  
            user = (Usuario) session.getAttribute("usuario");
            short idpartido = Short.valueOf(request.getParameter("idPartido"));
            Partido partido = em.find(Partido.class, idpartido);
            short goleslocal = Short.valueOf(request.getParameter("gLocal"));
            short golesvisitante = Short.valueOf(request.getParameter("gVisitante"));
            
            PorraPK porraPK = new PorraPK(user.getDni(),idpartido);
            
            Porra porra = new Porra(porraPK);
            porra.setUsuario(user);
            porra.setPartido(partido);
            porra.setGoleslocal(goleslocal);
            porra.setGolesvisitante(golesvisitante);
            
        } else if (op.equals("infoapuestas")){
            
        }
    }
}
