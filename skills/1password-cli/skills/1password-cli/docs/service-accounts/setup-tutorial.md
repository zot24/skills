> Source: https://www.1password.dev/service-accounts/setup-tutorial/


> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Service accounts


Use service accounts with 1Password SDKs


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/tutorials" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Tutorials</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Service accounts


# Use service accounts with 1Password SDKs


- Create a new test vault in your 1Password account.
- Create a service account that can only access the test vault.
- Save a secret in the test vault.
- Set up your project, and install and configure the 1Password JS SDK.
- Get a secret reference URI that points to the test secret you created.
- Build a simple application that takes the secret reference as input and outputs the actual secret.


## 


<a href="#prerequisites" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>.
2.  (Optional) <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.
3.  Basic knowledge of JavaScript.

## 


<a href="#part-1-set-up-a-1password-service-account" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#step-1-create-a-new-vault" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.
2.  Select the plus icon in the sidebar next to your account name.
3.  Enter `Tutorial` for the vault name, then select **Create**.


### 


<a href="#step-2-create-a-service-account" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p"><a href="https://start.1password.com/signin" class="link" target="_blank" rel="noreferrer">Sign in</a> to your account on 1Password.com.</span>
2.  <span data-as="p">Select <a href="https://start.1password.com/developer-tools/directory" class="link" target="_blank" rel="noreferrer"><strong>Developer</strong></a> in the sidebar. Or, if you already have active applications and services, select **Directory** at the top of the Developer page.</span>
3.  <span data-as="p">Under Access Tokens, select **Service Account**. If you don’t see the option to create service accounts, ask your administrator to <a href="/service-accounts/manage-service-accounts#manage-who-can-create-service-accounts" class="link">give you access to create and manage service accounts</a>.</span>
4.  <span data-as="p">Give your service account a name. For this tutorial, use `Temp Service Account`.</span>
    <div>

    <div class="frame p-2 not-prose relative bg-gray-50/50 rounded-2xl overflow-hidden dark:bg-gray-800/25 print:print-color-exact" data-name="frame">

    <div class="absolute inset-0 bg-grid-neutral-200/20 [mask-image:linear-gradient(0deg,#fff,rgba(255,255,255,0.6))] dark:bg-grid-white/5 dark:[mask-image:linear-gradient(0deg,rgba(255,255,255,0.1),rgba(255,255,255,0.5))] print:print-color-exact" style="background-position:10px 10px">

    </div>

    <div class="relative rounded-xl overflow-hidden flex justify-center [&_:where(img:not([class*=rounded-]))]:rounded-xl">

    <span class="zoom-image-trigger contents cursor-zoom-in" ramka-trigger=""><span class="contents"><img src="https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=1c87e7eac5fa0f973f8bdbd6cdf53a5b" class="object-contain" style="aspect-ratio:2034 / 1362" data-path="static/img/sdks/create-sa-1.png" decoding="async" sizes="(max-width: 1024px) 100vw, 1024px" srcset="https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=280&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=1b4bc2c52dd29156635161d21734325d 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=560&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=fc8b5c7a8e309b20a93d9d0a913c7448 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=840&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=3044a464244c2658ee438ab3c05bea43 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=1100&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=f27a75e5591cb40df5ba0a547e6b69d6 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=1650&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=a59da512b9569b2cabc4045c60e3d598 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=2500&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=23e35e09a604b85ee56aca5d1e6277ac 2500w" data-optimize="true" width="2034" height="1362" /></span></span>

    </div>

    <div class="absolute inset-0 pointer-events-none border border-black/5 rounded-2xl dark:border-white/5">

    </div>

    </div>

    </div>
5.  <span data-as="p">Select **Next**.</span>
6.  <span data-as="p">On the next screen, you’ll see a list of your 1Password vaults. Select the **Tutorial** vault you created in the previous step, then select the gear icon next to it. In the permissions dropdown, check **Read Items** and **Write Items**.</span>
    <div>

    <div class="frame p-2 not-prose relative bg-gray-50/50 rounded-2xl overflow-hidden dark:bg-gray-800/25 print:print-color-exact" data-name="frame">

    <div class="absolute inset-0 bg-grid-neutral-200/20 [mask-image:linear-gradient(0deg,#fff,rgba(255,255,255,0.6))] dark:bg-grid-white/5 dark:[mask-image:linear-gradient(0deg,rgba(255,255,255,0.1),rgba(255,255,255,0.5))] print:print-color-exact" style="background-position:10px 10px">

    </div>

    <div class="relative rounded-xl overflow-hidden flex justify-center [&_:where(img:not([class*=rounded-]))]:rounded-xl">

    <span class="zoom-image-trigger contents cursor-zoom-in" ramka-trigger=""><span class="contents"><img src="https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=7d268867a8492346777c3dc260684b80" class="object-contain" style="aspect-ratio:2032 / 1366" data-path="static/img/sdks/create-sa-2.png" decoding="async" sizes="(max-width: 1024px) 100vw, 1024px" srcset="https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=280&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=ba4f2098190d45fb21a183d6b76d3ae4 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=560&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=5a1460bf71c02f4b92ddf18405c5be43 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=840&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=655f88f04196f6dfed6bfedb149bf964 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=1100&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=79bee8103de78a9b7d360813dcc03a76 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=1650&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=44855e2e65537aac041b726aad9c164f 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=2500&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=10d7782ad617581b21e5fa9080a11c04 2500w" data-optimize="true" width="2032" height="1366" /></span></span>

    </div>

    <div class="absolute inset-0 pointer-events-none border border-black/5 rounded-2xl dark:border-white/5">

    </div>

    </div>

    </div>
7.  <span data-as="p">Select **Create Account**.</span>
8.  <span data-as="p">On the next screen, select **Save in 1Password**, then save your newly-created service account token in the Tutorial vault.</span>
    <div>

    <div class="frame p-2 not-prose relative bg-gray-50/50 rounded-2xl overflow-hidden dark:bg-gray-800/25 print:print-color-exact" data-name="frame">

    <div class="absolute inset-0 bg-grid-neutral-200/20 [mask-image:linear-gradient(0deg,#fff,rgba(255,255,255,0.6))] dark:bg-grid-white/5 dark:[mask-image:linear-gradient(0deg,rgba(255,255,255,0.1),rgba(255,255,255,0.5))] print:print-color-exact" style="background-position:10px 10px">

    </div>

    <div class="relative rounded-xl overflow-hidden flex justify-center [&_:where(img:not([class*=rounded-]))]:rounded-xl">

    <span class="zoom-image-trigger contents cursor-zoom-in" ramka-trigger=""><span class="contents"><img src="https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=524d9343fa93eed9bf26dd09db248609" class="object-contain" style="aspect-ratio:2300 / 1624" data-path="static/img/sdks/create-sa-3a.png" decoding="async" sizes="(max-width: 1024px) 100vw, 1024px" srcset="https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=280&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=2941d65f5afac70850d2d759d32a9307 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=560&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=dadabebb5732d5c28fcc552bbc2e2b68 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=840&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=1db4194dc0ece71d8d5f1cf2f0606dae 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=1100&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=4e24c461da4429c715cdf55fa03e2b06 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=1650&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=7af37fa690fb9ebee73f9f033b03e6ca 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=2500&amp;fit=max&amp;auto=format&amp;n=9g9fZmRyYnb5i5sQ&amp;q=85&amp;s=0257882c41ffcb79995b9ba0ec68057e 2500w" data-optimize="true" width="2300" height="1624" /></span></span>

    </div>

    <div class="absolute inset-0 pointer-events-none border border-black/5 rounded-2xl dark:border-white/5">

    </div>

    </div>

    </div>

### 


<a href="#step-3-create-a-secret-to-retrieve-with-the-sdk" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.
2.  Select **+ New Item** to create a new item.
3.  Select **API credential** for the item category.
4.  For the purpose of this tutorial, enter `tutorial` for the username and `example credential` for the credential.
5.  Select the Tutorial vault you created in step 1 from the dropdown next to the Save icon.
6.  Select **Save** to create the item.


## 


<a href="#part-2-install-and-configure-a-1password-sdk" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#step-1-set-up-a-nodejs-runtime-environment" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">Open your terminal and create a new folder named Tutorial:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lc975deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pc975deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tc975deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6c975deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    mkdir Tutorial
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Change directories to the Tutorial folder, then check to make sure you have NodeJS version 18 or later installed:</span>


### 


<a href="#step-2-add-support-for-modules" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "name": "Tutorial",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```


### 


<a href="#step-3-install-the-1password-sdk" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
npm install @1password/sdk
```


## 


<a href="#part-3-build-a-js-application-to-fetch-a-secret-from-1password" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#step-1-import-the-sdk" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">Create a new file `index.js` in the Tutorial folder:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faoa55deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioa55deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoa55deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coa55deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    touch index.js
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Copy and paste the following code into it:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="13" language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faoi55deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioi55deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoi55deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coi55deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    import sdk from "@1password/sdk";

    // Creates an authenticated client.
    const client = await sdk.createClient({
    auth: process.env.OP_SERVICE_ACCOUNT_TOKEN,
    // Set the following to your own integration name and version.
    integrationName: "My 1Password Integration",
    integrationVersion: "v1.0.0",
    });

    // Fetches a secret.
    const secret = await client.secrets.resolve("op://vault/item/field");
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
3.  <span data-as="p">Save the file and return to the terminal.</span>
4.  <span data-as="p">Run the code:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_fap255deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fip255deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqp255deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cp255deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    node index.js
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


``` shiki
node:internal/process/esm_loader:40
      internalBinding('errors').triggerUncaughtException(
                                ^
missing field `serviceAccountToken` at line 1 column 252
(Use `node --trace-uncaught ...` to show where the exception was thrown)
```


### 


<a href="#step-2-import-your-service-account-token" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">Copy and paste the following into your terminal to export the token to the environment. Don’t run the code yet.</span>
    <div class="tabs tabs tab-container">

    - <div id="bash%2C-zsh%2C-sh">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh">

      Bash, Zsh, sh

      </div>

      </div>

    - <div id="fish">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-fish">

      fish

      </div>

      </div>

    - <div id="powershell">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

      PowerShell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-zsh%2C-sh-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0!" role="tabpanel" aria-labelledby="bash%2C-zsh%2C-sh" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lb8af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pb8af5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tb8af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6b8af5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    export OP_SERVICE_ACCOUNT_TOKEN=
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-fish-1" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="fish" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7ld8af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pd8af5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7td8af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6d8af5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    set -x OP_SERVICE_ACCOUNT_TOKEN
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-powershell-2" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="powershell" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lf8af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pf8af5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tf8af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6f8af5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_SERVICE_ACCOUNT_TOKEN =
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    </div>

    </div>
2.  <span data-as="p">Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.</span>
3.  <span data-as="p">Navigate to the Tutorial vault and open the item for your service account token.</span>
4.  <span data-as="p">Select the service account token credential to copy it.</span>
5.  <span data-as="p">Paste the token into your terminal to complete the export command, then press <span class="kbd">Enter</span>.</span>
    <div class="tabs tabs tab-container">

    - <div id="bash%2C-zsh%2C-sh-2">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh">

      Bash, Zsh, sh

      </div>

      </div>

    - <div id="fish-2">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-fish">

      fish

      </div>

      </div>

    - <div id="powershell-2">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

      PowerShell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-zsh%2C-sh-2-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0!" role="tabpanel" aria-labelledby="bash%2C-zsh%2C-sh-2" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lb9af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pb9af5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tb9af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6b9af5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    export OP_SERVICE_ACCOUNT_TOKEN=<your-service-account-token>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-fish-2-1" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="fish-2" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7ld9af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pd9af5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7td9af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6d9af5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    set -x OP_SERVICE_ACCOUNT_TOKEN <your-service-account-token>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-powershell-2-2" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="powershell-2" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lf9af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pf9af5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tf9af5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6f9af5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_SERVICE_ACCOUNT_TOKEN = "<your-service-account-token>"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    </div>

    </div>
6.  <span data-as="p">Run the following command to confirm you successfully set the environment variable:</span>
    <div class="tabs tabs tab-container">

    - <div id="bash%2C-zsh%2C-sh-3">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh">

      Bash, Zsh, sh

      </div>

      </div>

    - <div id="fish-3">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-fish">

      fish

      </div>

      </div>

    - <div id="powershell-3">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

      PowerShell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-zsh%2C-sh-3-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0!" role="tabpanel" aria-labelledby="bash%2C-zsh%2C-sh-3" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lb9if5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pb9if5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tb9if5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6b9if5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    echo $OP_SERVICE_ACCOUNT_TOKEN
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-fish-3-1" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="fish-3" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7ld9if5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pd9if5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7td9if5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6d9if5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    echo $OP_SERVICE_ACCOUNT_TOKEN
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-powershell-3-2" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="powershell-3" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lf9if5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pf9if5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tf9if5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6f9if5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_SERVICE_ACCOUNT_TOKEN
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    </div>

    </div>


``` shiki
node index.js
```


``` shiki
error resolving secret reference: no vault matched the secret reference query
```


### 


<a href="#step-3-get-a-secret-reference-and-resolve-the-secret" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.
2.  Open the Tutorial vault and select the API credential item you created earlier.
3.  Select the down arrow next to the “credential” field, then select **Copy Secret Reference**.
4.  In your `index.js` file, replace `op://vault/item/field` with the copied secret reference.


``` shiki
import sdk from "@1password/sdk";

// Creates an authenticated client.
const client = await sdk.createClient({
auth: process.env.OP_SERVICE_ACCOUNT_TOKEN,
// Set the following to your own integration name and version.
integrationName: "My 1Password Integration",
integrationVersion: "v1.0.0",
});

// Fetches a secret.
const secret = await client.secrets.resolve("op://Tutorial/API Credential/credential");
```


``` shiki
node index.js
```


1.  <span data-as="p">Reopen the `index.js` file and append the following line to output the secret to the console.</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lcbf5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcbf5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcbf5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cbf5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    console.log("The secret is: " + secret);
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Save and close the file, then run the code for a final time:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lcjf5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcjf5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcjf5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cjf5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    node index.js
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


``` shiki
The secret is: example credential
```


## 


<a href="#conclusion" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/service-accounts/get-started/" class="link">Get started with service accounts</a>
- <a href="https://github.com/1Password/onepassword-sdk-js?tab=readme-ov-file#-get-started" class="link" target="_blank" rel="noreferrer">Get started with the 1Password JS SDK</a>
- <a href="https://github.com/1Password/onepassword-sdk-go?tab=readme-ov-file#-get-started" class="link" target="_blank" rel="noreferrer">Get started with the 1Password Go SDK</a>
- <a href="https://github.com/1Password/onepassword-sdk-python?tab=readme-ov-file#requirements" class="link" target="_blank" rel="noreferrer">Get started with the 1Password Python SDK</a>
- <a href="/get-started/secure-deployment" class="link">Workflow: Secure your deployments</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


{"docsConfig":{"theme":"mint","\$schema":"https://mintlify.com/docs.json","name":"1Password Developer","colors":{"primary":"#104ebb","light":"#b8d7ff","dark":"#303136"},"logo":{"light":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d","dark":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=119233092720e49043d6f42ff71125f1"},"favicon":"https://mintcdn.com/ab-634991b8/s4Wjy03jBRs6hcHb/favicon.ico?fit=max\u0026auto=format\u0026n=s4Wjy03jBRs6hcHb\u0026q=85\u0026s=dd03b4bc604b342373aa4d3e21be4310","api":{"playground":{"display":"interactive"},"examples":{"languages":\["curl","node","python","go","dotnet","java","php","powershell","ruby"\]}},"background":{"color":{"light":"#fbf8f4","dark":"#1a1b1e"}},"navbar":{"links":\[{"href":"/community","label":"Community"},{"href":"https://www.1password.academy/path/1password-developer-tools","label":"Academy"}\],"primary":{"type":"button","label":"GitHub","href":"https://github.com/1Password"}},"footer":{"socials":{"github":"https://github.com/1Password","x":"https://twitter.com/1Password","reddit":"https://www.reddit.com/r/1Password","linkedin":"https://www.linkedin.com/company/1password","youtube":"https://www.youtube.com/1PasswordVideos","facebook":"https://www.facebook.com/1Password","instagram":"https://www.instagram.com/1password"},"links":\[{"header":"Legal","items":\[{"label":"Terms of Service","href":"https://1password.com/legal/terms-of-service"},{"label":"Privacy Policy","href":"https://1password.com/legal/privacy"},{"label":"Cookie Policy","href":"https://1password.com/legal/cookies"},{"label":"Accessibility","href":"https://1password.com/legal/accessibility"}\]},{"header":"Community","items":\[{"label":"Developer community","href":"/community"},{"label":"Code of Conduct","href":"/code-of-conduct"},{"label":"Community projects disclaimer","href":"/community/disclaimer"}\]},{"header":"Resources","items":\[{"label":"1Password University","href":"https://www.1password.university/?utm_ref=website-footer"},{"label":"Blog RSS","href":"https://blog.1password.com/index.xml"},{"label":"Newsletter","href":"https://1password.com/developer-newsletter"}\]}\]},"seo":{"metatags":{"canonical":"https://www.1password.dev","google-site-verification":"YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs"}},"fonts":{"heading":{"family":"Public Sans"},"body":{"family":"Public Sans"}},"banner":{"content":"\*\*New!\*\* Use the \[1Password Credential Broker\](https://www.1password.dev/brokered-access) to give CI/CD and other machine workflows short-lived access to secrets, without managing service account tokens.","dismissible":true,"color":{"light":"#145fe4","dark":"#145fe4"}},"errors":{"404":{"redirect":false,"title":"This page can't be found","description":"Our docs have moved to \[www.1password.dev\](https://www.1password.dev). Try searching for what you need or selecting from the list of tools."}},"contextual":{"options":\["copy","view","mcp","cursor","vscode","chatgpt","claude","perplexity"\],"display":"header"},"styling":{"latex":false},"navigation":{"pages":\[\]}},"deployment":{"deploymentMetadataValue":{"subdomain":"ab-634991b8","hasAudioNarration":false,"actualSubdomain":"ab-634991b8","customDomains":\["www.1password.dev"\],"gitSource":{"type":"github","owner":"1password","repo":"1password.dev","deployBranch":"main","contentDirectory":"","isPrivate":true,"mountPath":"","label":""},"chroma":{"liveDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c","collectionId":"2b0d16b8-c8c5-48fa-9c4d-f1ffef490467","schemaVersion":"v3","latestBuiltDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c"},"feedback":{"thumbs":true,"contextualFeedback":{"allowEmail":false},"agentFeedback":true},"entitlements":{"AI_CHAT":{"status":"ENABLED"},"REMOVE_BRANDING":{"status":"ENABLED"},"CONTEXTUAL_FEEDBACK":{"status":"ENABLED"},"CODE_SNIPPET_FEEDBACK":{"status":"ENABLED"},"WEB_MCP":{"status":"ENABLED"},"NARRATION":{"status":"ENABLED"}},"buildId":"6ae4c9014c4a3f4f5e4b234c","clientVersion":"0.0.4044","searchFilterCounts":\[{"language":"default","tag":"More Tools","count":257},{"language":"default","tag":"Shell Plugins","count":184},{"language":"default","tag":"CLI","count":112},{"language":"default","tag":"Secrets Automation","count":94},{"language":"default","tag":"SaaS Manager API","count":88},{"language":"default","tag":"Plugins","count":85},{"language":"default","tag":"API Reference","count":64},{"language":"default","tag":"Reference","count":58},{"language":"default","tag":"SDKs","count":53},{"language":"default","tag":"Integrations","count":50}\]},"assistantConfig":{"enableStarterQuestions":true,"enableContextualStarterQuestions":true,"deflection":{"enabled":true,"email":"support@1password.com","showHelpButton":true}},"basePath":"","hasChatPermissions":true,"hasWebMcpPermissions":true,"toggles":\[{"name":"kill-isr","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-mintlify-slack","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-integrations-settings","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-pr-grouping","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"custom-prefix","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"analytics-v7","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"user-flows-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"no-publish-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-onboarding","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"llms-txt-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving-live","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"stripTemperatureMiddleware","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"support-platform-pylon-zendesk","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"instant-rollback","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications-server","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-fable","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fixed-ai-action-pricing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automation-resolve-merge-conflict","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"scoped-publishing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"mintql","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"page-level-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"editor-version-history-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-page-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"full-page-search","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workspace-projects","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"assistant-v5","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"byok-sep-25","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fork-pr-previews","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"revalidation-jwt","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"vite-origin","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-updated-9-15","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-sso-scim","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"hobby-abuse-scan","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"dashboard-inbox","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-signup","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"turbopuffer-dual-write","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-enabled","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"approve-review-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"sso-setup-deadline-banner","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false}\],"googleFontsInlined":true},"customCss":\[{"filePath":"styles.css","content":":root{--op-secure-blue:#104ebb;--op-secure-blue-hover:#0e46a8;--op-iron-ore:#303136;--op-page-bg-dark:#1a1b1e;--op-white:#ffffff;--op-icy-blue:#dcebff;--op-cornflower:#b8d7ff;--op-biscuit:#fbf8f4;--op-sunbeam:#fad785;--op-tangerine:#ff8f78;--op-enable-mint:#76e0bd;--op-gold:#cbb88e;--op-status-success:#10622f;--op-status-warning:#8a4006;--op-status-error:#a71c1c;--op-status-info:var(--op-secure-blue);--op-border-ui:#949494;--op-border-ui-dark:#6b7280;--op-border-subtle:rgb(3 7 18 / 0.12);--op-border-subtle-dark:rgb(251 248 244 / 0.25);--op-border-footer-dark:rgb(251 248 244 / 0.37);--op-border-navbar-light:rgb(107 114 128 / 0.05);--op-border-navbar-dark:rgb(209 213 219 / 0.06);--op-border-card-light:rgb(3 7 18 / 0.1);--op-border-card-dark:rgb(255 255 255 / 0.1);--op-border-hero-light:rgb(255 255 255 / 0.08);--op-border-hero-dark:rgb(255 255 255 / 0.12);--op-border-badge-light:rgb(16 78 187 / 0.2);--op-border-badge-dark:rgb(184 215 255 / 0.25);--op-border-workflow-dark:rgb(251 248 244 / 0.2);--op-text-body:var(--op-iron-ore);--op-text-body-dark:var(--op-biscuit);--op-surface-card-light:var(--op-white);--op-surface-card-dark:#25262a;--op-surface-callout-light:rgb(220 235 255 / 0.45);--op-surface-callout-dark:rgb(184 215 255 / 0.08)}#content.prose{--tw-prose-body:var(--op-text-body)}.dark \#content.prose{--tw-prose-body:var(--op-text-body-dark)}#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body)}.dark \#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body-dark)}#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-600,#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-700,#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).text-gray-500{color:var(--op-text-body)}.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-300,.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-400,.dark \#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-500{color:var(--op-text-body-dark)}#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui)}.dark \#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)),.dark \#content .text-gray-500:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui-dark)}.dark .card-group{--background-dark:37 38 42}.dark .card-group .card{background-color:rgb(var(--background-dark))!important;border-color:var(--op-border-card-dark)!important}.card-group .card{border-color:var(--op-border-card-light)!important}.community-callout,.community-card,.op-card-surface{border:1px solid var(--op-border-card-light)}.dark .community-card,.dark .op-card-surface{border-color:var(--op-border-card-dark)}#content .hover\\:border-gray-300:hover{border-color:var(--op-iron-ore)}.dark \#content .hover\\:border-gray-600:hover{border-color:var(--op-biscuit)}.community-callout,.community-card{border-radius:.5rem;background-color:var(--op-surface-card-light)}.dark .community-card{background-color:var(--op-surface-card-dark)}.community-card .community-card-chevron{color:var(--op-border-ui)}.dark .community-card .community-card-chevron{color:var(--op-cornflower)}a.community-card:hover{border-color:var(--op-secure-blue)}.dark a.community-card:hover{border-color:var(--op-cornflower)}.community-callout{background-color:var(--op-surface-callout-light)}.dark .community-callout{border-color:var(--op-border-card-dark);background-color:var(--op-surface-callout-dark)}.community-link{color:var(--op-secure-blue);text-decoration:none}.community-link:hover{color:var(--op-secure-blue-hover);text-decoration:underline}.dark .community-link{color:var(--op-cornflower)}#footer a,#footer p.font-semibold,.dark \#content\>h5,.dark \#content\>h6,.dark .community-link:hover{color:var(--op-white)}:is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body)}.dark :is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body-dark)}:is(\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n) svg{color:inherit}#footer a.h-fit svg{background-color:var(--op-biscuit)}#footer a.h-fit:hover svg{background-color:var(--op-white)}.hero-background{background-color:var(--op-iron-ore);background-image:radial-gradient(ellipse 75% 100% at 100% 50%,rgb(20 95 228/.55) 0,rgb(20 95 228/.2) 40%,transparent 70%)}.dark .hero-background{background-color:var(--op-page-bg-dark);background-image:radial-gradient(ellipse 80% 100% at 100% 50%,rgb(20 95 228/.7) 0,rgb(20 95 228/.3) 45%,transparent 75%)}.hero-section{border-bottom:1px solid var(--op-border-hero-light)}.dark .hero-section{border-bottom-color:var(--op-border-hero-dark)}.hero-cta{background-color:var(--op-secure-blue);color:var(--op-white);box-shadow:0 1px 3px rgb(0 0 0/.25)}.hero-cta svg,.hero-cta svg path{fill:currentColor!important;color:currentColor!important}.hero-cta:hover{background-color:var(--op-secure-blue-hover)}#content a.op-cta-primary,#content.prose a.op-cta-primary{background-color:var(--op-secure-blue);color:var(--op-white)!important;text-decoration:none}#content a.op-cta-primary span,#content a.op-cta-primary span\[data-as=p\],#content a.op-cta-primary:hover span,#content a.op-cta-primary:hover span\[data-as=p\],#content.prose a.op-cta-primary span,#content.prose a.op-cta-primary span\[data-as=p\],#content.prose a.op-cta-primary:hover span,#content.prose a.op-cta-primary:hover span\[data-as=p\]{color:var(--op-white)!important}#content a.op-cta-primary:hover,#content.prose a.op-cta-primary:hover{background-color:var(--op-secure-blue-hover);color:var(--op-white)!important}#topbar-cta-button a\>span.absolute,.highlight-card-link svg{background-color:var(--op-secure-blue)!important}#topbar-cta-button a:hover\>span.absolute{background-color:var(--op-secure-blue-hover)!important}#topbar-cta-button a span.z-10,#topbar-cta-button a svg,.dark .highlight-card-link:hover{color:var(--op-white)!important}.card-group{gap:1rem}#content .card-group img\[src\*=\\/homepage-icons/brand/\\\]{width:32px;height:32px;flex-shrink:0}.homepage-card-title{display:inline-flex;flex-wrap:wrap;align-items:center;gap:.25rem .5rem}.image-button-link img{margin:10px 0}.dark \#content a\>div\>span{color:var(--op-cornflower)!important}.docs-higlight-cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:1rem;margin-bottom:1rem}.highlight-card-link{color:var(--op-secure-blue)!important}.highlight-card-link:hover{color:var(--op-secure-blue-hover)!important}.dark .highlight-card-link{color:var(--op-cornflower)!important}.dark .highlight-card-link svg{background-color:var(--op-cornflower)!important}.coloredCodeWrapper .code-block\>div:nth-child(3){--fade-color-light:transparent!important;--fade-color-dark:transparent!important}.badge{border-radius:.4rem;color:var(--op-white);font-weight:700;line-height:1;padding:3px 5px}.badge--primary{background-color:var(--op-secure-blue)}.badge--secondary{background-color:var(--op-biscuit);color:var(--op-iron-ore)}.op-status-badge,.op-workflow-guide-badge{display:inline-flex;flex-shrink:0;align-items:center;white-space:nowrap;border-radius:.25rem;color:var(--op-iron-ore);padding:.125rem .625rem;font-size:.75rem;line-height:1rem;font-weight:600}.op-status-badge{vertical-align:middle;border:1px solid var(--op-border-badge-light);background-color:var(--op-icy-blue)}.dark .op-status-badge{border-color:var(--op-border-badge-dark);background-color:rgb(184 215 255/.12);color:var(--op-icy-blue)}.op-workflow-guide-badge{margin-top:.75rem;border:1px solid transparent;background-color:var(--op-biscuit)}.dark .op-workflow-guide-badge{border-color:var(--op-border-workflow-dark);background-color:rgb(251 248 244/.1);color:var(--op-biscuit)}.op-beta-badge-inline{display:inline-flex;align-items:center;margin-left:.5rem;vertical-align:middle}.mdx-content a\[href^=http\]:not(\[href\*=\\://1password.com/\\\],\[href\$=\\://1password.com\\\],\[href\*=\\.1password.com/\\\],\[href\$=\\.1password.com\\\],\[href\*=\\://1password.dev/\\\],\[href\$=\\://1password.dev\\\],\[href\*=\\.1password.dev/\\\],\[href\$=\\.1password.dev\\\],\[href\*=\\://1password.ca/\\\],\[href\$=\\://1password.ca\\\],\[href\*=\\.1password.ca/\\\],\[href\$=\\.1password.ca\\\],\[href\*=\\://1password.eu/\\\],\[href\$=\\://1password.eu\\\],\[href\*=\\.1password.eu/\\\],\[href\$=\\.1password.eu\\\],\[href\*=\\://1password.io/\\\],\[href\$=\\://1password.io\\\],\[href\*=\\.1password.io/\\\],\[href\$=\\.1password.io\\\],\[href\*=\\://1password.university/\\\],\[href\$=\\://1password.university\\\],\[href\*=\\.1password.university/\\\],\[href\$=\\.1password.university\\\],\[href\*=\\://agilebits.com/\\\],\[href\$=\\://agilebits.com\\\],\[href\*=\\.agilebits.com/\\\],\[href\$=\\.agilebits.com\\\],\[href\*=\\://b5dev.com/\\\],\[href\$=\\://b5dev.com\\\],\[href\*=\\.b5dev.com/\\\],\[href\$=\\.b5dev.com\\\],\[href\*=\\://b5local.com/\\\],\[href\$=\\://b5local.com\\\],\[href\*=\\.b5local.com/\\\],\[href\$=\\.b5local.com\\\],\[href\*=\\://1infra.dev/\\\],\[href\$=\\://1infra.dev\\\],\[href\*=\\.1infra.dev/\\\],\[href\$=\\.1infra.dev\\\],\[href\*=\\://kolide.com/\\\],\[href\$=\\://kolide.com\\\],\[href\*=\\.kolide.com/\\\],\[href\$=\\.kolide.com\\\],\[href\*=\\://trelica.app/\\\],\[href\$=\\://trelica.app\\\],\[href\*=\\.trelica.app/\\\],\[href\$=\\.trelica.app\\\],\[href\*=\\://trelica.eu/\\\],\[href\$=\\://trelica.eu\\\],\[href\*=\\.trelica.eu/\\\],\[href\$=\\.trelica.eu\\\],\[href\*=\\://trelica.com/\\\],\[href\$=\\://trelica.com\\\],\[href\*=\\.trelica.com/\\\],\[href\$=\\.trelica.com\\\],\[href\*=\\://1password.community/\\\],\[href\$=\\://1password.community\\\],\[href\*=\\.1password.community/\\\],\[href\$=\\.1password.community\\\],\[href\*=\\://1pw.ca/\\\],\[href\$=\\://1pw.ca\\\],\[href\*=\\.1pw.ca/\\\],\[href\$=\\.1pw.ca\\\]):not(.card \*,.op-card-surface \*,.image-button-link,.community-card,.community-card \*,pre \*,:has(img))::after{content:\\\\;display:inline-block;width:1em;height:1em;margin-left:.25em;vertical-align:-.125em;background-color:currentColor;-webkit-mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain;mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain}.mdx-content a:is(\[href\*=\\://github.com/\\\], \[href\$=\\://github.com\\\], \[href\*=\\.github.com/\\\], \[href\$=\\.github.com\\\], \[href\*=\\://github.blog/\\\], \[href\$=\\://github.blog\\\]){--op-link-icon:url(\\/static/img/logos/github.svg\\)}#content\>h5,#content\>h6{font-weight:700}.accordion{background-color:var(--op-icy-blue)}.dark .accordion{background-color:var(--op-surface-card-dark)}.accordion .mint-bg-white{padding:1rem}.accordion .mint-bg-white \[class\*=-mx-\]{margin:0!important;padding:0!important;width:100%!important;--page-padding:0px}#footer img.nav-logo.dark\\:hidden,#footer\>div\>div.flex.flex-col.md\\:flex-row.gap-8.justify-between.min-h-\\\[76px\\\]\>div.flex.flex-col.sm\\:grid.max-md\\:\\!grid-cols-2.gap-8.flex-1\>div\>div\>p{display:none!important}footer#footer.advanced-footer{display:flex!important}footer#footer{align-items:unset;background-color:var(--op-iron-ore);color:var(--op-white)}#footer img.nav-logo.dark\\:block{display:block!important}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20\>div.h-\\\[1px\\\].w-full.bg-gray-100.dark\\:bg-white\\/5{background-color:var(--op-border-footer-dark)}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20{margin:0 auto}footer .email_form{max-width:650px;margin:auto}.codeblock_accordion{margin-top:10px}.codeblock_accordion .code-block{margin:0!important}.codeblock_accordion\>div\>.code-block,.codeblock_accordion\>div\>.code-block\>div:nth-child(2){border-bottom-left-radius:0;border-bottom-right-radius:0}.codeblock_accordion .see_results_container{border-bottom-left-radius:1rem;border-bottom-right-radius:1rem}.codeblock_accordion .see_results_container .code-block,.codeblock_accordion .see_results_container .code-block\>div:nth-child(2){border-top-left-radius:0;border-top-right-radius:0}.hide_bullets ul li{padding-left:0!important}.hide_bullets ul li::before{content:none!important}#navigation-items a\[href^=\\/\\\]:not(\[href^=\\//\\\])\>div\>div:nth-child(2){display:none}a\[href^=\\//\\\] .flex-shrink-0 svg,a\[href^=http\] .flex-shrink-0 svg{display:block}h1 code,h2 code,h3 code,h4 code,h5 code,h6 code{white-space:nowrap}h2.flex.whitespace-pre-wrap span.cursor-pointer svg.icon,h4.flex.whitespace-pre-wrap span.cursor-pointer svg.icon{margin:0;vertical-align:baseline}table thead tr th code{padding-left:0!important;padding-right:0!important}.tabs.tab-container{padding:0 .8rem 1rem;border:1px solid var(--op-border-subtle);border-radius:4px}.dark .tabs.tab-container{border-color:var(--op-border-subtle-dark)}.nav-tabs-item:nth-child(3),nav-tabs-item:nth-child(3){--tab-gap-before-divider:8px;--nav-tabs-item-gap:0.5rem;margin-left:var(--tab-gap-before-divider)!important;padding-left:calc(var(--tab-gap-before-divider) + var(--nav-tabs-item-gap))!important;border-left:1px solid var(--op-border-navbar-light)}.dark .nav-tabs-item:nth-child(3),.dark nav-tabs-item:nth-child(3){border-left-color:var(--op-border-navbar-dark)}.peer.is-center~div:has(.tutorial-explorer){max-width:84rem!important}@media (max-width:639px){.tutorial-filter-bar{display:grid!important;grid-template-columns:minmax(0,1fr)}.tutorial-filter-search,.tutorial-filter-tools,.tutorial-filter-topic{grid-column:1/-1;width:100%}.tutorial-filter-search input{width:100%!important}.tutorial-filter-dropdown\>button,.tutorial-filter-menu{width:100%}.tutorial-filter-dropdown\>button{justify-content:space-between}.tutorial-filter-menu{min-width:0!important}.tutorial-filter-sort{grid-column:1/-1;justify-self:end;margin-left:0!important}}#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body);text-shadow:none}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body-dark)}#navbar.is-custom .nav-tabs-item\[data-active\]\>div{background-color:transparent!important}#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(229 231 235)!important}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(55 65 81)!important}#footer .api-sdk-terms-notice{margin:0;padding:0 0 1.25rem;font-size:.875rem;font-style:italic;line-height:1.5;text-align:center;color:rgb(251 248 244/.8);pointer-events:auto}#footer .api-sdk-terms-notice a{position:relative;z-index:2;color:var(--op-cornflower);text-decoration:underline;text-underline-offset:2px;pointer-events:auto;cursor:pointer}"}\],"page":{"pagePath":"service-accounts/setup-tutorial","slug":"/service-accounts/setup-tutorial","pageMetadata":{"title":"Use service accounts with 1Password SDKs","sidebarTitle":"Use with 1Password SDKs","og:description":"Learn how to build a JavaScript application that securely fetches a secret from 1Password using a service account.","description":null,"href":"/service-accounts/setup-tutorial"},"pageType":"default","mdx":{"mdxSource":{"compiledSource":"\\use strict\\;const{Fragment:\_Fragment,jsx:\_jsx,jsxs:\_jsxs}=arguments\[0\];const{useMDXComponents:\_provideComponents}=arguments\[0\];const CodeResult=({children,resultLang,wrap,expandable})=\>{const{CodeBlock,Icon}=\_provideComponents()\|\|{};if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Icon)\_missingMdxReference(\`Icon\`,true);const parseChildren=()=\>{let language=\`text\`;let codeContent=\`\`;const extractText=node=\>{if(typeof node===\`string\`){return node}if(Array.isArray(node)){return node.map(extractText).join(\`\`)}if(node?.props?.children){return extractText(node.props.children)}return\`\`};const extractLanguage=node=\>{if(!node)return null;if(node.props?.className){const className=node.props.className;const langMatch=className.match(/language-(\\w+)/);if(langMatch){return langMatch\[1\]}}if(node.props?.\[\`data-language\`\]){return node.props\[\`data-language\`\]}if(node.props?.language){return node.props.language}return null};if(typeof children===\`string\`){codeContent=children}else if(Array.isArray(children)){codeContent=extractText(children);for(const child of children){const detectedLang=extractLanguage(child);if(detectedLang){language=detectedLang;break}}}else if(children?.props){const detectedLang=extractLanguage(children);if(detectedLang){language=detectedLang}codeContent=extractText(children)}const parts=codeContent.split(\`#code-result\`);if(parts.length\u003c2){return{command:codeContent.trim(),result:null,language,defaultOpen:false}}const resultText=parts\[1\].trim();const defaultOpen=resultText.startsWith(\`open\`);const cleanResult=defaultOpen?resultText.slice(4).trim():resultText;return{command:parts\[0\].trim(),result:cleanResult,language,defaultOpen}};const{command,result,language,defaultOpen}=parseChildren();const\[isOpen,setIsOpen\]=useState(defaultOpen);if(!result){return children}return \_jsxs(\`div\`,{className:\`codeblock_accordion not-prose mint-mb-4\`,children:\[\_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mb-0 \[\u0026\>\*\]:!mint-rounded-b-none\`,children:\_jsx(CodeBlock,{language,children:command,wrap,expandable})}),\_jsxs(\`div\`,{className:\`see_results_container mint-border-t-0 mint-bg-gray-100/80 dark:mint-bg-gray-800/80 mint-overflow-hidden\`,style:{marginTop:\`-0.25rem\`},children:\[\_jsxs(\`button\`,{onClick:()=\>setIsOpen(!isOpen),className:\`mint-w-full mint-px-4 mint-py-2.5 mint-flex mint-items-center mint-gap-1 mint-text-left mint-text-\[14px\] mint-font-medium mint-text-gray-600 dark:mint-text-gray-400 hover:mint-text-gray-800 dark:hover:mint-text-gray-200 hover:mint-bg-gray-200/60 dark:hover:mint-bg-gray-700/60 mint-transition-all mint-duration-150\`,\\aria-expanded\\:isOpen,children:\[isOpen?\_jsx(Icon,{icon:\`caret-down\`,size:\`14\`,iconType:\`solid\`}):\_jsx(Icon,{icon:\`caret-right\`,size:\`14\`,iconType:\`solid\`}),\_jsx(\`span\`,{children:\`See result...\`})\]}),isOpen\u0026\u0026_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mt-0 \[\u0026\>\*\]:!mint-rounded-t-none mint-border-t mint-border-\[var(--op-border-ui)\] dark:mint-border-\[var(--op-border-ui-dark)\]\`,children:\_jsx(CodeBlock,{language:resultLang\|\|language,children:result,wrap,expandable})})\]})\]})};function \_createMdxContent(props){const \_components={a:\`a\`,code:\`code\`,li:\`li\`,ol:\`ol\`,p:\`p\`,pre:\`pre\`,span:\`span\`,strong:\`strong\`,ul:\`ul\`,...\_provideComponents(),...props.components},{CardGroup,CodeBlock,Frame,Heading,OptimizedImage,Tab,Tabs,Tip,Warning,\_MdxComponentBoundary}=\_components;if(!CardGroup)\_missingMdxReference(\`CardGroup\`,true);if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Frame)\_missingMdxReference(\`Frame\`,true);if(!Heading)\_missingMdxReference(\`Heading\`,true);if(!OptimizedImage)\_missingMdxReference(\`OptimizedImage\`,true);if(!Tab)\_missingMdxReference(\`Tab\`,true);if(!Tabs)\_missingMdxReference(\`Tabs\`,true);if(!Tip)\_missingMdxReference(\`Tip\`,true);if(!Warning)\_missingMdxReference(\`Warning\`,true);if(!\_MdxComponentBoundary)\_missingMdxReference(\`\_MdxComponentBoundary\`,true);return \_jsxs(\_Fragment,{children:\[\_jsx(\_components.p,{children:\`In this tutorial, you’ll build a simple JavaScript application that securely fetches a secret from your 1Password account. In the process, you’ll learn how to:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\`Create a new test vault in your 1Password account.\`}),\`\n\`,\_jsx(\_components.li,{children:\`Create a service account that can only access the test vault.\`}),\`\n\`,\_jsx(\_components.li,{children:\`Save a secret in the test vault.\`}),\`\n\`,\_jsx(\_components.li,{children:\`Set up your project, and install and configure the 1Password JS SDK.\`}),\`\n\`,\_jsx(\_components.li,{children:\`Get a secret reference URI that points to the test secret you created.\`}),\`\n\`,\_jsx(\_components.li,{children:\`Build a simple application that takes the secret reference as input and outputs the actual secret.\`}),\`\n\`\]}),\`\n\`,\_jsx(Tip,{children:\_jsxs(\_components.p,{children:\[\`This tutorial covers end-to-end setup for the \`,\_jsx(\_components.a,{href:\`https://github.com/1Password/onepassword-sdk-js?tab=readme-ov-file#-get-started\`,children:\`1Password JavaScript SDK.\`}),\` Learn more about the \`,\_jsx(\_components.a,{href:\`https://github.com/1Password/onepassword-sdk-go?tab=readme-ov-file#-get-started\`,children:\`1Password Go SDK\`}),\` and the \`,\_jsx(\_components.a,{href:\`https://github.com/1Password/onepassword-sdk-python?tab=readme-ov-file#requirements\`,children:\`1Password Python SDK.\`})\]})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`prerequisites\`,children:\`Prerequisites\`}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`1Password subscription\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`(Optional) \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password desktop app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Basic knowledge of JavaScript.\`}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`part-1-set-up-a-1password-service-account\`,children:\`Part 1: Set up a 1Password Service Account\`}),\`\n\`,\_jsx(\_components.p,{children:\`In the first part of the tutorial, you’ll create a vault and item in your 1Password account to use for testing, and set up a service account to authenticate the SDK.\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-1-create-a-new-vault\`,children:\`Step 1: Create a new vault\`}),\`\n\`,\_jsxs(CardGroup,{cols:2,children:\[\_jsxs(\`div\`,{children:\[\_jsx(\_components.p,{children:\`First, create a new vault named Tutorial. You’ll scope your service account to this vault, so it can only access the test item you create for this tutorial.\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password desktop app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select the plus icon in the sidebar next to your account name.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Enter \`,\_jsx(\_components.code,{children:\`Tutorial\`}),\` for the vault name, then select \`,\_jsx(\_components.strong,{children:\`Create\`}),\`.\`\]}),\`\n\`\]})\]}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(OptimizedImage,{alt:\`\`,src:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-vault-light.png?fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=917a5a3ec9ed5ac11f419818a05b5632\`,\\data-og-width\\:\`786\`,width:\`786\`,\\data-og-height\\:\`862\`,height:\`862\`,\\data-path\\:\`static/img/sdks/create-vault-light.png\`,\\data-optimize\\:\`true\`,\\data-opv\\:\`3\`,srcset:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-vault-light.png?w=280\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=90642ebff15fb9f2eb43fd5ef475f79b 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-vault-light.png?w=560\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=846bce0a89e00ea1e9b72d5955ba796a 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-vault-light.png?w=840\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=ec5a8147d7f0e67b119f55aa081c4cdd 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-vault-light.png?w=1100\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=dcf86d245c8fb12d68702d0ede6e6786 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-vault-light.png?w=1650\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=9c26c272df122de547f62dace455824f 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-vault-light.png?w=2500\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=374004f870bdf99afd280a514dad30c8 2500w\`})})})\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-2-create-a-service-account\`,children:\`Step 2: Create a service account\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Next, create a \`,\_jsx(\_components.a,{href:\`/service-accounts/get-started/\`,children:\`1Password Service Account\`}),\`. This is a token-based authentication method that you can scope to specific vaults and permissions, so your process only has the minimum required access to your account.\`\]}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\_jsx(\_components.a,{href:\`https://start.1password.com/signin\`,children:\`Sign in\`}),\` to your account on 1Password.com.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Select \`,\_jsx(\_components.a,{href:\`https://start.1password.com/developer-tools/directory\`,children:\_jsx(\_components.strong,{children:\`Developer\`})}),\` in the sidebar. Or, if you already have active applications and services, select \`,\_jsx(\_components.strong,{children:\`Directory\`}),\` at the top of the Developer page.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Under Access Tokens, select \`,\_jsx(\_components.strong,{children:\`Service Account\`}),\`. If you don’t see the option to create service accounts, ask your administrator to \`,\_jsx(\_components.a,{href:\`/service-accounts/manage-service-accounts#manage-who-can-create-service-accounts\`,children:\`give you access to create and manage service accounts\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Give your service account a name. For this tutorial, use \`,\_jsx(\_components.code,{children:\`Temp Service Account\`}),\`.\`\]}),\`\n\`,\_jsx(Frame,{children:\_jsx(OptimizedImage,{alt:\`\`,src:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=1c87e7eac5fa0f973f8bdbd6cdf53a5b\`,\\data-og-width\\:\`2034\`,width:\`2034\`,\\data-og-height\\:\`1362\`,height:\`1362\`,\\data-path\\:\`static/img/sdks/create-sa-1.png\`,\\data-optimize\\:\`true\`,\\data-opv\\:\`3\`,srcset:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=280\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=1b4bc2c52dd29156635161d21734325d 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=560\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=fc8b5c7a8e309b20a93d9d0a913c7448 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=840\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=3044a464244c2658ee438ab3c05bea43 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=1100\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=f27a75e5591cb40df5ba0a547e6b69d6 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=1650\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=a59da512b9569b2cabc4045c60e3d598 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-1.png?w=2500\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=23e35e09a604b85ee56aca5d1e6277ac 2500w\`})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`Next\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`On the next screen, you’ll see a list of your 1Password vaults. Select the \`,\_jsx(\_components.strong,{children:\`Tutorial\`}),\` vault you created in the previous step, then select the gear icon next to it. In the permissions dropdown, check \`,\_jsx(\_components.strong,{children:\`Read Items\`}),\` and \`,\_jsx(\_components.strong,{children:\`Write Items\`}),\`.\`\]}),\`\n\`,\_jsx(Frame,{children:\_jsx(OptimizedImage,{alt:\`\`,src:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=7d268867a8492346777c3dc260684b80\`,\\data-og-width\\:\`2032\`,width:\`2032\`,\\data-og-height\\:\`1366\`,height:\`1366\`,\\data-path\\:\`static/img/sdks/create-sa-2.png\`,\\data-optimize\\:\`true\`,\\data-opv\\:\`3\`,srcset:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=280\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=ba4f2098190d45fb21a183d6b76d3ae4 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=560\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=5a1460bf71c02f4b92ddf18405c5be43 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=840\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=655f88f04196f6dfed6bfedb149bf964 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=1100\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=79bee8103de78a9b7d360813dcc03a76 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=1650\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=44855e2e65537aac041b726aad9c164f 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-2.png?w=2500\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=10d7782ad617581b21e5fa9080a11c04 2500w\`})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`Create Account\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`On the next screen, select \`,\_jsx(\_components.strong,{children:\`Save in 1Password\`}),\`, then save your newly-created service account token in the Tutorial vault.\`\]}),\`\n\`,\_jsx(Frame,{children:\_jsx(OptimizedImage,{alt:\`\`,src:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=524d9343fa93eed9bf26dd09db248609\`,\\data-og-width\\:\`2300\`,width:\`2300\`,\\data-og-height\\:\`1624\`,height:\`1624\`,\\data-path\\:\`static/img/sdks/create-sa-3a.png\`,\\data-optimize\\:\`true\`,\\data-opv\\:\`3\`,srcset:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=280\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=2941d65f5afac70850d2d759d32a9307 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=560\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=dadabebb5732d5c28fcc552bbc2e2b68 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=840\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=1db4194dc0ece71d8d5f1cf2f0606dae 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=1100\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=4e24c461da4429c715cdf55fa03e2b06 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=1650\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=7af37fa690fb9ebee73f9f033b03e6ca 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/create-sa-3a.png?w=2500\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=0257882c41ffcb79995b9ba0ec68057e 2500w\`})}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-3-create-a-secret-to-retrieve-with-the-sdk\`,children:\`Step 3: Create a secret to retrieve with the SDK\`}),\`\n\`,\_jsx(\_components.p,{children:\`Next, create an example API credential item in the Tutorial vault. In the second half of the tutorial, you’ll build a simple application to fetch the credential secret from this item.\`}),\`\n\`,\_jsxs(CardGroup,{cols:2,children:\[\_jsxs(\`div\`,{children:\[\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password desktop app\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`+ New Item\`}),\` to create a new item.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`API credential\`}),\` for the item category.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`For the purpose of this tutorial, enter \`,\_jsx(\_components.code,{children:\`tutorial\`}),\` for the username and \`,\_jsx(\_components.code,{children:\`example credential\`}),\` for the credential.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select the Tutorial vault you created in step 1 from the dropdown next to the Save icon.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`Save\`}),\` to create the item.\`\]}),\`\n\`\]}),\_jsx(\_components.p,{children:\`You should now see the API credential item in your Tutorial vault.\`})\]}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(OptimizedImage,{alt:\`\`,src:\`https://mintcdn.com/ab-634991b8/Ul-COtb5ywadNlrP/static/img/sdks/sdk-create-item-light.png?fit=max\u0026auto=format\u0026n=Ul-COtb5ywadNlrP\u0026q=85\u0026s=8d0f9614bfe20676d9efad5b73dec323\`,\\data-og-width\\:\`1192\`,width:\`1192\`,\\data-og-height\\:\`1460\`,height:\`1460\`,\\data-path\\:\`static/img/sdks/sdk-create-item-light.png\`,\\data-optimize\\:\`true\`,\\data-opv\\:\`3\`,srcset:\`https://mintcdn.com/ab-634991b8/Ul-COtb5ywadNlrP/static/img/sdks/sdk-create-item-light.png?w=280\u0026fit=max\u0026auto=format\u0026n=Ul-COtb5ywadNlrP\u0026q=85\u0026s=da45c9df89ecd123ba07b5e7523f72f9 280w, https://mintcdn.com/ab-634991b8/Ul-COtb5ywadNlrP/static/img/sdks/sdk-create-item-light.png?w=560\u0026fit=max\u0026auto=format\u0026n=Ul-COtb5ywadNlrP\u0026q=85\u0026s=6b732ff7b759eda06d8fa4e172929c0b 560w, https://mintcdn.com/ab-634991b8/Ul-COtb5ywadNlrP/static/img/sdks/sdk-create-item-light.png?w=840\u0026fit=max\u0026auto=format\u0026n=Ul-COtb5ywadNlrP\u0026q=85\u0026s=75f25a45ed9bc9dbb93669145e401b21 840w, https://mintcdn.com/ab-634991b8/Ul-COtb5ywadNlrP/static/img/sdks/sdk-create-item-light.png?w=1100\u0026fit=max\u0026auto=format\u0026n=Ul-COtb5ywadNlrP\u0026q=85\u0026s=bae64dcf35e03ff2eb22085abf52ebd5 1100w, https://mintcdn.com/ab-634991b8/Ul-COtb5ywadNlrP/static/img/sdks/sdk-create-item-light.png?w=1650\u0026fit=max\u0026auto=format\u0026n=Ul-COtb5ywadNlrP\u0026q=85\u0026s=92ad4b48f83df4a7ebeb3546b39d77ef 1650w, https://mintcdn.com/ab-634991b8/Ul-COtb5ywadNlrP/static/img/sdks/sdk-create-item-light.png?w=2500\u0026fit=max\u0026auto=format\u0026n=Ul-COtb5ywadNlrP\u0026q=85\u0026s=616b5ae2616ee597447fcd26dd20631f 2500w\`})})})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`part-2-install-and-configure-a-1password-sdk\`,children:\`Part 2: Install and configure a 1Password SDK\`}),\`\n\`,\_jsx(\_components.p,{children:\`In this part of the tutorial, you’ll create a new folder for your project, set up a NodeJS runtime environment in it, then install and configure the 1Password JavaScript SDK.\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-1-set-up-a-nodejs-runtime-environment\`,children:\`Step 1: Set up a NodeJS runtime environment\`}),\`\n\`,\_jsx(\_components.p,{children:\`Create a new folder for your project, then make sure you have NodeJS installed.\`}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Open your terminal and create a new folder named Tutorial:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`mkdir\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` Tutorial\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Change directories to the Tutorial folder, then check to make sure you have NodeJS version 18 or later installed:\`}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`cd\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` Tutorial\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`node\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -v\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`v20.16.8\`})}),\`\n\`\]})})})})}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.p,{children:\[\`If you don’t see an existing NodeJS version, or if you have an earlier version installed, \`,\_jsx(\_components.a,{href:\`https://nodejs.org/\`,children:\`learn how to install the latest version of NodeJS.\`})\]}),\`\n\`,\_jsx(\_components.p,{children:\`Then, initialize a NodeJS project in your Tutorial folder:\`}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`16\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`16\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`npm\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` init\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -y\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Wrote\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` to\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /Users/wendy.appleseed/Tutorial/package.json:\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`{\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\name\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Tutorial\\,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\version\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\1.0.0\\,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\description\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\\\,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\main\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\index.js\\,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\scripts\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\test\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\echo \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\\\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`Error: no test specified\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\\\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \u0026\u0026 exit 1\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` },\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\keywords\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \[\],\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\author\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\\\,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` \\license\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\ISC\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-2-add-support-for-modules\`,children:\`Step 2: Add support for Modules\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`After you’ve initialized a NodeJS project for the tutorial, you’ll need to edit the newly created \`,\_jsx(\_components.code,{children:\`package.json\`}),\` file to add support for Modules.\`\]}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Open the \`,\_jsx(\_components.code,{children:\`package.json\`}),\` file in the Tutorial folder and add \`,\_jsx(\_components.code,{children:\`\\type\\: \\module\\,\`}),\` on a new line after \`,\_jsx(\_components.code,{children:\`“main”:”index.js”\`}),\` on line \#5.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,highlight:\`\[6\]\`,numberOfLines:\`13\`,language:\`json\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`json\`,children:\_jsxs(\_components.code,{language:\`json\`,numberOfLines:\`13\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`{\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\name\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\Tutorial\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\version\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\1.0.0\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\description\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\main\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\index.js\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line line-highlight\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\type\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\module\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\scripts\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\test\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\echo \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\\\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`Error: no test specified\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\\\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \u0026\u0026 exit 1\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` },\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\keywords\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \[\],\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\author\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#116329\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \\license\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`: \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\ISC\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Save the file and exit.\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-3-install-the-1password-sdk\`,children:\`Step 3: Install the 1Password SDK\`}),\`\n\`,\_jsx(\_components.p,{children:\`Finally, return to your terminal and install the 1Password JS SDK in the Tutorial folder:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`npm\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` @1password/sdk\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`part-3-build-a-js-application-to-fetch-a-secret-from-1password\`,children:\`Part 3: Build a JS application to fetch a secret from 1Password\`}),\`\n\`,\_jsx(\_components.p,{children:\`In this part of the tutorial, you’ll build a simple JavaScript application to securely fetch your API credential secret from 1Password. Your application will authenticate to 1Password using the service account token you created in the previous section.\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-1-import-the-sdk\`,children:\`Step 1: Import the SDK\`}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Create a new file \`,\_jsx(\_components.code,{children:\`index.js\`}),\` in the Tutorial folder:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`touch\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` index.js\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Copy and paste the following code into it:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`13\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`13\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`import sdk from \\@1password/sdk\\;\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`// Creates an authenticated client.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`const client = await sdk.createClient({\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`auth: process.env.OP_SERVICE_ACCOUNT_TOKEN,\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`// Set the following to your own integration name and version.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`integrationName: \\My 1Password Integration\\,\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`integrationVersion: \\v1.0.0\\,\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`});\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`// Fetches a secret.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`const secret = await client.secrets.resolve(\\op://vault/item/field\\);\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Save the file and return to the terminal.\`}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Run the code:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`node\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` index.js\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`You’ll see an error because you haven’t yet imported your service account token into the environment. This is necessary for 1Password SDKs to be able to access your vaults.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`6\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`6\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`node:internal/process/esm_loader:40\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` internalBinding('errors').triggerUncaughtException(\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` ^\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\\missing field \`serviceAccountToken\` at line 1 column 252\\})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\\(Use \`node --trace-uncaught ...\` to show where the exception was thrown)\\})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-2-import-your-service-account-token\`,children:\`Step 2: Import your service account token\`}),\`\n\`,\_jsx(\_components.p,{children:\`To import your service account token:\`}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Copy and paste the following into your terminal to export the token to the environment. Don’t run the code yet.\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsx(Tab,{title:\`Bash, Zsh, sh\`,id:\`bash%2C-zsh%2C-sh\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`export\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` OP_SERVICE_ACCOUNT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`fish\`,id:\`fish\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`set\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -x\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` OP_SERVICE_ACCOUNT_TOKEN\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`PowerShell\`,id:\`powershell\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`Env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_SERVICE_ACCOUNT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`})\]}),\`\n\`\]})})})})\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password desktop app\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Navigate to the Tutorial vault and open the item for your service account token.\`}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Select the service account token credential to copy it.\`}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Paste the token into your terminal to complete the export command, then press \`,\_jsx(\`kbd\`,{children:\`Enter\`}),\`.\`\]}),\`\n\`,\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsx(Tab,{title:\`Bash, Zsh, sh\`,id:\`bash%2C-zsh%2C-sh-2\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`export\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` OP_SERVICE_ACCOUNT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`your-service-account-token\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`fish\`,id:\`fish-2\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`set\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -x\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` OP_SERVICE_ACCOUNT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`your-service-account-toke\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`n\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`PowerShell\`,id:\`powershell-2\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`Env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_SERVICE_ACCOUNT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\\u003cyour-service-account-token\>\\\`})\]}),\`\n\`\]})})})})\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Run the following command to confirm you successfully set the environment variable:\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsx(Tab,{title:\`Bash, Zsh, sh\`,id:\`bash%2C-zsh%2C-sh-3\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`echo\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \$OP_SERVICE_ACCOUNT_TOKEN\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`fish\`,id:\`fish-3\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`echo\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \$OP_SERVICE_ACCOUNT_TOKEN\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`PowerShell\`,id:\`powershell-3\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`Env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_SERVICE_ACCOUNT_TOKEN\`})\]}),\`\n\`\]})})})})\]}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`Now try running the code again:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`node\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` index.js\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`You’ll get a new error, in this case because you didn’t provide a reference path to a secret. Think of this like a URL for a secret within your vault.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`error resolving secret reference: no vault matched the secret reference query\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`step-3-get-a-secret-reference-and-resolve-the-secret\`,children:\`Step 3: Get a secret reference and resolve the secret\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`To fix the above error, get the \`,\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax/\`,children:\`secret reference URI\`}),\` for your API credential and paste it into the code in place of the placeholder secret reference.\`\]}),\`\n\`,\_jsxs(CardGroup,{cols:2,children:\[\_jsx(\`div\`,{children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password desktop app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Open the Tutorial vault and select the API credential item you created earlier.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Select the down arrow next to the “credential” field, then select \`,\_jsx(\_components.strong,{children:\`Copy Secret Reference\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`In your \`,\_jsx(\_components.code,{children:\`index.js\`}),\` file, replace \`,\_jsx(\_components.code,{children:\`op://vault/item/field\`}),\` with the copied secret reference.\`\]}),\`\n\`\]})}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(OptimizedImage,{alt:\`\`,src:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/api-reference-light.png?fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=9044a488d5e210f3ae004c7b3341af38\`,\\data-og-width\\:\`960\`,width:\`960\`,\\data-og-height\\:\`720\`,height:\`720\`,\\data-path\\:\`static/img/sdks/api-reference-light.png\`,\\data-optimize\\:\`true\`,\\data-opv\\:\`3\`,srcset:\`https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/api-reference-light.png?w=280\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=042d4f2f38571a2faf98ff6547517430 280w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/api-reference-light.png?w=560\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=50a70455cc9b89fea00e4983af5bf467 560w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/api-reference-light.png?w=840\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=5f3c68f03f8316f27d337b206a5c6c03 840w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/api-reference-light.png?w=1100\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=8bef42733387ccdc75f210d243e652fe 1100w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/api-reference-light.png?w=1650\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=28e843a7663b0640c210f32903984bb9 1650w, https://mintcdn.com/ab-634991b8/9g9fZmRyYnb5i5sQ/static/img/sdks/api-reference-light.png?w=2500\u0026fit=max\u0026auto=format\u0026n=9g9fZmRyYnb5i5sQ\u0026q=85\u0026s=572a5bc5f9f842b74531d7fea760fb47 2500w\`})})})\]}),\`\n\`,\_jsx(Tip,{children:\_jsxs(\_components.p,{children:\[\`You can also get secret references with \`,\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax/#with-1password-cli\`,children:\`1Password CLI\`}),\` and \`,\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax/#with-1password-for-vs-code\`,children:\`1Password for VS Code\`}),\`.\`\]})}),\`\n\`,\_jsx(\`br\`,{}),\`\n\`,\_jsx(\_components.p,{children:\`You should now see a secret reference that points to where the API credential is saved in your account:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,highlight:\`\[12\]\`,numberOfLines:\`12\`,language:\`javascript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`javascript\`,children:\_jsxs(\_components.code,{language:\`javascript\`,numberOfLines:\`12\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`import\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` sdk\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\` from\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\@1password/sdk\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`;\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`// Creates an authenticated client.\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`const\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` client\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\` await\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` sdk\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#8250DF\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`createClient\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`({\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`auth:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` process\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`env\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\`OP_SERVICE_ACCOUNT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`// Set the following to your own integration name and version.\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`integrationName:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\My 1Password Integration\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`integrationVersion:\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\v1.0.0\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`});\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`// Fetches a secret.\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line line-highlight\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`const\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` secret\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\` await\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` client\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`secrets\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#8250DF\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`resolve\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`(\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\op://Tutorial/API Credential/credential\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`);\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Save the file and run the code again:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`node\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` index.js\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`This time you won’t see any errors, but you also won’t see any output. You can fix this by adding some simple console logging.\`}),\`\n\`,\_jsx(Warning,{children:\_jsx(\_components.p,{children:\`Logging an example secret is useful for testing, but please don’t do this with production code.\`})}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Reopen the \`,\_jsx(\_components.code,{children:\`index.js\`}),\` file and append the following line to output the secret to the console.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`console.log(\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`\\The secret is: \\\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` +\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` secret\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`);\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Save and close the file, then run the code for a final time:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`node\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` index.js\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`You should now see your API credential returned:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`The secret is: example credential\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`conclusion\`,children:\`Conclusion\`}),\`\n\`,\_jsx(\_components.p,{children:\`In this tutorial, you learned how to create a 1Password vault, item, and service account, and how to access your newly-created vault and item using the 1Password JavaScript SDK.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Now that you have the basics down, you can extend this application to include other functions, like \`,\_jsx(\_components.a,{href:\`/sdks/manage-items#update-an-item\`,children:\`updating the secret\`}),\`.\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`learn-more\`,children:\`Learn more\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/service-accounts/get-started/\`,children:\`Get started with service accounts\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://github.com/1Password/onepassword-sdk-js?tab=readme-ov-file#-get-started\`,children:\`Get started with the 1Password JS SDK\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://github.com/1Password/onepassword-sdk-go?tab=readme-ov-file#-get-started\`,children:\`Get started with the 1Password Go SDK\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://github.com/1Password/onepassword-sdk-python?tab=readme-ov-file#requirements\`,children:\`Get started with the 1Password Python SDK\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/get-started/secure-deployment\`,children:\`Workflow: Secure your deployments\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/get-started/build-integrations\`,children:\`Workflow: Build integrations with 1Password\`})}),\`\n\`\]})\]})}function MDXContent(props={}){const{wrapper:MDXLayout}={...\_provideComponents(),...props.components};return MDXLayout?\_jsx(MDXLayout,{...props,children:\_jsx(\_createMdxContent,{...props})}):\_createMdxContent(props)}return{CodeResult,default:MDXContent};function \_missingMdxReference(id,component){throw new Error(\`Expected \`+(component?\`component\`:\`object\`)+\\ \`\\+id+\\\` to be defined: you likely forgot to import, pass, or provide it.\\)}","frontmatter":{},"scope":{"config":{},"pageMetadata":{"title":"Use service accounts with 1Password SDKs","sidebarTitle":"Use with 1Password SDKs","og:description":"Learn how to build a JavaScript application that securely fetches a secret from 1Password using a service account.","description":null,"href":"/service-accounts/setup-tutorial"}}},"mdxSourceWithNoJs":null,"noJsSplices":\[\[146,3043,")=\>null;function \_cr"\]\]},"mdxExtracts":{"tableOfContents":\[{"title":"Prerequisites","slug":"prerequisites","depth":2,"children":\[\]},{"title":"Part 1: Set up a 1Password Service Account","slug":"part-1-set-up-a-1password-service-account","depth":2,"children":\[{"title":"Step 1: Create a new vault","slug":"step-1-create-a-new-vault","depth":3,"children":\[\]},{"title":"Step 2: Create a service account","slug":"step-2-create-a-service-account","depth":3,"children":\[\]},{"title":"Step 3: Create a secret to retrieve with the SDK","slug":"step-3-create-a-secret-to-retrieve-with-the-sdk","depth":3,"children":\[\]}\]},{"title":"Part 2: Install and configure a 1Password SDK","slug":"part-2-install-and-configure-a-1password-sdk","depth":2,"children":\[{"title":"Step 1: Set up a NodeJS runtime environment","slug":"step-1-set-up-a-nodejs-runtime-environment","depth":3,"children":\[\]},{"title":"Step 2: Add support for Modules","slug":"step-2-add-support-for-modules","depth":3,"children":\[\]},{"title":"Step 3: Install the 1Password SDK","slug":"step-3-install-the-1password-sdk","depth":3,"children":\[\]}\]},{"title":"Part 3: Build a JS application to fetch a secret from 1Password","slug":"part-3-build-a-js-application-to-fetch-a-secret-from-1password","depth":2,"children":\[{"title":"Step 1: Import the SDK","slug":"step-1-import-the-sdk","depth":3,"children":\[\]},{"title":"Step 2: Import your service account token","slug":"step-2-import-your-service-account-token","depth":3,"children":\[\]},{"title":"Step 3: Get a secret reference and resolve the secret","slug":"step-3-get-a-secret-reference-and-resolve-the-secret","depth":3,"children":\[\]}\]},{"title":"Conclusion","slug":"conclusion","depth":2,"children":\[\]},{"title":"Learn more","slug":"learn-more","depth":2,"children":\[\]}\],"codeExamples":{}},"jsLinks":\["/\_mintlify/custom/ab-634991b8/5ebc0d10523e8210/static/js/analytics.js","/\_mintlify/custom/ab-634991b8/5bb7437b1c9dcb44/static/js/gtag-prod-sst.js","/\_mintlify/custom/ab-634991b8/ee8ea0eeb20ecd1e/static/js/gtag-sst.js","/\_mintlify/custom/ab-634991b8/f2b239f3d459dc67/api-sdk-terms-notice.js","/\_mintlify/custom/ab-634991b8/3604035e212f8294/homepage-card-icons.js"\],"dynamicCss":".mint-mb-4 {\n margin-bottom: 1rem\n}\n.mint-flex {\n display: flex\n}\n.mint-w-full {\n width: 100%\n}\n.mint-items-center {\n align-items: center\n}\n.mint-gap-1 {\n gap: 0.25rem\n}\n.mint-overflow-hidden {\n overflow: hidden\n}\n.mint-border-t {\n border-top-width: 1px\n}\n.mint-border-t-0 {\n border-top-width: 0px\n}\n.mint-border-\\\[var\\(--op-border-ui\\)\\\] {\n border-color: var(--op-border-ui)\n}\n.mint-bg-gray-100\\/80 {\n background-color: rgb(243 244 246 / 0.8)\n}\n.mint-px-4 {\n padding-left: 1rem;\n padding-right: 1rem\n}\n.mint-py-2\\.5 {\n padding-top: 0.625rem;\n padding-bottom: 0.625rem\n}\n.mint-text-left {\n text-align: left\n}\n.mint-text-\\\[14px\\\] {\n font-size: 14px\n}\n.mint-font-medium {\n font-weight: 500\n}\n.mint-text-gray-600 {\n --tw-text-opacity: 1;\n color: rgb(75 85 99 / var(--tw-text-opacity, 1))\n}\n.mint-transition-all {\n transition-property: all;\n transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);\n transition-duration: 150ms\n}\n.mint-duration-150 {\n transition-duration: 150ms\n}\n.hover\\:mint-bg-gray-200\\/60:hover {\n background-color: rgb(229 231 235 / 0.6)\n}\n.hover\\:mint-text-gray-800:hover {\n --tw-text-opacity: 1;\n color: rgb(31 41 55 / var(--tw-text-opacity, 1))\n}\n.dark\\:mint-border-\\\[var\\(--op-border-ui-dark\\)\\\]:is(.dark \*) {\n border-color: var(--op-border-ui-dark)\n}\n.dark\\:mint-bg-gray-800\\/80:is(.dark \*) {\n background-color: rgb(31 41 55 / 0.8)\n}\n.dark\\:mint-text-gray-400:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(156 163 175 / var(--tw-text-opacity, 1))\n}\n.dark\\:hover\\:mint-bg-gray-700\\/60:hover:is(.dark \*) {\n background-color: rgb(55 65 81 / 0.6)\n}\n.dark\\:hover\\:mint-text-gray-200:hover:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(229 231 235 / var(--tw-text-opacity, 1))\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mb-0\>\* {\n margin-bottom: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mt-0\>\* {\n margin-top: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-b-none\>\* {\n border-bottom-right-radius: 0px !important;\n border-bottom-left-radius: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-t-none\>\* {\n border-top-left-radius: 0px !important;\n border-top-right-radius: 0px !important\n}","subdomain":"ab-634991b8","siteName":"1Password Developer","title":"Use service accounts with 1Password SDKs - 1Password Developer","relatedPagesConfig":{"enabled":true,"limit":3,"mode":"automatic"},"contextualStarterQuestions":\[{"\_id":"6ae4c9302086b3fba440c1ce","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I set up a service account?","status":"active","generatedBy":"contextual","path":"service-accounts/setup-tutorial","createdAt":"2026-10-30T16:43:28.875Z","updatedAt":"2026-10-30T16:43:28.875Z","\_\_v":0},{"\_id":"6ae4c9302086b3fba440c1d0","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I authenticate with SDK?","status":"active","generatedBy":"contextual","path":"service-accounts/setup-tutorial","createdAt":"2026-10-30T16:43:28.875Z","updatedAt":"2026-10-30T16:43:28.875Z","\_\_v":0},{"\_id":"6ae4c9302086b3fba440c1cf","deploymentId":"68a8af9a517ab813d3b84097","questionText":"What SDKs support service accounts?","status":"active","generatedBy":"contextual","path":"service-accounts/setup-tutorial","createdAt":"2026-10-30T16:43:28.875Z","updatedAt":"2026-10-30T16:43:28.875Z","\_\_v":0}\],"navMaps":{"firstHrefInVersion":{},"firstHrefInLanguage":{}},"lastModified":"2026-10-30T16:43:20.752Z","originalFileLocation":"service-accounts/setup-tutorial.mdx"},"headHtml":"\u003cscript data-mint-head\>(function(){var d=document.documentElement,p=null;if(!p){try{p=localStorage.getItem(\\isDarkMode\\)}catch(e){}if(p==='true')p='dark';else if(p==='false')p='light';if(p!=='light'\u0026\u0026p!=='dark'\u0026\u0026p!=='system')p=\\system\\}var r=p==='system'?(matchMedia(\\(prefers-color-scheme: dark)\\).matches?'dark':'light'):p;d.classList.remove(r==='dark'?'light':'dark');d.classList.add(r);d.setAttribute(\\data-theme-preference\\,p)})();\u003c/script\>\u003cmeta data-mint-head name=\\application-name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\generator\\ content=\\Mintlify\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\apple-touch-icon\\ type=\\image/png\\ sizes=\\180x180\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/apple-touch-icon.png\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-16x16.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-32x32.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon.ico\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-16x16.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-32x32.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon.ico\\ media=\\(prefers-color-scheme: dark)\\\>\u003cmeta data-mint-head property=\\og:title\\ content=\\Use service accounts with 1Password SDKs - 1Password Developer\\\>\u003cmeta data-mint-head property=\\og:description\\ content=\\Learn how to build a JavaScript application that securely fetches a secret from 1Password using a service account.\\\>\u003cmeta data-mint-head property=\\og:site_name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head property=\\og:url\\ content=\\https://www.1password.dev/service-accounts/setup-tutorial\\\>\u003cmeta data-mint-head property=\\og:type\\ content=\\website\\\>\u003cmeta data-mint-head property=\\og:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Service+accounts\u0026amp;title=Use+service+accounts+with+1Password+SDKs\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=bf98fd263e53a427a2249f5261434e15b5c67a232a07753abacd4e3a64338e98\\\>\u003cmeta data-mint-head property=\\og:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head property=\\og:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\twitter:card\\ content=\\summary_large_image\\\>\u003cmeta data-mint-head name=\\twitter:title\\ content=\\Use service accounts with 1Password SDKs - 1Password Developer\\\>\u003cmeta data-mint-head name=\\twitter:description\\ content=\\Learn how to build a JavaScript application that securely fetches a secret from 1Password using a service account.\\\>\u003cmeta data-mint-head name=\\twitter:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Service+accounts\u0026amp;title=Use+service+accounts+with+1Password+SDKs\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=bf98fd263e53a427a2249f5261434e15b5c67a232a07753abacd4e3a64338e98\\\>\u003cmeta data-mint-head name=\\twitter:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head name=\\twitter:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\msapplication-config\\ content=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/browserconfig.xml\\\>\u003cmeta data-mint-head name=\\apple-mobile-web-app-title\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\msapplication-TileColor\\ content=\\#104ebb\\\>\u003cmeta data-mint-head name=\\google-site-verification\\ content=\\YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs\\\>\u003clink data-mint-head rel=\\canonical\\ href=\\https://www.1password.dev/service-accounts/setup-tutorial\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\application/xml\\ href=\\/sitemap.xml\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\text/markdown\\ href=\\/service-accounts/setup-tutorial.md\\\>\u003cscript data-mint-head type=\\application/ld+json\\\>{\\@context\\:\\https://schema.org\\,\\@graph\\:\[{\\@type\\:\\Organization\\,\\@id\\:\\https://www.1password.dev/#organization\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\logo\\:{\\@type\\:\\ImageObject\\,\\url\\:\\https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d\\}},{\\@type\\:\\WebSite\\,\\@id\\:\\https://www.1password.dev#website\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\}},{\\@type\\:\\WebPage\\,\\@id\\:\\https://www.1password.dev/service-accounts/setup-tutorial#webpage\\,\\url\\:\\https://www.1password.dev/service-accounts/setup-tutorial\\,\\name\\:\\Use service accounts with 1Password SDKs\\,\\dateModified\\:\\2026-10-30T16:43:20.752Z\\,\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\},\\breadcrumb\\:{\\@id\\:\\https://www.1password.dev/service-accounts/setup-tutorial#breadcrumb\\}},{\\@type\\:\\BreadcrumbList\\,\\@id\\:\\https://www.1password.dev/service-accounts/setup-tutorial#breadcrumb\\,\\itemListElement\\:\[{\\@type\\:\\ListItem\\,\\position\\:1,\\name\\:\\Secrets Automation\\,\\item\\:\\https://www.1password.dev/secrets-automation\\},{\\@type\\:\\ListItem\\,\\position\\:2,\\name\\:\\Service accounts\\,\\item\\:\\https://www.1password.dev/service-accounts\\},{\\@type\\:\\ListItem\\,\\position\\:3,\\name\\:\\Use service accounts with 1Password SDKs\\,\\item\\:\\https://www.1password.dev/service-accounts/setup-tutorial\\}\]},{\\@type\\:\[\\Article\\,\\TechArticle\\\],\\@id\\:\\https://www.1password.dev/service-accounts/setup-tutorial#article\\,\\headline\\:\\Use service accounts with 1Password SDKs\\,\\name\\:\\Use service accounts with 1Password SDKs\\,\\url\\:\\https://www.1password.dev/service-accounts/setup-tutorial\\,\\mainEntityOfPage\\:{\\@id\\:\\https://www.1password.dev/service-accounts/setup-tutorial#webpage\\},\\dateModified\\:\\2026-10-30T16:43:20.752Z\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\},\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\}}\]}\u003c/script\>","siteName":"1Password Developer","nav":{"global":null,"tabs":\[{"tab":"Get Started","pages":\[{"title":"Get Started","href":"/get-started"}\]},{"tab":"Tutorials","pages":\[{"title":"Tutorials","href":"/tutorials"}\]},{"tab":"Security for AI","pages":\[{"title":"Security for AI","href":"/security-for-ai"}\]},{"tab":"Environments","pages":\[{"title":"Environments","href":"/environments"}\]},{"tab":"SSH \u0026 Git","pages":\[{"title":"SSH \u0026 Git","href":"/ssh"}\]},{"tab":"CLI","pages":\[{"title":"CLI","href":"/cli"}\]},{"tab":"SDKs","pages":\[{"title":"SDKs","href":"/sdks"}\]},{"tab":"More Tools","menu":\[{"item":"VS Code","icon":"laptop","pages":\[{"title":"VS Code","href":"/vscode"}\]},{"item":"Shell Plugins","icon":"puzzle-piece","pages":\[{"title":"Shell Plugins","href":"/cli/shell-plugins"}\]},{"item":"Integrations","icon":"puzzle","pages":\[{"title":"Integrations","href":"/integrations"}\]},{"item":"Secrets Automation","icon":"tablet-screen","groups":\[{"group":"Secrets Automation","pages":\[{"title":"1Password Secrets Automation","sidebarTitle":"Overview","href":"/secrets-automation"},{"group":"Service accounts","pages":\[{"title":"1Password Service Accounts","sidebarTitle":"Overview","href":"/service-accounts"},{"title":"Get started with 1Password Service Accounts","sidebarTitle":"Get started","href":"/service-accounts/get-started"},{"title":"Manage service accounts","sidebarTitle":"Manage","href":"/service-accounts/manage-service-accounts"},{"title":"Use service accounts with 1Password CLI","sidebarTitle":"Use with 1Password CLI","description":null,"href":"/service-accounts/use-with-1password-cli"},{"title":"Use service accounts with 1Password SDKs","sidebarTitle":"Use with 1Password SDKs","href":"/service-accounts/setup-tutorial"},{"group":"Integrations","pages":\[{"title":"Use CI/CD integrations with 1Password service accounts","sidebarTitle":"CI/CD integrations","description":null,"href":"/secrets-automation/ci-cd"},{"title":"Use Kubernetes integrations with 1Password service accounts","sidebarTitle":"Kubernetes integrations","href":"/secrets-automation/k8s"},{"title":"Postman","url":"https://learning.postman.com/docs/sending-requests/postman-vault/1password/","href":"/service-accounts/postman"},{"title":"Use the 1Password provider for Pulumi with service accounts","sidebarTitle":"Pulumi","href":"/service-accounts/pulumi"},{"title":"Pulumi ESC","url":"https://www.pulumi.com/docs/esc/integrations/dynamic-secrets/1password-secrets/","href":"/service-accounts/pulumi-esc"},{"title":"Use the 1Password Terraform provider with service accounts","sidebarTitle":"Terraform","href":"/service-accounts/terraform"}\]},{"title":"Service account rate limits","sidebarTitle":"Rate limits","href":"/service-accounts/rate-limits"},{"sidebarTitle":"Security","title":"1Password Service Account security","href":"/service-accounts/security"}\]},{"group":"Connect server","pages":\[{"title":"1Password Connect","sidebarTitle":"Overview","href":"/connect"},{"title":"Get started with a 1Password Connect server","sidebarTitle":"Get started","href":"/connect/get-started"},{"title":"Manage Connect servers","sidebarTitle":"Manage","href":"/connect/manage-connect"},{"title":"Configure your Connect server","sidebarTitle":"Configuration","href":"/connect/server-configuration"},{"title":"Use 1Password CLI with a Connect server","sidebarTitle":"Use with 1Password CLI","href":"/connect/cli"},{"group":"SDKs","expanded":true,"pages":\[{"title":"Go","url":"https://github.com/1Password/connect-sdk-go","href":"/connect/sdks/languages/golang"},{"title":"Node.js","url":"https://github.com/1Password/connect-sdk-js","href":"/connect/sdks/languages/javascript"},{"title":"Python","url":"https://github.com/1Password/connect-sdk-python","href":"/connect/sdks/languages/python"}\]},{"group":"Integrations","pages":\[{"title":"Ansible","href":"/connect/ansible"},{"title":"Deploy 1Password Connect Server on AWS ECS Fargate","sidebarTitle":"AWS ECS Fargate","href":"/connect/aws"},{"title":"Use CI/CD integrations with a 1Password Connect server","sidebarTitle":"CI/CD integrations","href":"/connect/ci-cd"},{"title":"Hashicorp Vault backend","url":"https://github.com/1Password/vault-plugin-secrets-onepassword","href":"/connect/hashicorp"},{"title":"Use Kubernetes integrations with a 1Password Connect server","sidebarTitle":"Kubernetes integrations","href":"/connect/k8s"},{"title":"Use the 1Password provider for Pulumi with Connect","sidebarTitle":"Pulumi","href":"/connect/pulumi"},{"title":"Use the 1Password Terraform provider with Connect","sidebarTitle":"Terraform","href":"/connect/terraform"}\]},{"group":"Reference","pages":\[{"group":"API Reference","pages":\[{"title":"1Password Connect Server API reference","sidebarTitle":"Overview","href":"/connect/api-reference"},{"title":"Get all Vaults","deprecated":null,"version":null,"sidebarTitle":"Get vaults","openapi":"/openapi/connect_server_api.yaml get /vaults","href":"/connect/api-reference/get-vaults"},{"title":"Get Vault details and metadata","deprecated":null,"version":null,"sidebarTitle":"Get vault by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}","href":"/connect/api-reference/get-vault-by-id"},{"title":"Get all items for inside a Vault","deprecated":null,"version":null,"sidebarTitle":"Get vault items","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items","href":"/connect/api-reference/get-vault-items"},{"title":"Create a new Item","deprecated":null,"version":null,"sidebarTitle":"Create vault item","openapi":"/openapi/connect_server_api.yaml post /vaults/{vaultUuid}/items","href":"/connect/api-reference/create-vault-item"},{"title":"Get the details of an Item","deprecated":null,"version":null,"sidebarTitle":"Get vault item by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/get-vault-item-by-id"},{"title":"Update an Item","deprecated":null,"version":null,"sidebarTitle":"Update vault item","openapi":"/openapi/connect_server_api.yaml put /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/update-vault-item"},{"title":"Delete an Item","deprecated":null,"version":null,"sidebarTitle":"Delete vault item","openapi":"/openapi/connect_server_api.yaml delete /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/delete-vault-item"},{"title":"Update a subset of Item attributes","deprecated":null,"version":null,"sidebarTitle":"Patch vault item","openapi":"/openapi/connect_server_api.yaml patch /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/patch-vault-item"},{"title":"Get all the files inside an Item","deprecated":null,"version":null,"sidebarTitle":"Get item files","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files","href":"/connect/api-reference/get-item-files"},{"title":"Get the details of a File","deprecated":null,"version":null,"sidebarTitle":"Get item file by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files/{fileUuid}","href":"/connect/api-reference/get-item-file-by-id"},{"title":"Get the content of a File","deprecated":null,"version":null,"sidebarTitle":"Download item file by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files/{fileUuid}/content","href":"/connect/api-reference/download-item-file-by-id"},{"title":"Retrieve a list of API Requests that have been made.","deprecated":null,"version":null,"sidebarTitle":"Get api activity","openapi":"/openapi/connect_server_api.yaml get /activity","href":"/connect/api-reference/get-api-activity"},{"title":"Ping the server for liveness","deprecated":null,"version":null,"sidebarTitle":"Get heartbeat","openapi":"/openapi/connect_server_api.yaml get /heartbeat","href":"/connect/api-reference/get-heartbeat"},{"title":"Get state of the server and its dependencies.","deprecated":null,"version":null,"sidebarTitle":"Get server health","openapi":"/openapi/connect_server_api.yaml get /health","href":"/connect/api-reference/get-server-health"},{"title":"Query server for exposed Prometheus metrics","deprecated":null,"version":null,"sidebarTitle":"Get prometheus metrics","openapi":"/openapi/connect_server_api.yaml get /metrics","href":"/connect/api-reference/get-prometheus-metrics"}\]},{"title":"Connect concepts","sidebarTitle":"Concepts","href":"/connect/concepts"},{"title":"About 1Password Connect Server security","sidebarTitle":"Security","href":"/connect/security"}\]}\]}\]}\]},{"item":"Events API","icon":"sensor-triangle-exclamation","pages":\[{"title":"Events API","href":"/events-api"}\]},{"item":"Users API","icon":"id-badge","pages":\[{"title":"Users API","href":"/users-api"}\]},{"item":"SaaS Manager API","icon":"chart-line","pages":\[{"title":"SaaS Manager API","href":"/saas-manager-api"}\]},{"item":"Partnership API","icon":"users","pages":\[{"title":"Partnership API","href":"/partnership-api/reference"}\]},{"item":"Accounts API","icon":"user-gear","pages":\[{"title":"Accounts API","href":"/accounts-api"}\]},{"item":"Web Development","icon":"code","pages":\[{"title":"Web Development","href":"/web/add-1password-button-website"}\]},{"item":"Developer Watchtower","icon":"tower-control","pages":\[{"title":"Developer Watchtower","href":"/watchtower"}\]}\]},{"tab":"Agentic Autofill partner guide","hidden":true,"pages":\[{"title":"Agentic Autofill partner guide","href":"/agentic-autofill/partners"}\]}\]},"basePath":"","title":"Use service accounts with 1Password SDKs - 1Password Developer","buildId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","deploymentId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","dynamics":\["10e4515597","07c022d89b","a74be98ba7"\],"chunks":\["BannerMarkdown-CX_qQQOL.js","dist-BTZUMDnx.js","lib-DuNMoZ05.js","lib-B8HbPgcC.js","clsx-xpJZXxdP.js","html-void-elements-mCSPHezU.js","katex-YMM-FMeD.js","marked.esm-CZWythHk.js","Frame-DXXFP6nH.js","DynamicMarkdown-B54_zNBF.js","zoom-image-lightbox-BG6oD64b.js","lightbox-handle-r17bVUz3.js"\]}
