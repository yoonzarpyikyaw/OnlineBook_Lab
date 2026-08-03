# 📚 Online Bookstore SQL Practice Project

A comprehensive collection of relational database schemas, data insertion scripts, and intermediate-to-advanced SQL queries built and practiced using MySQL. This repository serves as a hands-on project to demonstrate core database management, schema normalization, multi-table joins, aggregations, subqueries, and window functions.

---

## 🚀 Project Overview

This project simulates a fully functional **Online Bookstore Database** containing interconnected tables with proper Primary and Foreign Key constraints[cite: 1]. It is designed to practice and showcase real-world database querying skills essential for backend development and database administration.

---

## 🗄️ Database Schema & Architecture

The database consists of 6 core normalized tables[cite: 1]:
1. **`authors`**: Stores author profiles and their respective countries[cite: 1].
2. **`categories`**: Defines book genre classifications[cite: 1].
3. **`books`**: Contains book details, pricing, stock quantities, and foreign key references to authors and categories[cite: 1].
4. **`customers`**: Manages registered user information and contact details[cite: 1].
5. **`orders`**: Tracks order statuses (`PENDING`, `COMPLETED`), total amounts, and customer relations[cite: 1].
6. **`order_items`**: Acts as a junction table capturing specific book quantities and unit prices per order[cite: 1].

---

## 💻 SQL Queries & Practice Modules

All implementation and practice queries are structured as follows:

### 1. Database Setup & Table Creation
* Database initialization and full relational table creation with foreign key constraints[cite: 1].

### 2. Basic Filtering & Sorting
* Filtering records based on stock thresholds.
* Sorting records using `ORDER BY`[cite: 1].
* Querying specific string criteria (`WHERE country = 'UK'`)[cite: 1].

### 3. Multiple Tables JOIN
* Combining data across multiple tables using `INNER JOIN` to link books with categories, authors, and orders with customers[cite: 1].

### 4. Aggregate Functions & GROUP BY
* Calculating aggregate metrics such as total stock per category and total revenue for completed orders using `SUM()` and `GROUP BY`[cite: 1].

### 5. Subqueries & Advanced Filtering
* Utilizing subqueries with `IN` clauses and dynamic scalar calculations (e.g., filtering books priced above the average price)[cite: 1].

### 6. Window Functions
* Applying advanced analytical functions like `DENSE_RANK()` for data ranking based on product pricing[cite: 1].

---
