
# R Package Dependencies

This project includes R scripts and R Markdown documents for data analysis and visualization.

## Required Packages

The following packages are used across the individual and group R scripts:

| Package | Purpose |
|---|---|
| `tidyverse` | Data manipulation, cleaning, and visualization |
| `lubridate` | Date and time calculations |
| `here` | Project-relative file paths |
| `patchwork` | Combining visualizations |
| `scales` | Formatting visualization scales and percentages |
| `janitor` | Cleaning column names |
| `ggplot2` | Creating visualizations |

## Installation

Install the required packages in R:

```r
install.packages(c(
  "tidyverse",
  "lubridate",
  "here",
  "patchwork",
  "scales",
  "janitor",
  "ggplot2"
))
```

## R Markdown Rendering

Some project files use R Markdown.

Additional packages for rendering include:

```r
install.packages(c("rmarkdown", "knitr"))
```

The PDF output format may also require a LaTeX installation. HTML output does not require LaTeX.

## Notes

- `tidyverse` includes several packages used by the project, including `dplyr`, `readr`, `tidyr`, and `ggplot2`.
- The group-level single-dispense coverage analysis uses base R and does not require additional packages.
- Python dependencies are documented separately in `requirements.txt`.
