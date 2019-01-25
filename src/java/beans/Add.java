package beans;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.*;
import database.Db_Connection;
import static java.lang.System.out;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Add 
{
    private String nome, inqui, inizio, fine;
    private Double latd, longit;
    private Integer valore;
    
    public Add()
    {        
        nome="";
        latd=0.0;
        longit=0.0;
        inqui="";
        valore=0;
        inizio="";
        fine="";
    }        
 
    //----------------------------------// 
    
    public String getNome()
    {
        return nome;
    }
   
    public Double getLatd()
    {
        return latd;
    }
    
    public Double getLongit()
    {
        return longit;
    }
    
    public String getInqui()
    {
        return inqui;
    }
    
    public Integer getValore()
    {
        return valore;
    }
    
    public String getInizio()
    {
        return inizio;
    }
    
    public String getFine()
    {
        return fine;
    }

    //----------------------------------//
    
    public void setNome(String nome)
    {
        this.nome=nome;
    }
    
    public void setLatd(Double latd)
    {
        this.latd=latd;
    }
    
    public void setLongit(Double longit)
    {
        this.longit=longit;
    }
    
    public void setInqui(String inqui)
    {
        this.inqui=inqui;
    }
    
    public void setValore(Integer valore)
    {
        this.valore=valore;
    }
    
    public void setInizio(String inizio)
    {
        this.inizio=inizio;
    }
    
    public void setFine(String fine)
    {
        this.fine=fine;
    }

    //-----------------------------//

    /**
     * inserimento di nuovi marker nel db 
     */
    public boolean Add_Markers()
    {    
        boolean isVero= true;
        
        try
        {      
            Db_Connection dbconn=new Db_Connection();
            Connection myconnection= dbconn.Connection();
                
            String sql = "INSERT INTO map (nome, latd, longit, inqui, valore) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement st =myconnection.prepareStatement(sql);
                
            st.setString(1, nome);
            st.setDouble(2, latd);
            st.setDouble(3, longit);
            st.setString(4, inqui);
            st.setInt(5, valore);
            st.executeUpdate();
                
            myconnection.close();
        } catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return isVero;
    }

    
    //----------------------------------//
    
    /**
     * cancellazione di una sonda dal db
     */
    public boolean Add_Delete()
    {
        boolean isVero = true;
        
        try
        {    
            Db_Connection dbconn=new Db_Connection();
            Connection myconnection= dbconn.Connection();

            String sqlString="DELETE FROM map WHERE nome=('"+nome+"') ";
            
            Statement myStatement = myconnection.createStatement();
            
            try
            {    
                myStatement.executeUpdate(sqlString);
                myStatement.close();
                myconnection.close();
            } catch (SQLException ex) {
                Logger.getLogger(Add.class.getName()).log(Level.SEVERE, null, ex);
                isVero = false ;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Add.class.getName()).log(Level.SEVERE, null, ex);
            isVero = false;
        }
        return isVero;
    }
    
    //----------------------------------//
    
    /**
     * ritorna la media di un inquinante in una data città
     */
    public double Media_Sensore()
    {   
        double isMedia = 0.0;
        
        try
        {    
            Db_Connection dbconn=new Db_Connection();
            Connection myconnection= dbconn.Connection();

            String sqlString="SELECT AVG(valore) AS media FROM map WHERE nome='"+nome+"' AND inqui='"+inqui+"' AND data BETWEEN '"+inizio+" 00:00:00' AND '"+fine+" 00:00:00'";
            Statement myStatement = myconnection.createStatement();
            ResultSet rs=myStatement.executeQuery(sqlString);
            
            while(rs.next()){
                isMedia = rs.getDouble("media");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Add.class.getName()).log(Level.SEVERE, null, ex);
        }
        return isMedia;
    }    
}