WITH total_revenue_cte AS (
         SELECT sum(retail_sale.new_total) AS total_revenue
           FROM retail_sale
        ), total_transactions_cte AS (
         SELECT count(retail_sale.transaction_id) AS total_transactions
           FROM retail_sale
        ), avg_order_value_cte AS (
         SELECT avg(retail_sale.new_total) AS avg_order_value
           FROM retail_sale
        ), total_quantity_cte AS (
         SELECT sum(retail_sale.quantity) AS total_quantity_sold
           FROM retail_sale
        ), revenue_by_category_cte AS (
         SELECT retail_sale.category,
            sum(retail_sale.new_total) AS revenue_by_category
           FROM retail_sale
          GROUP BY retail_sale.category
        ), top_items_cte AS (
         SELECT retail_sale.item,
            sum(retail_sale.quantity) AS total_quantity
           FROM retail_sale
          GROUP BY retail_sale.item
          ORDER BY (sum(retail_sale.quantity)) DESC
         LIMIT 10
        ), low_items_cte AS (
         SELECT retail_sale.item,
            sum(retail_sale.new_total) AS total_revenue
           FROM retail_sale
          GROUP BY retail_sale.item
          ORDER BY (sum(retail_sale.new_total))
         LIMIT 10
        ), revenue_by_payment_cte AS (
         SELECT retail_sale.payment_method,
            sum(retail_sale.new_total) AS revenue_by_payment
           FROM retail_sale
          GROUP BY retail_sale.payment_method
        ), discount_percentage_cte AS (
         SELECT avg(
                CASE
                    WHEN retail_sale.discount_applied = true THEN 1
                    ELSE 0
                END) * 100::numeric AS discount_percentage
           FROM retail_sale
        ), revenue_by_location_cte AS (
         SELECT retail_sale.location,
            sum(retail_sale.new_total) AS revenue_by_location
           FROM retail_sale
          GROUP BY retail_sale.location
        )
 SELECT tr.total_revenue,
    tt.total_transactions,
    aov.avg_order_value,
    tq.total_quantity_sold,
    dp.discount_percentage
   FROM total_revenue_cte tr,
    total_transactions_cte tt,
    avg_order_value_cte aov,
    total_quantity_cte tq,
    discount_percentage_cte dp;