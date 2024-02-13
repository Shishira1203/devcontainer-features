
# LazyVim (lazyvim)

Provide essentials features for lazyvim inside devcontainers

## Example Usage

```json
"features": {
    "ghcr.io/Shishira1203/devcontainer-features/lazyvim:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| git | If true, git will be installed | boolean | true |
| build_essential | If true, build essential will be installed | boolean | true |
| wget | If true, wget will be installed | boolean | true |
| curl | If true, curl will be installed | boolean | true |
| python3 | If true, python3 will be installed | boolean | true |
| pip3 | If true, pip3 will be installed | boolean | true |
| python_is_python3 | If true, python-is-python3 will be installed | boolean | true |
| fd | If true, fd will be installed | boolean | true |
| ripgrep | If true, ripgrep will be installed | boolean | true |
| unzip | If true, unzip will be installed | boolean | true |
| lazygit | If true, lazygit will be installed | boolean | true |
| install_nvim | If true, neovim will be installed | boolean | true |
| nvim_version | Select the neovim version you want to install as present in GitHub Releases | string | stable |
| lazyvim_starter | If true, lazyvim starter will be installed | boolean | false |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/Shishira1203/devcontainer-features/blob/main/src/lazyvim/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
