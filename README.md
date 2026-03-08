# Local Developer Setup
The following guides provide the steps to setup a local development environment: 
- [UV](#uv-installation)
- [Python Virtual Environment](#python-virtual-environment-creation)
- [Pre-commit](#pre-commit-setup)
See also:
- [IDEs](#ides)

# UV
## Installation {#uv-installation}
### Ubuntu
```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

# Python Virtual Environment 
## Creation {#python-virtual-environment-creation}
### Prerequisites
- [UV](#uv-installation)
### Command
#### Without Developer Dependencies
```
uv sync
```
#### With Developer Dependences
```
uv sync --extra dev
```

# Pre-commit
## Setup {#pre-commit-setup}
### Prerequisites
- [Python Virtual Environment](#python-virtual-environment)
### Command
```
uv run pre-commit install
```

## Validation
To validate existing files, run `uv run pre-commit run --all-files`

# IDEs
## VSCode
### Interpreter
#### Prerequisites
- [Python Virtual Environment](#python-virtual-environment)
#### Steps
1. `ctrl`+`shift`+`p`
2. Type `Python: Select Interpreter`.
3. Select `./.venv/bin/python`.

### Testing
#### Prerequisites
- [Python Virtual Environment](#python-virtual-environment)
#### Steps
1. Select "Testing" tab.
2. Select "Configure Python Tests".
3. Select `pytest`.
4. Select `tests`.