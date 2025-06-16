create database onlinebookstore;

--create table books:
CREATE TABLE books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);


--create table customers:
CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR (100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);


--create table orders:
CREATE TABLE Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC (10,2)
);

SELECT*FROM Books;
SELECT*FROM Customers;
SELECT*FROM Orders;

--import books:
COPY Books(Book_ID, Title,Author,Genre,Published_Year,Price,Stock)
FROM 'D:\Books.csv'
CSV HEADER;

--import customers:
COPY Customers(Customer_ID, Name,Email,Phone,City,Country)
FROM 'D:\Customers.csv'
CSV HEADER;

--import orders:
COPY Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'D:\Orders.csv'
CSV HEADER;

--basic question:

1--retrive all the books from the friction genre:
select* from Books
where Genre='Fiction'


2--find books published after the year 1950:

select*from Books
where Published_Year>1950

3--list all the customer from the canada:
select*from Customers
where Country='Canada';

4--show orders placed in november 2023:
select*from Orders
where Order_Date between'2023-11-01' AND '2023-11-30';

5--RETRIVE THE TOTAL STOCK OF BOOKS AVAILABLE:
SELECT sum(stock)from books as total_stock;

6--FIND THE DETAILS OF MOST EXPENSIVE BOOKS:
select * from Books order by price desc limit 1;

7-- SHOW ALL CUSTOMERS WHO ORDERED MORE THAN 1 QUANTITY OF BOOKS:
select*from orders
where Qantity >1;



8-- RETRIVE ALL THE ORDERS WHERE THE TOTAL AMOUNT EXCEEDS DOLLAR 20:
select*from orders 
where total_amount>20;



9-- LIST ALL GENRES AVAILABLE IN THE BOOKS TABLE:
select distinct genre from books ;



10-- FIND THE BOOK WITH THE LOWEST STOCK:
select*from books order by stock asc limit 1;

11--calculate the total revenue generated from all the orders:
select sum(total_amount)as total_revenue from orders;


---advance questions:
1--retrive the total number of books sold for each genre:
select b.GENRE,sum(o.Qantity)as total_books_sold
from Orders o
join Books b on o.book_id=b.book_id
group by b.genre;


2--find the average price of books in the fantasy genre:
select avg(price) as average_price from books
where genre = 'Fantasy';



3-- list customers who have placed at least 2 orders:
select o. customer_id,c.name,count(o.order_id) as order_count
from orders o
join customers c on o.customer_id=c.customer_id
group by o. customer_id ,c.name
having count(order_id)>2;

4--find the most frequently ordered book:
select o. Book_id, b.title,count(o.order_id)as order_count
from orders o
join books b on o.book_id=b.book_id
group by o. Book_id,b.title
order by order_count desc ;


5--show the top 3 most expencive books of fantasy genre :
select*from books
where genre='Fantasy'
order by price desc limit 3;

6--retrive the total quantity of books sold by each author:
select b.author,sum(o.qantity)as total_books_sold
from orders o
join books b on o.book_id=b.book_id
group by b.author;

7--list the cities where customers who spent over dollar 30 are located:
select distinct c.city, total_amount
from orders o
join customers c on o.customer_id=c.customer_id
where o.total_amount>30;

8--find the customer who spent the most on orders:
select c.customer_id,c.name , sum(o.total_amount)as total_spent
from orders o
join customers c on o.customer_id=o.customer_id
group by c.customer_id, c.name
order by total_spent desc;

9--calculate the stocks remaining after fulfilling all orders:
select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0)as order_quantity,b.stock-coalesce(sum(o.quantity),0)
as order_quantity,b.stock-coalesce(sum(o.quantity),0)as remaining_quantity
from books b
left join orders o on b.book_id=o.book_id
group by b.book_id order by b.book_id;







