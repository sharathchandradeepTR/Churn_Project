# GFR Churn Prediction Model

## Project Overview
This project is designed to predict customer churn for the **GoFileRoom (GFR)** CAS product suite. By aggregating data from subscription history, support tickets, product usage, and training engagements, the model identifies firms at high risk of cancellation. The final output is a probability score that allows stakeholders to proactively engage with at-risk customers.

## Key Features
- **Data Integration**: Connects to Snowflake and EMS SQL Server to fetch real-time data on firm demographics, licensing, and support interactions.
- **Feature Engineering**: Calculates critical metrics such as:
  - **Tenure**: Subscription duration in days.
  - **Seat Fluctuations**: Tracking upgrades and downgrades in license counts.
  - **Module Downgrades**: specifically monitoring removal of the "FirmFlow" module.
  - **Support Escalations**: Flagging firms with high-priority support tickets.
- **Predictive Modeling**: Utilizes **XGBoost** to classify firms into "Churn" or "Retain" categories with a specific probability score.

## Prerequisites

### System Requirements
- Python 3.8+
- Access to Thomson Reuters internal network (for Snowflake & EMS SQL Server connectivity)

### Required Libraries
Install the necessary dependencies using pip:

```bash
pip install pandas numpy snowflake-connector-python pyodbc matplotlib seaborn xgboost tqdm joblib openpyxl


Configuration
Before running the notebook, ensure you have the following credentials configured:
Snowflake Credentials: The script uses a dictionary ROLE_CONFIGS to manage environment roles (e.g., PROD, TEST). Ensure your user account has access to the following views:
EMS_DBO_FPV_LIMITED_VW (Product Versions)
EMS_DBO_FIRM_VW (Firm Demographics)
SALESFORCE_GSI_PSE_PROJ_C_VW (Training Projects)
FLASH_DBO_TICKET_VW (Support Tickets)
SQL Server Drivers: The script requires the 'ODBC Driver 17 for SQL Server' to connect to the EMS database.
Usage
Clone the Repository
Bash
 
Plain Text
git clone [https://github.com/your-username/GFR_churn_prediction.git](https://github.com/your-username/GFR_churn_prediction.git)


Run the AnalysisOpen the Jupyter Notebook test.ipynb and execute the cells sequentially.
Step 1: Library imports and connection setup.
Step 2: Data extraction from Snowflake and SQL Server.
Step 3: Data cleaning and feature engineering (calculating tenure, flagging downgrades).
Step 4: Merging datasets into a single analytical view.
Step 5: Running the XGBoost prediction model.
OutputThe script generates an Excel file containing the predictions:
File Name: GFR_churn_probability_xgboost_recall_[Date].xlsx
Columns: FirmID, Churn_Probability, Model_Prediction, Categorized_Training, etc.
Methodology
The model follows this logic pipeline:
Active vs. Cancelled: Determines the current status of a firm based on license expiration dates.
Behavioral Signals:
Downgrades: If a firm drops "FirmFlow" but keeps "GoFileRoom", it is flagged as a partial churn risk.
Support Friction: A high volume of escalated tickets is treated as a negative signal.
Training Gaps: Firms that have not undergone "Guided" or "Foundational" training are analyzed for higher churn correlation.
Prediction: The XGBoost classifier assigns a probability score (0-1) to every active firm.
Files in Repository
GFR_churn_prediction_Final_Copy.ipynb: Main analysis and modeling notebook.
README.md: Project documentation.