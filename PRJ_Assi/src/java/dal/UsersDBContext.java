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

/*Lớp UsersDBContext kế thừa từ DBContext<User> 
và có nhiệm vụ truy xuất thông tin của người dùng (User) từ cơ sở dữ liệu, bao gồm:
+) Thông tin cá nhân: Tên đăng nhập (username), tên hiển thị (displayname).
+) Thông tin nhân viên: ID, tên nhân viên, phòng ban.
+) Vai trò (Role) của người dùng và các chức năng (Feature) mà vai trò đó có quyền truy cập.*/


public class UsersDBContext extends DBContext<User>{
   public User get(String username, String password){
       try{      
       String sql = """
                    SELECT u.username,
                           u.displayname,
                           r.id_Roles,
                           r.name_Roles,
                           f.id_Feature,
                           f.url_Feature,
                           e.id_Employee,
                           e.name_Employee,
                           d.id_Department,
                           d.name_Department
                    FROM Users u
                    INNER JOIN Employees e ON u.id_Employee = e.id_Employee
                    INNER JOIN Department d ON e.id_Department = d.id_Department
                    LEFT JOIN User_Role ur ON u.username = ur.username
                    LEFT JOIN Roles r ON ur.id_Roles = r.id_Roles
                    LEFT JOIN Role_Feature rf ON rf.id_Roles = r.id_Roles
                    LEFT JOIN Features f ON f.id_Feature = rf.id_Feature
                    WHERE u.username = ? and u.password = ?;
                    """;
       
       
       PreparedStatement stm = connection.prepareStatement(sql);
       //Gán giá trị username và password vào truy vấn SQL.
       stm.setString(1, username);
       stm.setString(2,password);
       //Thực thi truy vấn (executeQuery) và lưu kết quả vào ResultSet rs.
       ResultSet rs = stm.executeQuery();
       
       /*-------------------------------*/
      
       User user = null;//ban đầu chưa có đối tượng User
       //current_role: Biến tạm để kiểm tra vai trò hiện tại,
       Role current_role = new Role();
       //gán ID -1 (ID không hợp lệ để kiểm tra khi đọc dữ liệu từ ResultSet).
       current_role.setId(-1);
       
       
       while(rs.next()){ 

       if (user == null) {
        //Khởi tạo đối tượng User, gán username và displayname   
                    user = new User();
                    user.setUsername(username);
                    user.setDisplayname(rs.getString("displayname"));
                    Employee e = new Employee();//Tạo Employee để lưu thông tin nhân viên.
                    e.setId(rs.getInt("id_Employee"));
                    e.setName(rs.getString("name_Employee"));
                    Department d = new Department();//Tạo Department và liên kết với nhân viên(Employee).
                    d.setId(rs.getInt("id_Department"));
                    d.setName(rs.getString("name_Department"));
                    e.setDept(d);
                    user.setEmployee(e);
                }
        //Xử lý danh sách vai trò(Role) của User
                int rid = rs.getInt("id_Roles");
        //Nếu rid != 0 và rid khác current_role.getId(), 
        //nghĩa là có một vai trò mới        
                if (rid != 0 && rid != current_role.getId()) {
                    current_role = new Role();
                    current_role.setId(rid);
                    current_role.setName(rs.getString("name_Roles"));
                    //Thêm Role vào danh sách user.getRoles().
                    user.getRoles().add(current_role);
                    current_role.getUsers().add(user);
                }
        //Xử lý danh sách Feature của Role
                int fid = rs.getInt("id_Feature");
                if (fid != 0) {
                    Feature feature = new Feature();
                    feature.setId(rs.getInt("id_Feature"));
                    feature.setUrl(rs.getString("url_Feature"));
                    current_role.getFeature().add(feature);
                    feature.getRoles().add(current_role);
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

