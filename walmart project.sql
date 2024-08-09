CREATE DATABASE IF NOT EXISTS salesdatawalmart;
CREATE TABLE IF NOT EXISTS walmartsalesdata(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1));
SELECT * FROM salesdatawalmart.walmartsalesdata;
SELECT Time FROM walmartsalesdata;
SELECT
    time,
    (CASE
        WHEN TIME(time) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN TIME(time) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
FROM walmartsalesdata;
ALTER TABLE walmartsalesdata ADD COLUMN Time_of_day VARCHAR(20);
DESCRIBE walmartsalesdata;
UPDATE walmartsalesdata 
SET Time_of_day=(CASE
        WHEN TIME(time) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN TIME(time) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);
SET SQL_SAFE_UPDATES=0; 
SELECT date,Dayname(date)FROM walmartsalesdata;
ALTER TABLE walmartsalesdata ADD Column day_name VARCHAR(10);
UPDATE walmartsalesdata
SET day_name=Dayname(date);
SELECT DATE,monthname(date) FROM walmartsalesdata;
ALTER TABLE walmartsalesdata ADD Column Month_name VARCHAR(10);
UPDATE walmartsalesdata
SET Month_name=monthname(date);
SELECT DISTINCT CITY FROM walmartsalesdata;
SELECT DISTINCT BRANCH FROM walmartsalesdata;
SELECT DISTINCT BRANCH,CITY FROM walmartsalesdata;
SELECT Count(DISTINCT Product_line) FROM salesdatawalmart.walmartsalesdata;
SELECT payment,Count(payment) FROM walmartsalesdata GROUP BY payment ORDER BY Count(payment) DESC LIMIT 1;
SELECT product_line,Count(product_line) FROM walmartsalesdata GROUP BY payment ORDER BY Count(product_line) DESC;
SELECT Month_name AS Month ,sum(total) AS total_revenue FROM walmartsalesdata GROUP BY Month_name ORDER BY total_revenue DESC;
SELECT Month_name AS Month ,sum(cogs) AS largest_cogs From walmartsalesdata GROUP BY Month_name ORDER BY Cogs DESC LIMIT 1;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))
SELECT Product_Line,sum(total) as total_revenue FROM walmartsalesdata GROUP BY product_line ORDER BY total_revenue DESC;
SELECT CITY,sum(total) as total_revenue FROM walmartsalesdata GROUP BY CITY ORDER BY total_revenue DESC;
SELECT product_line,avg(VAT) as avg_tax FROM walmartsalesdata GROUP BY product_line ORDER BY avg_tax DESC;
SELECT product_line,ROUND(AVG(total),2) AS Average_Sales,
(CASE
when avg(total)>(SELECT avg(total) FROM walmartsalesdata) THEN "GOOD"
ELSE "BAD"
END) FROM Walmartsalesdata;
SELECT BRANCH,SUM(QUANTITY)as qty from walmartsalesdata GROUP BY branch 
HAVING Sum(quantity)>(SELECT AVG(Quantity) FROM walmartsalesdata);
SELECT GENDER,PRODUCT_LINE,COUNT(GENDER) AS total_cnt FROM walmartsalesdata GROUP BY GENDER,PRODUCT_LINE ORDER BY total_cnt DESC;
SELECT Product_line,avg(rating) as avg_rating FROM walmartsalesdata GROUP BY Product_line ORDER BY avg_rating desc;
SELECT Time_of_day,Count(*) AS total_sales FROM walmartsalesdata WHERE day_name='Monday' GROUP BY Time_of_day ORDER BY total_sales DESC;
SELECT customer_type,sum(total) AS most_revenue FROM walmartsalesdata WHERE day_name='Sunday' GROUP BY Customer_type 
Order BY most_revenue DESC LIMIT 1;
SELECT CITY,avg(tax_pct)as tax FROM walmartsalesdata group by city order by Tax DESC;
SELECT Customer_type,avg(tax_pct) as tax FROM walmartsalesdata group by city order by Tax DESC;
SELECT DISTINCT customer_type from walmartsalesdata;
SELECT DISTINCT payment_method from walmartsalesdata ;
SELECT Customer_type,COUNT(*) AS cstm_cnt FROM salesdatawalmart.walmartsalesdata GROUP BY customer_type;
SELECT GENDER ,COUNT(*) AS gender_cnt FROM walmartsalesdata GROUP BY GENDER order by gender_cnt;
SELECT GENDER ,COUNT(*) AS gender_cnt FROM walmartsalesdata WHERE BRANCH="c" GROUP BY GENDER order by gender_cnt;
SELECT Time_of_day , avg(rating) as ratingavg from walmartsalesdata GROUP BY Time_of_day ORDER BY ratingavg DESC;
SELECT Time_of_day ,AVG(rating) as totrat from walmartsalesdata WHERE BRANCH="B" GROUP BY Time_of_day ORDER BY totrat DESC;
SELECT Day_name,avg(rating) as avgrat FROM walmartsalesdata GROUP BY Day_name ORDER BY avgrat DESC;
SELECT Day_name,avg(rating) as avgrat FROM walmartsalesdata WHERE BRANCH='A' GROUP BY Day_name ORDER BY avgrat DESC;























 











