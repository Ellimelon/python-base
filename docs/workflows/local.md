# Local Host Workflow
Use the local host workflow when you want to:
- run tests from your IDE
- use local linting and type-checking
- debug Python code locally
- use `pre-commit`

## Contents
- [UV Installation](#uv-installation)
- [Python Environment](#python-environment)
- [Pre-commit](#pre-commit)
- IDEs
  - [PyCharm](ides/pycharm.md)
  - [VS Code](ides/vscode.md)

## UV Installation
### Ubuntu
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Python Environment
### Prerequisites
- [UV Installation](#uv-installation)

### Setup
For normal contributor setup, install the local development environment with:

```bash
uv sync --extra dev
```

This creates `.venv` and installs the development tools used by this repository.

### Optional: Runtime-only Setup
If you only need the runtime dependency set locally, you can use:

```bash
uv sync
```

## Pre-commit

### Prerequisites
- [Python Environment](#python-environment)

### Setup
Install pre-commit hooks from the local host environment with:

```bash
uv run pre-commit install
```

Once installed, the Git commit hooks run automatically during `git commit`.

### Manual Validation
To validate existing files, run:

```bash
uv run pre-commit run --all-files
```
