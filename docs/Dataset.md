## 📂 Dataset Description

The dataset contains sales information from a Super Store and consists of a single table with multiple variables related to orders, customers, products, and logistics.


### 📊 Variables

| Column Name    | Description                                               |
| -------------- | --------------------------------------------------------- |
| category       | Product category sold by the store                        |
| sub_category   | Product subcategory within the main category              |
| product_id     | Unique identifier for each product                        |
| product_name   | Name of the product                                       |
| sales          | Total sales value for the order                           |
| profit         | Profit generated from the order                           |
| quantity       | Number of items ordered                                   |
| discount       | Discount applied to the order                             |
| shipping_cost  | Cost of shipping the order                                |
| order_id       | Unique identifier for each order                          |
| order_date     | Date when the order was placed                            |
| ship_date      | Date when the order was shipped                           |
| ship_mode      | Shipping method used                                      |
| order_priority | Priority level of the order                               |
| customer_id    | Unique identifier for each customer                       |
| customer_name  | Name of the customer                                      |
| segment        | Customer segment (e.g., Consumer, Corporate, Home Office) |
| city           | City where the order was placed                           |
| state          | State or region within the country                        |
| country        | Country where the order was placed                        |
| region         | Geographic region of the order                            |
| market         | Market or business region                                 |
| market2        | Alternative market column (duplicate of "market")         |
| weeknum        | Week number when the order was placed                     |
| year           | Year when the order was placed                            |
| row_id         | Unique identifier for each row in the dataset             |
| unknown        | Unspecified or unidentified column                        |

---

### ⚠️ Notes

* The column **`market2`** contains duplicate information from the `market` column and may be redundant.
* The column **`unknown`** does not have a clear definition and should be evaluated before use.
* Dates (`order_date`, `ship_date`) can be used to derive additional time-based features.

---
