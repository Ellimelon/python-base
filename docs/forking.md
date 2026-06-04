# Forking
After you fork or copy this repository, update the project identity before you build on it further.

## Rename Checklist
- Update the project name and metadata in `pyproject.toml`.
- Rename the package directory `src/python_base` to match the new import path.
- Update the Compose project name in `docker-compose.yaml` if you do not want to keep `python-base`.
- Update commands in `Dockerfile`.
