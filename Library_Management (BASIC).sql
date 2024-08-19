use library_books_management;
-- 1. Table One BOOKS
create table books (
book_id int auto_increment primary key,
book_title varchar(100),
book_author varchar(100),
book_genre varchar(100),
pulication_year year,
copies_available int
);

-- 2. Table Two Books Borrower Details
create table borrower(
borrower_id int primary key auto_increment,
borrower_name varchar(100),
borrower_address varchar(100),
borrower_email varchar(100)
);

-- 3. Create a table manage books borrowing and returns
create table loans(
loan_id int primary key auto_increment,
book_id int,
borrower_id int,
borrow_date date not null,
return_date date not null,
due_date date not null,
foreign key (book_id) references books(book_id),
foreign key (borrower_id) references borrower(borrower_id)
);

-- 4. Insert values into BOOKS table
insert into books(book_title, book_author, book_genre, pulication_year, copies_available) values("It was mean to be like that", "Vedansh", "Fictional", "2023", 12),("Tere Bin", "Ashish", "Dramatic", "2021", 20),("Causual & Perfect", "Ansh", "Fictional", "2020", 3);

desc books;
alter table books change pulication_year publication_year year;
select * from books;

-- 5. Insert values into BORROWER table
insert into borrower(borrower_name, borrower_address, borrower_email) values("Bhargavi", "Nizampet", "bhargvai.chigurupati@gmail.com"),("Priyanka", "JNTU", "priyanka.manuri@gmail.com"),("Hemalatha", "Kukkatpally", "hema.mannnem@gmail.com");
desc borrower;
select * from borrower;

-- 6. Insert values into LOANS table
insert into loans(book_id, borrower_id, borrow_date, return_date, due_date) values(2, 1, "2024-08-10", "2024-08-19", "2024-08-17"),(1, 2, "2024-08-05", "2024-08-18", "2024-08-18"),(3,1, "2024-08-15", "2024-08-18", "2024-08-20");
desc loans;
select * from loans;

-- 7. insert extra records into all three tables
insert into books(book_title, book_author, book_genre, publication_year, copies_available) values("It was not mean be together", "yash", "Fictional", "2019", 4),("Tere Bin-2", "Ashish", "Dramatic", "2024", 8),("Hidden Love", "Ashish", "Fictional", "2023", 7);
insert into borrower(borrower_name, borrower_address, borrower_email) values("Keerthana", "Vasanth Nagar", "keerthana.komma@gmail.com"),("Geethika", "dharma reddy nagar", "geethika.komma@gmail.com"),("radha", "pragathi nagar", "radha.bolnedu@gmail.com");
insert into loans(book_id, borrower_id, borrow_date, return_date, due_date) values(4, 4, "2024-08-10", "2024-08-19", "2024-08-17"),(6, 3, "2024-08-05", "2024-08-18", "2024-08-18"),(5,6, "2024-08-15", "2024-08-18", "2024-08-20"),(6, 1, "2024-08-12","2024-08-19", "2024-08-17");

select * from books;
select * from borrower;
select * from loans;

-- 8. 10 Challanges to be executed on above library management tables

-- QUERY-1 : RETRIEVE ALL BOOKS IN THE LIBRARY
select * from books;

-- QUERY-2 : FIND BOOKS BY A SPECIFIC AUTHOR
select * from books where book_author = "Ashish";

-- QUERY-3 : CHECK AVAILABLE COPIES OF SPECIFIC BOOK
select copies_available from books where book_title = "Tere bin";

-- QUERY-4 : LIST ALL BORROWERS WHO REGISTERED IN THE LIBRARY
select * from borrower;

-- QUERY-5 : LIST ALL DETAILS ON LOANS TABLE IN SYSTEM
select * from loans;

-- QUERY-6 : FIND ALL BOOKS BORROWED BY SPECIFIC BORROWER 
select borrower.borrower_id, books.book_title, books.book_id, loans.borrow_date, loans.due_date
from loans
join books
on books.book_id = loans.book_id
join borrower
on borrower.borrower_id = loans.borrower_id
where loans.borrower_id = 1;

-- QUERY-7 : LIST ALL BOOKS THAT ARE OVERDUE FOR RETURN
alter table loans change return_date return_date date;
insert into loans(book_id, borrower_id, borrow_date, return_date, due_date) values(4, 1, "2024-08-10", null , "2024-08-17"),(1, 6, "2024-08-05", "2024-08-18", "2024-08-18"),(6,5, "2024-08-15", null , "2024-08-20");
select books.book_title, borrower.borrower_name, borrower.borrower_id, loans.borrow_date, loans.due_date 
from loans
join books 
on books.book_id = loans.book_id
join borrower
on borrower.borrower_id = loans.borrower_id
where loans.due_date <= "2024-08-19" and 
loans.return_date is null;

-- QUERY-8 : TOTAL NUMBERS OF BOOKS BORROWED BY EACH BORROWER
select borrower.borrower_name, count(loans.loan_id) as total_no_of_books
from loans 
join borrower
on borrower.borrower_id = loans.borrower_id
group by borrower.borrower_name;

-- QUERY-9 : UPDATE THE RETURN DATE IN LOANS OF SPECIFIC BOOK BORROWED BY SPECIFIC BORROWER
update loans
set return_date = "2024-08-20"
where book_id = (select book_id from books where book_title = "Tere Bin") 
and
borrower_id = (select borrower_id from borrower where borrower_name = "Bhargavi");
select * from loans where borrower_id = (select borrower_id from borrower where borrower_name = "Bhargavi");
 
-- QUERY-10 : DELETE A BORROWER RECORD FROM LOANS TABLE 
delete from loans
where borrower_id = 5;