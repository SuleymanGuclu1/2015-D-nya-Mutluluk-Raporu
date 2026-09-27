# 2015 World Happiness Report — Data Analysis

## Project Overview

This project presents an exploratory and statistical analysis of the **2015 World Happiness Report** dataset using multiple data analysis environments.

The primary objective is to examine country-level happiness scores, identify relationships between selected socioeconomic indicators, and demonstrate an end-to-end analytical workflow using **Google Sheets, Python, SQL, Google Colab, and Google BigQuery**.

The project focuses not only on obtaining results, but also on demonstrating how the same analytical problem can be approached through different tools and methodologies.

### Main Objectives

* Explore and structure the dataset
* Rank countries according to their happiness scores
* Analyze regional distributions
* Apply data normalization techniques
* Investigate relationships between selected variables
* Calculate correlation coefficients using Python and SQL
* Perform advanced SQL analysis using BigQuery
* Apply `JOIN` and window functions
* Visualize relevant patterns and comparisons
* Evaluate analytical limitations and avoid causal interpretations of correlation

---

## Dataset

The analysis is based on the **2015 World Happiness Report** dataset.

The dataset contains country-level indicators related to happiness and socioeconomic conditions.

Key analytical variables include:

* Country
* Region
* Happiness Score
* Economic / socioeconomic indicators
* Other relevant country-level variables included in the original dataset

The analysis is limited to observations available for **2015**.

> **Note:** Since this project focuses exclusively on one year, the results should not be interpreted as evidence of long-term trends or changes in happiness over time.

---

## Methodology

The project follows a multi-stage data analysis workflow.

### 1. Data Exploration and Preparation

The initial stage was performed using **Google Sheets** to inspect the structure of the dataset and identify relevant variables.

Operations included:

* Data inspection
* Sorting
* Filtering
* Basic validation
* Country ranking
* Regional comparison
* Data normalization

### 2. Exploratory Data Analysis

The dataset was examined to identify:

* Countries with the highest and lowest happiness scores
* Regional differences
* Distribution patterns
* Relationships between selected indicators

### 3. Statistical Analysis

**Python** was used in Google Colab to perform correlation analysis and examine linear relationships between variables.

The analysis produced an approximate correlation coefficient of:

**Pearson's r ≈ 0.78**

This indicates a relatively strong positive linear association between the variables examined.

However, correlation should not be interpreted as causation. The observed relationship alone does not establish that changes in one variable directly cause changes in another.

### 4. SQL Analysis

SQL was used to reproduce and extend analytical operations through structured queries.

The analysis included:

* Filtering
* Aggregation
* Sorting
* Grouping
* Joining datasets
* Ranking observations
* Window functions

### 5. BigQuery Analysis

Google BigQuery was used to perform more advanced SQL-based analysis.

In particular, `JOIN` operations and window functions were applied to support:

* Comparative analysis
* Ranking within groups
* Regional comparisons
* Relative position analysis
* Analytical calculations across country-level observations

---

## SQL Queries

The SQL component of the project focuses on transforming raw data into analytical outputs.

### Example: Ranking Countries by Happiness Score

```sql
SELECT
    Country,
    Region,
    Happiness_Score,
    RANK() OVER (
        ORDER BY Happiness_Score DESC
    ) AS Happiness_Rank
FROM happiness_data
ORDER BY Happiness_Rank;
```

This query uses the `RANK()` window function to assign a relative position to each country according to its happiness score.

### Example: Regional Ranking

```sql
SELECT
    Country,
    Region,
    Happiness_Score,
    RANK() OVER (
        PARTITION BY Region
        ORDER BY Happiness_Score DESC
    ) AS Regional_Rank
FROM happiness_data;
```

This approach allows countries to be ranked within their respective regions rather than across the entire dataset.

### SQL Techniques Used

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `JOIN`
* `RANK()`
* `PARTITION BY`
* Window Functions
* Aggregation Functions

---

## Python Analysis

Python analysis was performed in **Google Colab**.

The main objectives were to explore the dataset programmatically and investigate statistical relationships between variables.

### Main Python Tasks

* Data loading
* Data inspection
* Data cleaning
* Descriptive analysis
* Correlation analysis
* Result interpretation
* Data visualization

A correlation analysis produced an approximate:

**r = 0.78**

The result indicates a positive linear association between the variables examined.

The analysis does **not** establish a causal relationship. Additional factors, omitted variables, measurement limitations, and the observational nature of the dataset should be considered before making causal interpretations.

### Analytical Perspective

The Python workflow demonstrates how statistical analysis can complement SQL-based data exploration:

**Data → Exploration → Transformation → Statistical Analysis → Interpretation**

---

## Visualizations

Several visualizations were created to make the analytical results easier to interpret.

### 1. Country Ranking

Countries were sorted according to their happiness scores to identify the highest-ranking observations.

In the 2015 dataset, **Switzerland recorded a happiness score of approximately 7.59**, placing it at the top of the dataset's ranking.

### 2. Regional Distribution

Regional comparisons were visualized to examine differences in happiness scores across geographical groups.

This visualization helps identify whether the distribution of happiness scores appears to vary between regions.

### 3. Normalized Data

Normalization was applied to selected variables to place measurements on a comparable scale.

This step is particularly useful when variables have substantially different numerical ranges.

### 4. Correlation Analysis

The relationship between selected variables was examined using correlation analysis.

The approximate Pearson correlation coefficient of **0.78** indicates a positive linear association within the analyzed data.

---

## Key Findings

The analysis produced several notable observations:

1. **Switzerland recorded the highest happiness score in the analyzed 2015 dataset, with a score of approximately 7.59.**

2. A positive relationship was observed between the selected variables, with an approximate **Pearson correlation coefficient of r = 0.78**.

3. Regional comparisons revealed differences in the distribution of happiness scores across geographical groups.

4. Data normalization provided a standardized basis for comparing variables with different scales.

5. SQL window functions enabled country-level rankings to be calculated both globally and within individual regions.

6. Combining Python, SQL, BigQuery, and spreadsheet-based analysis provided multiple perspectives on the same dataset.

### Important Interpretation

The correlation result represents a **statistical association rather than a causal relationship**.

Therefore, the findings should be interpreted as descriptive and exploratory rather than as evidence that one socioeconomic factor directly determines national happiness.

---

## Limitations

Several limitations should be considered when interpreting the results.

### 1. Single-Year Dataset

The analysis is limited to **2015**.

Consequently, the project cannot demonstrate:

* Long-term trends
* Changes in country rankings over time
* Year-over-year variation
* The persistence of observed relationships

### 2. Correlation vs. Causation

The correlation coefficient indicates statistical association but does not establish causality.

A causal analysis would require additional methodological approaches and potentially longitudinal or experimental data.

### 3. Country-Level Aggregation

The analysis uses country-level observations.

Therefore, the results should not automatically be interpreted as representing individual citizens or population subgroups.

### 4. Potentially Omitted Variables

National happiness can be influenced by numerous economic, social, political, cultural, and demographic factors.

Variables not included in the analysis may therefore affect the observed relationships.

---

## Folder Structure

```text
2015-world-happiness-analysis/
│
├── README.md
│
├── data/
│   └── 2015_world_happiness_report.csv
│
├── python/
│   └── happiness_analysis.ipynb
│
├── sql/
│   ├── country_ranking.sql
│   ├── regional_analysis.sql
│   └── window_functions.sql
│
├── bigquery/
│   ├── joins.sql
│   └── analytical_queries.sql
│
├── google-sheets/
│   └── normalized_data.xlsx
│
└── visualizations/
    ├── happiness_ranking.png
    ├── regional_distribution.png
    └── correlation_analysis.png
```

---

## Tools & Technologies

| Tool                   | Purpose                                   |
| ---------------------- | ----------------------------------------- |
| **Google Sheets**      | Data exploration, sorting, normalization  |
| **Python**             | Statistical analysis and data exploration |
| **Google Colab**       | Python-based analytical environment       |
| **SQL**                | Data querying and transformation          |
| **Google BigQuery**    | Advanced SQL analysis                     |
| **Window Functions**   | Ranking and comparative analysis          |
| **Data Visualization** | Pattern and relationship analysis         |

---

## Project Workflow

```text
Raw Dataset
     ↓
Data Exploration
     ↓
Data Cleaning & Preparation
     ↓
Google Sheets Analysis
     ↓
Python Statistical Analysis
     ↓
SQL Queries
     ↓
BigQuery Analysis
     ↓
Visualizations
     ↓
Findings & Limitations


## Conclusion
This project demonstrates an end-to-end data analysis workflow using multiple analytical technologies.
Rather than relying on a single tool, the analysis combines **spreadsheet-based exploration, Python-based statistical analysis, SQL querying, and BigQuery-based analytical techniques**.
The project demonstrates practical skills in:
* Exploratory Data Analysis
* Data Preparation
* Statistical Analysis
* Correlation Analysis
* SQL
* BigQuery
* Window Functions
* Data Visualization
* Analytical Interpretation
* Critical Evaluation of Data Limitations

The results should be understood within the scope of the **2015 dataset** and the methodological limitations described above.

