-- 1) Tao View ten v_order_summary

CREATE VIEW v_order_summary AS
SELECT
    c.full_name,
    o.total_amount,
    o.order_date
FROM customer c
JOIN orders o
    ON c.customer_id = o.customer_id;



-- 2) Truy van xem tat ca du lieu tu View v_order_summary

SELECT *
FROM v_order_summary;


-- 3) Tao View lay tat ca don hang co total_amount >= 1,000,000

CREATE VIEW v_orders_over_1m AS
SELECT
    order_id,
    customer_id,
    total_amount,
    order_date
FROM orders
WHERE total_amount >= 1000000;


-- 4) Cap nhat 1 ban ghi trong view v_orders_over_1m
-- Vi du: cap nhat don hang co order_id = 1
--
-- Giai thich:
-- PostgreSQL cho phep UPDATE tren view neu do la view don gian,
-- khong co GROUP BY, DISTINCT, JOIN, aggregate...
-- View v_orders_over_1m thoa dieu kien do, nen co the update duoc

UPDATE v_orders_over_1m
SET total_amount = 1500000
WHERE order_id = 1;



-- 5) Tao View thu hai v_monthly_sales
-- Thong ke tong doanh thu moi thang

CREATE VIEW v_monthly_sales AS
SELECT
    DATE_TRUNC('month', order_date)::date AS sales_month,
    SUM(total_amount) AS total_monthly_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;

