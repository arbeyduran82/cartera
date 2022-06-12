package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.swing.JOptionPane;

public class Conexion {
    private Connection con;
    private Statement stm;

    public Conexion(){
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con=DriverManager.getConnection("jdbc:mysql://localhost/DClase", "root", "");
            stm=con.createStatement();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }
    
    public Boolean CUD(String sql){
        Boolean b=false;
        try {
            b=stm.execute(sql);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
            b=true;
        }
        return b;
        
        
    }

    public ResultSet Consulta(String sql){
        ResultSet r=null;
        try {
            r=stm.executeQuery(sql);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
        return r;

    }

    public void Cerrar(){
        try {
            stm.close();
            con.close();
        } catch (Exception e) {
            
        }
    }
    
    
}
