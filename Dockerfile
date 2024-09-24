# Etapa 1: Compilar o binário Go
FROM golang:1.20-alpine AS builder

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o código Go para o diretório de trabalho
COPY . .

# Compilar o binário para Linux
RUN go build -o app main.go

# Etapa 2: Criar a imagem final
FROM alpine:3.17

# Copiar o binário compilado da etapa anterior
COPY --from=builder /app/app /app/app

# Definir o ponto de entrada para o binário
ENTRYPOINT ["/app/app"]
