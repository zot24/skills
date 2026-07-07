> Source: https://www.1password.dev/service-accounts/security/



Service accounts


# 1Password Service Account security


Copy page


Copy page


## 


<a href="#access-control" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#service-accounts-and-token-generation" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Element    | Regular user  | Service account |
|------------|---------------|-----------------|
| Secret Key | Generated     | Generated       |
| Password   | User provided | Generated       |


- <a href="#auk" class="link">Account Unlock Key (AUK)</a>
- <a href="#srp" class="link">Secure Remote Password (SRP)</a>


- <div id="encoded">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Encoded">

  Encoded

  </div>

  </div>

- <div id="decoded">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Decoded">

  Decoded

  </div>

  </div>


``` shiki
ops_eyJ...EXAMPLE-TOKEN-REDACTED
```


``` shiki
{
  "email": "ejwe64qmlxhri@1passwordserviceaccounts.lcl",
  "muk": {
    "alg": "A256GCM",
    "ext": true,
    "k": "M8VPfIc8VEfThcMXLaKCKF8sMh5JMZsPAtu92fQNb-o",
    "key_ops": [
      "encrypt",
      "decrypt"
    ],
    "kty": "oct",
    "kid": "mp"
  },
  "secretKey": "A3-C4ZJMN-PQTZTL-HGL84-G64M7-KVZRN-4ZVP6",
  "srpX": "870d67a9e626625d9e368507804c9c32e661c57e7e558778291bf29d5a279ae1",
  "signInAddress": "gotham.b5local.com:4000",
  "userAuth": {
    "method": "SRPg-4096",
    "alg": "PBES2g-HS256",
    "iterations": 100000,
    "salt": "FMRUPiyrN4Xf_8Hoh6YRXQ"
  },
  "throttleSecret": {
    "seed": "ddc20da89d71ff640f36bb6c446c64d56a2123eb4e7bd9c89ce303075eea5780",
    "uuid": "TP4Z5ZB7IJABDPGIVSUZLY4T5A"
  },
  "deviceUuid": "ay5shynibdyqisjz3j63b7uygy"
}
```


### 


<a href="#token-rotation-and-revocation" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/service-accounts/manage-service-accounts#revoke-token" class="link">Learn how to revoke a service account token.</a>
- <a href="/service-accounts/manage-service-accounts#rotate-token" class="link">Learn how to rotate a service account token.</a>

## 


<a href="#security-model" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <span data-as="p">A service account can only read items from vaults it has READ access to.</span>
- <span data-as="p">A service account can only update, delete, and create items for vaults it has WRITE access to.</span>
- <span data-as="p">The creator of a service account can only grant the service account access to vaults that the creator has access to.</span>
- <span data-as="p">You can’t grant a service account access to vaults that have service accounts turned off, even if the creator of the service account has permissions to manage the vault.</span>
- <span data-as="p">Disabling service accounts for a vault removes access to that vault from all pre-existing service accounts.</span>
- <span data-as="p">By default, account <a href="https://support.1password.com/1password-glossary#owner" class="link" target="_blank" rel="noreferrer">owners</a> and <a href="https://support.1password.com/1password-glossary#administrator" class="link" target="_blank" rel="noreferrer">administrators</a> can create service accounts.</span>
  - All owners and administrators can view service account details and delete service accounts, but they can’t view the generated service account token.
  - Owners and administrators can <a href="/service-accounts/manage-service-accounts#manage-who-can-create-service-accounts" class="link">give other team members access</a> to create and manage their own service accounts.
  - Team members can only grant service accounts access to a vault if they have the `Manage Vault` permission for that vault.
- <span data-as="p">A service account token associated with a deleted service account can’t authenticate.</span>
- <span data-as="p">You can’t add vault access to a generated service account after creation.</span>
- <span data-as="p">A service account can’t create another service account.</span>
- <span data-as="p">A service account can’t manage users.</span>

## 


<a href="#terminology" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#auk" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#personal-keyset" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#srp" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#service-account-token" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#2skd" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#responsible-disclosure" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Was this page helpful?


<a href="/service-accounts/rate-limits" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Rate limits</span></a><a href="/connect" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Overview</span></a>


