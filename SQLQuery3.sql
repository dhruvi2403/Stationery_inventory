CREATE DATABASE ECommerce1

USE ECommerce1

CREATE TABLE Category
(
	CategoryId int primary key identity(1,1),
	CategoryName varchar(100) not null,
	CategoryImageUrl varchar(max) not null,
	IsActive bit not null,
	CreatedDate datetime not null

)

-- drop table Category

CREATE TABLE SubCategory
(
	SubCategoryId int primary key identity(1,1),
	SubCategoryName varchar(100),
	CategoryId int foreign key references Category(CategoryId) on delete cascade not null,
	IsActive bit not null,
	CreatedDate datetime not null

)

create table Product 
(
	ProductId int primary key identity(1,1),
	ProductName varchar(100) not null,
	ShortDescription varchar(200) null,
	LongDescription varchar(max) null,
	AdditionalDescription varchar(max) null,
	Price decimal(18,2) not null,
	Quantity int not null,
	Size varchar(30) null,
	Color varchar(30) null,
	CompanyName varchar(100) null,
	CategoryId int foreign key references Category(CategoryId) on delete cascade not null,
	SubCategoryId int not null,
	Sold int null,
	IsCustomised bit not null,
	IsActive bit not null,
	CreatedDate datetime not null
)

create table ProductImages
(
	ImageId int primary key identity(1,1),
	ImageUrl varchar(max) null,
	ProductId int foreign key references Product(ProductId) on delete cascade not null,
	DefaultImage bit null
)

create table Roles
(
	RoleId int primary key,
	RoleName varchar(100) not null
)

insert into Roles Values (1,'Admin')
insert into Roles values (2,'Customer')


create table users
(
	UserId int primary key identity(1,1),
	Name varchar(50) null,
	Username varchar(50) null unique,
	Mobile varchar(20) null,
	Email varchar(50) null,
	Address varchar(max) null,
	PostCode varchar(50) null,
	Password varchar(50) null,
	ImageUrl varchar(max) null,
	RoleId int foreign key references Roles(RoleId) on delete cascade not null,
	CreatedDate datetime not null
)

--drop table users 


create table ProductReview
(
	Review int primary key identity(1,1),
	Rating int not null,
	Comment varchar(max) null,
	ProductId int foreign key references Product(ProductId) on delete cascade not null,
	UserId int foreign key references Users(UserId) on delete cascade not null,
	CreatedDate datetime not null
)

create table WishList
(
	WishlistId int primary key identity(1,1),
	ProductId int foreign key references Product(ProductId) on delete cascade not null,
	UserId int foreign key references Users(UserId) on delete cascade not null,
	CreatedDate datetime not null
)

create table Cart
(
	CardId int primary key identity(1,1),
	ProductId int foreign key references Product(ProductId) on delete cascade not null,
	Quantity int null,
	UserId int foreign key references Users(UserId) on delete cascade not null,
	CreatedDate datetime not null

)

create table Contact
(
	ContactId int primary key identity(1,1),
	Name varchar(50) null,
	Email varchar(50) null,
	Subject varchar(50) null,
	Message varchar(max) null,
	CreatedDate datetime not null
)

create table Payment
(
	PaymentId int primary key identity(1,1),
	Name varchar(50) null,
	CardNo varchar(50) null,
	ExpiryDate varchar(50) null,
	CvvNo int null,
	Address varchar(max) null,
	PaymentMode varchar(50) null
)
create table Orders
(
	OrderDetailsId int primary key identity(1,1),
	OrderNo varchar(max) null,
	ProductId int foreign key references Product(ProductId) on delete cascade not null,
	Quantity int null,
	UserId int foreign key references Users(UserId) on delete cascade not null,
	Status varchar(50) null,
	PaymentId int foreign key references Payment(PaymentId) on delete cascade not null,
	OrderDate datetime not null,
	IsCancel bit not null default 0,
)