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

INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (1, N'Mr Kien', 1, NULL)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) values (2, N'Mr John Wick',1,1 )
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (3, N'Mr A', 1, 2)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid]) VALUES (4, N'Mr B', 1, 2)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid])VALUES (5, N'Mr C', 1, 2)
INSERT into Employees (id_Employee, name_Employee, id_Department, [managerid])VALUES (6, N'Mr D', 1, 2)


------tạo bảng insert into của bảng Users
insert into Users (username,[password],displayname) values (N'kien', N'1234', N'Mr Kien')
insert into Users (username,[password],displayname) values (N'john', N'12', N'Mr John Wick')
insert into Users (username,[password],displayname) values (N'mra', N'123', N'Mr A')
insert into Users (username,[password],displayname) values (N'mrb', N'123', N'Mr B')
insert into Users (username,[password],displayname) values (N'mrc', N'123', N'Mr C')
insert into Users (username,[password],displayname) values (N'mrd', N'123', N'Mr D')

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


INSERT into Department ( id_Department, name_Department) VALUES (1, N'IT')
INSERT into Department ( id_Department, name_Department) VALUES (2, N'Accounting')
INSERT into Department ( id_Department, name_Department) VALUES (3, N'Marketing')