# Virtual Office (VO) Customer Churn Prediction Model

![Python](https://img.shields.io/badge/python-3.x-blue.svg)
![XGBoost](https://img.shields.io/badge/ML-XGBoost-green.svg)
![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)

## 📌 Project Overview
This repository contains the end-to-end data pipeline and machine learning model for predicting customer churn for **Virtual Office (VOSET)** and **SaaS** products. 

The project extracts historical subscription, support ticket, call, and web activity data from two distinct enterprise databases (**Snowflake** and **EMS SQL Server**). It processes this data, engineers relevant features, and trains an **XGBoost Classifier** optimized via **Bayesian Search** to predict the likelihood of an active firm canceling its subscription.

---

## 📊 Data Sources
The pipeline aggregates data at the `firm_id` level:

### Snowflake (PROD)
* Firm Product Versions & Status (Active/Cancelled)
* Flash Support Tickets (Open, Closed, Void counts)
* Flash Call Support Logs (Call minutes, Support vs. Bug vs. Lead calls)

### SQL Server (EMS_Copy)
* Web Service Logins & Clients
* SaaS Firm Transitions
* Web Service Activities, Orders, Quantities, and Revenue (Retail Price, Fees, Discounts)
* Cancellations & Firm Names

---

## 🛠️ Tech Stack
* **Language:** Python 3.x
* **ML/Data:** `pandas`, `numpy`, `scikit-learn`, `xgboost`, `scikit-optimize` (BayesSearchCV), `shap`
* **Infrastructure:** `snowflake-connector-python`, `sqlalchemy`, `pyodbc`
* **Environment:** Jupyter Notebook

---

## 🚀 Pipeline Workflow

1. **Data Extraction & Merging:** Establishes connections to Snowflake and SQL Server to aggregate customer interactions into a master DataFrame.
2. **Preprocessing & Feature Engineering:** Calculates subscription duration, filters for mature accounts (>300 days), handles missing values, and applies categorical encoding.
3. **Machine Learning Modeling:** Trains an **XGBoost Classifier** using 5-fold Cross-Validation and Bayesian Optimization to maximize **Precision**. 
4. **Explainability:** Generates feature importance and **SHAP summary plots** to explain individual churn drivers.
5. **Prediction & Export:** Outputs probability scores and binary churn flags for active firms.

---

## 📂 Outputs Generated
Running the pipeline generates the following in your local directory:
* `VO_churn_model_Final_data.xlsx`: Dataset used for training.
* `VO_churn_probability_February_result_set.xlsx`: **Final Output** (Active firms with probability scores).
* Raw supporting CSVs: `VO_firms_support_25_02_2026.csv` and metadata mappings.

---

## 📝 Setup & Usage

### Prerequisites
* **ODBC Driver:** You must have the ODBC Driver 17 for SQL Server installed.
* **SSO:** Snowflake connection relies on external browser authentication.

### Installation
```bash
pip install pandas numpy matplotlib seaborn requests python-dateutil tqdm joblib
pip install snowflake-connector-python[secure-local-storage]
pip install sqlalchemy pyodbc
pip install scikit-learn xgboost scikit-optimize shap
pip install openpyxl