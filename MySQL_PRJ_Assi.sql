create database User_PRJ_Assi
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


CREATE TABLE LeaveRequest (
    id_LeaveRequest INT PRIMARY KEY,
    title VARCHAR(150),
    reason VARCHAR(150),
    [from_date] DATE, -- Đổi tên tránh từ khóa SQL
    [to_date] DATE,
    status TINYINT,
    createBy VARCHAR(150),
    ownerid_Employee INT, -- Tham chiếu chính xác đến id_Employee trong Employees
    createddate DATETIME,
    FOREIGN KEY (createBy) REFERENCES Users(username),
    FOREIGN KEY (ownerid_Employee) REFERENCES Employees(id_Employee) -- Đúng tên cột
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
-----------------------------------------------------------------------------
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) values (7, N'Mrs.Linh',3,1)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (8, N'Mrs.E', 3, 7)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (9, N'Mrs.F', 3, 7)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (10, N'Mrs.G', 3, 7)


------tạo bảng insert into của bảng Users
insert into Users (username,[password],displayname) values (N'kien', N'1234', N'Mr.Kien')
insert into Users (username,[password],displayname) values (N'john', N'12', N'Mr.John')
insert into Users (username,[password],displayname) values (N'linh', N'12', N'Mrs.Linh')
insert into Users (username,[password],displayname) values (N'mra', N'123', N'Mr.A')
insert into Users (username,[password],displayname) values (N'mrb', N'123', N'Mr.B')
insert into Users (username,[password],displayname) values (N'mrc', N'123', N'Mr.C')
insert into Users (username,[password],displayname) values (N'mrd', N'123', N'Mr.D')
--------------------------
insert into Users (username,[password],displayname) values (N'mrse', N'123', N'Mrs.E')
insert into Users (username,[password],displayname) values (N'mrsf', N'123', N'Mrs.F')
insert into Users (username,[password],displayname) values (N'mrsg', N'123', N'Mrs.G')


-------tạo bảng insert into User_Role
insert into User_Role(username,id_Roles) values (N'kien',1)
insert into User_Role(username,id_Roles) values (N'john',2)
insert into User_Role(username,id_Roles) values (N'linh',2)
insert into User_Role(username,id_Roles) values (N'mra',3)
insert into User_Role(username,id_Roles) values (N'mrb',3)
insert into User_Role(username,id_Roles) values (N'mrc',3)
insert into User_Role(username,id_Roles) values (N'mrd',3)
-----------------
insert into User_Role(username,id_Roles) values (N'mrse',3)
insert into User_Role(username,id_Roles) values (N'mrsf',3)
insert into User_Role(username,id_Roles) values (N'mrsg',3)


----------------bảng insert into  Roles
insert into Roles(id_Roles,name_Roles) values(1,N'Lãnh đạo')
insert into Roles(id_Roles,name_Roles) values(2,N'Trưởng phòng')
insert into Roles(id_Roles,name_Roles) values(3,N'Nhân viên')
select * from Roles



------------------bảng insert into Features

INSERT into Features(id_Feature, url_Feature) VALUES (1, N'/user/agendalist')
INSERT into Features(id_Feature, url_Feature) VALUES (2, N'/leaverequest/create')
INSERT into Features(id_Feature, url_Feature) VALUES (3, N'/leaverequest/update')

------------------bảng insert into Role_Feature
insert into Role_Feature(id_Roles,id_Feature) values (1,1)
insert into Role_Feature(id_Roles,id_Feature) values (1,2)
insert into Role_Feature(id_Roles,id_Feature) values (1,3)
insert into Role_Feature(id_Roles,id_Feature) values (1,4)

insert into Role_Feature(id_Roles,id_Feature) values (2,1)
insert into Role_Feature(id_Roles,id_Feature) values (2,2)
insert into Role_Feature(id_Roles,id_Feature) values (2,3)
insert into Role_Feature(id_Roles,id_Feature) values (2,4)
insert into Role_Feature(id_Roles,id_Feature) values (2,5)
insert into Role_Feature(id_Roles,id_Feature) values (2,6)

insert into Role_Feature(id_Roles,id_Feature) values (3,2)
insert into Role_Feature(id_Roles,id_Feature) values (3,3)
insert into Role_Feature(id_Roles,id_Feature) values (3,5)
insert into Role_Feature(id_Roles,id_Feature) values (3,6)




INSERT into Department (id_Department, name_Department) VALUES (1, N'IT')
INSERT into Department (id_Department, name_Department) VALUES (2, N'')
INSERT into Department (id_Department, name_Department) VALUES (3, N'Marketing')


----------------------------------------------------------------
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
Order by e.id_Employee asc;
----------------------------------------------------------------
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

-------------------------------------------------------------
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
-------------------------------------------------------

SELECT 
    lr.id_LeaveRequest,
    lr.title,
    lr.reason,
    lr.[from_date],  -- Đúng tên cột
    lr.[to_date],    -- Đúng tên cột
    lr.[status],
    u.username AS createdbyusername,
    u.displayname,
    e.id_Employee AS ownereid,  -- Đúng tên cột trong Employees
    e.name_Employee AS ename,   -- Đúng tên cột trong Employees
    d.id_Department AS did,     -- Đúng tên cột trong Department
    d.name_Department AS dname, -- Đúng tên cột trong Department
    lr.[createddate]
FROM LeaveRequest lr  
INNER JOIN Users u ON u.username = lr.createBy  -- Đúng tên cột
INNER JOIN Employees e ON e.id_Employee = lr.ownerid_Employee  -- Đúng tên cột
INNER JOIN Department d ON e.id_Department = d.id_Department  -- Đúng tên cột
WHERE lr.id_LeaveRequest = 4;


SELECT name_Employee 
FROM Employees 
WHERE ManagerID = (SELECT id_Employee FROM Employees WHERE name_Employee = 'Mr.Kien');
	


