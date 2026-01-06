# Microsoft 365 – Identity, Security & Automation (Portfolio)

This repository demonstrates practical experience with Microsoft 365 administration,
identity management (Entra ID) and automation using PowerShell.

## What’s inside
- **Entra ID**: automated user provisioning from CSV, group creation
- **Licensing**: group-based licensing approach (documented)
- **Exchange Online**: mailbox delegation (Send As / Send on behalf)
- **Operations mindset**: repeatable scripts, input validation, and safe defaults

> All scripts are sanitized for portfolio use. No production data or secrets are included.

## Structure
- `scripts/00-connect/` – connect helpers (Graph / Exchange Online)
- `scripts/01-identity/` – users, groups, sample CSV
- `scripts/02-exchange/` – delegation / mailbox tasks
- `docs/` – short notes and design decisions

## How to run (high level)
1. Connect to Microsoft Graph / Exchange Online using the scripts in `scripts/00-connect/`
2. Use `Users.sample.csv` as input for provisioning
3. Run identity scripts, then Exchange scripts

## Disclaimer
These scripts are provided as-is for demonstration purposes.
