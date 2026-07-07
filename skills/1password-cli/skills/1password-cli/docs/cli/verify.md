> Source: https://www.1password.dev/cli/verify/



Install


# Verify the authenticity of 1Password CLI


Copy page


Copy page


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


### 


<a href="#zip-file" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
gpg --keyserver keyserver.ubuntu.com --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
gpg --verify op.sig op
```


### 


<a href="#package-file" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Open the 1Password CLI installer. If you see “This package will run a program to determine if the software can be installed”, select **Continue**. This will not begin the installation.
2.  Select the lock icon in the top right corner of the installer window. If you don’t see the lock icon, the package is unsigned, and you shouldn’t install it.
3.  Select **Developer ID Installer: AgileBits Inc. (2BUA8C4S2C)**. If you see a different developer ID, or the certificate doesn’t have a green checkmark indicating that it’s valid, don’t install the package.
4.  Select the triangle next to Details and scroll down.
5.  Make sure that the SHA-256 fingerprint in the installer matches one of the following fingerprints. If they match, the signature is verified. Select **OK** and continue installation.


| Hash | Fingerprint |
|----|----|
| SHA‑256 | CA B5 78 06 1B 02 09 FB 70 93 4D A3 44 EF 6F EB CD 32 79 B1 C0 74 C5 4B 0D 7D 55 57 43 B9 D8 9F |
| SHA‑256 | 14 1D D8 7B 2B 23 12 11 F1 44 08 49 79 80 07 DF 62 1D E6 EB 3D AB 98 5B C9 64 EE 97 04 C4 A1 C1 |


1.  <span data-as="p">Open PowerShell as an Administrator.</span>
2.  <span data-as="p">Verify that the certificate was issued to AgileBits:</span>
3.  <span data-as="p">Verify the certificate was issued by Microsoft Corporation:</span>
4.  <span data-as="p">Verify the EKU matches 1Password’s EKU of `1.3.6.1.4.1.311.97.661420558.769123285.207353056.500447802`:</span>


Was this page helpful?


<a href="/cli/get-started" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Get started</span></a><a href="/cli/install-server" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Install on a server</span></a>


