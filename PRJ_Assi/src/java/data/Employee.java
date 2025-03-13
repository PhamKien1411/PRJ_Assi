/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

import java.util.ArrayList;

/**
 *
 * @author ADM
 */
public class Employee {
    private int id;
    private String name;
    private Department dept;
    private Employee manager;
    private ArrayList<Employee> staffs = new ArrayList<>();
    private ArrayList<Employee> directstaffs = new ArrayList<>();
 private Employee manager_by_id;

    public Employee getManager_by_id() {
        return manager_by_id;
    }

    public void setManager_by_id(Employee manager_by_id) {
        this.manager_by_id = manager_by_id;
    }

    public Employee(int id, String name, Department dept, Employee manager, Employee manager_by_id) {
        this.id = id;
        this.name = name;
        this.dept = dept;
        this.manager = manager;
        this.manager_by_id = manager_by_id;
    }

    public Employee() {
    }
    

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Department getDept() {
        return dept;
    }

    public void setDept(Department dept) {
        this.dept = dept;
    }

    public Employee getManager() {
        return manager;
    }

    public void setManager(Employee manager) {
        this.manager = manager;
    }

    public ArrayList<Employee> getStaffs() {
        return staffs;
    }

    public void setStaffs(ArrayList<Employee> staffs) {
        this.staffs = staffs;
    }

    public ArrayList<Employee> getDirectstaffs() {
        return directstaffs;
    }

    public void setDirectstaffs(ArrayList<Employee> directstaffs) {
        this.directstaffs = directstaffs;
    }

 
}
