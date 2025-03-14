create database User_PRJ_Assi
use User_PRJ_Assi


------tạo bảng Department(phòng ban)
drop table Department
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
ALTER TABLE Employees
ADD manager_by_id INT;

ALTER TABLE Employees
ADD CONSTRAINT FK_Manager_By FOREIGN KEY (manager_by_id) REFERENCES Employees(id_Employee);


-- Tạo bảng Employee_Attendance (Chấm công)
CREATE TABLE Employee_Attendance (
    id_Attendance INT IDENTITY(1,1) PRIMARY KEY,
	id_Employee INT NOT NULL,
    attendance_date DATE NOT NULL, -- Đổi `date` thành `attendance_date`
    status VARCHAR(150) CHECK (status IN ('working', 'leave')) NOT NULL, -- SQL Server không hỗ trợ ENUM
    FOREIGN KEY (id_Employee) REFERENCES Employees(id_Employee)
);

DELETE FROM Role_Feature WHERE id_Roles = 1 AND id_Feature = 5;
select * from Role_Feature
---Tạo bảng User
CREATE TABLE Users (
    username VARCHAR(150) PRIMARY KEY,
    [password] VARCHAR(150),
    displayname NVARCHAR(150),
	id_Employee int,
	FOREIGN KEY (id_Employee) REFERENCES Employees(id_Employee)

);
select  * from users

CREATE TABLE LeaveRequest (
    id_LeaveRequest INT IDENTITY(1,1) PRIMARY KEY not null,
    title VARCHAR(150) not null,
    reason VARCHAR(150) not null,
    [from_date] DATE, -- Đổi tên tránh từ khóa SQL
    [to_date] DATE,
    status TINYINT DEFAULT 0,
    createBy VARCHAR(150),
    owner_eid INT, -- Tham chiếu chính xác đến id_Employee trong Employees
    createddate DATETIME default getDate(),
    FOREIGN KEY (createBy) REFERENCES Users(username),
    FOREIGN KEY (owner_eid) REFERENCES Employees(id_Employee) -- Đúng tên cột
);

-- Tạo bảng Roles
CREATE TABLE Roles (
    id_Roles INT PRIMARY KEY,
    name_Roles nVARCHAR(150)
);
select * from Roles
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
UPDATE Employees 
SET manager_by_id = 1 
WHERE id_Employee = 7; 

select * from Employees


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


----------------bảng insert into  Roles
insert into Roles(id_Roles,name_Roles) values(1,N'Lãnh đạo')
insert into Roles(id_Roles,name_Roles) values(2,N'Trưởng phòng')
insert into Roles(id_Roles,name_Roles) values(3,N'Nhân viên')





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

select * from user_role




------------------bảng insert into Features
INSERT into Features(id_Feature, url_Feature) VALUES (1, N'/user/agenda')
INSERT into Features(id_Feature, url_Feature) VALUES (2, N'/leaverequest/create')
INSERT into Features(id_Feature, url_Feature) VALUES (3, N'/leaverequest/update')
INSERT into Features(id_Feature, url_Feature) VALUES (4, N'/leaverequest/view')
INSERT into Features(id_Feature, url_Feature) VALUES (5, N'/leaverequest/duyetdonnghi')

------------------bảng insert into Role_Feature
insert into Role_Feature(id_Roles,id_Feature) values (1,1)
insert into Role_Feature(id_Roles,id_Feature) values (1,5)

insert into Role_Feature(id_Roles,id_Feature) values (2,2)
insert into Role_Feature(id_Roles,id_Feature) values (2,3)
insert into Role_Feature(id_Roles,id_Feature) values (2,4)
insert into Role_Feature(id_Roles,id_Feature) values (2,5)

insert into Role_Feature(id_Roles,id_Feature) values (3,2)
insert into Role_Feature(id_Roles,id_Feature) values (3,3)
insert into Role_Feature(id_Roles,id_Feature) values (3,4)

INSERT into Department (id_Department, name_Department) VALUES (1, N'IT')
INSERT into Department (id_Department, name_Department) VALUES (3, N'Marketing')


----------------------------------------------------------------
select * from Employee_Attendance

SELECT DISTINCT id_Employee
FROM Employee_Attendance;

ALTER TABLE Employee_Attendance
ADD CONSTRAINT unique_attendance UNIQUE (id_Employee, attendance_date);
UPDATE Employees
SET managerid = 1
WHERE managerid IS NOT NULL;


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
INNER JOIN Employees e ON e.id_Employee = lr.owner_eid  -- Đúng tên cột
INNER JOIN Department d ON e.id_Department = d.id_Department  -- Đúng tên cột
WHERE lr.id_LeaveRequest = 1;

SELECT local_net_address, local_tcp_port FROM sys.dm_exec_connections WHERE net_transport = 'TCP';

SELECT name, is_disabled FROM sys.sql_logins WHERE name = 'sa';

SELECT username, password FROM Users WHERE username = 'kien';


SELECT u.username, r.name_Roles 
FROM Users u
JOIN User_Role ur ON u.username = ur.username
JOIN Roles r ON ur.id_Roles = r.id_Roles
WHERE u.username = 'kien';


SELECT r.name_Roles, f.url_Feature 
FROM Role_Feature rf
JOIN Roles r ON rf.id_Roles = r.id_Roles
JOIN Features f ON rf.id_Feature = f.id_Feature
WHERE r.name_Roles = 'Nhân viên';

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
       staff.name_Employee,
       e.managerid,
       manager.name_Employee ,
       d.id_Department ,
       d.name_Department 
FROM employee_hierarchy e INNER JOIN Employees staff ON staff.id_Employee = e.id_Employee
                          INNER JOIN Department d ON d.id_Department = staff.id_Department
                          LEFT JOIN Employees manager ON e.managerid = manager.id_Employee
Order by e.id_Employee asc;


