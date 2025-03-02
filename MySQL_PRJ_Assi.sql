﻿create database User_PRJ_Assi
use User_PRJ_Assi


------tạo bảng Department(phòng ban)
create table Department(
   id_Department int primary key,
   name_Department varchar(150)
);
------Tạo bảng employee
create table Employees(
    id_Employee int primary key,
    name_Employee varchar(150),
    id_Department INT,
    managerid INT,
    FOREIGN KEY (id_Department) REFERENCES Department(id_Department),
    FOREIGN KEY (managerid) REFERENCES Employees(id_Employee)

);

---Tạo bảng User
CREATE TABLE Users (
    username VARCHAR(150) PRIMARY KEY,
    [password] VARCHAR(150),
    displayname NVARCHAR(150),
	id_Employee int,
	FOREIGN KEY (id_Employee) REFERENCES Employees(id_Employee)
);

-- Tạo bảng Roles
CREATE TABLE Roles (
    id_Roles INT PRIMARY KEY,
    name_Roles VARCHAR(150)
);


-- Bảng trung gian User_Role để liên kết Users và Roles
CREATE TABLE User_Role (
    username VARCHAR(150) NOT NULL,
    id_Roles INT,
    PRIMARY KEY (username, id_Roles),
    FOREIGN KEY (username) REFERENCES Users(username),
    FOREIGN KEY (id_Roles) REFERENCES Roles(id_Roles)
);


-- Tạo bảng Features
CREATE TABLE Features (
    id_Feature int PRIMARY KEY,
    url_Feature VARCHAR(2083)
);


-- Bảng trung gian Role_Feature để liên kết Roles và Features
CREATE TABLE Role_Feature (
    id_Roles INT NOT NULL,
    id_Feature  INT NOT NULL,
    PRIMARY KEY (id_Roles, id_Feature),
    FOREIGN KEY (id_Roles) REFERENCES Roles(id_Roles),
    FOREIGN KEY (id_Feature) REFERENCES Features(id_Feature )
);

--bảng Emphoyees( 
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (1, N'Mr.Kien', 1, NULL)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) values (2, N'Mr.John',1,1 )
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (3, N'Mr.A', 1, 2)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (4, N'Mr.B', 1, 2)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid])VALUES (5, N'Mr.C', 1, 2)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid])VALUES (6, N'Mr.D', 1, 2)


------tạo bảng insert into của bảng Users
insert into Users (username,[password],displayname) values (N'kien', N'1234', N'Mr.Kien')
insert into Users (username,[password],displayname) values (N'john', N'12', N'Mr.John')
insert into Users (username,[password],displayname) values (N'mra', N'123', N'Mr.A')
insert into Users (username,[password],displayname) values (N'mrb', N'123', N'Mr.B')
insert into Users (username,[password],displayname) values (N'mrc', N'123', N'Mr.C')
insert into Users (username,[password],displayname) values (N'mrd', N'123', N'Mr.D')

-------tạo bảng insert into User_Role
insert into User_Role(username,id_Roles) values (N'kien',1)
insert into User_Role(username,id_Roles) values (N'john',2)
insert into User_Role(username,id_Roles) values (N'mra',3)
insert into User_Role(username,id_Roles) values (N'mrb',3)
insert into User_Role(username,id_Roles) values (N'mrc',3)
insert into User_Role(username,id_Roles) values (N'mrd',3)

----------------bảng insert into  Roles
insert into Roles(id_Roles,name_Roles) values(1,N'Sếp')
insert into Roles(id_Roles,name_Roles) values(2,N'Trưởng phòng')
insert into Roles(id_Roles,name_Roles) values(3,N'Nhân viên')

------------------bảng insert into Features
insert into Features(id_Feature,url_Feature) values  (1, N'/user/list')
INSERT into Features(id_Feature, url_Feature) values (2, N'/user/create')
INSERT into Features(id_Feature, url_Feature) values (3, N'/user/update')
INSERT into Features(id_Feature, url_Feature) values (4, N'/user/delete')

------------------bảng insert into Role_Feature
insert into Role_Feature(id_Roles,id_Feature) values (1,1)
insert into Role_Feature(id_Roles,id_Feature) values (1,2)
insert into Role_Feature(id_Roles,id_Feature) values (1,3)
insert into Role_Feature(id_Roles,id_Feature) values (1,4)
insert into Role_Feature(id_Roles,id_Feature) values (2,1)
insert into Role_Feature(id_Roles,id_Feature) values (2,2)
insert into Role_Feature(id_Roles,id_Feature) values (2,3)
insert into Role_Feature(id_Roles,id_Feature) values (3,4)
insert into Role_Feature(id_Roles,id_Feature) values (4,4)


INSERT into Department (id_Department, name_Department) VALUES (1, N'IT')
INSERT into Department (id_Department, name_Department) VALUES (2, N'Accounting')
INSERT into Department (id_Department, name_Department) VALUES (3, N'Marketing')



WITH employee_hierarchy AS (
    SELECT id_Employee, managerid, 0 AS level
    FROM Employees
    WHERE id_Employee = 1
    UNION ALL   
    SELECT e.id_Employee, e.managerid, eh.level + 1
    FROM Employees e
    INNER JOIN employee_hierarchy eh ON e.managerid = eh.id_Employee
)

SELECT e.id_Employee as [staffid], 
       staff.name_Employee as [staffname],
       e.managerid as [ID quản lí],
       manager.name_Employee as [Tên quản lý],
       d.id_Department as [Mã phòng ban],
       d.name_Department as [Tên phòng ban]
FROM employee_hierarchy e INNER JOIN Employees staff ON staff.id_Employee = e.id_Employee
                          INNER JOIN Department d ON d.id_Department = staff.id_Department
                          LEFT JOIN Employees manager ON e.managerid = manager.id_Employee

SELECT * FROM Users u INNER JOIN Employees e ON u.id_Employee = e.id_Employee WHERE u.username = 'kien';

SELECT * FROM Users u 
INNER JOIN Employees e ON u.id_Employee = e.id_Employee 
INNER JOIN Department d ON e.id_Department = d.id_Department 
WHERE u.username = 'kien';


SELECT ur.username, r.id_Roles, r.name_Roles
FROM User_Role ur
LEFT JOIN Roles r ON ur.id_Roles = r.id_Roles
WHERE ur.username = 'kien';


SELECT rf.id_Roles, f.id_Feature, f.url_Feature
FROM Role_Feature rf
LEFT JOIN Features f ON rf.id_Feature = f.id_Feature
WHERE rf.id_Roles IN (SELECT id_Roles FROM User_Role WHERE username = 'kien');

SELECT * FROM Users WHERE username = 'john' AND id_Employee IS NULL;
UPDATE Users SET id_Employee = 1 WHERE username = 'kien';
UPDATE Users SET id_Employee = 2 WHERE username = 'john';
UPDATE Users SET id_Employee = 3 WHERE username = 'mra';
UPDATE Users SET id_Employee = 4 WHERE username = 'mrb';
UPDATE Users SET id_Employee = 5 WHERE username = 'mrc';
UPDATE Users SET id_Employee = 6 WHERE username = 'mrd';


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
WHERE u.username = 'kien' and u.password = '1234';



