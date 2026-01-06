# Security Considerations

## Access control
- All access is group-based
- No direct license assignment to users
- Admin roles should be protected with MFA and PIM

## Automation safety
- Scripts do not store credentials
- Interactive authentication only
- Input data is validated before execution

## Logging and audit
- Actions are visible in Entra ID and Exchange audit logs
- Automation supports traceability and repeatability

## Portfolio disclaimer
All scripts in this repository are sanitized and intended for demonstration.
They must be adapted and reviewed before production use.
