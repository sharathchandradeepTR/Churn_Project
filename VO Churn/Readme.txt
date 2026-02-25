# Virtual Office (VO) Customer Churn Prediction 

## 📌 Project Overview
This repository contains the Phase 2 data pipeline and machine learning model for predicting customer churn for Virtual Office (VOSET) and Software as a Service (SaaS) products. 

The project extracts historical subscription, support ticket, call, and web activity data from two distinct enterprise databases (**Snowflake** and **EMS SQL Server**). It then processes this data, engineers relevant features, and trains an **XGBoost Classifier** optimized via **Bayesian Search** to predict the likelihood of an active firm canceling its subscription.

## 📊 Data Sources
The pipeline aggregates data at the `firm_id` level from multiple sources:
* **Snowflake (PROD):**
    * Firm Product Versions & Status (Active/Cancelled)
    * Flash Support Tickets (Open, Closed, Void counts)
    * Flash Call Support Logs (Call minutes, Support vs. Bug vs. Lead calls)
* **SQL Server (EMS_Copy):**
    * Web Service Logins & Clients
    * SaaS Firm Transitions
    * Web Service Activities, Orders, Quantities, and Revenue (Retail Price, Fees, Discounts)
    * Cancellations & Firm Names

## 🛠️ Tech Stack & Prerequisites
**Language:** Python 3.x  
**Environment:** Jupyter Notebook

### Required Libraries
To run this notebook, ensure you have the following packages installed:
```bash
pip install pandas numpy matplotlib seaborn requests python-dateutil tqdm joblib
pip install snowflake-connector-python[secure-local-storage]
pip install sqlalchemy pyodbc
pip install scikit-learn xgboost scikit-optimize shap
pip install openpyxl