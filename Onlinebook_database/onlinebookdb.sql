-- =========================================================
-- FILE NAME: online_bookstore_queries.sql
-- PURPOSE   : Complete Online Bookstore SQL Practice Queries
-- DATABASE  : online_bookstore
-- =========================================================

-- =========================================================
-- 1. DATABASE SETUP & TABLES CREATION
-- =========================================================

-- Database ဖန်တီးခြင်း
-- CREATE DATABASE IF NOT EXISTS online_bookstore;
-- USE online_bookstore;

-- 1. Authors Table (စာရေးဆရာများ)
-- CREATE TABLE authors (
--     author_id INT AUTO_INCREMENT PRIMARY KEY,
--     first_name VARCHAR(50) NOT NULL,
--     last_name VARCHAR(50) NOT NULL,
--     country VARCHAR(50)
-- );

-- 2. Categories Table (စာအုပ်အမျိုးအစားများ)
-- CREATE TABLE categories (
--     category_id INT AUTO_INCREMENT PRIMARY KEY,
--     category_name VARCHAR(50) NOT NULL UNIQUE
-- );

-- 3. Books Table (စာအုပ်များ)
-- CREATE TABLE books (
--     book_id INT AUTO_INCREMENT PRIMARY KEY,
--     title VARCHAR(150) NOT NULL,
--     author_id INT,
--     category_id INT,
--     price DECIMAL(10, 2) NOT NULL,
--     stock_quantity INT DEFAULT 0,
--     published_date DATE,
--     CONSTRAINT fk_book_author FOREIGN KEY (author_id) REFERENCES authors (author_id),
--     CONSTRAINT fk_book_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
-- );

-- 4. Customers Table (ဖောက်သည်များ)
-- CREATE TABLE customers (
--     customer_id INT AUTO_INCREMENT PRIMARY KEY,
--     first_name VARCHAR(50) NOT NULL,
--     last_name VARCHAR(50) NOT NULL,
--     email VARCHAR(100) UNIQUE NOT NULL,
--     phone VARCHAR(20),
--     registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- 5. Orders Table (အော်ဒါခေါင်းစဉ်များ)
-- CREATE TABLE orders (
--     order_id INT AUTO_INCREMENT PRIMARY KEY,
--     customer_id INT,
--     order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     total_amount DECIMAL(10, 2),
--     status VARCHAR(20) DEFAULT 'PENDING',
--     CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
-- );

-- 6. Order Items Table (အော်ဒါပါ စာအုပ်အသေးစိတ်များ)
-- CREATE TABLE order_items (
--     order_item_id INT AUTO_INCREMENT PRIMARY KEY,
--     order_id INT,
--     book_id INT,
--     quantity INT NOT NULL,
--     unit_price DECIMAL(10, 2) NOT NULL,
--     CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
--     CONSTRAINT fk_item_book FOREIGN KEY (book_id) REFERENCES books(book_id)
-- );


-- =========================================================
-- 2. BASIC FILTERING & SORTING (အခြေခံ ရှာဖွေခြင်းနှင့် စီခြင်း)
-- =========================================================

-- Stock ပမာဏ ၃၀ အောက်နည်းသော စာအုပ်များ ရှာခြင်း:
SELECT title, price
FROM books
WHERE stock_quantity < 30;

-- ဈေးနှုန်းအကြီးဆုံးမှ အသေးဆုံးသို့ စီခြင်း:
SELECT title, price
FROM books
ORDER BY price DESC;

-- UK နိုင်ငံသား စာရေးဆရာများ ရှာခြင်း:
SELECT first_name, last_name
FROM authors
WHERE country = 'UK';


-- =========================================================
-- 3. MULTIPLE TABLES JOIN (ဇယားများ ချိတ်ဆက်ခြင်း)
-- =========================================================

-- စာအုပ်နာမည်နှင့် အမျိုးအစားနာမည် တွဲ၍ ထုတ်ခြင်း:
SELECT title, category_name
FROM books
INNER JOIN categories ON
books.category_id = categories.category_id;

-- စာအုပ်၊ ဈေးနှုန်းနှင့် စာရေးဆရာနာမည် တွဲ၍ ထုတ်ခြင်း:
SELECT title, price, first_name, last_name
FROM books
INNER JOIN authors ON
books.author_id = authors.author_id;

-- အော်ဒါနှင့် ဖောက်သည်နာမည် တွဲ၍ ထုတ်ခြင်း:
SELECT order_id, status, first_name
FROM orders
INNER JOIN customers ON
orders.customer_id = customers.customer_id;


-- =========================================================
-- 4. AGGREGATE FUNCTIONS & GROUP BY (စုစည်း တွက်ချက်ခြင်း)
-- =========================================================

-- အမျိုးအစား တစ်ခုချင်းစီအလိုက် Stock စုစုပေါင်း ထုတ်ခြင်း (Table Aliases အသုံးပြုထားခြင်း):
SELECT c.category_name, SUM(b.stock_quantity) AS total_stock
FROM books b
INNER JOIN categories c ON b.category_id = c.category_id
GROUP BY c.category_name;

-- Status 'COMPLETED' ဖြစ်သော အော်ဒါများ၏ စုစုပေါင်း ငွေပမာဏ ထုတ်ခြင်း:
SELECT status, SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'COMPLETED'
GROUP BY status;


-- =========================================================
-- 5. SUBQUERIES & ADVANCED FILTERING (အဆင့်မြင့် ရှာဖွေခြင်း)
-- =========================================================

-- ပျမ်းမျှ ဈေးနှုန်းထက် ကြီးသော စာအုပ်များ ရှာခြင်း:
SELECT title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books);

-- အော်ဒါ တင်ဖူးသော ဖောက်သည်များကို Subquery (IN) ဖြင့် ရှာခြင်း:
SELECT first_name, last_name, email
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);


-- =========================================================
-- 6. WINDOW FUNCTIONS (အဆင့်မြင့် ခွဲခြမ်းစိတ်ဖြာခြင်း)
-- =========================================================

-- ဈေးနှုန်းအပေါ် မူတည်ပြီး DENSE_RANK() သုံး၍ အဆင့်သတ်မှတ်ခြင်း:
SELECT title, price,
       DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
FROM books;

-- =========================================================
-- FILE NAME: advanced_window_functions.sql
-- PURPOSE   : Advanced SQL Window Functions Practice Queries
-- DATABASE  : online_bookstore
-- =========================================================

-- =========================================================
-- 1. ROW_NUMBER() FUNCTION
-- =========================================================

-- စာအုပ်များကို ဈေးနှုန်းအကြီးဆုံးမှ အသေးဆုံးသို့ စီပြီး စဉ်លេខ (Row Number) ထည့်ခြင်း
SELECT 
    ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num,
    title, 
    price
FROM books;


-- =========================================================
-- 2. RANK() & DENSE_RANK() FUNCTIONS
-- =========================================================

-- စာအုပ်ဈေးနှုန်းများကို Rank နှင့် Dense Rank ဖြင့် အဆင့်သတ်မှတ်ခြင်း
SELECT 
    title, 
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank,
    DENSE_RANK() OVER (ORDER BY price DESC) AS price_dense_rank
FROM books;


-- =========================================================
-- 3. PARTITION BY WITH WINDOW FUNCTIONS
-- =========================================================

-- အမျိုးအစား (Category) တစ်ခုချင်းစီအလိုက် စာအုပ်များကို ဈေးအကြီးဆုံးမှ အသေးဆုံး အဆင့်သတ်မှတ်ခြင်း
SELECT 
    c.category_name,
    b.title,
    b.price,
    ROW_NUMBER() OVER (PARTITION BY b.category_id ORDER BY b.price DESC) AS category_row_num
FROM books b
INNER JOIN categories c ON b.category_id = c.category_id;


-- =========================================================
-- 4. AGGREGATE WINDOW FUNCTIONS (SUM, AVG)
-- =========================================================

-- စာအုပ်အမျိုးအစား အလိုက် စုစုပေါင်း Stock ပမာဏနှင့် ပျမ်းမျှဈေးနှုန်းကို တန်းစီဖော်ပြခြင်း
SELECT 
    title,
    category_id,
    price,
    SUM(stock_quantity) OVER (PARTITION BY category_id) AS category_total_stock,
    AVG(price) OVER (PARTITION BY category_id) AS category_avg_price
FROM books;


-- =========================================================
-- 5. LEAD() & LAG() FUNCTIONS
-- =========================================================

-- ယခင်စာအုပ်ဈေးနှုန်းနှင့် နောက်စာအုပ်ဈေးနှုန်းတို့ကို နှိုင်းယှဉ်ထုတ်ယူခြင်း
SELECT 
    title,
    price,
    LAG(price, 1) OVER (ORDER BY price DESC) AS higher_price_neighbor,
    LEAD(price, 1) OVER (ORDER BY price DESC) AS lower_price_neighbor
FROM books;
