> Source: https://www.1password.dev/cli/app-integration/



Sign in


# Use the 1Password desktop app to sign in to 1Password CLI


Turn on the 1Password app integration to sign in to 1Password CLI with Touch ID, Windows Hello, or Linux system authentication, and fix common sign-in problems.


- Seamlessly sign to the 1Password accounts you’ve added to the app in your terminal.
- Authenticate 1Password CLI the same way you unlock your device, like with your fingerprint, face, Apple Watch, Windows Hello PIN, or device user password.
- Track recent 1Password CLI activity from your 1Password app.


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


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


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="https://1password.com/downloads/mac" class="link" target="_blank" rel="noreferrer">1Password for Mac</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="https://1password.com/downloads/windows" class="link" target="_blank" rel="noreferrer">1Password for Windows</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="https://1password.com/downloads/linux" class="link" target="_blank" rel="noreferrer">1Password for Linux</a>
- <a href="https://gitlab.freedesktop.org/polkit/polkit" class="link" target="_blank" rel="noreferrer">PolKit</a> (included in many popular distributions)
- A PolKit authentication agent running


## <a href="#set-up-the-app-integration" class="anchor-link" aria-label="Navigate to header: Set up the app integration"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">Set up the app integration</span>

### <a href="#step-1-turn-on-the-app-integration" class="anchor-link" aria-label="Navigate to header: Step 1: Turn on the app integration"></a><span id="_R_d9deehkd74t9_" class="cursor-pointer">Step 1: Turn on the app integration</span>


- <div id="mac-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux-2">

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


### <a href="#step-2-enter-any-command-to-sign-in" class="anchor-link" aria-label="Navigate to header: Step 2: Enter any command to sign in"></a><span id="_R_h9deehkd74t9_" class="cursor-pointer">Step 2: Enter any command to sign in</span>


``` shiki
op vault list
```


#### <a href="#if-you-have-multiple-accounts" class="anchor-link" aria-label="Navigate to header: If you have multiple accounts"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">If you have multiple accounts</span>


``` shiki
op vault ls --account my.1password.com
```


### <a href="#optional-remove-previously-added-account-details" class="anchor-link" aria-label="Navigate to header: Optional: Remove previously added account details"></a><span id="_R_159deehkd74t9_" class="cursor-pointer">Optional: Remove previously added account details</span>


- `~/.op/config`
- `~/.config/op/config`
- `~/.config/.op/config`


``` shiki
op account forget --all
```


### <a href="#optional-set-the-biometric-unlock-environment-variable" class="anchor-link" aria-label="Navigate to header: Optional: Set the biometric unlock environment variable"></a><span id="_R_1j9deehkd74t9_" class="cursor-pointer">Optional: Set the biometric unlock environment variable</span>


Bash, Zsh, sh


fish


PowerShell


``` shiki
export OP_BIOMETRIC_UNLOCK_ENABLED=true
```


set -x OP_BIOMETRIC_UNLOCK_ENABLED true


\$Env:OP_BIOMETRIC_UNLOCK_ENABLED = "true"


Bash, Zsh, sh


fish


PowerShell


``` shiki
export OP_BIOMETRIC_UNLOCK_ENABLED=false
```


set -x OP_BIOMETRIC_UNLOCK_ENABLED false


\$Env:OP_BIOMETRIC_UNLOCK_ENABLED = "false"


## <a href="#track-1password-cli-activity" class="anchor-link" aria-label="Navigate to header: Track 1Password CLI activity"></a><span id="_R_219deehkd74t9_" class="cursor-pointer">Track 1Password CLI activity</span>


1.  Open and unlock the 1Password desktop app.
2.  Select **Developer** in the sidebar.
3.  Select **View CLI**.


## <a href="#troubleshooting" class="anchor-link" aria-label="Navigate to header: Troubleshooting"></a><span id="_R_2b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Troubleshooting</span>

### <a href="#if-you’re-prompted-for-your-secret-key-instead-of-your-fingerprint" class="anchor-link" aria-label="Navigate to header: If you’re prompted for your Secret Key instead of your fingerprint"></a><span id="_R_2d9deehkd74t9_" class="cursor-pointer">If you’re prompted for your Secret Key instead of your fingerprint</span>


- **Integrate with 1Password CLI** is turned on in the app under **Settings \> Developer**.
- Your device isn’t managed by an organization policy that restricts the app integration — if it is, check with your 1Password administrator.

### <a href="#if-op-signin-doesn’t-list-your-account" class="anchor-link" aria-label="Navigate to header: If op signin doesn’t list your account"></a><span id="_R_2j9deehkd74t9_" class="cursor-pointer">If `op signin` doesn’t list your account</span>


### <a href="#if-you-see-“no-accounts-configured”-on-macos-27-golden-gate" class="anchor-link" aria-label="Navigate to header: If you see “No accounts configured” on macOS 27 Golden Gate"></a><span id="_R_2n9deehkd74t9_" class="cursor-pointer">If you see “No accounts configured” on macOS 27 Golden Gate</span>


1.  Open **System Settings** \> **Privacy & Security** \> **Files & Folders**.
2.  Select the app you use to run commands, like Terminal, iTerm, or Ghostty. If you use a terminal built into an editor, like Visual Studio Code or Cursor, select the editor.
3.  Turn on the setting that starts with “Data shared by 1Password”. The rest of the name depends on which 1Password apps you’ve installed.
4.  Quit and reopen your terminal, then try your command again.


### <a href="#if-you-see-a-lost-connection-no-accounts-configured-or-connection-reset-error" class="anchor-link" aria-label="Navigate to header: If you see a lost connection, no accounts configured, or connection reset error"></a><span id="_R_319deehkd74t9_" class="cursor-pointer">If you see a lost connection, no accounts configured, or connection reset error</span>


- <div id="mac-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


1.  Open and unlock the 1Password desktop app.
2.  Select your account or collection at the top of the sidebar.
3.  Select **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>** and make sure **Integrate with 1Password CLI** is selected.


3.  Select **Settings** \> **General**.
4.  Make sure “Keep 1Password in the menu bar” is selected.


1.  Open and unlock the 1Password desktop app.
2.  Select your account or collection at the top of the sidebar.
3.  Select **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>** and make sure **Integrate with 1Password CLI** is selected.


1.  Open and unlock the 1Password desktop app.
2.  Select your account or collection at the top of the sidebar.
3.  Select **Settings** \> **General**.
4.  Make sure “Keep 1Password in the notification area” is selected.


1.  Open and unlock the 1Password desktop app.
2.  Select your account or collection at the top of the sidebar.
3.  Select **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>** and make sure **Integrate with 1Password CLI** is selected.


1.  Open and unlock the 1Password desktop app.
2.  Select your account or collection at the top of the sidebar.
3.  Select **Settings** \> **General**.
4.  Make sure “Keep 1Password in the system tray” is selected.


- <div id="mac-4">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows-4">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux-4">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


Open **System Settings** \> **General** \> **Login Items** and make sure **Allow in background** is turned on for 1Password.


1.  Make sure you’re using the latest version of the 1Password desktop app.
2.  Restart the app.


1.  Make sure you’re using the latest version of the 1Password desktop app.
2.  Restart the app.


1.  Make sure you’re using the latest version of the 1Password desktop app.
2.  Restart the app.


### <a href="#if-you-aren’t-prompted-to-authenticate-with-your-preferred-method" class="anchor-link" aria-label="Navigate to header: If you aren’t prompted to authenticate with your preferred method"></a><span id="_R_3b9deehkd74t9_" class="cursor-pointer">If you aren’t prompted to authenticate with your preferred method</span>


- <div id="mac-5">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows-5">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux-5">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


1.  Make sure you’ve set up <a href="https://support.1password.com/system-authentication-linux/" class="link" target="_blank" rel="noreferrer">system authentication</a> to unlock 1Password on your Linux computer.
2.  Update the authentication method in your Linux settings to use a <a href="https://help.ubuntu.com/stable/ubuntu-help/session-fingerprint.html.en" class="link" target="_blank" rel="noreferrer">fingerprint</a> or other biometrics instead of your Linux user password.


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_3h9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/use-multiple-accounts/" class="link">Use multiple 1Password accounts with 1Password CLI</a>
- <a href="https://support.1password.com/add-account/" class="link" target="_blank" rel="noreferrer">Add accounts to the 1Password app</a>
- <a href="/cli/app-integration-security/" class="link">1Password app integration security</a>


Was this page helpful?


