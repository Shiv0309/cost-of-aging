# Project Overview

## The Cost of Aging

### Project Description

The Cost of Aging examines the relationship between patient age, medication costs, and insurance coverage. Using synthetic healthcare data, the project explores whether insurance coverage keeps pace with medication costs as patients age, or whether the share of medication costs not covered by insurance changes across age groups.

The project combines data engineering, exploratory data analysis, data visualization, and healthcare cost analysis to organize complex healthcare records into an accessible analytical dataset.

### Research Question

**As patients age and take more medications, does insurance coverage keep pace, or do patients bear a growing share of costs?**

### Project Objectives

The project aims to:

- Examine medication costs and payer coverage across different patient age groups.
- Explore differences in insurance coverage among payers.
- Transform raw healthcare records into structured, analysis-ready datasets.
- Develop visualizations that communicate patterns in medication costs and insurance coverage.
- Identify trends and potential gaps that may warrant further investigation.

### Data and Technology

The project uses synthetic healthcare records from Synthea. The data is processed and organized in Microsoft Fabric using a Bronze, Silver, and Gold data architecture.

Technologies used in the project include:

- **Microsoft Fabric:** Data storage, engineering, and transformation.
- **PySpark / Spark SQL:** Data processing, querying, and aggregation.
- **Delta Lake:** Storage of structured data tables within the Lakehouse.
- **Python:** Data analysis and visualization workflows.
- **Power BI:** Interactive data visualization and dashboard development.
- **GitHub:** Version control, project organization, and documentation.

### Project Scope

The analysis focuses on medication records and associated payer coverage. The final processed dataset, `cleaned_aggregated_data.csv`, summarizes medication records and costs by patient age group and payer.

The dataset includes:

- Age group
- Payer ID and payer name
- Number of medication records
- Total medication cost
- Total payer coverage
- Proportion of medication costs covered by the payer

The project is intended to explore patterns in the provided synthetic data. It does not estimate actual healthcare expenses for real patients or establish causal relationships between age and insurance coverage.

### Repository Structure

The repository is organized into the following main directories:

- `data/`: Raw source data, processed data, and the data dictionary.
- `scripts/`: Data processing notebooks and individual and group visualization scripts.
- `outputs/`: Generated individual and group visualizations.
- `presentation/`: Final project presentation.
- `documentation/`: Project background, data provenance, workflow, reproducibility, and responsible data science documentation.

### Expected Outcome

The expected outcome is a documented and reproducible data analysis project that demonstrates how healthcare records can be transformed into meaningful insights about medication costs and insurance coverage across age groups.
