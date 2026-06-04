# PyCharm
## Contents
- [Interpreter](#interpreter)

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

### WSL
#### Steps
1. In the bottom right, select `Add New Interpreter`.
2. Select `On WSL`.
3. Click `Next`.
4. Select `Select existing`.
5. Under *Type* select `uv`.
6. Under *Environment* Select the folder icon and navigate to the interpreter.
