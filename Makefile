# Variáveis
RUN_CMD = go run $(SERVER_DIR)/main.go
SERVER_DIR = cmd/server
APP_NAME = kaizen-auth-server

# Builda a imagem da API
build:
	docker compose build

# Sobe os containers
up:
	docker compose up -d

# Para os containers
down:
	docker compose down

# Derruba tudo e remove volume do Postgres
reset:
	docker compose down -v

# Limpa cache e reconstroi
rebuild:
	docker compose build --no-cache

# Regra padrão para rodar o servidor
run:
	$(RUN_CMD)

create-user:
	go run cmd/tools/create_user.go

# Faz um commit
gcm:
	@if [ -z "$(m)" ]; then \
		echo "Erro: é necessário fornecer uma mensagem de commit."; \
		exit 1; \
	fi
	@git add . && git commit -m "$(m)" && git push