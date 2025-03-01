/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import data.Department;
import data.Employee;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADM
 */
public class EmployeeDBContext extends DBContext<Employee> {

    @Override
    public ArrayList<Employee> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

      
    @Override
    public Employee get(int id) {
    ArrayList<Employee> employeeS = new ArrayList<>();
     try{
         String sql = "WITH employee_hierarchy AS (\n" 
                 //khai báo một CTE đệ quy để lấy ra tất cả nhân viên liên quan đến id_Employee = ?
                    + "    SELECT id_Employee, managerid, 0 AS level\n"
                    + "    FROM Employees\n"
                    + "    WHERE id_Employee = ?\n"
                    + "    UNION ALL\n"
                    + "    SELECT e.id_Employee, e.managerid, eh.level + 1\n"
                    + "    FROM Employees e\n"
                    + "    INNER JOIN employee_hierarchy eh ON e.managerid = eh.id_Employee\n"
                    + ")\n"      
                 
                 
                    + "SELECT \n"
                    + "    e.id_Employee as [staffid], \n"
                    + "	staff.name_Employee as [staffname],\n"
                    + "    e.managerid as [ID quản lí],\n"
                    + "	manager.name_Employee as [Tên quản lý],\n"
                    + "	d.id_Department as [Mã phòng ban],\n"
                    + "	d.name_Department as [Tên phòng ban]\n"
                    + "FROM employee_hierarchy e INNER JOIN Employees staff ON staff.id_Employee = e.id_Employee\n"
                    + "INNER JOIN Department d ON d.id_Department = staff.id_Department\n"
                    + "LEFT JOIN Employees manager ON e.managerid = manager.id_Employee";
        
         
         PreparedStatement stm = connection.prepareStatement(sql);
         stm.setInt(1, id);
         ResultSet rs = stm.executeQuery();
         while (rs.next()) {
             Employee e = new Employee();
             e.setId(rs.getInt("staffid"));
             e.setName(rs.getString("staffname"));
             int managerid = rs.getInt("managerid");
             
             
             if (managerid != 0) {
                 Employee m = new Employee();
                 m.setId(rs.getInt("managerid"));
                 m.setName(rs.getString("managername"));
                 e.setManager(m);
             }
                Department d = new Department();
                d.setId(rs.getInt("id_Department"));
                d.setName(rs.getString("name_Department"));
                e.setDept(d);
                employeeS.add(e);
     
            }
     }catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
     if (employeeS.size() > 0) {
            Employee root = employeeS.get(0);
            for (Employee e : employeeS) {
                if (root != e) {
                    Employee manager = findManager(employeeS, e);
                    e.setManager(manager);
                    manager.getDirectstaffs().add(e);
                    root.getStaffs().add(e);
                }
            }
            return root;
        } else {
            return null;
        }
    }
    
    
      private Employee findManager(ArrayList<Employee> emps, Employee e) {
        for (Employee emp : emps) {
            if (e.getManager().getId() == emp.getId()) {
                return emp;
            }
        }
        return null;
    }
    

  @Override
    public void insert(Employee model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Employee model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Employee model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    



}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  