<p align="center">
  <img src="https://nixos.wiki/images/thumb/2/20/Home-nixos-logo.png/207px-Home-nixos-logo.png" alt="NixOS Logo" width="100"/>
</p>

<h1 align="center">NixOS & Dotfiles ❄️</h1>

<p align="center">
  <b>Modular NixOS, Home Manager, and Development Shells</b><br/>
  Optimized for 3D graphics, high-performance computing, and cross-platform consistency.
</p>

---

## 🛠️ Highlights

- **Hybrid Setup:** Full NixOS for **Desktop** and a standalone Home Manager configuration for **WSL**.
- **Specialized Shells:** Pre-configured `nix develop` environments for **CUDA**, **MPI**, **Graphics**, Python, and JS.
- **FHS Escape Hatch:** Includes a **Dockerfile** (Ubuntu-based) to run binaries or tools that struggle with NixOS's non-standard filesystem (FHS).
- **Full Dots:** Managed configurations for **Neovim, Tmux, i3, Zsh**, and more.

## 📁 Repository Structure

| Folder/File | Description |
| :--- | :--- |
| `hosts/` | Machine-specific configs: `desktop` (NixOS) and `wsl` (Home Manager). |
| `modules/` | Divided into `system` (NixOS core) and `home` (User environment). |
| `shells/` | Dev environments: `cuda`, `mpi`, `graphics`, `py`, `js`. |
| `dockerfile` | Containerized Ubuntu environment for FHS-dependent software. |
| `flake.nix` | Main entry point for the entire configuration. |
| `stykux.nix` | Personal configuration/user-specific overrides. |

## 🚀 Usage

### Apply System/Home Configuration
```bash
# For NixOS Desktop
sudo nixos-rebuild switch --flake .#desktop

# For WSL (Home Manager standalone)
home-manager switch --flake .#wsl