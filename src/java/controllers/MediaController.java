package controllers;

import beans.Add;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MediaController extends HttpServlet {

    /**
     * controller per il rilevamento della media di un inquinante.
     * richiama il metodo Media_Sensore
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            try 
            {
                Add user = new Add();
     
                user.setNome(request.getParameter("nome"));
                user.setInqui(request.getParameter("inqui"));
                user.setInizio(request.getParameter("inizio"));
                user.setFine(request.getParameter("fine"));
                
                double vero = user.Media_Sensore();
                
                if (vero < 0.0)
                {
                    request.getRequestDispatcher("mappa.jsp").forward(request,response);
                } else 
                {
                    request.setAttribute("avg", Double.toString(vero));
                    request.getRequestDispatcher("media.jsp").forward(request,response);
                }
            } finally {out.close();}
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
