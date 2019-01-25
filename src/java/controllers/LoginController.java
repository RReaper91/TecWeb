package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import beans.User;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import static javax.swing.JOptionPane.showMessageDialog;

public class LoginController extends HttpServlet 
{
    /**
     * controller per la login degli utenti.
     * richiama il metodo LoginUser
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

                
        try
        {
            User user = new User();
            user.setUser(request.getParameter("user"));
            user.setPwd(request.getParameter("pwd"));
        
            if(User.LoginUser(request.getParameter("user"),request.getParameter("pwd")))
            {
               
                
                User us = new User();
                us.setUser(String.valueOf(request.getParameter("user")));
                us.GetUser();
                
                HttpSession sessionUser = request.getSession();
                sessionUser.setAttribute("user",us.getUser());
                
                RequestDispatcher rd1 = request.getRequestDispatcher("welcome_page.jsp");
                rd1.forward(request,response);
            } else
            {
                RequestDispatcher rd1 = request.getRequestDispatcher("login_error.html");
                rd1.forward(request,response);
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