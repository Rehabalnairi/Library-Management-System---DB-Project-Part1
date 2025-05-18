create database Library 
use Library

create table book(
bookId int primary key,
ISBN varchar(20),
title varchar(20) not null,
genre VARCHAR(20) CHECK (genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
price decimal(10, 2) CHECK (price > 0),
availability bit Default 1,
status  varchar(20) not null

);

create table libarary(
LibararyID int primary key,
name varchar(100)not null,
location varchar(20)not null,
contact int,
established_year varchar(20),
);

create table  Members(
 MemberID int primary key not null,
Fullname varchar(100)not null,
email VARCHAR(255),
membership_date date,

);

EXEC sp_rename 'staff', ' Members';
EXEC sp_rename 'Members.staffID', ' MemberID', 'COLUMN';

create table  staff(
 staffID int primary key not null,
Fullname varchar(100)not null,
position VARCHAR(25),
);

create table  loan(
 loan_date date, 
due_date date, 
return_date date, 
status VARCHAR(20) CHECK (status IN ('Issued', 'Returned', 'Overdue')),
MemberID int,
foreign key (MemberID) references Members(MemberID)
);

create table  payments(
paymentID int primary key not null,
payment_date date, 
amount DECIMAL(10, 2) CHECK (amount > 0),
method varchar(100)not null,
);

create table  review(
rating INT CHECK (rating >= 1 AND rating <= 5),
review_date date, 
comments nvarchar(300),
 bookId int,
 foreign key (bookId) references book(bookId),
);

 --create table Book_review (
--bookId int,
--rating int,
 --Foreign key (bookId) references book(bookId),
 --Foreign key (rating) references review(rating),
--  );


CREATE TABLE Book_review (
 bookId INT,
 rating INT CHECK (rating >= 1 AND rating <= 5),
    
 FOREIGN KEY (bookId) REFERENCES book(bookId)
);




ALTER TABLE book
ADD LibararyID INT;

ALTER TABLE book
ADD CONSTRAINT FK_book_library
FOREIGN KEY (LibararyID) REFERENCES libarary(LibararyID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE libarary
ADD staff_ID INT;
ALTER TABLE libarary
ADD bookId INT;
ALTER TABLE libarary
add staff_ID int foreign key references staff(staff_ID);


ALTER TABLE Members
ADD rating INT;

ALTER TABLE  loan
ADD paymentID INT foreign key references payments(paymentID);


 alter table Book_review
add primary key (bookId,rating);

ALTER TABLE Book_review
ALTER COLUMN bookId INT NOT NULL;

ALTER TABLE Book_review
ALTER COLUMN rating INT NOT NULL;

ALTER TABLE Book_review
ADD PRIMARY KEY (bookId, rating);

