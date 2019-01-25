package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import beans.Add;
import javax.servlet.http.HttpSession;

public class DeleteMarker extends HttpServlet 
{
    /**
     * controller per la cancellazione di una sonda.
     * richiama il metodo Add_Delete
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            Add user = new Add();
            
            user.setNome(request.getParameter("nome"));
            user.setInqui(request.getParameter("inqui"));
            
            boolean vero = user.Add_Delete();
            
            if (vero == true){
                RequestDispatcher rd1 = request.getRequestDispatcher("admin.jsp");
                rd1.forward(request,response);
            } else {
                RequestDispatcher rd1 = request.getRequestDispatcher("admin.jsp");
                rd1.forward(request,response);
            }
        } finally {
            out.close();
        }
    }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
        {
            processRequest(request, response);
        }
        
        @Override
        public String getServletInfo() 
        {
            return "Short description";
        }
}   