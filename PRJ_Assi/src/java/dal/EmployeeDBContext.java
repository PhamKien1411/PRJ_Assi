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
//Lớp EmployeeDBContext kế thừa từ DBContext<Employee>, 
//có nhiệm vụ thao tác với cơ sở dữ liệu để lấy thông tin về nhân viên (Employee). 
public class EmployeeDBContext extends DBContext<Employee> {

    @Override
    public Employee get(int id) {
        ArrayList<Employee> employees = new ArrayList<>();
        //Một danh sách Employees được tạo để chứa dữ liệu nhân viên lấy từ cơ sở dữ liệu.
        try {
            //Truy vấn SQL với CTE đệ quy
            //Truy xuất nhân viên có id_Employee = ? (tức là nhân viên cần tìm).
            //Đệ quy lấy tất cả người quản lý(staff) của nhân viên đó (managerid).
            String sql = """
                     WITH employee_hierarchy AS (
                         SELECT id_Employee, managerid, 0 AS level
                         FROM Employees
                         WHERE id_Employee = ?
                         UNION ALL   
                         SELECT e.id_Employee, e.managerid, eh.level + 1
                         FROM Employees e
                         INNER JOIN employee_hierarchy eh ON e.managerid = eh.id_Employee
                     )
                     
                     SELECT e.id_Employee as [staffid], 
                            staff.name_Employee as [staffname],
                            e.managerid as [managerid],
                            manager.name_Employee as [mananame],
                            d.id_Department as [departid],
                            d.name_Department as [departname]
                     FROM employee_hierarchy e INNER JOIN Employees staff ON staff.id_Employee = e.id_Employee
                                               INNER JOIN Department d ON d.id_Department = staff.id_Department
                                               LEFT JOIN Employees manager ON e.managerid = manager.id_Employee
                        Order by e.id_Employee asc; 
                     """;

            //PreparedStatement được dùng để ngăn ngừa SQL Injection.
            //Giúp ngăn chặn việc bị phá hủy cơ sở dữ liệu, tránh bị hack và mã độc 
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);//đặt giá trị id vào dấu ? trong truy vấn SQL.
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

    @Override
    public ArrayList<Employee> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
    
    
    
    
    
    
    
    
    
    
    
  