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
# Reads straight from GitHub. If you cloned the repo, point this at the local
# folder instead, e.g. "growing-cost-of-care/data/synthea_sample_data_csv_latest"
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