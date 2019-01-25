package beans;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.*;
import database.Db_Connection;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User 
{
    private String first_name,last_name,user,pwd,email,citta,data,id,nome,latd,longit,inquinante;
    
    public User()
    {
        first_name="";
        last_name="";
        user="";
        pwd="";
        email="";
        citta="";
        data="";
        id="";
        nome="";
        latd="";
        longit="";
        inquinante="";
    }        
 
    //----------------------------------//
    
    public String getFirst_name() 
    {
        return first_name;
    }
    
    public String getLast_name() 
    {
        return last_name;
    }

    public String getUser() 
    {
        return user;
    }

    public String getPwd() 
    {
        return pwd;
    }
    
    public String getEmail()
    {
        return email;
    }
    
    public String getCitta()
    {
        return citta;
    }
    
    public String getData()
    {
        return data;
    }
    
    public String getId()
    {
        return id;
    }
    
    public String getNome()
    {
        return nome;
    }
    
    public String getLati()
    {
        return latd;
    }
    
    public String getLongit()
    {
        return longit;
    }
    
     public String getInquinante()
    {
        return inquinante;
    }
    
    //----------------------------------//
    
    public void setFirst_name(String first_name) 
    {
        this.first_name =first_name;
    }

    public void setLast_name(String last_name) 
    {
        this.last_name =last_name;
    }

    public void setUser(String user) 
    {
        this.user=user;
    }

    public void setPwd(String pwd) 
    {
        this.pwd=pwd;
    }
    
    public void setEmail (String email)
    {
        this.email=email;
    }
    
    public void setCitta(String citta)
    {
        this.citta=citta;
    }
    
    public void setData(String data)
    {
        this.data=data;
    }
    
    public void setId(String id)
    {
        this.id=id;
    }
    
    public void setNome(String nome)
    {
        this.nome=nome;
    }
    
    public void setLati(String latd)
    {
        this.latd=latd;
    }
    
    public void setLongit(String longit)
    {
        this.longit=longit;
    }
    
    public void setInquinante(String inquinante)
    {
        this.inquinante=inquinante;
    }
    
    //----------------------------------//

    /**
     * controllo sulla login dell'amministratore
     */
    public static boolean LoginAdmin(String user,String pwd) 
    {
        boolean check =false;
        
        try 
        {      
            Db_Connection dbconn=new Db_Connection();
            Connection myconnection= dbconn.Connection();
                
            PreparedStatement ps1 =myconnection.prepareStatement("SELECT * FROM admin WHERE username=? and password=?");

            ps1.setString(1, user);
            ps1.setString(2, pwd);
            ResultSet rs1 =ps1.executeQuery();
            check = rs1.next();

            myconnection.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
            
            return check;    
    }

    //---------------------------------------//
      
    /**
     * controllo sulla registrazione degli utenti
     */
    public boolean RegisterUser()
    {    
        boolean isRegistrationSucceded = true;
        
        try
        {    
            Db_Connection dbconn=new Db_Connection();
            Connection myconnection= dbconn.Connection();

            String sqlString="INSERT INTO sospeso (first_name,last_name,username,password,email,citta,data) VALUES ('"+first_name+"','"+last_name+"','"+user+"','"+pwd+"','"+email+"','"+citta+"','"+data+"')";
            
            Statement myStatement = myconnection.createStatement();
            
            try
            {    
                myStatement.executeUpdate(sqlString);
                myStatement.close();
                myconnection.close();
            } catch (SQLException ex) {
                Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
                isRegistrationSucceded = false ;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            isRegistrationSucceded = false;
        }
        return isRegistrationSucceded;
    }
    
    //----------------------------------//
    
    /**
     * controllo sull'accettazione di nuovi utenti
     */
    public void AcceptUser(String stringa){
        
        try 
        {        
            Db_Connection dbconn=new Db_Connection();
            Connection myconnection= dbconn.Connection();
            Statement myStatement = myconnection.createStatement();
            
            String sqlSearch="SELECT * FROM sospeso WHERE username='"+stringa+"'";
            
            ResultSet rs = myStatement.executeQuery(sqlSearch);
            while (rs.next())
            {
                first_name = rs.getString("first_name");
                last_name = rs.getString("last_name");
                user = rs.getString("username");
                pwd = rs.getString("password");
                email = rs.getString("email");
                citta = rs.getString("citta");
                data = rs.getString("data");
            }
            
            String sqlInsert="INSERT INTO users (first_name,last_name,username,password,email,citta,data) VALUES ('"+first_name+"','"+last_name+"','"+user+"','"+pwd+"','"+email+"','"+citta+"','"+data+"')";
            
            try
            {    
                myStatement.executeUpdate(sqlInsert);
                myconnection.commit();
            } catch (SQLException ex) {
                Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String sqlDelete="DELETE FROM sospeso WHERE username='"+stringa+"'";
            
            try
            {    
                myStatement.executeUpdate(sqlDelete);
                myconnection.commit();
                myStatement.close();
                myconnection.close();
            } catch (SQLException ex) {
                Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            }

        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //----------------------------------//
    
    /**
     * cambio della password
     */
    public void PasswordUser()
    {
        try
        {    
            Db_Connection dbconn=new Db_Connection();
            Connection myconnection= dbconn.Connection();

            String sqlString="UPDATE users SET password='"+pwd+"' WHERE username='"+user+"'";
            
            Statement myStatement = myconnection.createStatement();
            
            try
            {    
                myStatement.executeUpdate(sqlString);
                myStatement.close();
                myconnection.close();
            } catch (SQLException ex) {Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);}
        } catch (SQLException ex) {Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);}  
    }
    
    //----------------------------------//
    
    /**
     * controllo sulla login degli utenti
     */
    public static boolean LoginUser(String user,String pwd) 
    {
            boolean check =false;
            try 
            {      
                Db_Connection dbconn=new Db_Connection();
                Connection myconnection= dbconn.Connection();
                
                PreparedStatement ps1 =myconnection.prepareStatement("select * from users where username=? and password=?");

                ps1.setString(1, user);
                ps1.setString(2, pwd);
                ResultSet rs1 =ps1.executeQuery();
                check = rs1.next();

                myconnection.close();        
            }catch(Exception e){e.printStackTrace();}
            
            return check;    
    }
    
    //----------------------------------//
    
    public void GetUser()
    {
            try 
            {      
                Db_Connection dbconn=new Db_Connection();
                Connection myconnection= dbconn.Connection();
                
                String sqlString = "SELECT * FROM users WHERE username = '"+user+"'";
                Statement myStatement = myconnection.createStatement();
                ResultSet rs=myStatement.executeQuery(sqlString);

                while(rs.next())
                {
                    first_name= rs.getString("first_name");
                    last_name = rs.getString("last_name");
                    user= rs.getString("username");
                    pwd = rs.getString("password");
                    email = rs.getString("email");
                    citta = rs.getString("citta");
                    data = rs.getString("data");               
                }
                
                myStatement.close();
                myconnection.close();
                
            } catch (SQLException ex) {Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);} 
            
    }
    
}