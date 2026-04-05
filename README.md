# Local Developer Setup

This repository supports two development workflows:

1. Local host development with `uv` and a local `.venv`.
   Use this for IDE integration, local testing, linting, type-checking, and debugging.
2. Containerized development with `docker compose`
   Use this for running the application in a containerized environment and for container-native commands.

The local `.venv` remains the recommended interpreter for IDEs. The `dev` container is a workspace container and is not intended to replace your IDE interpreter.

## Contents
- [Development Workflows](#development-workflows)
- [UV Installation](#uv-installation)
- [Local Python Environment](#local-python-environment)
- [IDEs](#ides)
- [Container Workflow](#container-workflow)
- [When to Rebuild](#when-to-rebuild)
- [Pre-commit](#pre-commit)

## Development Workflows

### Local Host Workflow
Use the local host workflow when you want to:
- run tests from your IDE
- use local linting and type-checking
- debug Python code locally
- use `pre-commit`

### Container Workflow
Use the container workflow when you want to:
- run the application in a containerized environment
- execute commands inside the workspace container
- work against the same container setup defined by `Dockerfile` and `docker-compose.yaml`

The `dev` container installs the project in editable mode, so source changes in the bind-mounted repository are visible immediately inside the container without rebuilding the image.

## UV Installation

### Ubuntu
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Local Python Environment

### Prerequisites
- [UV Installation](#uv-installation)

### Recommended Setup
For normal contributor setup, install the local development environment with:

```bash
uv sync --extra dev
```

This creates `.venv` and installs the development tools used by this repository.

### Optional Runtime-only Setup
If you only need the runtime dependency set locally, you can use:

```bash
uv sync
```

## IDEs

### Prerequisites
- [Local Python Environment](#local-python-environment)

### VSCode

#### Interpreter
Use the local `.venv` interpreter for IDE-based testing and debugging.

POSIX path:
```text
./.venv/bin/python
```

Windows path:
```text
.\.venv\Scripts\python.exe
```

##### Steps
1. Press `ctrl` + `shift` + `p`.
2. Run `Python: Select Interpreter`.
3. Select the interpreter from `.venv`.

#### Testing

##### Steps
1. Select the "Testing" tab.
2. Select "Configure Python Tests".
3. Select `pytest`.
4. Select `tests`.

You can also run tests directly on the host with:

```bash
uv run pytest
```

## Container Workflow

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
docker compose exec dev mypy src
docker compose exec dev bash
```

### Stop the Workspace Container
```bash
docker compose down
```

## When to Rebuild

### Rebuild Not Required
You do not usually need to rebuild Docker images when:
- you change application source code under `src/`
- you change tests
- you change other bind-mounted project files that are only used at runtime inside the workspace container

This is because the repository is bind-mounted into `/app` in the `dev` service.

### Rebuild Required
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

## Pre-commit

### Prerequisites
- [Local Python Environment](#local-python-environment)

### Setup
Install pre-commit hooks from the local host environment with:

```bash
uv run pre-commit install
```

### Manual Validation
To validate existing files, run:

```bash
uv run pre-commit run --all-files
```
