## 🛒 E-Commerce Sales Data Analysis (MySQL)
This project showcases basic exploratory data analysis (EDA) on an e-commerce dataset using SQL (MySQL). The goal is to derive useful business insights from transactional sales data, such as total revenue, customer behavior, product performance, and time-based trends.

## 📦 Dataset
The dataset contains typical e-commerce fields including:

InvoiceNo

StockCode

Description

Quantity

InvoiceDate (converted from string to DATETIME)

UnitPrice

CustomerID

Country

## ⚙️ Database Setup
sql
Copy
Edit
CREATE DATABASE Intern;
USE Intern;

-- Fix InvoiceDate formatting
ALTER TABLE e_commerce ADD COLUMN InvoiceDate_new DATETIME;
UPDATE e_commerce
SET InvoiceDate_new = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i');
ALTER TABLE e_commerce DROP COLUMN InvoiceDate;
ALTER TABLE e_commerce CHANGE COLUMN InvoiceDate_new InvoiceDate DATETIME;
## 📁 Files

> [ABOUT TASK](README.md)

> [SQL Queries](Task3.sql)

> [Result Screenshots](Screenshots.pdf)

> [E commerce Data](ecommerce.csv)





