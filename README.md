# Kaizen auth service
O kaizen auth service surgiu com o intuito de servir como um IDP para 
o ecossistema de microserviços Kaizen

## Tecnologias utilizadas
- Go 1.23.5
- MySQL

## Pré-requisitos para uso
- Go 1.23.5
- Docker

## Rodando a aplicação localmente
### 1. Clone o repositório

```bash
git clone https://github.com/ropehapi/kaizen-auth-service.git
cd kaizen-auth-service
```

### 2. Copie e defina as variáveis de ambiente
```bash
cp .env.example .env 
```

### 3. Suba os containers com Docker Compose

```bash
make up
```

> Ou, se não estiver usando Make:
>
> ```bash
> docker compose up -d
> ```

### 4. Suba o servidor da aplicação
```bash
make run
```

### 5. Execute o script de criação de usuário
Este script criará um usuário no banco de dados conforme os dados que você informou no arquivo `.env`.

```bash
make create-user
```

## Afinal, como usa?
Ao executar os passos anteriormente listados, você subiu um banco de dados, uma aplicação, e criou um primeiro usuário nesse banco de dados.

### Implemente o middleware na aplicação que você deseja adicionar autenticação
```bash
r.Use(jwt.ValidateToken)
```

### Gere um bearer token no IDP
Request:
```bash
curl --location 'http://localhost:8028/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"seunome",
    "password":"suasenha"
}'
```
Response:
```json
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmVzX2F0IjoxNzU1NDkyNjI5LCJpZCI6IjYyN2ExZGEwLWUyODQtNDVkMS05MzBmLWMyZDU3MDM1NDM3ZiIsInVzZXJuYW1lIjoicm9zZWxpIn0.04wD2RM4SwG7GQq-aMUOU9asM97rv7ezlwOOilreRCg"
}
```

### Inclua o token no cabeçalho de sua requisição
Exemplo: 
```bash
curl --location 'http://localhost:8080/accounts' \
--header 'Authorization: SEU TOKEN AQUI'
```