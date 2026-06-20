<!-- Source: https://www.1password.dev/cli/ssh-keys/ -->

# Manage SSH Keys

## Requirements

To manage SSH keys with 1Password CLI, you need:

* An active 1Password account
* 1Password CLI version 2.20.0 or later

## Generate an SSH Key

Create a new SSH key using the `op item create` command with the `ssh` category:

```shell
op item create --category ssh --title "My SSH Key"
```

The CLI generates an Ed25519 key by default and stores it in your Personal, Private, or Employee vault. The output displays the key type, public key, and fingerprint (private key is redacted).

To generate an RSA key instead, use the `--ssh-generate-key` flag:

```shell
op item create --category ssh --title "RSA SSH Key" --ssh-generate-key RSA,2048
```

Supported RSA sizes: 2048, 3072, or 4096 bits (default).

**Note:** Use the 1Password desktop app to import existing SSH keys.

## Retrieve a Private Key

Fetch an SSH key's private key in OpenSSH format with `op read`:

```shell
op read "op://Private/ssh keys/ssh key/private key?ssh-format=openssh"
```

This returns the private key in OpenSSH format, ready for use with SSH clients and Git operations.

## Related Resources

* [Supported SSH key types](/ssh/manage-keys#supported-ssh-key-types)
* [1Password for SSH & Git](/ssh/)
* [Managing SSH keys in the 1Password app](/ssh/manage-keys/)
* [Git commit signing with SSH](/ssh/git-commit-signing/)

---

## See also: 1Password SSH Agent & Git commit signing

The 1Password SSH agent (configured in the desktop app, not the CLI) lets SSH and Git use keys stored in 1Password, authorized with biometrics. To use it:

1. In the 1Password desktop app, go to Settings > Developer and turn on **Use the SSH agent**.
2. Point your SSH client at the agent socket:
   - Mac/Linux: `~/.1password/agent.sock` (set `IdentityAgent` in `~/.ssh/config`)
   - Windows: `\\.\pipe\openssh-ssh-agent`
3. For Git commit signing, configure Git to sign with SSH and use the public key stored in 1Password:
   ```shell
   git config --global gpg.format ssh
   git config --global user.signingkey "ssh-ed25519 AAAA..."  # your public key
   git config --global commit.gpgsign true
   ```

Full details: [SSH agent overview](/ssh/agent/) and [Git commit signing](/ssh/git-commit-signing/).
