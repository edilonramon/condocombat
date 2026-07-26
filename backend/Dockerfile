FROM python:3.12-slim

WORKDIR /app

# Instala o uv diretamente na imagem
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Copia os arquivos de dependências
COPY pyproject.toml uv.lock ./

# Instala as dependências (o uv cria o .venv automaticamente e com os links corretos)
RUN uv sync --frozen --no-dev --no-install-project

# Copia o restante do código do backend
COPY . .

# Corrige permissões e quebras de linha do Windows no entrypoint
RUN chmod +x ./entrypoint.sh && sed -i 's/\r$//' ./entrypoint.sh

# Adiciona o ambiente virtual ao PATH do container
ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8000

# Executa o entrypoint
CMD ["/bin/bash", "./entrypoint.sh"]
