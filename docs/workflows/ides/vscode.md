# VS Code
## Contents
- [Interpreter](#interpreter)
- [Testing](#testing)

## Interpreter
Use the local `.venv` interpreter for IDE-based testing and debugging.

POSIX path:
```text
./.venv/bin/python
```

Windows path:
```text
.\.venv\Scripts\python.exe
```

### Prerequisites
- [Python Environment](../local.md#python-environment)

### Steps
1. Press `ctrl` + `shift` + `p`.
2. Run `Python: Select Interpreter`.
3. Select the interpreter from `.venv`.

## Testing

### Prerequisites
- [Interpreter](#interpreter)

### Steps
1. Select the "Testing" tab.
2. Select "Configure Python Tests".
3. Select `pytest`.
4. Select `tests`.

You can also run tests directly on the host with:

```bash
uv run pytest
```
