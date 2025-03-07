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
        ArrayList<Employee> employees = new ArrayList<>();
        try {
            String sql = "SELECT [id_Employee]\n"
                    + "      ,[name_Employee]\n"
                    + "  FROM [Employees]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("id_Employee"));
                e.setName(rs.getString("name_Employee"));
                employees.add(e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return employees;
    }

    @Override
    public Employee get(int id) {
        ArrayList<Employee> employees = new ArrayList<>();
        //Một danh sách Employees được tạo để chứa dữ liệu nhân viên lấy từ cơ sở dữ liệu.
        try {

            String sql = """
                         SELECT e.id_Employee AS staffid, 
                                    e.name_Employee AS staffname, 
                                    e.managerid, 
                                    m.name_Employee AS mananame,
                                    d.id_Department AS departid, 
                                    d.name_Department AS departname
                             FROM Employees e
                             LEFT JOIN Employees m ON e.managerid = m.id_Employee
                             LEFT JOIN Department d ON e.id_Department = d.id_Department
                             WHERE e.id_Employee = ? OR e.managerid = ?;
                         """;
            //PreparedStatement được dùng để ngăn ngừa SQL Injection.
            //Giúp ngăn chặn việc bị phá hủy cơ sở dữ liệu, tránh bị hack và mã độc 
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);//đặt giá trị id vào dấu ? trong truy vấn SQL.
            stm.setInt(2, id);
            ResultSet rs = stm.executeQuery();//thực thi truy vấn và nhận kết quả.
/*-----------------------------------------------------------------------------------------*/
//Duyệt qua kết quả và tạo đối tượng Employee        
//Lấy thông tin từ ResultSet rs và tạo đối tượng Employee         
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("staffid"));
                e.setName(rs.getString("staffname"));
                int managerid = rs.getInt("managerid");

                //Nếu nhân viên có managerid ≠ 0, 
                //thì tạo đối tượng Employee làm quản lý (Manager).
                if (managerid != 0) {
                    Employee m = new Employee();
                    m.setId(rs.getInt("managerid"));
                    m.setName(rs.getString("mananame"));
                    e.setManager(m);
                }
                //Tạo đối tượng Department để lưu thông tin về phòng ban(Department).
                Department d = new Department();
                d.setId(rs.getInt("departid"));
                d.setName(rs.getString("departname"));
                e.setDept(d);
                //Thêm nhân viên vào danh sách employees
                employees.add(e);

            }
        } catch (SQLException ex) {
            Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EmployeeDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        /*-----------------------------------------------------------------------------------*/
        // Xây dựng cây nhân viên (Hierarchy)
        if (employees.size() > 0) {
            //root: Là nhân viên chính (đầu vào id)
            //Lặp qua danh sách nhân viên, nếu một nhân viên có quản lý (manager), 
            //thì thêm nhân viên đó vào danh sách nhân viên dưới quyền (directstaffs).
            Employee root = employees.get(0);
            for (Employee employee : employees) {
                if (root != employee) {
                    Employee manager = findManager(employees, employee);
                    employee.setManager(manager);
                    manager.getDirectstaffs().add(employee);
                    root.getStaffs().add(employee);
                }
            }
            //Trả về root, tức là nhân viên chính và cây cấp dưới của họ.
            return root;
        } else {
            return null;
        }
    }

    //Duyệt danh sách emps để tìm quản lý của Employee e dựa vào managerid.
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
