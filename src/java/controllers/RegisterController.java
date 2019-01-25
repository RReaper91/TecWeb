package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import beans.User;
import javax.servlet.http.HttpSession;

public class RegisterController extends HttpServlet 
{
        /**
         * controllo sulla registrazione di nuovi utenti
         * richiama il metodo RegisterUser
         */
        protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  
        {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            try 
            {
                User user = new User();
     
                user.setFirst_name(request.getParameter("first_name"));
                user.setLast_name(request.getParameter("last_name"));
                user.setUser(request.getParameter("user"));
                user.setPwd(request.getParameter("pwd"));
                user.setEmail(request.getParameter("email"));
                user.setCitta(request.getParameter("citta"));
                user.setData(request.getParameter("data"));
                
                boolean userRegistered = user.RegisterUser();
                
                if (userRegistered == true)
                {
                    RequestDispatcher rd = request.getRequestDispatcher("register_Succes.html");
                    rd.forward(request,response);    
                } else 
                {
                    RequestDispatcher rd = request.getRequestDispatcher("register_error.html");
                    rd.forward(request,response);
                }
            } finally {
                out.close();
            }
        }
           
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
        {
            processRequest(request, response);
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