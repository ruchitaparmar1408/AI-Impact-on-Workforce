AI-Driven Workforce Disruption Analysis — Predicting Automation Risk

An end-to-end data analytics and machine learning project analyzing the impact of artificial intelligence on global workforce displacement across 195 countries and 10 industry sectors. The project covers the complete analytics workflow — from raw data ingestion and exploratory analysis to SQL querying, ML classification modeling, and an interactive Power BI dashboard.

Project Overview :-

The core problem this project addresses:
Companies, policymakers, and individuals have no clear visibility into which sectors face the highest automation risk and by how much — making it impossible to prepare, reskill, or intervene in advance.

This project builds a machine learning model that predicts automation risk category (High, Medium, or Low) for any industry sector based on economic and workforce indicators — giving a data-backed early warning system for AI-driven job displacement.

Dataset :-

Source: World Economic Forum — Future of Jobs Report 2025

Coverage: 195 countries, 10 industry sectors, 2020–2024

Format: CSV

Key Features: AI adoption index, GDP per capita, sector automation risk score, workforce displacement percentage, net workforce change, reskilling programs count, government AI policy score, female displacement percentage, AI tool adoption percentage, AI-cited layoff announcements

Tools and Technologies :-

Python (Jupyter Notebook) — Data cleaning, EDA, ML modeling
Pandas, NumPy — Data manipulation and transformation
scikit-learn — Machine learning — Logistic Regression, Random Forest
Matplotlib, Seaborn — Data visualization and EDA charts
MySQL — Data storage and SQL business queries
SQLAlchemy + PyMySQL — Python to MySQL connection pipeline
Power BI Desktop — Interactive 6-page dashboard

Machine Learning Pipeline :-

Problem Statement :
Classify each industry sector into one of three automation risk categories — High, Medium, or Low — based on economic, policy, and workforce indicators.
This is a supervised multi-class classification problem.

Target Variable :
risk_category — derived from sector_automation_risk_score using pd.cut() into three labeled bins: Low, Medium, High.

Features Used :
ai_tool_adoption_pct — Strongest predictor — sectors using AI tools show highest displacement
net_workforce_change_pct — Directly reflects whether sector is growing or shrinking
pct_sector_workforce_displaced — Current displacement rate as evidence of ongoing disruption
ai_adoption_index — Country-level AI adoption speed
govt_ai_policy_score_1_to_10 — Policy response quality
reskilling_programs_count — Availability of workforce safety net
female_replaced_pct — Gender-specific displacement signal
ai_cited_layoff_announcements — Real-world evidence of AI-driven job cuts
gdp_per_capita_usd — Country wealth context


Model Results :-
Logistic Regression Accuracy: 81.2%
Random Forest Classifier Accuracy: 94.5%

Random Forest outperformed Logistic Regression by 13.3 percentage points. The model was evaluated using accuracy score, confusion matrix, precision, recall, and F1 score per class.


Feature Importance — Top Findings
ai_tool_adoption_pct — most important feature (0.21)
net_workforce_change_pct — second most important (0.18)
pct_sector_workforce_displaced — third (0.15)
gdp_per_capita_usd — least important (0.03)

The finding that GDP ranks lowest confirms the scatter plot and correlation matrix result — country wealth does not predict automation risk. The type of work determines risk, not the country's income level.


Key Findings :-

Finding 1 — All sectors are shrinking
Zero sectors globally show a positive net workforce change. New AI job creation fails to outpace job displacement in every sector, every country, and every quarter analyzed. This was confirmed at three levels — mean analysis, visual chart, and row-level comparison of displacement vs new role creation columns.

Finding 2 — Administrative and Clerical faces the deepest crisis
This sector recorded the highest automation risk score (0.79), the most negative net workforce change (-0.35), and the highest female displacement rate (92%) — confirmed by three independent analyses pointing to the same sector.

Finding 3 — Gender bias in automation
Female displacement exceeded overall displacement in every sector without exception. Administrative and Clerical shows a 10x gap — overall displacement at 8% versus female displacement at 92%.

Finding 4 — Government policy drives reskilling investment
Correlation of 0.92 between government AI policy score and reskilling program count — the strongest relationship in the entire correlation matrix. Countries with strong policy have 6.7x more reskilling programs than weak policy countries.

Finding 5 — Reskilling is distributed equally, not equitably
All sectors receive approximately the same number of reskilling programs (34.3 to 34.7) regardless of their automation risk level. High-risk sectors like Administrative and Clerical receive the same support as low-risk sectors like Healthcare — a fundamental policy misallocation.

Finding 6 — GDP does not predict automation risk
Scatter plot and correlation matrix both show near-zero correlation (0.00) between GDP per capita and automation risk score. A data entry worker in India faces the same automation threat as a data entry worker in the United States. Risk is determined by job type, not country wealth.

Finding 7 — India Specific
India's automation risk profile is closely aligned with the global average across all 10 sectors, with differences ranging from -0.008 to +0.003 — statistically negligible variation.

This means India faces the same automation threat intensity as the global benchmark in every sector. India holds no structural advantage or disadvantage in terms of sector-level automation risk compared to other countries.

However, with a moderate government AI policy score of 6.1/10 and an AI adoption index of 0.52, India's risk lies in its policy response gap — AI adoption is accelerating while reskilling infrastructure remains insufficient relative to the scale of workforce exposure.

The highest risk sector in India is Administrative and Clerical (0.785) — where the combination of high automation risk, female-dominated workforce, and limited reskilling programs creates the most urgent intervention need.


SQL Analysis Highlights :-

Ten business queries written and executed in MySQL covering:
Industry-wise average automation risk score
India-specific sector analysis vs global average
Gender displacement gap by sector
Government policy effectiveness — displacement vs reskilling by policy category
Quarterly trend of automation risk and displacement over time
Reskilling gap score — risk per available program by sector
Country readiness score combining policy, reskilling, and adoption metrics
Complete sector crisis profile — single query covering all key metrics



Power BI Dashboard Structure

Page 1 — Executive Overview — KPI cards, world risk map, sector risk bar chart

Page 2 — Sector Risk Analysis — Risk scores and net workforce change by sector

Page 3 — Gender Impact — Female vs overall displacement comparison

Page 4 — Country Readiness — Policy vs reskilling scatter, top and bottom countries

Page 5 — India Insights — India sector risk vs global average, reskilling gap

Page 6 — ML Results — Feature importance chart, model accuracy comparison
