# ======
# uv-bin
# ======
# Pinned uv image reference. Update the version tag and digest together.
FROM ghcr.io/astral-sh/uv:0.10.9@sha256:10902f58a1606787602f303954cea099626a4adb02acbac4c69920fe9d278f82 AS uv-bin

# ====
# base
# ====
FROM python:3.12-slim AS base

WORKDIR /app

# Copy uv from uv-bin
COPY --from=uv-bin /uv /uvx /bin/

# =================
# dependency-wheels
# =================
FROM base AS dependency-wheels

# Copy pyproject.toml & uv.lock
COPY pyproject.toml uv.lock ./

# Export locked runtime dependencies and materialize them as local wheels.
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=cache,target=/root/.cache/pip \
    mkdir -p /wheels \
    && uv export --frozen --no-dev --no-emit-project --output-file /app/requirements-runtime.txt \
    && if grep -Eq '^[[:space:]]*[^#[:space:]]' /app/requirements-runtime.txt; then \
        python3 -m pip wheel \
          --disable-pip-version-check \
          --requirement /app/requirements-runtime.txt \
          --wheel-dir /wheels; \
    fi

# ===============
# mounted-runtime
# ===============
FROM base AS mounted-runtime

# Copy runtime dependency wheelhouse artifacts from dependency-wheels
COPY --from=dependency-wheels /app/requirements-runtime.txt /app/requirements-runtime.txt
COPY --from=dependency-wheels /wheels /wheels

# Install runtime dependencies from the local wheelhouse when the manifest is not empty.
RUN if grep -Eq '^[[:space:]]*[^#[:space:]]' /app/requirements-runtime.txt; then \
        uv pip install --system --no-index --find-links /wheels --no-verify-hashes -r /app/requirements-runtime.txt; \
    fi

# ===
# dev
# ===
FROM mounted-runtime AS dev

# Copy project metadata and source for editable installation.
COPY pyproject.toml uv.lock ./
COPY README.md ./
COPY src/ ./src/

# Install development dependencies into the container environment and register the project as editable.
RUN --mount=type=cache,target=/root/.cache/uv \
    uv export --frozen --extra dev --no-emit-project --output-file /app/requirements-dev.txt \
    && uv pip install --system -r /app/requirements-dev.txt \
    && uv pip install --system --editable /app

# Default command for a long-running local development workspace.
CMD ["sleep", "infinity"]
