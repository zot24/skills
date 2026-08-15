> Source: https://www.1password.dev/cli/recover-users/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Manage team members


Recover accounts using 1Password CLI


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Manage team members


# Recover accounts using 1Password CLI


- They’ll receive a new Secret Key and create a new 1Password account password.  
- They’ll be able to access all the data they had before.
- They’ll need to sign in again on all their devices once recovery is complete.
- Their two-factor authentication will be reset.

## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a> version `2.32.0` or later.


- You’re a team <a href="https://support.1password.com/groups/#administrators" class="link" target="_blank" rel="noreferrer">administrator</a> or <a href="https://support.1password.com/groups/#owners" class="link" target="_blank" rel="noreferrer">owner</a>.
- You belong to a <a href="https://support.1password.com/custom-groups/" class="link" target="_blank" rel="noreferrer">custom group</a> that has the “Recover Accounts” permission.
- You’re a <a href="https://support.1password.com/family-organizer/" class="link" target="_blank" rel="noreferrer">family organizer</a>.

## 


<a href="#begin-recovery" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op user recovery begin { <email> | <name> | <userID> }
```


``` shiki
op user recovery begin ZMAE4RTRONHN7LGELNYYO373KM WHPOFIMMYFFITBVTOTZUR3R324 FGH76DFS89FYCU6342CSDWIFJU
```


## 


<a href="#complete-recovery" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/provision-users" class="link">Add and remove team members</a>
- <a href="/cli/grant-revoke-vault-permissions" class="link">Grant and revoke vault permissions</a>
- <a href="https://support.1password.com/after-recovery/" class="link" target="_blank" rel="noreferrer">Sign back in to 1Password after your account has been recovered</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>
- <a href="/get-started/administrator-quickstart" class="link">Administrator quickstart</a>


Related topics

<a href="/service-accounts/use-with-1password-cli" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use service accounts with 1Password CLI</span></a><a href="/cli/reference/management-commands/user" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">user</span></a><a href="/cli/provision-users" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Add and remove team members</span></a>


Was this page helpful?


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


