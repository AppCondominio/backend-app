# Use a imagem base do Dart Runtime
FROM dart

# Configura o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o código do backend para o contêiner
COPY . .

# Instale as dependências do aplicativo
RUN dart pub get

# Defina o diretório de trabalho novamente
WORKDIR /app

# Exponha a porta em que o aplicativo está escutando
EXPOSE 8080

# Defina o comando para iniciar o backend
CMD ["dart", "bin/main.dart"]
