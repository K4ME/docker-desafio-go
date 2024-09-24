# Etapa 1: Compilar o binário Go
FROM golang:alpine AS builder

# Instalar o UPX para compactar o binário
RUN apk add --no-cache upx

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o código Go para o diretório de trabalho
COPY . .

# Compilar o binário para Linux, reduzindo o tamanho com flags de otimização
RUN go build -ldflags="-s -w" -o app main.go

# Compactar o binário usando UPX
RUN upx --best app

# Etapa 2: Usar a imagem mínima "scratch" para rodar o binário
FROM scratch
COPY --from=builder /app/app /app/app
ENTRYPOINT ["/app/app"]

