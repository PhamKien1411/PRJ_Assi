create database Users_PRJ
use Users_PRJ

CREATE TABLE Users (
    username VARCHAR(150) PRIMARY KEY,
    [password] VARCHAR(150),
    displayname NVARCHAR(150)
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
    FOREIGN KEY (id_Roles) REFERENCES Roles(id_Roles )
);


-- Tạo bảng Features
CREATE TABLE Features (
    id_Feature int PRIMARY KEY,
    url_Feature VARCHAR(MAX)
);


-- Bảng trung gian Role_Feature để liên kết Roles và Features
CREATE TABLE Role_Feature (
    id_Roles INT NOT NULL,
    id_Feature  INT NOT NULL,
    PRIMARY KEY (id_Roles, id_Feature),
    FOREIGN KEY (id_Roles) REFERENCES Roles(id_Roles),
    FOREIGN KEY (id_Feature) REFERENCES Features(id_Feature )
);
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

select * from Users
select * from Roles
select * from Features
select * from Role_Feature
select * from User_Role