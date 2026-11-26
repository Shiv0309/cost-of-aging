
# Raw Data

## 1. Overview

This folder contains the original, unmodified raw data used in our project. The dataset was generated using [Synthea](https://synthetichealth.github.io/synthea/), an open-source synthetic patient generator that produces realistic but fictional healthcare records.

The original dataset is preserved as a ZIP archive rather than as individually uploaded CSV files.

## 2. Data Source

- **Source:** [Synthea – Synthetic Patient Data](https://synthetichealth.github.io/synthea/)
- **Dataset:** Synthea Sample Data (CSV Format)
- **Archive:** `synthea_sample_data_csv_latest.zip`
- **Contents:** 18 CSV files

## 3. Files Included

The ZIP archive contains the following 18 CSV files:

| File | Description |
|---|---|
| `allergies.csv` | Patient allergy records |
| `careplans.csv` | Patient care plans and associated treatment information |
| `claims_transactions.csv` | Healthcare insurance claim transaction records |
| `claims.csv` | Healthcare insurance claim records |
| `conditions.csv` | Patient diagnoses and medical conditions |
| `devices.csv` | Medical devices associated with patients |
| `encounters.csv` | Patient healthcare encounters and visits |
| `imaging_studies.csv` | Medical imaging study records |
| `immunizations.csv` | Patient immunization records |
| `medications.csv` | Patient medication records |
| `observations.csv` | Clinical observations, measurements, and test results |
| `organizations.csv` | Healthcare organizations and facilities |
| `patients.csv` | Synthetic patient demographic information |
| `payer_transitions.csv` | Patient insurance payer transition records |
| `payers.csv` | Healthcare insurance payer information |
| `procedures.csv` | Medical procedures performed on patients |
| `providers.csv` | Healthcare provider information |
| `supplies.csv` | Medical supplies associated with patient care |

## 4. Data Preservation and Organization

The original ZIP archive is retained in this folder to preserve the source data and maintain a clear distinction between raw and processed data.

Our project follows these practices:

- Raw data is preserved in its original form and is not directly modified during analysis.
- Data exploration, cleaning, filtering, and aggregation are performed through the project's data processing scripts.
- Cleaned and aggregated data is stored separately in `data/processed/`.
- Processing steps are documented to support transparency and reproducibility.

This separation allows the original data to remain available for reference and enables the processing workflow to be reproduced.

## 5. Extracting the Data

Before running the data processing pipeline, extract the CSV files from the ZIP archive.

From the root directory of the repository, run:

```bash
unzip data/raw/synthea_sample_data_csv_latest.zip -d data/raw/synthea_sample_data_csv_latest/
```

This creates a folder containing the 18 original CSV files.

## 6. Data Characteristics and Limitations

Synthea generates **synthetic healthcare data**, not records from actual patients. Although the data is designed to resemble real-world healthcare information, it may not fully represent the complexity, diversity, or distributions found in actual patient populations.

Therefore, findings from this project should be interpreted within the limitations of synthetic data and should not be treated as direct evidence of real-world patient outcomes.

## 7. Related Documentation

- [Project README](../../README.md)
- [Data Dictionary](../DATA_DICTIONARY.md)
- [Data Provenance](../../documentation/DATA_PROVENANCE.md)
- [Workflow Documentation](../../documentation/WORKFLOW.md)
- [Reproducibility Guide](../../documentation/REPRODUCIBILITY.md)
- [Responsible Data Science](../../documentation/RESPONSIBLE_DATA_SCIENCE.md)
