# Reproducibility

## Purpose

This document describes the resources and general steps needed to review and reproduce The Cost of Aging project.

The project uses Microsoft Fabric for data engineering and Power BI for data visualization. Reproducing the full workflow requires access to the source dataset and an appropriately configured Microsoft Fabric environment.

## Repository Contents

The following repository resources support the project workflow:

| Resource | Location | Purpose |
|---|---|---|
| Raw source data | `data/raw/` | Original Synthea CSV files |
| Processed dataset | `data/processed/` | Final aggregated CSV output |
| Data dictionary | `data/DATA_DICTIONARY.md` | Definitions of source and processed data fields |
| Pipeline notebook | `scripts/01_data_processing/` | Data validation, transformation, and aggregation |
| Visualization scripts | `scripts/` | Individual and group visualization code |
| Visualization outputs | `outputs/` | Generated visualizations |
| Project documentation | `documentation/` | Project methods, workflow, and supporting information |
| Final presentation | `presentation/` | Final project presentation |

## Requirements

To review or reproduce the project, the following resources are needed:

- Access to the project repository.
- The original Synthea CSV dataset.
- Access to Microsoft Fabric.
- A Fabric Lakehouse configured with the required source tables.
- The project's exported Fabric notebook.
- Access to Power BI for reviewing or recreating the dashboard and visualizations, where applicable.

The exact Python, PySpark, and other dependency versions should be documented once confirmed from the project environment.

## Reproduction Steps

### 1. Obtain the Source Data

Use the Synthea dataset available through the [official downloads page](https://synthea.mitre.org/downloads).

The project uses the **100 Sample Synthetic Patient Records, CSV** dataset downloaded on November 12, 2026.

The original CSV files are organized in:

`data/raw/`

### 2. Configure the Microsoft Fabric Environment

Create or access a Microsoft Fabric workspace and configure a Lakehouse containing the required source data tables.

The source tables should be available to the pipeline in the expected locations and under the expected table names.

The original project uses the Fabric Lakehouse and its source tables as the starting point for data processing.

### 3. Run the Data Processing Notebook

Open the exported notebook located at:

`scripts/01_data_processing/cost_of_aging_pipeline.ipynb`

Run the notebook in the appropriate Microsoft Fabric environment.

The notebook contains the project's data validation, transformation, enrichment, and aggregation steps.

The required source tables and Lakehouse references must be configured before running the notebook. Exporting the notebook does not automatically recreate the original Fabric workspace or Lakehouse.

### 4. Generate the Processed Dataset

The pipeline produces the final age-group and payer coverage aggregation.

The expected exported output is:

`data/processed/cleaned_aggregated_data.csv`

The output should contain the fields documented in `data/DATA_DICTIONARY.md`.

### 5. Review the Visualizations

The visualization scripts and generated outputs are organized in the repository's `scripts/` and `outputs/` directories.

Review the relevant scripts and outputs to understand how the processed dataset is used to communicate the project's findings.

### 6. Review the Final Presentation

The final presentation will be stored in:

`presentation/`

It summarizes the research question, methods, analysis, and findings.

## Reproducibility Notes

- The original source CSV files are retained separately from the processed dataset.
- The final CSV is an output of the project's processing and aggregation workflow.
- The exported notebook provides the code, but successful execution also depends on the required Fabric workspace, Lakehouse, and source table configuration.
- Exact software and package versions should be added after confirming the environment used by the project.
- Generated visualizations may depend on the specific tools and configurations used by individual team members.

This repository is intended to provide a clear record of the project's data, processing logic, and analytical outputs.
