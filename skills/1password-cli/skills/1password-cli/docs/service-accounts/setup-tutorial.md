> Source: https://www.1password.dev/service-accounts/setup-tutorial/



Service Accounts


# Use service accounts with 1Password SDKs


- Create a new test vault in your 1Password account.
- Create a service account that can only access the test vault.
- Save a secret in the test vault.
- Set up your project, and install and configure the 1Password JS SDK.
- Get a secret reference URI that points to the test secret you created.
- Build a simple application that takes the secret reference as input and outputs the actual secret.


## <a href="#prerequisites" class="anchor-link" aria-label="Navigate to header: Prerequisites"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Prerequisites</span>

1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>.
2.  (Optional) <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.
3.  Basic knowledge of JavaScript.

## <a href="#part-1-set-up-a-1password-service-account" class="anchor-link" aria-label="Navigate to header: Part 1: Set up a 1Password Service Account"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">Part 1: Set up a 1Password Service Account</span>


### <a href="#step-1-create-a-new-vault" class="anchor-link" aria-label="Navigate to header: Step 1: Create a new vault"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">Step 1: Create a new vault</span>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.
2.  Select the plus icon in the sidebar next to your account name.
3.  Enter `Tutorial` for the vault name, then select **Create**.


### <a href="#step-2-create-a-service-account" class="anchor-link" aria-label="Navigate to header: Step 2: Create a service account"></a><span id="_R_j9deehkd74t9_" class="cursor-pointer">Step 2: Create a service account</span>


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

### <a href="#step-3-create-a-secret-to-retrieve-with-the-sdk" class="anchor-link" aria-label="Navigate to header: Step 3: Create a secret to retrieve with the SDK"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">Step 3: Create a secret to retrieve with the SDK</span>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app</a>.
2.  Select **+ New Item** to create a new item.
3.  Select **API credential** for the item category.
4.  For the purpose of this tutorial, enter `tutorial` for the username and `example credential` for the credential.
5.  Select the Tutorial vault you created in step 1 from the dropdown next to the Save icon.
6.  Select **Save** to create the item.


## <a href="#part-2-install-and-configure-a-1password-sdk" class="anchor-link" aria-label="Navigate to header: Part 2: Install and configure a 1Password SDK"></a><span id="_R_v9deehkd74t9_" class="cursor-pointer">Part 2: Install and configure a 1Password SDK</span>


### <a href="#step-1-set-up-a-nodejs-runtime-environment" class="anchor-link" aria-label="Navigate to header: Step 1: Set up a NodeJS runtime environment"></a><span id="_R_139deehkd74t9_" class="cursor-pointer">Step 1: Set up a NodeJS runtime environment</span>


1.  <span data-as="p">Open your terminal and create a new folder named Tutorial:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lc979deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pc979deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tc979deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6c979deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


### <a href="#step-2-add-support-for-modules" class="anchor-link" aria-label="Navigate to header: Step 2: Add support for Modules"></a><span id="_R_1f9deehkd74t9_" class="cursor-pointer">Step 2: Add support for Modules</span>


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


### <a href="#step-3-install-the-1password-sdk" class="anchor-link" aria-label="Navigate to header: Step 3: Install the 1Password SDK"></a><span id="_R_1p9deehkd74t9_" class="cursor-pointer">Step 3: Install the 1Password SDK</span>


``` shiki
npm install @1password/sdk
```


## <a href="#part-3-build-a-js-application-to-fetch-a-secret-from-1password" class="anchor-link" aria-label="Navigate to header: Part 3: Build a JS application to fetch a secret from 1Password"></a><span id="_R_1v9deehkd74t9_" class="cursor-pointer">Part 3: Build a JS application to fetch a secret from 1Password</span>


### <a href="#step-1-import-the-sdk" class="anchor-link" aria-label="Navigate to header: Step 1: Import the SDK"></a><span id="_R_239deehkd74t9_" class="cursor-pointer">Step 1: Import the SDK</span>

1.  <span data-as="p">Create a new file `index.js` in the Tutorial folder:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faoa59deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioa59deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoa59deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coa59deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_faoi59deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioi59deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoi59deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coi59deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_fap259deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fip259deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqp259deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cp259deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


### <a href="#step-2-import-your-service-account-token" class="anchor-link" aria-label="Navigate to header: Step 2: Import your service account token"></a><span id="_R_2b9deehkd74t9_" class="cursor-pointer">Step 2: Import your service account token</span>


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

    <div id="base-ui-_R_7lb8af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pb8af9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tb8af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6b8af9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7ld8af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pd8af9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7td8af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6d8af9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7lf8af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pf8af9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tf8af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6f8af9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7lb9af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pb9af9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tb9af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6b9af9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7ld9af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pd9af9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7td9af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6d9af9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7lf9af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pf9af9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tf9af9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6f9af9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7lb9if9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pb9if9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tb9if9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6b9if9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7ld9if9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pd9if9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7td9if9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6d9if9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7lf9if9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pf9if9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tf9if9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6f9if9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


### <a href="#step-3-get-a-secret-reference-and-resolve-the-secret" class="anchor-link" aria-label="Navigate to header: Step 3: Get a secret reference and resolve the secret"></a><span id="_R_2p9deehkd74t9_" class="cursor-pointer">Step 3: Get a secret reference and resolve the secret</span>


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

    <div id="base-ui-_R_7lcbf9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcbf9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcbf9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cbf9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_7lcjf9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcjf9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcjf9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cjf9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


## <a href="#conclusion" class="anchor-link" aria-label="Navigate to header: Conclusion"></a><span id="_R_3l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Conclusion</span>


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_3r9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/service-accounts/get-started/" class="link">Get started with service accounts</a>
- <a href="https://github.com/1Password/onepassword-sdk-js?tab=readme-ov-file#-get-started" class="link" target="_blank" rel="noreferrer">Get started with the 1Password JS SDK</a>
- <a href="https://github.com/1Password/onepassword-sdk-go?tab=readme-ov-file#-get-started" class="link" target="_blank" rel="noreferrer">Get started with the 1Password Go SDK</a>
- <a href="https://github.com/1Password/onepassword-sdk-python?tab=readme-ov-file#requirements" class="link" target="_blank" rel="noreferrer">Get started with the 1Password Python SDK</a>
- <a href="/get-started/secure-deployment" class="link">Workflow: Secure your deployments</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


