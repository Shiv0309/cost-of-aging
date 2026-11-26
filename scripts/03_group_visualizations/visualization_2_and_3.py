"""Print cost-weighted coverage for single-dispense medications by age."""

from sample_coverage_by_age_and_payer import SAMPLE_DIR, coverage_totals


def main():
    groups, payer_names = coverage_totals(
        SAMPLE_DIR, ("<18", "18-54", "55+"), (18, 55), single_dispense_only=True,
    )
    older = [(payer, total) for (age, payer), total in groups.items() if age == "55+"]
    if not older:
        raise ValueError("No single-dispense medication records found for patients aged 55+.")

    for payer, total in sorted(older, key=lambda item: (payer_names.get(item[0], ""), item[0])):
        name = payer_names.get(payer) or payer or "Unknown payer"
        share = f"{total.coverage / total.cost:.2%}" if total.cost and total.coverage is not None else "No data"
        print(f"{name}: {share}")

    cost = sum(total.cost or 0 for _, total in older)
    coverage = [total.coverage for _, total in older if total.coverage is not None]
    share = f"{sum(coverage) / cost:.2%}" if cost and coverage else "No data"
    print(f"All payer types: {share}")

    print("\nSingle-dispense coverage by age (all payer types):")
    ages = ["<18", "18-54", "55+"]
    ages.extend(age for age in ("Invalid Age", "Unknown") if any(key[0] == age for key in groups))
    for age in [*ages, "All records"]:
        totals = [total for (group, _), total in groups.items()
                  if age == "All records" or group == age]
        cost = sum(total.cost or 0 for total in totals)
        coverage = [total.coverage for total in totals if total.coverage is not None]
        if coverage and any(total.cost is not None for total in totals):
            share = f"{sum(coverage) / cost:.2%}" if cost else "No data"
            print(f"{age}: ${sum(coverage):,.2f} of ${cost:,.2f} covered ({share})")
        else:
            print(f"{age}: No data")


if __name__ == "__main__":
    main()
