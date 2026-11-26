# Percent of cost covered by insurance for single-dispense medications
# Data: Synthea Massachusetts sample from github.com/Shiv0309/growing-cost-of-care
# Uses base R only (no packages needed).
#
# Definition (matches the repo's docs/methodology.md):
#   percent covered = PAYER_COVERAGE / TOTALCOST * 100
# Only records with DISPENSES == 1 are used. In Synthea, PAYER_COVERAGE is the
# amount covered per dispense while TOTALCOST = BASE_COST x DISPENSES, so the two
# columns are only comparable when there is exactly one dispense.

# ---- Settings ---------------------------------------------------------------
# Reads straight from GitHub. 
data_dir <- "C:/Users/ktchi/Downloads/growing-cost-of-care/data/synthea_sample_data_csv_latest"
out_dir  <- "."

# ---- Load -------------------------------------------------------------------
read_csv_utf8 <- function(name) {
  read.csv(file.path(data_dir, name), stringsAsFactors = FALSE,
           fileEncoding = "UTF-8-BOM", check.names = FALSE)
}
meds   <- read_csv_utf8("medications.csv")
payers <- read_csv_utf8("payers.csv")[, c("Id", "NAME")]
names(payers) <- c("PAYER", "payer_name")

# ---- Keep single-dispense records -------------------------------------------
single <- meds[meds$DISPENSES == 1 & meds$TOTALCOST > 0, ]
single <- merge(single, payers, by = "PAYER", all.x = TRUE, sort = FALSE)
single$pct_covered <- 100 * single$PAYER_COVERAGE / single$TOTALCOST

# ---- 1. One row per single-dispense record ----------------------------------
record_level <- single[order(single$DESCRIPTION, single$START),
                       c("PATIENT", "payer_name", "CODE", "DESCRIPTION", "START", "STOP",
                         "TOTALCOST", "PAYER_COVERAGE", "pct_covered")]
names(record_level) <- c("patient_id", "payer", "medication_code", "medication",
                         "start", "stop", "total_cost", "payer_coverage", "pct_covered")

# ---- 2. One row per medication ----------------------------------------------
# pct_covered is cost-weighted: sum(coverage) / sum(cost) for that medication.
by_med <- split(single, single$DESCRIPTION)
medication_level <- do.call(rbind, lapply(by_med, function(d) {
  data.frame(
    medication     = d$DESCRIPTION[1],
    medication_code = d$CODE[1],
    n_records      = nrow(d),
    n_patients     = length(unique(d$PATIENT)),
    total_cost     = sum(d$TOTALCOST),
    payer_coverage = sum(d$PAYER_COVERAGE),
    pct_covered    = 100 * sum(d$PAYER_COVERAGE) / sum(d$TOTALCOST),
    stringsAsFactors = FALSE
  )
}))
medication_level <- medication_level[order(-medication_level$pct_covered,
                                           -medication_level$n_records), ]
rownames(medication_level) <- NULL

# ---- Save and print ---------------------------------------------------------
write.csv(record_level,     file.path(out_dir, "single_dispense_record_coverage.csv"),
          row.names = FALSE)
write.csv(medication_level, file.path(out_dir, "single_dispense_medication_coverage.csv"),
          row.names = FALSE)

overall <- 100 * sum(single$PAYER_COVERAGE) / sum(single$TOTALCOST)
cat(sprintf("Single-dispense records: %d (%d medications, %d patients)\n",
            nrow(single), nrow(medication_level), length(unique(single$PATIENT))))
cat(sprintf("Overall percent covered (single-dispense): %.1f%%\n\n", overall))
preview <- head(medication_level, 15)
preview$medication <- substr(preview$medication, 1, 50)   # console preview only
print(preview[, c("medication", "n_records", "n_patients", "pct_covered")],
      row.names = FALSE, digits = 4)

# ---- 3. Median costs and each patient's contribution ------------------------
total_cost_all <- sum(single$TOTALCOST)
by_pat <- split(single, single$PATIENT)
patient_level <- do.call(rbind, lapply(names(by_pat), function(id) {
  d <- by_pat[[id]]
  data.frame(
    patient_id     = id,
    n_records      = nrow(d),
    total_cost     = sum(d$TOTALCOST),
    payer_coverage = sum(d$PAYER_COVERAGE),
    pct_covered    = 100 * sum(d$PAYER_COVERAGE) / sum(d$TOTALCOST),  # patient's own rate
    stringsAsFactors = FALSE
  )
}))
patient_level$pct_of_records <- 100 * patient_level$n_records / nrow(single)
patient_level$pct_of_cost    <- 100 * patient_level$total_cost / total_cost_all
# Contribution in percentage points: these add up to the overall percent covered
patient_level$contribution_pts <- 100 * patient_level$payer_coverage / total_cost_all
patient_level <- patient_level[order(-patient_level$contribution_pts), ]
patient_level$cumulative_pts <- cumsum(patient_level$contribution_pts)
rownames(patient_level) <- NULL

write.csv(patient_level, file.path(out_dir, "single_dispense_patient_contribution.csv"),
          row.names = FALSE)

cat("\n---- Median costs (single-dispense) ----\n")
cat(sprintf("Median cost per record:               $%.2f\n", median(single$TOTALCOST)))
cat(sprintf("Median total cost per patient:        $%.2f\n", median(patient_level$total_cost)))
cat(sprintf("Median per-patient percent covered:   %.1f%%\n", median(patient_level$pct_covered)))

cat("\n---- Patient contribution to the overall percent ----\n")
cat(sprintf("Overall percent covered: %.1f%% = sum of every patient's contribution (%.1f pts)\n",
            overall, sum(patient_level$contribution_pts)))
top <- patient_level[1, ]
rest <- patient_level[-1, ]
cat(sprintf("Largest patient: %.0f%% of records, %.0f%% of cost, contributes %.1f of %.1f pts\n",
            top$pct_of_records, top$pct_of_cost, top$contribution_pts, overall))
cat(sprintf("Overall percent without that patient: %.1f%%\n",
            100 * sum(rest$payer_coverage) / sum(rest$total_cost)))
cat(sprintf("Top 5 patients contribute %.1f of %.1f pts\n\n",
            patient_level$cumulative_pts[5], overall))
pv <- head(patient_level, 10)
pv$patient_id <- substr(pv$patient_id, 1, 8)    # shortened for the console only
print(pv[, c("patient_id", "n_records", "total_cost", "pct_covered",
             "pct_of_cost", "contribution_pts", "cumulative_pts")],
      row.names = FALSE, digits = 3)
