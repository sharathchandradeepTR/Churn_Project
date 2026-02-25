# Virtual Office (VO) Customer Churn Prediction - Phase 2

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
System Requirements
ODBC Driver: You must have the ODBC Driver 17 for SQL Server installed on your machine to connect to the EMS database via pyodbc.

SSO Authentication: The Snowflake connection relies on external browser authentication (Thomson Reuters SSO).

🚀 Pipeline Workflow
1. Data Extraction & Merging
Establishes connections to Snowflake and SQL Server.

Executes complex SQL queries to aggregate customer interactions, billing, and support metrics.

Merges all features into a master DataFrame (combined_df) using firm_id as the primary key.

2. Data Preprocessing & Feature Engineering
Calculates subscription_duration_days based on Purchase Date and End Date/Current Date.

Filters out new accounts (keeps only subscriptions > 300 days).

Handles missing values by imputing 0 for inactive metrics.

Applies Label Encoding to the target variable (status_flag -> firm_status_encoded).

Applies One-Hot Encoding to categorical product names.

3. Machine Learning Modeling
Algorithm: XGBoost Classifier.

Optimization: Uses BayesSearchCV (Bayesian Optimization) with 5-fold Cross Validation to find the optimal hyperparameters.

Target Metric: The model is specifically optimized to maximize Precision to ensure high confidence when flagging accounts at risk of churn.

Threshold Tuning: Calculates the optimal probability cutoff threshold using the ROC-Curve (Youden's J statistic).

4. Explainability
Generates Feature Importance charts natively via XGBoost.

Utilizes SHAP (SHapley Additive exPlanations) to create summary plots, illustrating how individual features push a firm toward or away from churn.

5. Prediction & Export
Applies the trained model to a holdout set of currently active firms.

Generates a churn probability score and a binary prediction (0 = Retain, 1 = Churn).

Exports the final actionable dataset to local .xlsx and .csv files for business stakeholders.

📂 Outputs Generated
Running this notebook will generate the following files in your specified local directories:

VO_firms_support_25_02_2026.csv: Raw support and ticket merged data.

VO_churn_data_25_02_2026.xlsx: Fully merged dataset before duration filtering.

VO_churn_model_Final_data.xlsx: The exact dataset used to train the XGBoost model.

VO_churn_probability_February_result_set.xlsx: Final Output containing active firms, their features, predicted churn probabilities, and binary predictions.

VO_churn_VOSET_VOUTAX_SQL_dData.csv & VO_churn_Firmname_SQL_Data.csv: Metadata mappings for BI reporting.

⚠️ Important Security Note for GitHub
Before committing this code to a public or shared repository:

Remove hardcoded Server Names & Credentials: Ensure internal server addresses (e.g., egmissqlprod3.int...) and email addresses are removed or abstracted.

Use Environment Variables: It is highly recommended to use a .env file and the python-dotenv library to pass database credentials, usernames, and local file paths (e.g., C:\Users\6130665\...) rather than hardcoding them in the notebook cells.

📝 How to Run
Clone the repository.

Ensure your VPN/Network allows connections to the Snowflake and EMS SQL Server databases.

Update the file export paths in the notebook to match your local directory structure.

Run the Jupyter Notebook cell by cell. Follow the prompts in your browser for Snowflake SSO authentication.