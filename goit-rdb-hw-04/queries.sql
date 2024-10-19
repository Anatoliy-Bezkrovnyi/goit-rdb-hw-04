CREATE SCHEMA LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(50)
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50)
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50),
    publication_year DATE,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    borrow_date DATE,
    return_date DATE
);

INSERT INTO authors (author_name)
VALUES ('William Shakespeare'), ('J. K. Rowling'), ('Paulo Coelho');

SELECT * FROM authors;

INSERT INTO genres (genre_name)
VALUES ('play'), ('fantasy'), ('prose');

SELECT * FROM genres;

INSERT INTO users (username, email)
VALUES ('John', 'john@mail.com'), 
('Bob', 'bob@mail.com'), 
('Carl', 'carl@mail.com');

SELECT * FROM users;

INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES ('Macbeth', '2023-12-31', '1', '1'), 
('Harry Potter and the Philosophers Stone', '2022-02-11', '2', '2'), 
('The Alchemist', '2021-07-20', '3', '3');

SELECT * FROM books;

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES ('1', '1', '2022-02-11', '2022-03-11'), 
('2', '2', '2023-05-21', '2023-08-11'), 
('3', '3', '2024-11-11', '2024-12-30');

SELECT * FROM borrowed_books;

SELECT o.id as order_id, o.date as order_date, 
em.last_name as employee_last_name, em.first_name as employee_first_name,
em.birthdate as employee_birthdate, em.photo as employee_photo, em.notes as employee_notes,
cus.name as customer_name, cus.contact as customer_contact, cus.address as customer_address,
cus.city as customer_city, cus.postal_code as customer_postal_code, cus.country as customer_country,
cat.name as category_name, cat.description as category_description,
p.name as product_name, p.unit as product_unit, p.price as product_price,
od.quantity as product_quantity,
sup.name as supplier_name, sup.contact as supplier_contact, sup.address as supplier_address, 
sup.city as supplier_city, sup.postal_code as supplier_postal_code, sup.country as supplier_country, sup.phone as supplier_phone,
ship.name as shipper_name, ship.phone as shipper_phone 
FROM orders as o
	INNER JOIN order_details as od ON o.id = od.order_id
    INNER JOIN customers as cus ON o.customer_id = cus.id
    INNER JOIN employees as em ON o.employee_id = em.employee_id
    INNER JOIN shippers as ship ON o.shipper_id = ship.id    
    INNER JOIN products as p ON od.product_id = p.id
    INNER JOIN categories as cat ON p.category_id = cat.id
    INNER JOIN suppliers as sup ON p.supplier_id = sup.id;

SELECT COUNT(*) AS rows_count
FROM orders as o
	INNER JOIN order_details as od ON o.id = od.order_id
    INNER JOIN customers as cus ON o.customer_id = cus.id
    INNER JOIN employees as em ON o.employee_id = em.employee_id
    INNER JOIN shippers as ship ON o.shipper_id = ship.id    
    INNER JOIN products as p ON od.product_id = p.id
    INNER JOIN categories as cat ON p.category_id = cat.id
    INNER JOIN suppliers as sup ON p.supplier_id = sup.id;
    
SELECT COUNT(*) AS rows_count
FROM orders as o
	RIGHT JOIN order_details as od ON o.id = od.order_id
    LEFT JOIN customers as cus ON o.customer_id = cus.id
    LEFT JOIN employees as em ON o.employee_id = em.employee_id
    INNER JOIN shippers as ship ON o.shipper_id = ship.id    
    RIGHT JOIN products as p ON od.product_id = p.id
    LEFT JOIN categories as cat ON p.category_id = cat.id
    INNER JOIN suppliers as sup ON p.supplier_id = sup.id;
    
SELECT o.id as order_id, o.date as order_date, 
em.last_name as employee_last_name, em.first_name as employee_first_name,
em.birthdate as employee_birthdate, em.photo as employee_photo, em.notes as employee_notes,
cus.name as customer_name, cus.contact as customer_contact, cus.address as customer_address,
cus.city as customer_city, cus.postal_code as customer_postal_code, cus.country as customer_country,
cat.name as category_name, cat.description as category_description,
p.name as product_name, p.unit as product_unit, p.price as product_price,
od.quantity as product_quantity,
sup.name as supplier_name, sup.contact as supplier_contact, sup.address as supplier_address, 
sup.city as supplier_city, sup.postal_code as supplier_postal_code, sup.country as supplier_country, sup.phone as supplier_phone,
ship.name as shipper_name, ship.phone as shipper_phone 
FROM orders as o
	INNER JOIN order_details as od ON o.id = od.order_id
    INNER JOIN customers as cus ON o.customer_id = cus.id
    INNER JOIN employees as em ON o.employee_id = em.employee_id
    INNER JOIN shippers as ship ON o.shipper_id = ship.id    
    INNER JOIN products as p ON od.product_id = p.id
    INNER JOIN categories as cat ON p.category_id = cat.id
    INNER JOIN suppliers as sup ON p.supplier_id = sup.id
WHERE em.employee_id > 3 AND em.employee_id <= 10;

SELECT o.id as order_id, 
cat.name as category_name,
p.name as product_name,
od.quantity as product_quantity
FROM orders as o
	INNER JOIN order_details as od ON o.id = od.order_id      
    INNER JOIN products as p ON od.product_id = p.id
    INNER JOIN categories as cat ON p.category_id = cat.id;
    
SELECT  
cat.name as category_name,
COUNT(p.id) AS product_count,
AVG(od.quantity) as avg_quantity_per_order
FROM categories as cat
	INNER JOIN products as p ON p.category_id = cat.id 
	INNER JOIN order_details as od ON od.product_id = p.id
GROUP BY category_name
HAVING avg_quantity_per_order > 21
ORDER BY avg_quantity_per_order DESC
LIMIT 4 
OFFSET 1;





UPDATE books SET author_id = 3 WHERE book_id = 3;
