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

public class AddMarker extends HttpServlet 
{
    
        /**
         * controller per l'inserimento di nuovi marker. 
         * richiama il metodo Add_Markers
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
                user.setLatd(Double.parseDouble(request.getParameter("latd")));
                user.setLongit(Double.parseDouble(request.getParameter("longit")));
                user.setInqui(request.getParameter("inqui"));
                user.setValore((int) ((Math.random() * 100) +1));
     
                boolean vero = user.Add_Markers();
                
                if (vero == true)
                {
                    RequestDispatcher rd1 = request.getRequestDispatcher("admin.jsp");
                    rd1.forward(request,response);
                } else 
                {
                    RequestDispatcher rd1 = request.getRequestDispatcher("admin.jsp");
                    rd1.forward(request,response);
                }
            } finally {out.close();}
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