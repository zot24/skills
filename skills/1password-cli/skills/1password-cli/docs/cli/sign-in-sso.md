> Source: https://www.1password.dev/cli/sign-in-sso/



Sign in


# Unlock 1Password CLI with SSO


Copy page


Copy page


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://support.1password.com/explore/team-member/" class="link" target="_blank" rel="noreferrer">Join your team</a>, or <a href="https://support.1password.com/sso-get-started/" class="link" target="_blank" rel="noreferrer">switch to unlock with SSO</a>.
2.  Install the latest version of 1Password for <a href="https://1password.com/downloads/mac" class="link" target="_blank" rel="noreferrer">Mac</a>, <a href="https://1password.com/downloads/windows" class="link" target="_blank" rel="noreferrer">Windows</a>, or <a href="https://1password.com/downloads/linux" class="link" target="_blank" rel="noreferrer">Linux</a>.
3.  Sign in to 1Password for <a href="https://support.1password.com/sso-sign-in/#in-the-apps/" class="link" target="_blank" rel="noreferrer">Mac</a>, <a href="https://support.1password.com/sso-sign-in/#in-the-apps/" class="link" target="_blank" rel="noreferrer">Windows</a>, or <a href="https://support.1password.com/sso-sign-in/#in-the-apps/" class="link" target="_blank" rel="noreferrer">Linux</a> using SSO.
4.  Install <a href="/cli/get-started" class="link">the latest Password CLI build</a>.

## 


<a href="#step-1-connect-1password-cli-with-the-1password-app" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Linux">

  Linux

  </div>

  </div>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
4.  Select **Integrate with 1Password CLI**.
5.  If you want to authenticate 1Password CLI with your fingerprint, turn on **<a href="https://support.1password.com/touch-id-mac/" class="link" target="_blank" rel="noreferrer">Touch ID</a>** in the app.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Turn on **<a href="https://support.1password.com/windows-hello/" class="link" target="_blank" rel="noreferrer">Windows Hello</a>** in the app.
4.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
5.  Select **Integrate with 1Password CLI**.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Security</a>**.
4.  Turn on **<a href="https://support.1password.com/system-authentication-linux/" class="link" target="_blank" rel="noreferrer">Unlock using system authentication</a>**.
5.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
6.  Select **Integrate with 1Password CLI**.


## 


<a href="#step-2-sign-in-with-sso" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op signin
```


``` shiki
Select account  [Use arrows to move, type to filter]
> ACME Corp (acme.1password.com)
  AgileBits (agilebits.1password.com)
  Add another account
```


## 


<a href="#get-help" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://support.1password.com/sso/" class="link" target="_blank" rel="noreferrer">Set up 1Password Unlock with SSO</a>
- <a href="https://support.1password.com/sso-get-started/" class="link" target="_blank" rel="noreferrer">Get started with 1Password Unlock with SSO</a>
- <a href="https://support.1password.com/sso-sign-in/" class="link" target="_blank" rel="noreferrer">Sign in to 1Password with SSO</a>
- <a href="https://support.1password.com/sso-linked-apps-browsers/" class="link" target="_blank" rel="noreferrer">Link new apps and browsers to unlock with SSO</a>
- <a href="https://support.1password.com/sso-troubleshooting/" class="link" target="_blank" rel="noreferrer">If you’re having trouble unlocking 1Password with SSO</a>


Was this page helpful?


<a href="/cli/sign-in-manually" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Sign in manually</span></a><a href="/cli/sign-in-sso-azure" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Sign in with Microsoft</span></a>


