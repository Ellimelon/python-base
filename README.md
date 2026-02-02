# Setup
## Poetry Install
`poetry install`

## Pre-commit Install
`poetry run pre-commit install`

## VSCode
### Interpreter
1. `ctrl`+`shift`+`p`
2. Type `Python: Select Interpreter`.
3. Select `./.venv/bin/python`.

### Testing
1. Select "Testing" tab.
2. Select "Configure Python Tests".
3. Select `pytest`.
4. Select `tests`.

# Validation
To validate existing files, run `poetry run pre-commit run --all-files`
