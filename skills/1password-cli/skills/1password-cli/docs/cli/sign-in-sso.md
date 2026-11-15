> Source: https://www.1password.dev/cli/sign-in-sso/



Sign in


# Unlock 1Password CLI with SSO


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


1.  <a href="https://support.1password.com/explore/team-member/" class="link" target="_blank" rel="noreferrer">Join your team</a>, or <a href="https://support.1password.com/sso-get-started/" class="link" target="_blank" rel="noreferrer">switch to unlock with SSO</a>.
2.  Install the latest version of 1Password for <a href="https://1password.com/downloads/mac" class="link" target="_blank" rel="noreferrer">Mac</a>, <a href="https://1password.com/downloads/windows" class="link" target="_blank" rel="noreferrer">Windows</a>, or <a href="https://1password.com/downloads/linux" class="link" target="_blank" rel="noreferrer">Linux</a>.
3.  Sign in to 1Password for <a href="https://support.1password.com/sso-sign-in/#in-the-apps/" class="link" target="_blank" rel="noreferrer">Mac</a>, <a href="https://support.1password.com/sso-sign-in/#in-the-apps/" class="link" target="_blank" rel="noreferrer">Windows</a>, or <a href="https://support.1password.com/sso-sign-in/#in-the-apps/" class="link" target="_blank" rel="noreferrer">Linux</a> using SSO.
4.  Install <a href="/cli/get-started/" class="link">the latest Password CLI build</a>.


## <a href="#step-1-connect-1password-cli-with-the-1password-app" class="anchor-link" aria-label="Navigate to header: Step 1: Connect 1Password CLI with the 1Password app"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">Step 1: Connect 1Password CLI with the 1Password app</span>


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **Developer**. <span class="small"><a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Open Developer settings</a> if 1Password is installed on this device.</span>
4.  Select **Integrate with 1Password CLI**.
5.  If you want to authenticate 1Password CLI with your fingerprint, turn on **<a href="https://support.1password.com/touch-id-mac/" class="link" target="_blank" rel="noreferrer">Touch ID</a>** in the app.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Turn on **<a href="https://support.1password.com/windows-hello/" class="link" target="_blank" rel="noreferrer">Windows Hello</a>** in the app.
4.  Navigate to **Settings** \> **Developer**. <span class="small"><a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Open Developer settings</a> if 1Password is installed on this device.</span>
5.  Select **Integrate with 1Password CLI**.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **Security**. <span class="small"><a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Open Security settings</a> if 1Password is installed on this device.</span>
4.  Turn on **<a href="https://support.1password.com/system-authentication-linux/" class="link" target="_blank" rel="noreferrer">Unlock using system authentication</a>**.
5.  Navigate to **Settings** \> **Developer**. <span class="small"><a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Open Developer settings</a> if 1Password is installed on this device.</span>
6.  Select **Integrate with 1Password CLI**.


## <a href="#step-2-sign-in-with-sso" class="anchor-link" aria-label="Navigate to header: Step 2: Sign in with SSO"></a><span id="_R_l9deehkd74t9_" class="cursor-pointer">Step 2: Sign in with SSO</span>


``` shiki
op signin
```


``` shiki
Select account  [Use arrows to move, type to filter]
> ACME Corp (acme.1password.com)
  AgileBits (agilebits.1password.com)
  Add another account
```


## <a href="#troubleshooting" class="anchor-link" aria-label="Navigate to header: Troubleshooting"></a><span id="_R_119deehkd74t9_" class="min-w-0 break-words cursor-pointer">Troubleshooting</span>

- **Prompted for a Secret Key instead of SSO?** This means the CLI is trying to sign in directly instead of through the app integration. Confirm the app integration is turned on (Step 1), then try again.
- **If the account doesn’t allow biometric unlock**, you’ll be prompted to allow 1Password CLI access to the 1Password app the first time you sign in instead of using your fingerprint.
- **Managed devices**: your organization’s administrator controls who has 1Password Unlock with SSO turned on. If you don’t see the option, check with your administrator.

## <a href="#get-help" class="anchor-link" aria-label="Navigate to header: Get help"></a><span id="_R_159deehkd74t9_" class="cursor-pointer">Get help</span>


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_199deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="https://support.1password.com/sso/" class="link" target="_blank" rel="noreferrer">Set up 1Password Unlock with SSO</a>
- <a href="https://support.1password.com/sso-get-started/" class="link" target="_blank" rel="noreferrer">Get started with 1Password Unlock with SSO</a>
- <a href="https://support.1password.com/sso-sign-in/" class="link" target="_blank" rel="noreferrer">Sign in to 1Password with SSO</a>
- <a href="https://support.1password.com/sso-linked-apps-browsers/" class="link" target="_blank" rel="noreferrer">Link new apps and browsers to unlock with SSO</a>
- <a href="https://support.1password.com/sso-troubleshooting/" class="link" target="_blank" rel="noreferrer">If you’re having trouble unlocking 1Password with SSO</a>


Was this page helpful?


