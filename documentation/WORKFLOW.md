# Project Workflow

## Overview

The Cost of Aging project follows a data engineering and analysis workflow that transforms raw synthetic healthcare records into structured datasets for analysis and visualization.

The workflow consists of five major stages:

1. Raw data acquisition and storage
2. Data ingestion into Microsoft Fabric
3. Data cleaning and transformation
4. Data aggregation and preparation
5. Visualization and analysis

The data engineering process uses a Bronze, Silver, and Gold architecture within a Microsoft Fabric Lakehouse.

## 1. Raw Data Acquisition

The project begins with the Synthea synthetic healthcare dataset, which contains 100 sample synthetic patient records.

The original CSV files are stored in:

`data/raw/`

The source dataset contains 18 healthcare-related CSV files. These files serve as the original source data for the project and are preserved separately from processed outputs.

## 2. Data Ingestion: Bronze Layer

The raw CSV data is made available in the Microsoft Fabric Lakehouse through the project's source tables and shortcuts.

The Bronze layer preserves the original source records and provides the foundation for downstream transformations.

## 3. Data Cleaning and Transformation: Silver Layer

The Silver layer prepares relevant source data for analysis.

The pipeline combines medication records with patient demographic information to calculate patient age at the time of medication use.

The transformation process includes:

- Joining medication records with patient demographic information.
- Calculating patient age at medication start.
- Assigning records to defined age groups.
- Calculating the portion of medication cost not covered by the payer.
- Enriching medication records with payer names.

The resulting Silver tables provide structured data for downstream analysis.

## 4. Data Modeling and Aggregation: Gold Layer

The Gold layer organizes the transformed data into analytical tables and aggregated datasets.

The pipeline creates patient and payer dimensions, medication fact data, and aggregate tables used to examine medication costs and payer coverage.

The final analysis focuses on medication costs and insurance coverage by age group and payer.

The resulting dataset is exported as:

`data/processed/cleaned_aggregated_data.csv`

Each row represents one age-group and payer combination.

## 5. Visualization and Analysis

The processed data supports the project's individual and group visualization work.

Visualization scripts are organized in:

- `scripts/02_individual_visualizations/`
- `scripts/03_group_visualizations/`

Generated visualizations are organized in:

- `outputs/individual_visualizations/`
- `outputs/group_visualizations/`

These visualizations are used to explore differences in medication costs and payer coverage across age groups and insurance providers.

The final project presentation is stored in:

`presentation/`

## Pipeline Implementation

The data processing workflow is documented in the consolidated Microsoft Fabric notebook:

`scripts/01_data_processing/cost_of_aging_pipeline.ipynb`

This notebook contains the project's data processing steps, including validation, transformation, and aggregation.

The notebook is the primary reference for the implementation of the data engineering pipeline. This workflow document provides a high-level explanation of the process rather than duplicating the notebook's code.

## Workflow Summary

**Synthea CSV files → Bronze Layer → Silver Layer → Gold Layer → Processed Dataset → Visualizations → Final Presentation**

The repository separates source data, processing scripts, generated outputs, and documentation to make the project easier to navigate and review.
