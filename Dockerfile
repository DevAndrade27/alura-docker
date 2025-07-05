# Use uma imagem base oficial do Python. Recomendo usar uma versão específica.
FROM python:3.11-slim

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Impedir que o Python grave arquivos .pyc no host
ENV PYTHONDONTWRITEBYTECODE 1
# Impedir que o Python armazene em buffer stdout e stderr
ENV PYTHONUNBUFFERED 1

# Copie o arquivo de dependências e instale-as
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copie o código da sua aplicação para o diretório de trabalho
COPY . /app 

# Expõe a porta que a aplicação vai rodar
EXPOSE 8000

# Comando para executar a aplicação com Uvicorn em produção
# O docker-compose irá sobrescrever este comando para desenvolvimento
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]