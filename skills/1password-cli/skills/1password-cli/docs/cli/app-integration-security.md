> Source: https://www.1password.dev/cli/app-integration-security/



Reference


# 1Password app integration security


## <a href="#security-model" class="anchor-link" aria-label="Navigate to header: Security model"></a><span id="_R_19deehkd74t9_" class="cursor-pointer">Security model</span>


## <a href="#authorization-model" class="anchor-link" aria-label="Navigate to header: Authorization model"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">Authorization model</span>


- On macOS and Linux, authorization is confined to a terminal session but extends to sub-shell processes in that window.
- On Windows, commands executed in a sub-shell require separate authorization.

## <a href="#accepted-risks" class="anchor-link" aria-label="Navigate to header: Accepted risks"></a><span id="_R_j9deehkd74t9_" class="cursor-pointer">Accepted risks</span>

- A user or application with root/administrator level privileges on the same system may be able to circumvent one or more security measures and could obtain access to 1Password accounts through 1Password CLI without authorization if (and only if) the 1Password app is unlocked.
- Applications that are granted accessibility permissions on macOS may be able to circumvent the authorization prompt.

## <a href="#technical-design" class="anchor-link" aria-label="Navigate to header: Technical design"></a><span id="_R_n9deehkd74t9_" class="cursor-pointer">Technical design</span>

### <a href="#session-credentials" class="anchor-link" aria-label="Navigate to header: Session credentials"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">Session credentials</span>


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>

- <div id="windows">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>


### <a href="#how-does-1password-cli-communicate-with-the-1password-app" class="anchor-link" aria-label="Navigate to header: How does 1Password CLI communicate with the 1Password app?"></a><span id="_R_v9deehkd74t9_" class="cursor-pointer">How does 1Password CLI communicate with the 1Password app?</span>


- <div id="mac-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="linux-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>

- <div id="windows-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>


### <a href="#authorization-prompts" class="anchor-link" aria-label="Navigate to header: Authorization prompts"></a><span id="_R_159deehkd74t9_" class="cursor-pointer">Authorization prompts</span>


- <div id="mac-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="linux-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>

- <div id="windows-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>


Was this page helpful?


