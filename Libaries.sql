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

select * from libarary
--add  2–3 Libraries
insert into  libarary (LibararyID, name, location, contact, established_year, staff_ID, bookId)
values
(1, 'Central Library', 'Muscat', 24567890, '1990', 1, 1),
(2, 'City Branch', 'Sohar', 24211234, '2001', 2, 4),
(3, 'University Library', 'Nizwa', 24333444, '2010', 3, 7);

--Add Books
select * from book
alter table book
ALTER column title VARCHAR(100);

insert into book (bookId, ISBN, title, genre, price, availability, status, LibararyID,staff_ID)
values
(1, '9780140449136', 'The Odyssey', 'Fiction', 5.99, 1, 'Available', 1,1),
(2, '9780679783275', 'Pride and Prejudice', 'Fiction', 6.99, 1, 'Available', 1,3),
(3, '9780131103627', 'C Programming', 'Reference', 12.50, 1, 'Available', 1,4),
(4, '9780747532743', 'Harry Potter 1', 'Children', 8.50, 1, 'Available', 2,3),
(5, '9780451524935', '1984', 'Fiction', 7.25, 1, 'Available', 2,4),
(6, '9781593279509', 'Python Crash Course', 'Reference', 15.00, 1, 'Available', 2,6),
(7, '9780061120084', 'To Kill a Mockingbird', 'Fiction', 6.80, 1, 'Available', 3,6),
(8, '9780596009205', 'Learning SQL', 'Reference', 10.00, 1, 'Available', 3,7),
(9, '9780439139601', 'Harry Potter 3', 'Children', 9.99, 1, 'Available', 3,8),
(10, '9780525566151', 'Educated', 'Non-fiction', 11.00, 1, 'Available', 3,3);

--add  6+ Members
select * from Members
insert into  Members (MemberID, Fullname, email, membership_date, rating)
values
(1, 'Sara Al-Mukhaini', 'sara@gmail.com', '2023-01-10', 5),
(2, 'Yousef Al-Farsi', 'yousef@gmail.com', '2022-11-05', 4),
(3, 'Laila Al-Mahrooqi', 'laila@gmail.com', '2023-06-15', 3),
(4, 'Omar Al-Hosni', 'omar@gmail.com', '2021-09-20', 5),
(5, 'Aisha Al-Riyami', 'aisha@gmail.com', '2024-01-01', 4),
(6, 'Khalid Al-Busaidi', 'khalid@gmail.com', '2022-03-30', 2);


--Add 4+ Payments
insert into payments (paymentID, payment_date, amount, method)
values
(1, '2024-01-18', 2.00, 'Cash'),
(2, '2024-02-14', 3.50, 'Card'),
(3, '2024-03-01', 5.00, 'Online'),
(4, '2024-03-22', 1.50, 'Cash');



--add 8–10 Loans
select * from loan
insert into loan (loan_date,due_date,return_date,status,MemberID,paymentID)
values
('2024-01-10', '2024-01-20', '2024-01-18', 'Returned', 1, 1),
('2024-02-01', '2024-02-15', '2024-02-14', 'Returned', 2, 2),
('2024-03-01', '2024-03-10', NULL, 'Issued', 3, 3),
('2024-03-05', '2024-03-20', '2024-03-22', 'Overdue', 4, 4),
('2024-04-01', '2024-04-10', '2024-04-09', 'Returned', 5, 1),
('2024-04-15', '2024-04-25', NULL, 'Issued', 6, 2),
('2024-05-01', '2024-05-15', NULL, 'Issued', 1, 3),
('2024-05-10', '2024-05-20', NULL, 'Issued', 2, 4);
SELECT * FROM payments;

--Add  4+ Staff

insert into staff (staffID, Fullname, position)
values
(1, 'Ahmed Al-Balushi', 'Librarian'),
(2, 'Fatma Al-Zadjali', 'Assistant Librarian'),
(3, 'Salim Al-Harthy', 'Cataloguer'),
(4, 'Muna Al-Lawati', 'IT Support');


--ADD  6+ Reviews

insert into review (rating, review_date, comments, bookId)
values
(5, '2024-01-20', 'Great read!', 1),
(4, '2024-02-15', 'Very informative.', 3),
(3, '2024-03-11', 'Good, but complex.', 6),
(5, '2024-04-12', 'My favorite!', 4),
(2, '2024-05-01', 'Not engaging.', 5),
(4, '2024-05-10', 'Excellent storytelling.', 2);

-- add DML
-- Mark books as returned
UPDATE loan
SET return_date = GETDATE()
WHERE loan_date = '2025-05-01'  
  AND status = 'Issued';

-- Update loan status 
update loan
SET status = 'Overdue'
WHERE due_date < GETDATE() AND return_date IS NULL;


--Delete reviews/payments
Delete from review
where bookId = 1 AND rating = 3;