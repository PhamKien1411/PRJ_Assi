/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import data.User;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContextUsers extends DBContext<User>{
   public User  get(String username, String password){
       try{
          //Để ý String sql 
         String sql = "SELECT username,displayname FROM Users\n"
                    + "WHERE username = ? AND [password] = ?";
       PreparedStatement stm = connection.prepareStatement(sql);
       stm.setString(1, username);
       stm.setString(2,password);
       ResultSet rs = stm.executeQuery();
       if(rs.next()){
           User u = new User();
           u.setUsername(username);
           u.setDisplayname(rs.getString("displayname"));
           return u;
           
       }
       }catch(SQLException ex){
           Logger.getLogger( DBContextUsers.class.getName()).log(Level.SEVERE,null,ex);
       }
       finally{
           if(connection!=null)
               try{
                   connection.close();
               }catch(SQLException ex){
                   Logger.getLogger( DBContextUsers.class.getName()).log(Level.SEVERE,null,ex);
               }
       }
       return null;
   }

    @Override
    public ArrayList<User> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public User get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(User model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(User model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(User model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}

