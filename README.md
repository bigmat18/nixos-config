<p align="center">
  <img src="https://nixos.wiki/images/thumb/2/20/Home-nixos-logo.png/207px-Home-nixos-logo.png" alt="NixOS Logo" width="120"/>
</p>

<h1 align="center">NixOS Config 🔧</h1>

<p align="center">
  <b>My personal, modular, and reproducible NixOS configuration</b><br/>
  <i>For development, productivity, and 3D graphics</i>
</p>

---

## ✨ Features

- 🧩 **Modular structure** — Easy to maintain and extend
- 🏠 **Home Manager** — User environment management
- 💻 **Multi-host support** — Laptop, desktop, and more
- 🎨 **Custom overlays** — Personal packages and tweaks
- 🖥️ **Focus on 3D & graphics** — Optimized for Computer Graphics workflows

---

## 🚀 Getting Started

> ⚠️  **This config is tailored to my hardware and workflow. Use at your own risk!**

### Prerequisites

- [NixOS](https://nixos.org/) installed
- Basic knowledge of Nix and NixOS

### Installation

```sh
git clone https://github.com/bigmat18/nixos-config.git
cd nixos-config
```

- Review and adapt the configuration to your hardware and preferences.

```sh
sudo nixos-rebuild switch --flake .#your-hostname
```

---

## 📁 Structure

| Folder/File      | Description                        |
|------------------|------------------------------------|
| `hosts/`         | Per-machine configurations         |
| `modules/`       | Custom NixOS modules               |
| `home/`          | Home Manager configs               |
| `overlays/`      | Custom package overlays            |
| `flake.nix`      | Flake entry point                  |

---

## 🙏 Credits

- Inspired by the amazing [NixOS community](https://nixos.org/community.html) and many public dotfiles repos.

---

<p align="center">
  🚀<br/>
  <b>Happy hacking!</b>
</p>