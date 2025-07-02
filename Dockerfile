# Etapa 1: Imagem base
# Usamos uma imagem oficial do Python com Alpine Linux.
# Alpine é uma distribuição Linux leve, o que resulta em imagens Docker menores.
# A versão 3.11 é uma versão estável e amplamente utilizada.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho
# Isso garante que todos os comandos subsequentes sejam executados neste diretório dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar e instalar as dependências
# Copiamos o arquivo de requisitos primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não precisará reinstalar as dependências em builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
COPY . .

# Etapa 5: Expor a porta que a aplicação usará
EXPOSE 8000

# Etapa 6: Comando para executar a aplicação
# Usamos uvicorn para rodar a aplicação, ouvindo em todas as interfaces (0.0.0.0)
# para que seja acessível de fora do contêiner. O --reload não é usado em produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
