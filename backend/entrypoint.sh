#!/bin/bash
set -e

# Executa migrações de banco se necessário e inicia o Uvicorn
exec uvicorn app.main:app --host 0.0.0.0 --port 8000
