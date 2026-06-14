# Container Workflow
Use the container workflow when you want to:
- run the application in a containerized environment
- execute commands inside the workspace container
- work against the same container setup defined by `Dockerfile` and `docker-compose.yaml`

The `dev` container inherits runtime dependencies from the `mounted-runtime` image, adds only the `dev` dependency group, and installs the project in editable mode. The container bind-mounts only the files it needs for active development, including `src/`, `tests/`, `pyproject.toml`, `uv.lock`, and `README.md`.

## Contents
- [Start the Workspace Container](#start-the-workspace-container)
- [Run Commands in the Container](#run-commands-in-the-container)
- [Stop the Workspace Container](#stop-the-workspace-container)
- [When to Rebuild](#when-to-rebuild)


## Start the Workspace Container
Build and start the workspace container with:

```bash
docker compose up -d --build
```

## Run Commands in the Container
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

## Stop the Workspace Container
```bash
docker compose down
```

## When to Rebuild

### Rebuild Not Required
You do not usually need to rebuild Docker images when:
- you change application source code under `src/`
- you change tests

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
