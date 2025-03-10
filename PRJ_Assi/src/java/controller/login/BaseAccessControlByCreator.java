/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.login;

import data.BaseEntity;
import data.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public abstract class BaseAccessControlByCreator<T extends BaseEntity> extends BaseRequiredAuthenticationController {
    
    private boolean isAccessed(T entity,User user)
    {
        return user.getUsername().equals(entity.getCreatedby().getUsername());
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        T entity = getEntity(Integer.parseInt(req.getParameter("rid")));
        if(isAccessed(entity, user))
        {
            doPost(req, resp, user, entity);
        }
        else
        {
            resp.getWriter().println("access denied!");
        }
    }
    
    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, User user, T entity) throws ServletException, IOException;
    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, User user, T entity) throws ServletException, IOException;
    protected abstract T getEntity(int id);
   

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        T entity = getEntity(Integer.parseInt(req.getParameter("id")));///
        if(isAccessed(entity, user))
        {
            doGet(req, resp, user, entity);
        }
        else
        {
            resp.getWriter().println("access denied!");
        }
    }
    
}