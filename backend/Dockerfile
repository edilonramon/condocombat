# Stage 1: Builder
FROM python:3.12-slim AS builder

WORKDIR /app

# Instala o uv para gerenciar dependências
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uv/bin/uv

# Copia os arquivos de manifesto de dependências
COPY pyproject.toml uv.lock ./

# Instala as dependências de produção sem instalar o projeto atual ainda
RUN /uv/bin/uv sync --frozen --no-dev --no-install-project

# Stage 2: Runtime
FROM python:3.12-slim AS runner

WORKDIR /app

# Copia o ambiente virtual com as dependências instaladas
COPY --from=builder /app/.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

# Copia o código da aplicação
COPY . .

EXPOSE 8000

# Executa o entrypoint script
CMD ["/bin/bash", "./entrypoint.sh"]
