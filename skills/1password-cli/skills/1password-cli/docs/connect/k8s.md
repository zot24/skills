> Source: https://www.1password.dev/connect/k8s/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Integrations


Use Kubernetes integrations with a 1Password Connect server


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Integrations


# Use Kubernetes integrations with a 1Password Connect server


## Securing secrets across your full deployment stack?


## 


<a href="#comparison" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| **Feature**                                                 | <a href="#kubernetes-injector" class="link"><strong>Kubernetes Injector</strong></a> | <a href="#kubernetes-operator" class="link"><strong>Kubernetes Operator</strong></a> |
|-------------------------------------------------------------|--------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------|
| Supports service accounts                                   | <span class="badge badge--primary">Yes</span>                                        | <span class="badge badge--primary">Yes</span>                                        |
| Supports Connect servers                                    | <span class="badge badge--primary">Yes</span>                                        | <span class="badge badge--primary">Yes</span>                                        |
| Allows for granular selection of secrets                    | <span class="badge badge--primary">Yes</span>                                        | <span class="badge badge--secondary">No</span>                                       |
| Uses Kubernetes Secrets                                     | <span class="badge badge--secondary">No</span>                                       | <span class="badge badge--primary">Yes</span>                                        |
| Injects 1Password items directly into Kubernetes pods       | <span class="badge badge--primary">Yes</span>                                        | <span class="badge badge--secondary">No</span>                                       |
| Works with multiple credentials simultaneously              | <span class="badge badge--primary">Yes</span>                                        | <span class="badge badge--secondary">No</span>                                       |
| Supports automatic redeployment when 1Password items change | <span class="badge badge--secondary">No</span>                                       | <span class="badge badge--primary">Yes</span>                                        |
| Requires a Connect token to deploy                          | <span class="badge badge--secondary">No</span>                                       | <span class="badge badge--primary">Yes</span>                                        |


### 


<a href="#kubernetes-injector" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#kubernetes-operator" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- Create Kubernetes Secrets from 1Password items and load them into Kubernetes deployments.
- Automatically restart deployments when 1Password items update.

### 


<a href="#1password-helm-charts" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Related topics

<a href="/secrets-automation/k8s" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use Kubernetes integrations with 1Password service accounts</span></a><a href="/connect/get-started" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Get started with a 1Password Connect server</span></a><a href="/connect/ci-cd" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use CI/CD integrations with a 1Password Connect server</span></a>


Was this page helpful?


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


