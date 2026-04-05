# Contents
- [Local Developer Setup](#local-developer-setup)
  - [Local Host Workflows](#local-host-workflow)
    - [UV Installation](#uv-installation)
    - [Local Python Environment](#local-python-environment)
    - [Pre-commit](#pre-commit)
    - [IDEs](#ides)
      - [VSCode](#vscode)
  - [Container Workflow](#container-workflow)
    - [Start the Workspace Container](#start-the-workspace-container)
    - [Run Commands in the Container](#run-commands-in-the-container)
    - [Stop the Workspace Container](#stop-the-workspace-container)
    - [When to Rebuild](#when-to-rebuild)
- [Forking](#forking)

# Local Developer Setup

This repository supports two development workflows:

- [Local Host Workflow](#local-host-workflow), with `uv` and a local `.venv`.
   Use this for IDE integration, local testing, linting, type-checking, and debugging.
- [Container Workflow](#container-workflow) with `docker compose`.
   Use this for running the application in a containerized environment and for container-native commands.

## Local Host Workflow
Use the local host workflow when you want to:
- run tests from your IDE
- use local linting and type-checking
- debug Python code locally
- use `pre-commit`

### UV Installation

#### Ubuntu
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Local Python Environment

#### Prerequisites
- [UV Installation](#uv-installation)

#### Setup
For normal contributor setup, install the local development environment with:

```bash
uv sync --extra dev
```

This creates `.venv` and installs the development tools used by this repository.

#### Optional: Runtime-only Setup
If you only need the runtime dependency set locally, you can use:

```bash
uv sync
```


### Pre-commit

#### Prerequisites
- [Local Python Environment](#local-python-environment)

#### Setup
Install pre-commit hooks from the local host environment with:

```bash
uv run pre-commit install
```

Once installed, the Git commit hooks run automatically during `git commit`.

#### Manual Validation
To validate existing files, run:

```bash
uv run pre-commit run --all-files
```

### IDEs

#### Prerequisites
- [Local Python Environment](#local-python-environment)

#### VSCode

##### Interpreter
Use the local `.venv` interpreter for IDE-based testing and debugging.

POSIX path:
```text
./.venv/bin/python
```

Windows path:
```text
.\.venv\Scripts\python.exe
```

###### Steps
1. Press `ctrl` + `shift` + `p`.
2. Run `Python: Select Interpreter`.
3. Select the interpreter from `.venv`.

##### Testing

###### Steps
1. Select the "Testing" tab.
2. Select "Configure Python Tests".
3. Select `pytest`.
4. Select `tests`.

You can also run tests directly on the host with:

```bash
uv run pytest
```

## Container Workflow
Use the container workflow when you want to:
- run the application in a containerized environment
- execute commands inside the workspace container
- work against the same container setup defined by `Dockerfile` and `docker-compose.yaml`

The `dev` container installs the project in editable mode. The container bind-mounts only the files it needs for active development, including `src/`, `tests/`, `pyproject.toml`, `uv.lock`, and `README.md`.

### Start the Workspace Container
Build and start the workspace container with:

```bash
docker compose up -d --build
```

### Run Commands in the Container
Run commands inside the `dev` service with:

```bash
docker compose exec dev <command>
```

Examples:

```bash
docker compose exec dev pytest
docker compose exec dev ruff check .
docker compose exec dev mypy
docker compose exec dev bash
```

### Stop the Workspace Container
```bash
docker compose down
```

### When to Rebuild

#### Rebuild Not Required
You do not usually need to rebuild Docker images when:
- you change application source code under `src/`
- you change tests

#### Rebuild Required
You should rebuild the container environment when you change:
- `pyproject.toml`
- `uv.lock`
- `Dockerfile`
- `docker-compose.yaml`

These changes affect dependency resolution, image contents, or container configuration.

A rebuild can be triggered with:

```bash
docker compose up -d --build
```

# Forking

After you fork or copy this repository, update the project identity before you build on it further.

## Rename Checklist
- Update the project name and metadata in `pyproject.toml`.
- Rename the package directory `src/python_base` to match the new import path.
- Update the Compose project name in `docker-compose.yaml` if you do not want to keep `python-base`.
- Update commands in `Dockerfile`.
