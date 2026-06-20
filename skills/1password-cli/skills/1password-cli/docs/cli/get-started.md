<!-- Source: https://www.1password.dev/cli/get-started/ -->

# Get Started with 1Password CLI

1Password CLI brings password management to your terminal. This guide covers installation, integration with the 1Password desktop application, and initial authentication using biometric or system authentication methods.

## Step 1: Install 1Password CLI

### Requirements

**Mac:**
- 1Password subscription
- 1Password for Mac
- macOS Big Sur 11.0.0 or later
- Supported shells: Bash, Zsh, sh, fish

**Windows:**
- 1Password subscription
- 1Password for Windows
- Supported shells: PowerShell

**Linux:**
- 1Password subscription
- 1Password for Linux
- PolKit and a running PolKit authentication agent
- Supported shells: Bash, Zsh, sh, fish

### Installation Methods

**Mac - Homebrew:**
```shell
brew install 1password-cli
op --version
```

**Mac - Manual:**
1. Download the [latest 1Password CLI release](https://app-updates.agilebits.com/product_history/CLI2)
2. Open `op.pkg` or extract `op.zip` and move `op` to `usr/local/bin`
3. Verify: `op --version`

**Windows - winget:**
```powershell
winget install 1password-cli
op --version
```

**Windows - Manual:**
1. Download the [latest release](https://app-updates.agilebits.com/product_history/CLI2) and extract `op.exe`
2. Open PowerShell as administrator
3. Create installation folder: `mkdir "C:\Program Files\1Password CLI"`
4. Move file: `mv ".\op.exe" "C:\Program Files\1Password CLI"`
5. Add folder to PATH via Advanced System Settings > Environment Variables
6. Verify: `op --version`

Alternatively, run this single command in PowerShell as administrator:
```powershell
$arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
switch ($arch) {
    '64-bit' { $opArch = 'amd64'; break }
    '32-bit' { $opArch = '386'; break }
    Default { Write-Error "Sorry, your operating system architecture '$arch' is unsupported" -ErrorAction Stop }
}
$installDir = Join-Path -Path $env:ProgramFiles -ChildPath '1Password CLI'
Invoke-WebRequest -Uri "https://cache.agilebits.com/dist/1P/op2/pkg/v2.33.1/op_windows_$($opArch)_v2.33.1.zip" -OutFile op.zip
Expand-Archive -Path op.zip -DestinationPath $installDir -Force
$envMachinePath = [System.Environment]::GetEnvironmentVariable('PATH','machine')
if ($envMachinePath -split ';' -notcontains $installDir){
    [Environment]::SetEnvironmentVariable('PATH', "$envMachinePath;$installDir", 'Machine')
}
Remove-Item -Path op.zip
```

**Linux - APT:**
```shell
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
  sudo tee /etc/apt/sources.list.d/1password.list && \
  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ && \
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
  sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
  sudo apt update && sudo apt install 1password-cli
op --version
```

Direct download links for `.deb` packages:
- [amd64](https://downloads.1password.com/linux/debian/amd64/stable/1password-cli-amd64-latest.deb)
- [386](https://downloads.1password.com/linux/debian/386/stable/1password-cli-386-latest.deb)
- [arm](https://downloads.1password.com/linux/debian/arm/stable/1password-cli-arm-latest.deb)
- [arm64](https://downloads.1password.com/linux/debian/arm64/stable/1password-cli-arm64-latest.deb)

**Linux - YUM:**
```shell
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf check-update -y 1password-cli && sudo dnf install 1password-cli
op --version
```

**Linux - Alpine:**
```shell
echo https://downloads.1password.com/linux/alpinelinux/stable/ >> /etc/apk/repositories
wget https://downloads.1password.com/linux/keys/alpinelinux/support@1password.com-61ddfc31.rsa.pub -P /etc/apk/keys
apk update && apk add 1password-cli
op --version
```

**Linux - NixOS:**
Add to `/etc/nixos/configuration.nix` or `flake.nix`:
```nix
programs._1password = { enable = true; };

programs._1password-gui = {
  enable = true;
  polkitPolicyOwners = [ "<your-linux-username>" ];
};
```

Apply configuration:
```shell
sudo nixos-rebuild switch
# or for flakes:
sudo nixos-rebuild switch --flake <flake-directory-path>.#<output-name>
op --version
```

**Linux - Manual:**
```shell
ARCH="<choose between 386/amd64/arm/arm64>" && \
wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.33.1/op_linux_${ARCH}_v2.33.1.zip" -O op.zip && \
unzip -d op op.zip && \
sudo mv op/op /usr/local/bin/ && \
rm -r op.zip op && \
sudo groupadd -f onepassword-cli && \
sudo chgrp onepassword-cli /usr/local/bin/op && \
sudo chmod g+s /usr/local/bin/op
```

Verify authenticity before moving the binary:
```shell
gpg --keyserver keyserver.ubuntu.com --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
gpg --verify op.sig op
```

## Step 2: Turn on 1Password Desktop App Integration

### Mac

1. Open and unlock the 1Password app
2. Select your account or collection at the top of the sidebar
3. Navigate to Settings > Developer
4. Select "Integrate with 1Password CLI"
5. To authenticate with fingerprint, turn on Touch ID in the app

### Windows

1. Open and unlock the 1Password app
2. Select your account or collection at the top of the sidebar
3. Turn on Windows Hello in the app
4. Navigate to Settings > Developer
5. Select "Integrate with 1Password CLI"

### Linux

1. Open and unlock the 1Password app
2. Select your account or collection at the top of the sidebar
3. Navigate to Settings > Security
4. Turn on "Unlock using system authentication"
5. Navigate to Settings > Developer
6. Select "Integrate with 1Password CLI"

**Alternative authentication method:** Use a service account token scoped to specific vaults or environments. Service accounts are recommended for shared building, automated access, and headless server authentication.

## Step 3: Enter Any Command to Sign In

After enabling app integration, run any command to trigger authentication prompts:

```shell
op vault list
```

### Multiple Accounts

If you have multiple 1Password accounts in your desktop app, use the signin command to select which account to authenticate:

```shell
op signin
```

Output:
```
Select account  [Use arrows to move, type to filter]
> ACME Corp (acme.1password.com)
  AgileBits (agilebits.1password.com)
  Add another account
```

## Next Steps

1. [Get started with basic 1Password CLI commands](/cli/reference/)
2. [Set up 1Password Shell Plugins for authentication with other command-line tools](/cli/shell-plugins/)
3. [Learn to securely load secrets without plaintext secrets in code](/cli/secret-references/)
