# 📊 ETL Pipeline – Data Processing Project

This project was developed as part of the Laboratória Bootcamp and focuses on building an end-to-end ETL (Extract, Transform, Load) pipeline for data processing and analysis.

The goal is to collect raw data, clean and transform it, and make it ready for analysis and visualization.

---

## 🎯 Business context and main goal

This project simulates a sales analytics scenario, where raw data is processed and structured to enable strategic analysis of customers, products, and revenue.
The goal of this project is to build a reliable data pipeline and prepare data for analysis, enabling data-driven decision-making. 

The pipeline was designed to support answering key business questions such as:
- Which products generate the most revenue?
- Who are the most valuable customers?
- Is there any seasonality in sales over time?
- Which product categories perform better?

---

## ⚙️ Tools & Technologies
- BigQuery;
- drawSQL;
- Google Sheets;
- Jupyter Notebook;
- Python;
- SQL;

---

## 🔍 Methodology
The project was structured into three main steps:

1. Extract
- Data collected from source files (CSV / API / etc.)

2. Transform
- Data cleaning (null values, duplicates);
- Data type corrections;
- Feature creation;
- Standardization;
  
3. Load
- Data stored in structured format;
- Ready for analysis or visualization;

---

## 🧩 Why Star Schema?
A dimensional model (Star Schema) was implemented to:

- Simplify analytical queries;
- Improve performance for aggregations;
- Enable efficient integration with BI tools;
- Provide a clear separation between facts and dimensions;

Fact table:
- fato_pedidos: sales metrics;

Dimension tables:
- dim_cliente: customer information;
- dim_produto: product details;
- dim_tempo: time attributes;

---

## ⚙️ Data Pipeline
The data pipeline was designed to ensure scalability, data quality, and efficient transformations.
It follows a layered architecture:

- **Raw Layer**: ingestion of original CSV data into BigQuery
- **Staging Layer**: data cleaning and standardization
- **Data Modeling Layer**: transformation into a star schema
- **Analytics Layer**: optimized tables for reporting and analysis

<h2 align="center"> Data Pipeline </h2>

<p align="center">
  <img src="assets/data_pipeline_diagram.png" width="700"/>
</p>



Future improvements include orchestration with Cloud Composer (Airflow) and transformation management with dbt.

---

## ✔️ “Business impact”
This pipeline ensures reliable and clean data, improving data quality for decision-making.

---

## 📊 Insights

Some exploratory insights that can be derived from the dataset:
- A significant portion of revenue is concentrated in a small number of products;
- Sales show variation over time, indicating possible seasonality;
- Some customers demonstrate recurring purchasing behavior;

This project demonstrates the importance of well-structured data pipelines in enabling reliable and scalable data analysis.
It serves as a foundational layer for analytics, ensuring that downstream analysis is based on clean and consistent data.
