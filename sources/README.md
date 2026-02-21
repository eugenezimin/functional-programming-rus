# Haskell + Cabal Installation Guide
### macOS · Windows · Visual Studio Code

> **Recommended toolchain:** GHCup is the official, community-endorsed installer for the entire Haskell ecosystem. It manages GHC, Cabal, HLS (Haskell Language Server), and Stack — all from one tool.

---

## Table of Contents

1. [macOS Installation](#1-macos-installation)
2. [Windows Installation](#2-windows-installation)
3. [Visual Studio Code Setup](#3-visual-studio-code-setup)
4. [Verifying Your Setup](#4-verifying-your-setup)
5. [Your First Cabal Project](#5-your-first-cabal-project)
6. [Useful GHCup Commands Reference](#6-useful-ghcup-commands-reference)
7. [Troubleshooting](#7-troubleshooting)

---

## 1. macOS Installation

### Step 1 — Prerequisites

Ensure you have the Xcode Command Line Tools installed. Open **Terminal** and run:

```bash
xcode-select --install
```

If already installed, this will say so. If not, a dialog will appear — click **Install** and wait for it to finish.

> **Apple Silicon (M1/M2/M3) note:** GHCup provides native ARM64 binaries. Make sure you're running a native ARM64 Terminal (not Rosetta). If you installed Stack previously via the official Stack website, those binaries are x86 and will trigger Rosetta — **use GHCup for native binaries instead**.

### Step 2 — Install GHCup

Run the official bootstrap script in Terminal:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

The interactive installer will ask you several questions:

- **Prepend GHCup to PATH in your shell profile?** → Type `P` and press Enter (recommended)
- **Install Haskell Language Server (HLS)?** → Type `Y` (needed for VS Code)
- **Install Stack?** → Optional; type `N` if you only want Cabal

Wait for the download and installation to complete. This installs the latest recommended versions of GHC and Cabal automatically.

### Step 3 — Reload Your Shell

Apply the PATH changes immediately without restarting Terminal:

```bash
source ~/.ghcup/env
```

For permanent effect this is already written to your `~/.bashrc`, `~/.zshrc`, or `~/.bash_profile` (depending on your shell). New terminal windows will pick it up automatically.

### Step 4 — Update Cabal Package Index

```bash
cabal update
```

This fetches the latest package metadata from Hackage (the Haskell package registry).

### Step 5 — Verify Installation

```bash
ghcup --version
ghc --version
cabal --version
```

You should see version numbers for all three tools.

---

## 2. Windows Installation

### Step 1 — Prerequisites

- Windows 10 or Windows 11 (64-bit)
- **PowerShell 5.1+** (pre-installed on both) or Windows Terminal (recommended)
- At least 10 GB of free disk space (GHC toolchains are large)

GHCup on Windows automatically installs **MSYS2**, which provides the Unix-like environment (gcc, make, etc.) that GHC requires for compilation. You do **not** need to install MSYS2 manually.

### Step 2 — Install GHCup via PowerShell

Open **PowerShell as Administrator** (right-click PowerShell → "Run as administrator") and run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -ArgumentList $true
```

The installer will:
1. Ask where to install GHCup (default: `C:\ghcup`)
2. Ask where to install Cabal files (default: `C:\cabal`)
3. Download and install MSYS2
4. Download and install the latest recommended GHC
5. Optionally install HLS → **choose Yes** for VS Code support

> **Important:** Accept all default paths unless you have a specific reason to change them. Non-standard paths can cause issues with the `cabal.config` file later.

### Step 3 — Set Required Environment Variables

GHCup should set these automatically, but verify them. Open **System Properties → Environment Variables** and confirm:

| Variable | Value (defaults) |
|---|---|
| `GHCUP_INSTALL_BASE_PREFIX` | `C:\` |
| `GHCUP_MSYS2` | `C:\msys64` |
| `CABAL_DIR` | `C:\cabal` |

Also ensure your **PATH** includes:
- `C:\ghcup\bin`
- `C:\cabal\bin`
- `C:\msys64\mingw64\bin`
- `C:\msys64\usr\bin`

If any of these are missing, add them manually through **Environment Variables → System Variables → Path → Edit**.

### Step 4 — Configure cabal.config for Windows

GHCup will create a `cabal.config` file (usually at `C:\cabal\config`). Open it in a text editor and ensure the following lines are set (uncomment and edit as needed):

```
extra-include-dirs: C:\msys64\mingw64\include
extra-lib-dirs: C:\msys64\mingw64\lib
extra-prog-path: C:\ghcup\bin, C:\cabal\bin, C:\msys64\mingw64\bin, C:\msys64\usr\bin
```

### Step 5 — Fix MSYS2 Home Directory

Run this in PowerShell (not MSYS2 shell) to make the MSYS2 `HOME` match your Windows home:

```powershell
ghcup run -m -- sed -i -e 's/db_home:.*$/db_home: windows/' /c/msys64/etc/nsswitch.conf
```

And enable path inheritance in the MSYS2 shell:

```powershell
ghcup run -m -- sed -i -e 's/rem set MSYS2_PATH_TYPE=inherit/set MSYS2_PATH_TYPE=inherit/' /c/msys64/msys2_shell.cmd
```

### Step 6 — Update Cabal Package Index

Open a **new** PowerShell window (so the updated PATH is loaded) and run:

```powershell
cabal update
```

### Step 7 — Verify Installation

```powershell
ghcup --version
ghc --version
cabal --version
```

---

## 3. Visual Studio Code Setup

This section applies to both macOS and Windows.

### Step 1 — Install VS Code

Download and install VS Code from https://code.visualstudio.com if you haven't already.

### Step 2 — Install the Haskell Extension

Open VS Code and go to the Extensions panel (`Ctrl+Shift+X` / `Cmd+Shift+X`). Search for **"Haskell"** and install the extension published by **"Haskell"** (identifier: `haskell.haskell`).

Alternatively, install from the command line:

```bash
code --install-extension haskell.haskell
```

This extension is powered by **Haskell Language Server (HLS)** and provides:
- Type information on hover
- Auto-completion
- Go to definition
- Inline error diagnostics (powered by hlint)
- Code formatting
- Module name suggestions
- Rename refactoring

### Step 3 — Ensure GHCup is in PATH for VS Code

VS Code may not inherit your full shell PATH, especially on macOS if you launch it from the Dock (not from the terminal).

**macOS:** Add the following to your VS Code user settings (`Cmd+Shift+P` → "Open User Settings (JSON)"):

```json
{
  "haskell.serverEnvironment": {
    "PATH": "${HOME}/.ghcup/bin:${HOME}/.cabal/bin:$PATH"
  }
}
```

**Windows:** GHCup's paths should already be in the system PATH, so this is usually not necessary. If the extension fails to start HLS, add:

```json
{
  "haskell.serverEnvironment": {
    "PATH": "C:\\ghcup\\bin;C:\\cabal\\bin;C:\\msys64\\mingw64\\bin;${env:PATH}"
  }
}
```

### Step 4 — Configure the Extension to Use GHCup

The Haskell extension can manage HLS installations automatically via GHCup. Open VS Code settings and set:

```json
{
  "haskell.manageHLS": "GHCup"
}
```

This tells the extension to delegate all HLS version management to GHCup, which is the cleanest approach. With this setting, the extension will install the correct HLS version for your active GHC version automatically.

### Step 5 — (Optional) Pin Specific Toolchain Versions

If you want to lock your project to a specific HLS or GHC version, add to your workspace settings (`.vscode/settings.json`):

```json
{
  "haskell.toolchain": {
    "hls": "2.9.0.1",
    "ghc": null,
    "cabal": null,
    "stack": null
  }
}
```

Setting `ghc`, `cabal`, and `stack` to `null` tells the extension not to install those through itself — GHCup already manages them. Only `hls` is managed by the extension through GHCup here.

### Step 6 — Recommended Additional Extensions

| Extension | Purpose |
|---|---|
| `justusadam.language-haskell` | Syntax highlighting fallback |
| `haskell.haskell` | Main extension (already installed) |
| `formulahendry.code-runner` | Quick run snippets in editor |

### Step 7 — Open a Project and Test

Open a folder containing a `.cabal` project (`File → Open Folder`). The Haskell extension will detect the project type and start HLS in the background. You'll see a spinning indicator in the status bar saying "Haskell: Starting" — wait for it to complete (can take 1–2 minutes on first load while it indexes).

Once ready, open any `.hs` file. Hover over a function — you should see its type signature in a tooltip. This confirms HLS is working correctly.

---

## 4. Verifying Your Setup

Run these commands to confirm everything is properly installed:

```bash
# GHCup itself
ghcup --version

# Glasgow Haskell Compiler
ghc --version

# Cabal build tool
cabal --version

# Haskell Language Server
haskell-language-server-wrapper --version

# Interactive REPL
ghci
```

In `ghci`, try a quick test:

```haskell
Prelude> 2 + 2
4
Prelude> map (*2) [1..5]
[2,4,6,8,10]
Prelude> :quit
```

---

## 5. Your First Cabal Project

Create and run a minimal Haskell project:

```bash
mkdir hello-haskell
cd hello-haskell
cabal init --non-interactive
cabal run
```

You should see output like:

```
Hello, Haskell!
```

To add an external dependency, edit `hello-haskell.cabal` and add a package to `build-depends`:

```cabal
executable hello-haskell
  main-is:          Main.hs
  build-depends:    base ^>=4.17, text ^>=2.0
  ...
```

Then run `cabal build` — Cabal will fetch and compile the dependency automatically.

---

## 6. Useful GHCup Commands Reference

```bash
# List all available and installed tools
ghcup list

# Install the latest recommended GHC
ghcup install ghc

# Install a specific GHC version
ghcup install ghc 9.8.2

# Switch active GHC version
ghcup set ghc 9.8.2

# Install latest Cabal
ghcup install cabal latest

# Install Haskell Language Server
ghcup install hls

# Update GHCup itself
ghcup upgrade

# Remove a GHC version
ghcup rm ghc 9.6.4

# Launch the interactive TUI (text-based UI for managing tools)
ghcup tui
```

The `ghcup tui` command opens a full-screen terminal interface where you can install, remove, and switch between tool versions interactively — very convenient.

---

## 7. Troubleshooting

### "command not found: ghc" or "ghcup: not found"

Your shell PATH isn't set up correctly. Run:

```bash
# macOS / Linux
source ~/.ghcup/env

# Then verify:
echo $PATH | grep ghcup
```

On Windows, open a fresh PowerShell and check that `C:\ghcup\bin` is in `$env:PATH`.

### HLS fails to start in VS Code

1. Check the **Output** panel in VS Code (`View → Output`) and select "Haskell" from the dropdown — it will show HLS startup logs and any errors.
2. Make sure GHCup is in PATH for VS Code (see Step 3 of the VS Code section).
3. Run `ghcup install hls` in terminal to ensure HLS is installed for your current GHC version.
4. Try running `haskell-language-server-wrapper --version` in a terminal — if that fails, HLS isn't installed or not in PATH.

### VS Code shows spurious "GHC/Cabal not installed" warnings when using Stack

If you're using Stack and see these warnings, add this to your VS Code settings to suppress them:

```json
{
  "haskell.toolchain": {
    "ghc": null,
    "cabal": null,
    "stack": null
  }
}
```

### `cabal build` fails with missing C libraries (Windows)

Ensure your `cabal.config` has the correct `extra-include-dirs` and `extra-lib-dirs` pointing to your MSYS2 `mingw64` directory (see Step 4 of the Windows section).

### Apple Silicon: `ghc` crashes or produces wrong architecture binaries

Make sure you installed GHCup in a native ARM64 terminal (not under Rosetta). To check:

```bash
arch
# Should print: arm64
```

If it says `i386`, your terminal is running under Rosetta. Open a new terminal natively or adjust your Terminal app settings.

### GHCup installation script fails with certificate errors

If behind a corporate proxy or firewall with SSL inspection, you may need to install custom CA certificates. Alternatively, try downloading the GHCup binary directly from https://downloads.haskell.org/~ghcup/ and placing it in your PATH manually, then running `ghcup install ghc`.

---

*Guide based on GHCup documentation and HLS documentation as of early 2026. Visit https://www.haskell.org/ghcup/ for the latest updates.*
