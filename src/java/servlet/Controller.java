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
            String nombre = (String) request.getParameter("nombre");
            sql = "select idjoranda, nombre from Jornada";
            query = em.createQuery(sql);
            lhl = query.getResultList();
            session.setAttribute("lhl", lhl);

            sql = "from Jornada";
            query = em.createQuery(sql);
            lh = query.getResultList();
            session.setAttribute("lh", lh);
            session.setAttribute("local", "visitante");
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        }else if(op.equals("jornadas")){
            String idjornada = (String) request.getParameter("idjornada");
            sql = "from Partido where idjornada=?";
            query = em.createQuery(sql);
            query.setString();
            List lr = query.getResultList();
            request.setAttribute("lr", lr);
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
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
