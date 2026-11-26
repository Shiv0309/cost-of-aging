# Data Dictionary
## The Cost of Aging

This document describes the source data and final processed dataset used in **The Cost of Aging** project.

The project investigates the relationship between patient age, medication utilization, insurance coverage, and calculated uncovered medication costs.

The data dictionary covers two datasets:

1. **Raw Source Data:** The 18 original CSV files obtained from Synthea.
2. **Processed Analytical Dataset:** The final aggregated dataset, `cleaned_aggregated_data.csv`, used for analysis and visualization.

---

# 1. Raw Source Data

## 1.1 Data Source

The original dataset comes from [Synthea](https://synthetichealth.github.io/synthea/), an open-source synthetic patient generator that produces realistic but artificial healthcare records.

The project uses 18 CSV files containing synthetic patient demographics, healthcare encounters, medications, insurance information, and other clinical records.

The original files are stored in:

`data/raw/`

The source data is preserved separately from processed outputs and is not modified during the data transformation process.

**Important:** Synthea data is synthetic and does not represent actual patient records. However, the dataset contains fields modeled after sensitive personal and healthcare information, so the project applies data minimization when creating analytical outputs.

## 1.2 Source Files Overview

| File | Description |
|---|---|
| `allergies.csv` | Patient allergy records and associated reactions. |
| `careplans.csv` | Patient care plans, their dates, and associated reasons. |
| `claims_transactions.csv` | Individual healthcare claim transactions and financial amounts. |
| `claims.csv` | Healthcare claim records, diagnoses, providers, and billing information. |
| `conditions.csv` | Patient clinical, behavioral, and social condition records. |
| `devices.csv` | Medical device and other coded device-related records. |
| `encounters.csv` | Patient healthcare visits, encounter types, and associated costs. |
| `imaging_studies.csv` | Imaging study metadata and associated procedures. |
| `immunizations.csv` | Patient immunization records and associated costs. |
| `medications.csv` | Patient medication records, dispensing information, and insurance coverage. |
| `observations.csv` | Patient observations, including vital signs, social history, and survey responses. |
| `organizations.csv` | Healthcare organizations and facility information. |
| `patients.csv` | Patient demographic, geographic, and socioeconomic information. |
| `payer_transitions.csv` | Patient insurance coverage periods and payer transitions. |
| `payers.csv` | Insurance payer information and aggregate financial measures. |
| `procedures.csv` | Clinical procedures performed during patient encounters. |
| `providers.csv` | Healthcare provider information, specialties, and organizational affiliations. |
| `supplies.csv` | Medical supplies and other coded items associated with patient encounters. |

## 1.3 Individual Source Table Dictionaries

### 1.3.1 `allergies.csv`

**Purpose:** Records patient allergies, associated substances, and documented reactions.

| Column | Description |
|---|---|
| `START` | Date the allergy record begins. |
| `STOP` | Date the allergy record ends, if applicable. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `CODE` | Standardized code identifying the allergy or finding. |
| `SYSTEM` | Coding system used for the allergy record. |
| `DESCRIPTION` | Human-readable description of the allergy or finding. |
| `TYPE` | Type of record. |
| `CATEGORY` | Allergy category, such as food or environmental. |
| `REACTION1` | Code for the first recorded reaction. |
| `DESCRIPTION1` | Description of the first reaction. |
| `SEVERITY1` | Severity of the first reaction. |
| `REACTION2` | Code for a second recorded reaction, if available. |
| `DESCRIPTION2` | Description of the second reaction. |
| `SEVERITY2` | Severity of the second reaction. |

**Notes:** Reaction fields and `STOP` may be blank. Some descriptions may represent general allergy-related findings rather than a specific allergen.

### 1.3.2 `careplans.csv`

**Purpose:** Contains patient care plans, their time periods, and associated clinical reasons.

| Column | Description |
|---|---|
| `Id` | Unique care plan identifier. |
| `START` | Care plan start date. |
| `STOP` | Care plan end date, if available. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `CODE` | Standardized care plan code. |
| `DESCRIPTION` | Description of the care plan or intervention. |
| `REASONCODE` | Code identifying the reason for the care plan. |
| `REASONDESCRIPTION` | Human-readable description of the reason. |

**Notes:** Care plans may include diabetes management, respiratory therapy, rehabilitation, and other interventions. Optional fields may be blank.

### 1.3.3 `claims_transactions.csv`

**Purpose:** Contains individual financial transactions associated with healthcare claims.

| Column | Description |
|---|---|
| `ID` | Unique transaction identifier. |
| `CLAIMID` | Claim identifier linking to `claims.csv` through its `Id` column. |
| `CHARGEID` | Identifier associated with the transaction charge. |
| `PATIENTID` | Patient identifier linking to `patients.csv`. |
| `TYPE` | Transaction type, such as charge, payment, transfer in, or transfer out. |
| `AMOUNT` | Transaction amount. |
| `METHOD` | Payment method. |
| `FROMDATE` | Beginning date or timestamp associated with the transaction. |
| `TODATE` | Ending date or timestamp associated with the transaction. |
| `PLACEOFSERVICE` | Code or description identifying the place of service. |
| `PROCEDURECODE` | Procedure code associated with the transaction. |
| `MODIFIER1` | First procedure modifier, if applicable. |
| `MODIFIER2` | Second procedure modifier, if applicable. |
| `DIAGNOSISREF1` | First diagnosis reference. |
| `DIAGNOSISREF2` | Second diagnosis reference. |
| `DIAGNOSISREF3` | Third diagnosis reference. |
| `DIAGNOSISREF4` | Fourth diagnosis reference. |
| `UNITS` | Number of service units associated with the transaction. |
| `DEPARTMENTID` | Department identifier associated with the transaction. |
| `NOTES` | Additional transaction notes. |
| `UNITAMOUNT` | Amount charged per unit. |
| `TRANSFEROUTID` | Identifier associated with an outgoing transfer. |
| `TRANSFERTYPE` | Type of financial transfer. |
| `PAYMENTS` | Payment amount associated with the transaction. |
| `ADJUSTMENTS` | Financial adjustment amount. |
| `TRANSFERS` | Amount associated with transfers. |
| `OUTSTANDING` | Outstanding financial balance. |
| `APPOINTMENTID` | Associated appointment identifier. |
| `LINENOTE` | Additional note associated with the transaction line. |
| `PATIENTINSURANCEID` | Patient insurance identifier. |
| `FEESCHEDULEID` | Fee schedule identifier. |
| `PROVIDERID` | Associated provider identifier. |
| `SUPERVISINGPROVIDERID` | Supervising provider identifier. |

**Notes:**
- `CLAIMID` connects transactions to their corresponding claim records.
- `TYPE` distinguishes charges, payments, and transfers.
- `AMOUNT`, `PAYMENTS`, `ADJUSTMENTS`, `TRANSFERS`, and `OUTSTANDING` represent different financial measures and should not be treated as interchangeable.
- Several modifier, diagnosis, and note fields may be blank.

### 1.3.4 `claims.csv`

**Purpose:** Contains healthcare claim information, including patient diagnoses, providers, insurance identifiers, and billing status.

| Column | Description |
|---|---|
| `Id` | Unique claim identifier. |
| `PATIENTID` | Patient identifier linking to `patients.csv`. |
| `PROVIDERID` | Associated provider identifier. |
| `PRIMARYPATIENTINSURANCEID` | Primary patient insurance identifier. |
| `SECONDARYPATIENTINSURANCEID` | Secondary patient insurance identifier, if available. |
| `DEPARTMENTID` | Department identifier associated with the claim. |
| `PATIENTDEPARTMENTID` | Patient department identifier. |
| `DIAGNOSIS1`–`DIAGNOSIS8` | Diagnosis codes associated with the claim. |
| `REFERRINGPROVIDERID` | Referring provider identifier. |
| `APPOINTMENTID` | Associated appointment identifier. |
| `CURRENTILLNESSDATE` | Date associated with the current illness. |
| `SERVICEDATE` | Date the healthcare service was provided. |
| `SUPERVISINGPROVIDERID` | Supervising provider identifier. |
| `STATUS1` | Status of the first claim or insurance component. |
| `STATUS2` | Status of the second claim or insurance component. |
| `STATUSP` | Status of the patient claim component. |
| `OUTSTANDING1` | Outstanding balance for the first claim component. |
| `OUTSTANDING2` | Outstanding balance for the second claim component. |
| `OUTSTANDINGP` | Outstanding patient balance. |
| `LASTBILLEDDATE1` | Last billing date for the first claim component. |
| `LASTBILLEDDATE2` | Last billing date for the second claim component. |
| `LASTBILLEDDATEP` | Last billing date for the patient component. |
| `HEALTHCARECLAIMTYPEID1` | Healthcare claim type identifier for the first component. |
| `HEALTHCARECLAIMTYPEID2` | Healthcare claim type identifier for the second component. |

**Notes:**
- `Id` connects to `CLAIMID` in `claims_transactions.csv`.
- Some secondary insurance and additional diagnosis fields may be blank.
- Claim-level outstanding balances are distinct from medication-level calculated uncovered costs.

### 1.3.5 `conditions.csv`

**Purpose:** Records patient clinical, behavioral, and social conditions.

| Column | Description |
|---|---|
| `START` | Date the condition begins. |
| `STOP` | Date the condition ends, if applicable. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `SYSTEM` | Coding system used for the condition. |
| `CODE` | Standardized condition code. |
| `DESCRIPTION` | Human-readable condition description. |

**Notes:** Conditions may include clinical diagnoses as well as social and behavioral findings. `STOP` may be blank for ongoing conditions.

**Header verification:** These column definitions are based on the supplied sample. Verify the exact header against the original CSV.

### 1.3.6 `devices.csv`

**Purpose:** Records device-related and other coded objects associated with patient encounters.

| Column | Description |
|---|---|
| `START` | Date or timestamp the device record begins. |
| `STOP` | Date or timestamp the device record ends, if applicable. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `CODE` | Standardized device or object code. |
| `DESCRIPTION` | Human-readable description of the device or object. |
| `UDI` | Unique Device Identifier associated with the record. |

**Notes:** Records may include medical devices and other coded objects or environments. `STOP` may be blank.

**Header verification:** These column definitions are based on the supplied sample. Verify the exact header against the original CSV.

### 1.3.7 `encounters.csv`

**Purpose:** Contains patient healthcare visits, encounter classifications, and associated financial information.

| Column | Description |
|---|---|
| `Id` | Unique encounter identifier. |
| `START` | Encounter start timestamp. |
| `STOP` | Encounter end timestamp. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ORGANIZATION` | Healthcare organization identifier. |
| `PROVIDER` | Healthcare provider identifier. |
| `PAYER` | Insurance payer identifier linking to `payers.csv`. |
| `ENCOUNTERCLASS` | Encounter classification, such as wellness, urgent care, ambulatory, or outpatient. |
| `CODE` | Standardized encounter code. |
| `DESCRIPTION` | Human-readable encounter description. |
| `BASE_ENCOUNTER_COST` | Base cost associated with the encounter. |
| `TOTAL_CLAIM_COST` | Total claim cost associated with the encounter. |
| `PAYER_COVERAGE` | Amount covered by the payer for the encounter. |
| `REASONCODE` | Code identifying the reason for the encounter. |
| `REASONDESCRIPTION` | Human-readable reason for the encounter. |

**Notes:** `Id` connects to `ENCOUNTER` in multiple clinical source tables. Encounter-level financial measures are distinct from medication-level financial measures in `medications.csv`.

### 1.3.8 `imaging_studies.csv`

**Purpose:** Contains metadata about imaging studies associated with patient encounters.

| Column | Description |
|---|---|
| `Id` | Unique imaging study record identifier. |
| `DATE` | Date and time of the imaging study. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `SERIES_UID` | Unique identifier for the imaging series. |
| `BODYSITE_CODE` | Standardized anatomical body-site code. |
| `BODYSITE_DESCRIPTION` | Description of the anatomical body site. |
| `MODALITY_CODE` | Imaging modality code. |
| `MODALITY_DESCRIPTION` | Description of the imaging modality. |
| `INSTANCE_UID` | Unique identifier for an imaging instance. |
| `SOP_CODE` | Service-Object Pair code. |
| `SOP_DESCRIPTION` | Description of the Service-Object Pair. |
| `PROCEDURE_CODE` | Associated imaging procedure code. |

**Notes:** This file contains imaging metadata, not the actual medical image files.

### 1.3.9 `immunizations.csv`

**Purpose:** Records patient immunizations and their associated base costs.

| Column | Description |
|---|---|
| `DATE` | Date and time of the immunization. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `CODE` | Standardized immunization or vaccine code. |
| `DESCRIPTION` | Human-readable vaccine description. |
| `BASE_COST` | Base cost associated with the immunization. |

**Notes:** `BASE_COST` is an immunization-level cost and is distinct from medication `TOTALCOST` or encounter `TOTAL_CLAIM_COST`.

### 1.3.10 `medications.csv`

**Purpose:** Contains patient medication records, including medication dates, dispensing information, costs, and insurance coverage. This is the primary source table used in the project's medication and insurance coverage analyses.

| Column | Description |
|---|---|
| `START` | Medication start date and time. |
| `STOP` | Medication end date and time, if applicable. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `PAYER` | Insurance payer identifier linking to `payers.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `CODE` | Standardized medication code. |
| `DESCRIPTION` | Human-readable medication name, formulation, or dosage description. |
| `BASE_COST` | Base cost per dispensing. |
| `PAYER_COVERAGE` | Amount covered by the insurance payer. |
| `DISPENSES` | Number of medication dispensings. |
| `TOTALCOST` | Total medication cost associated with the record. |
| `REASONCODE` | Code identifying the reason for the medication. |
| `REASONDESCRIPTION` | Human-readable description of the medication reason. |

**Notes:**
- This table is the primary source for medication utilization and insurance coverage analysis.
- `BASE_COST` represents the base cost per dispensing, while `TOTALCOST` represents the total medication cost.
- `PAYER_COVERAGE` represents the amount covered by the payer.
- `STOP`, `REASONCODE`, and `REASONDESCRIPTION` may be blank.
- Medication records are connected to patient demographics using `PATIENT` and payer information using `PAYER`.

### 1.3.11 `observations.csv`

**Purpose:** Contains patient observations, including vital signs, social history, and survey responses.

| Column | Description |
|---|---|
| `DATE` | Date and time of the observation. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `CATEGORY` | Observation category, such as vital signs, social history, or survey. |
| `CODE` | Standardized observation code. |
| `DESCRIPTION` | Human-readable observation description. |
| `VALUE` | Recorded observation value, which may be numeric, categorical, or text. |
| `UNITS` | Measurement units, when applicable. |
| `TYPE` | Data type of the observation, such as numeric or text. |

**Notes:** Observation values may represent measurements such as height, weight, BMI, blood pressure, heart rate, and respiratory rate. Social history and survey observations may contain categorical or text responses.

### 1.3.12 `organizations.csv`

**Purpose:** Contains information about healthcare organizations and facilities.

| Column | Description |
|---|---|
| `Id` | Unique organization identifier. |
| `NAME` | Organization name. |
| `ADDRESS` | Organization street address. |
| `CITY` | Organization city. |
| `STATE` | Organization state. |
| `ZIP` | Organization ZIP code. |
| `LAT` | Organization latitude. |
| `LON` | Organization longitude. |
| `PHONE` | Organization phone number. |
| `REVENUE` | Organization revenue measure. |
| `UTILIZATION` | Organization utilization measure. |
| `NPI` | National Provider Identifier. |

**Notes:**
- `Id` connects to `ORGANIZATION` in `providers.csv` and `encounters.csv`.
- `ZIP` should be treated as a string to preserve leading zeros and formatting.
- The precise interpretation of `UTILIZATION` should follow the source dataset documentation.

### 1.3.13 `patients.csv`

**Purpose:** Contains patient-level demographic, geographic, and socioeconomic information.

| Column | Description |
|---|---|
| `Id` | Unique patient identifier. |
| `BIRTHDATE` | Patient date of birth. |
| `DEATHDATE` | Patient date of death, if applicable. |
| `SSN` | Synthetic Social Security number. |
| `DRIVERS` | Synthetic driver's license identifier. |
| `PASSPORT` | Synthetic passport identifier. |
| `PREFIX` | Name prefix. |
| `FIRST` | First name. |
| `MIDDLE` | Middle name. |
| `LAST` | Last name. |
| `SUFFIX` | Name suffix. |
| `MAIDEN` | Maiden name, if applicable. |
| `MARITAL` | Marital status. |
| `RACE` | Patient race category. |
| `ETHNICITY` | Patient ethnicity category. |
| `GENDER` | Patient gender field as represented in the source data. |
| `BIRTHPLACE` | Patient birthplace. |
| `ADDRESS` | Patient street address. |
| `CITY` | Patient city. |
| `STATE` | Patient state. |
| `COUNTY` | Patient county. |
| `FIPS` | Geographic Federal Information Processing Standards code. |
| `ZIP` | Patient ZIP code. |
| `LAT` | Patient latitude. |
| `LON` | Patient longitude. |
| `HEALTHCARE_EXPENSES` | Patient-level healthcare expenses measure. |
| `HEALTHCARE_COVERAGE` | Patient-level healthcare coverage measure. |
| `INCOME` | Patient income measure. |

**Notes:**
- `Id` is the primary patient identifier used to connect patient records to clinical and financial source tables.
- `BIRTHDATE` is used to calculate patient age at medication start.
- `HEALTHCARE_EXPENSES` and `HEALTHCARE_COVERAGE` are patient-level measures and are distinct from medication-level costs and payer coverage.
- The original file includes synthetic direct identifiers and demographic fields. Direct identifiers are excluded from the project's analytical output.
- `DEATHDATE` and other fields may be blank.
- `FIPS` and `ZIP` should be treated as strings when preserving their formatting.

### 1.3.14 `payer_transitions.csv`

**Purpose:** Records patient insurance coverage periods and transitions between payers.

| Column | Description |
|---|---|
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `MEMBERID` | Insurance member identifier. |
| `START_DATE` | Beginning date of the insurance coverage period. |
| `END_DATE` | Ending date of the insurance coverage period. |
| `PAYER` | Primary payer identifier linking to `payers.csv`. |
| `SECONDARY_PAYER` | Secondary payer identifier, if available. |
| `PLAN_OWNERSHIP` | Ownership classification of the insurance plan. |
| `OWNER_NAME` | Name associated with the plan ownership record. |

**Notes:**
- A patient may have multiple records representing different insurance coverage periods.
- `MEMBERID` is an insurance member identifier and is distinct from the patient identifier.
- `SECONDARY_PAYER` may be blank.

### 1.3.15 `payers.csv`

**Purpose:** Contains insurance payer information and aggregate financial and utilization measures.

| Column | Description |
|---|---|
| `Id` | Unique payer identifier. |
| `NAME` | Payer name. |
| `OWNERSHIP` | Payer ownership classification, such as government, private, or no insurance. |
| `ADDRESS` | Payer address. |
| `CITY` | Payer city. |
| `STATE_HEADQUARTERED` | State where the payer is headquartered. |
| `ZIP` | Payer ZIP code. |
| `PHONE` | Payer phone number. |
| `AMOUNT_COVERED` | Aggregate amount covered by the payer. |
| `AMOUNT_UNCOVERED` | Aggregate amount not covered by the payer. |
| `REVENUE` | Payer revenue measure. |
| `COVERED_ENCOUNTERS` | Number of covered encounters. |
| `UNCOVERED_ENCOUNTERS` | Number of uncovered encounters. |
| `COVERED_MEDICATIONS` | Number of covered medication records. |
| `UNCOVERED_MEDICATIONS` | Number of uncovered medication records. |
| `COVERED_PROCEDURES` | Number of covered procedures. |
| `UNCOVERED_PROCEDURES` | Number of uncovered procedures. |
| `COVERED_IMMUNIZATIONS` | Number of covered immunizations. |
| `UNCOVERED_IMMUNIZATIONS` | Number of uncovered immunizations. |
| `UNIQUE_CUSTOMERS` | Number of unique customers associated with the payer. |
| `QOLS_AVG` | Average quality-of-life score as supplied by the source dataset. |
| `MEMBER_MONTHS` | Aggregate number of member-months. |

**Notes:**
- `Id` connects to `PAYER` in `medications.csv`, `encounters.csv`, and `payer_transitions.csv`.
- `NO_INSURANCE` is a meaningful payer category and should not automatically be treated as a missing value.
- Payer-level aggregate values are distinct from calculations made using individual medication records.
- The scale and interpretation of `QOLS_AVG` should not be assumed beyond the source-provided measure.

### 1.3.16 `procedures.csv`

**Purpose:** Records clinical procedures performed for patients during healthcare encounters.

| Column | Description |
|---|---|
| `START` | Procedure start date and time. |
| `STOP` | Procedure end date and time, if available. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `SYSTEM` | Coding system used for the procedure. |
| `CODE` | Standardized procedure code. |
| `DESCRIPTION` | Human-readable procedure description. |
| `BASE_COST` | Base cost associated with the procedure. |
| `REASONCODE` | Code identifying the reason for the procedure. |
| `REASONDESCRIPTION` | Human-readable description of the procedure reason. |

**Notes:** Procedure records may include screenings, consultations, dental care, and other interventions. `STOP`, `REASONCODE`, and `REASONDESCRIPTION` may be blank.

### 1.3.17 `providers.csv`

**Purpose:** Contains healthcare provider information, specialties, and organizational affiliations.

| Column | Description |
|---|---|
| `Id` | Unique provider identifier. |
| `ORGANIZATION` | Organization identifier linking to `organizations.csv`. |
| `NAME` | Synthetic provider name. |
| `GENDER` | Provider gender field as represented in the source data. |
| `SPECIALITY` | Provider medical specialty. |
| `ADDRESS` | Provider practice address. |
| `CITY` | Provider practice city. |
| `STATE` | Provider practice state. |
| `ZIP` | Provider practice ZIP code. |
| `LAT` | Provider practice latitude. |
| `LON` | Provider practice longitude. |
| `ENCOUNTERS` | Number of encounters associated with the provider. |
| `PROCEDURES` | Number of procedures associated with the provider. |
| `NPI` | National Provider Identifier. |

**Notes:**
- `Id` connects to provider identifiers in `claims.csv`, `claims_transactions.csv`, and `encounters.csv`.
- `ORGANIZATION` connects to `organizations.csv`.
- `ENCOUNTERS` and `PROCEDURES` are provider-level counts, not individual encounter or procedure records.
- Provider names and identifiers are synthetic.

### 1.3.18 `supplies.csv`

**Purpose:** Records supplies and other coded items associated with patient encounters.

| Column | Description |
|---|---|
| `DATE` | Date and time associated with the supply record. |
| `PATIENT` | Patient identifier linking to `patients.csv`. |
| `ENCOUNTER` | Associated encounter identifier linking to `encounters.csv`. |
| `CODE` | Standardized supply or item code. |
| `DESCRIPTION` | Human-readable description of the supply or item. |
| `QUANTITY` | Recorded quantity of the item. |

**Notes:** Records may include items such as glucose testing strips, blood lancets, and other medical or dental supplies. `QUANTITY` represents the recorded quantity and should not automatically be interpreted as a unique product or prescription count.

---

# 2. Processed Analytical Dataset

## 2.1 Overview

The final processed dataset is generated through the project's Microsoft Fabric data pipeline.

The pipeline uses the original Synthea patient, medication, and payer records to produce an aggregated dataset focused on medication utilization and insurance coverage across patient age groups and insurance payers.

The final processed file is stored in:

`data/processed/cleaned_aggregated_data.csv`

This is the primary dataset used for the project's final analysis and Power BI visualizations.

## 2.2 `cleaned_aggregated_data.csv`

**Purpose:** Summarizes medication utilization, medication costs, and payer coverage across patient age groups and insurance payers.

**Source tables:**
- `medications.csv`
- `patients.csv`
- `payers.csv`

**Grain:** One row per combination of `age_group` and `payer_id`.

Each row represents the aggregated medication records and financial measures for a particular age group and payer.

### Column Definitions

| Column | Description |
|---|---|
| `age_group` | Patient age category at the start of the medication record. |
| `payer_id` | Unique insurance payer identifier. |
| `payer_name` | Human-readable insurance payer name. |
| `medication_records` | Number of medication records for that age group and payer combination. |
| `total_medication_cost` | Sum of medication costs for that age group and payer combination. |
| `total_payer_coverage` | Sum of payer coverage amounts for that age group and payer combination. |
| `coverage_proportion` | Ratio of total payer coverage to total medication cost. |

### 2.2.1 Age Group Categories

Age is calculated using the patient's birth date and the medication start date. Patients are grouped according to their age when the medication record began.

| Age Group | Definition |
|---|---|
| `Under 18` | Patients younger than 18 years. |
| `18-29` | Patients aged 18 through 29 years. |
| `30-44` | Patients aged 30 through 44 years. |
| `45-59` | Patients aged 45 through 59 years. |
| `60-74` | Patients aged 60 through 74 years. |
| `75+` | Patients aged 75 years and older. |
| `Unknown` | Records where age could not be calculated. |
| `Invalid Age` | Records where the calculated age is negative. |

### 2.2.2 Financial Calculations

**Total Medication Cost**

The sum of medication costs for all medication records within an age-group and payer combination.

`total_medication_cost = SUM(total_cost)`

**Total Payer Coverage**

The sum of insurance coverage amounts for all medication records within an age-group and payer combination.

`total_payer_coverage = SUM(payer_coverage)`

**Coverage Proportion**

The proportion of total medication costs covered by the payer.

`coverage_proportion = total_payer_coverage / total_medication_cost`

For example:

- `0.25` represents 25% payer coverage.
- `0.50` represents 50% payer coverage.
- `0.75` represents 75% payer coverage.
- `1.00` represents 100% payer coverage.

If total medication cost is zero, the coverage proportion is returned as `NULL`.

**Medication Records**

The number of individual medication records included in each age-group and payer combination.

`medication_records = COUNT(*)`

### 2.2.3 Important Interpretation Considerations

- `coverage_proportion` is stored as a decimal ratio, not a percentage on a 0–100 scale.
- Coverage proportion is calculated using the sum of payer coverage divided by the sum of medication costs. It is not an average of individual medication-level coverage percentages.
- `medication_records` counts medication records, not unique medications or unique patients.
- Age represents the patient's age at medication start, not their current age.
- The dataset does not include a separate calculated uncovered-cost column. The difference between total medication cost and payer coverage can be calculated from the two financial columns if needed.

---

# 3. Data Relationships

The source tables contain identifiers that connect patient, medication, payer, and encounter records.

The following relationships are particularly relevant to the project's final dataset:

| Primary Table | Primary Key | Related Table | Foreign Key |
|---|---|---|---|
| `patients.csv` | `Id` | `medications.csv` | `PATIENT` |
| `payers.csv` | `Id` | `medications.csv` | `PAYER` |
| `patients.csv` | `Id` | `encounters.csv` | `PATIENT` |
| `payers.csv` | `Id` | `encounters.csv` | `PAYER` |
| `patients.csv` | `Id` | `payer_transitions.csv` | `PATIENT` |
| `payers.csv` | `Id` | `payer_transitions.csv` | `PAYER` |

The final processed dataset uses patient identifiers to incorporate demographic information and payer identifiers to incorporate payer names.

The final output is aggregated by `age_group` and `payer_id`, rather than retaining individual patient records.

---

# 4. Data Quality and Limitations

## 4.1 Data Validation

The data pipeline includes validation checks to assess data quality and consistency.

These checks include:

- Record counts across source tables.
- Minimum and maximum date ranges.
- Missing patient identifiers and birth dates.
- Missing medication dates, payer identifiers, and financial values.
- Duplicate patient identifiers.
- Medication records without matching patient records.
- Medication payer identifiers without matching payer records.
- Medication cost calculations compared with base cost multiplied by dispensing count.
- Negative medication costs and coverage values.
- Payer coverage amounts exceeding total medication costs.
- Consistency of financial totals between source and processed data.

## 4.2 Data Limitations

The following limitations should be considered when interpreting the project's findings:

- **Synthetic data:** Synthea records are artificially generated and may not reflect real-world healthcare utilization, insurance arrangements, or patient spending.
- **Coverage versus spending:** The dataset provides payer coverage amounts but does not establish actual patient out-of-pocket expenses.
- **Association versus causation:** Relationships between age, medication utilization, insurance coverage, and uncovered costs should not be interpreted as causal.
- **Source data completeness:** Some records contain missing dates, payer identifiers, or other optional fields.
- **Age-based grouping:** Age groups are based on age at medication start and may differ from age at other healthcare encounters.
- **Medication definitions:** Multiple records may refer to the same medication code. Medication record counts should not be interpreted as counts of unique medications.
- **Payer classification:** Insurance categories and payer names reflect the source dataset and may not represent the full complexity of real-world insurance arrangements.

## 4.3 Privacy and Responsible Data Use

Although the dataset is synthetic, the project follows data minimization practices.

- Direct personal identifiers are excluded from the final analytical dataset.
- Patient identifiers are used only where necessary to connect and aggregate records.
- Original source tables are preserved without modification.
- Final outputs focus on aggregated measures rather than exposing individual-level patient information.
- Findings are presented with appropriate limitations and should not be generalized to real patient populations without further validation.

---

# 5. Technology and Tools

| Technology | Purpose |
|---|---|
| Microsoft Fabric | Data engineering environment and Lakehouse platform. |
| Lakehouse | Storage and organization of source and transformed data. |
| Python | Data exploration and pipeline development. |
| PySpark | Data cleaning, transformation, and enrichment. |
| Spark SQL | Analytical queries and aggregation. |
| Delta Lake | Storage format for transformed Lakehouse tables. |
| Power BI | Data visualization and dashboard development. |
| GitHub | Project version control, source code organization, and documentation. |

---

# 6. Summary

The Cost of Aging uses synthetic healthcare data to examine how medication utilization and insurance coverage vary across patient age groups and insurance payers.

The original 18 Synthea CSV files provide the foundation for the project's data pipeline. Patient demographic information is combined with medication records to calculate age at medication start, while payer information is incorporated to identify insurance providers.

The final processed dataset, `cleaned_aggregated_data.csv`, summarizes medication records, total medication costs, and payer coverage for each age-group and payer combination. This dataset serves as the primary input for the project's final analysis and Power BI dashboard.

The project addresses the following research question:

**As patients age and take more medications, does insurance coverage keep pace, or do patients bear a growing share of medication costs?**

All findings should be interpreted in the context of the synthetic nature of the dataset and the distinction between payer-uncovered costs and actual patient spending.
