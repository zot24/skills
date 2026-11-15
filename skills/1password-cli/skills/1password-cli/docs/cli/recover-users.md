> Source: https://www.1password.dev/cli/recover-users/



Manage team members


# Recover accounts using 1Password CLI


- They’ll receive a new Secret Key and create a new 1Password account password.  
  <span class="small">If your team uses Unlock with SSO, they’ll be able to [link a new app or browser to their account](https://support.1password.com/sso-linked-apps-browsers/) again.</span>
- They’ll be able to access all the data they had before.
- They’ll need to sign in again on all their devices once recovery is complete.
- Their two-factor authentication will be reset.

## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>

- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a> version `2.32.0` or later.


- You’re a team <a href="https://support.1password.com/groups/#administrators" class="link" target="_blank" rel="noreferrer">administrator</a> or <a href="https://support.1password.com/groups/#owners" class="link" target="_blank" rel="noreferrer">owner</a>.
- You belong to a <a href="https://support.1password.com/custom-groups/" class="link" target="_blank" rel="noreferrer">custom group</a> that has the “Recover Accounts” permission.
- You’re a <a href="https://support.1password.com/family-organizer/" class="link" target="_blank" rel="noreferrer">family organizer</a>.

## <a href="#begin-recovery" class="anchor-link" aria-label="Navigate to header: Begin recovery"></a><span id="_R_d9deehkd74t9_" class="cursor-pointer">Begin recovery</span>


``` shiki
op user recovery begin { <email> | <name> | <userID> }
```


``` shiki
op user recovery begin ZMAE4RTRONHN7LGELNYYO373KM WHPOFIMMYFFITBVTOTZUR3R324 FGH76DFS89FYCU6342CSDWIFJU
```


## <a href="#complete-recovery" class="anchor-link" aria-label="Navigate to header: Complete recovery"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">Complete recovery</span>


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_v9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/provision-users" class="link">Add and remove team members</a>
- <a href="/cli/grant-revoke-vault-permissions" class="link">Grant and revoke vault permissions</a>
- <a href="https://support.1password.com/after-recovery/" class="link" target="_blank" rel="noreferrer">Sign back in to 1Password after your account has been recovered</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>


Was this page helpful?


