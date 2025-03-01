/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import data.Department;
import data.Employee;
import data.Feature;
import data.Role;
import data.User;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsersDBContext extends DBContext<User>{
   public User get(String username, String password){
       try{
        /*
        String sql = "SELECT username,displayname FROM Users\n"
                    + "WHERE username = ? AND [password] = ?";
       
       */
       String sql = "SELECT u.username,u.displayname\n"
                    + "                    ,r.id_Roles,r.name_Roles\n"
                    + "                    ,f.id_Feature,f.url_Feature\n"
                    + "					,e.id_Employee,e.name_Employee\n"
                    + "					,d.id_Department,d.name_Department\n"
                    + "                    FROM Users u \n"
                    + "					INNER JOIN Employees e ON u.id_Employee = e.id_Employee\n"
                    + "					INNER JOIN Department d ON e.id_Department = d.id_Department\n"
                    + "					LEFT JOIN User_Role ur ON u.username = ur.username\n"
                    + "                    LEFT JOIN Roles r ON ur.id_Roles = r.id_Roles\n"
                    + "                    LEFT JOIN Role_Feature rf ON rf.id_Roles = r.id_Roles\n"
                    + "                    LEFT JOIN Features f ON f. id_Feature  = rf. id_Feature \n"
                    + "                    WHERE u.username = ? AND u.password = ?";
       PreparedStatement stm = connection.prepareStatement(sql);
       stm.setString(1, username);
       stm.setString(2,password);
       ResultSet rs = stm.executeQuery();
       
       /*-------------------------------*/
       User user = null;
       Role current_role = new Role();
       current_role.setId(-1);
       
       
       while(rs.next()){ 
      /* if(rs.next()){
           User u = new User();
           u.setUsername(username);
           u.setDisplayname(rs.getString("displayname"));
           return u;           
       }*/
       
       if (user == null) {
                    user = new User();
                    user.setUsername(username);
                    user.setDisplayname(rs.getString("displayname"));
                    Employee e = new Employee();
                    e.setId(rs.getInt("id_Employee"));
                    e.setName(rs.getString("name_Employee"));
                    Department d = new Department();
                    d.setId(rs.getInt("id_Department"));
                    d.setName(rs.getString("name_Department"));
                    e.setDept(d);
                    user.setEmployee(e);
                }

                int rid = rs.getInt("id_Roles");
                if (rid != 0 && rid != current_role.getId()) {
                    current_role = new Role();
                    current_role.setId(rid);
                    current_role.setName(rs.getString("name_Roles"));
                    user.getRoles().add(current_role);
                    current_role.getUsers().add(user);
                }

                int fid = rs.getInt("id_Feature");
                if (fid != 0) {
                    Feature f = new Feature();
                    f.setId(rs.getInt("id_Feature"));
                    f.setUrl(rs.getString("url_Feature"));
                    current_role.getFeature().add(f);
                    f.getRoles().add(current_role);
                }
       }
            return user;
       }catch(SQLException ex){
           Logger.getLogger(UsersDBContext.class.getName()).log(Level.SEVERE,null,ex);
       }
       finally{
           if(connection!=null)
               try{
                   connection.close();
               }catch(SQLException ex){
                   Logger.getLogger(UsersDBContext.class.getName()).log(Level.SEVERE,null,ex);
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

