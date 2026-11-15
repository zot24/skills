> Source: https://www.1password.dev/service-accounts/security/



Service Accounts


# 1Password Service Account security


## <a href="#access-control" class="anchor-link" aria-label="Navigate to header: Access control"></a><span id="_R_39deehkd74t9_" class="cursor-pointer">Access control</span>


## <a href="#service-accounts-and-token-generation" class="anchor-link" aria-label="Navigate to header: Service accounts and token generation"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">Service accounts and token generation</span>


| Element    | Regular user  | Service account |
|------------|---------------|-----------------|
| Secret Key | Generated     | Generated       |
| Password   | User provided | Generated       |


- <a href="#auk" class="link">Account Unlock Key (AUK)</a>
- <a href="#srp" class="link">Secure Remote Password (SRP)</a>


- <div id="encoded">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Encoded">

  Encoded

  </div>

  </div>

- <div id="decoded">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Decoded">

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


### <a href="#token-rotation-and-revocation" class="anchor-link" aria-label="Navigate to header: Token rotation and revocation"></a><span id="_R_139deehkd74t9_" class="cursor-pointer">Token rotation and revocation</span>


- <a href="/service-accounts/manage-service-accounts#revoke-token" class="link">Learn how to revoke a service account token.</a>
- <a href="/service-accounts/manage-service-accounts#rotate-token" class="link">Learn how to rotate a service account token.</a>

## <a href="#security-model" class="anchor-link" aria-label="Navigate to header: Security model"></a><span id="_R_199deehkd74t9_" class="cursor-pointer">Security model</span>


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

## <a href="#terminology" class="anchor-link" aria-label="Navigate to header: Terminology"></a><span id="_R_1f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Terminology</span>

### <a href="#auk" class="anchor-link" aria-label="Navigate to header: Account Unlock Key"></a><span id="_R_1h9deehkd74t9_" class="cursor-pointer">Account Unlock Key</span>


### <a href="#personal-keyset" class="anchor-link" aria-label="Navigate to header: Personal keyset"></a><span id="_R_1l9deehkd74t9_" class="cursor-pointer">Personal keyset</span>


### <a href="#srp" class="anchor-link" aria-label="Navigate to header: Secure Remote Password"></a><span id="_R_1p9deehkd74t9_" class="cursor-pointer">Secure Remote Password</span>


### <a href="#service-account-token" class="anchor-link" aria-label="Navigate to header: Service account token"></a><span id="_R_1t9deehkd74t9_" class="cursor-pointer">Service account token</span>


### <a href="#2skd" class="anchor-link" aria-label="Navigate to header: Two-secret key derivation"></a><span id="_R_219deehkd74t9_" class="cursor-pointer">Two-secret key derivation</span>


## <a href="#responsible-disclosure" class="anchor-link" aria-label="Navigate to header: Responsible disclosure"></a><span id="_R_259deehkd74t9_" class="cursor-pointer">Responsible disclosure</span>


Was this page helpful?


