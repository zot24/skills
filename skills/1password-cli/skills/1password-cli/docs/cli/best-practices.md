<!-- Source: https://www.1password.dev/cli/best-practices/ -->

# 1Password CLI Best Practices

## Overview

1Password CLI brings command-line access to 1Password capabilities. The documentation recommends several key practices for secure and effective usage.

## Key Recommendations

### Keep Software Current

Maintain up-to-date installations by regularly checking for available updates using the `op update` command. This helps ensure access to security patches and new features.

### Apply Least Privilege Principles

Service Accounts enable restricted access to specific items needed for particular tasks. Best practice involves:
- Using dedicated vaults scoped to service accounts
- Limiting vault access to only what's necessary
- Avoiding over-provisioning permissions

The documentation references NIST's principle of least privilege and points to additional resources on managing group and vault permissions.

### Secure Secret Creation

When using `op item create` to generate items containing sensitive data, employ JSON template files rather than entering values directly in commands. This approach helps protect sensitive information during item creation workflows, since command arguments can be visible to other processes on the machine.

### Other Tips

- Use unique IDs instead of names in scripts and automation — they're more stable and reduce the number of API requests (important for service-account rate limits).
- Use `op run` (which masks secrets in output by default) rather than printing secrets directly.
- Delete files produced by `op inject --out-file` once they're no longer needed.
- Assume processes run by the same user can read each other's environment; be cautious passing secrets as environment variables.
