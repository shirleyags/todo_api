# Task API

API REST para gerenciamento de tarefas (To-Do List) desenvolvida em **Ruby com Sinatra** e **MongoDB**.

O projeto implementa operações CRUD, validações de negócio e organização em camadas para manter o código limpo e fácil de manter.

---

## Funcionalidades

- Criar tarefas
- Listar tarefas
- Buscar tarefa por ID
- Atualizar tarefa
- Deletar tarefa
- Healthcheck da aplicação

---

## Tecnologias utilizadas

- Ruby
- Sinatra
- MongoDB
- Puma
- Docker (opcional para rodar o banco)

---

## Pré-requisitos

- Ruby (>= 3.x)
- Bundler
- MongoDB (local ou via Docker)

---

## Variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto com:

```env
MONGO_URL=mongodb://127.0.0.1:27017/todo_api
PORT=4567
```
---

## Estrutura do Projeto

A organização do código segue uma arquitetura simples inspirada em **DDD / Clean Architecture**, separando responsabilidades em camadas.

```
src/
  models/        → entidades do domínio
  repositories/  → acesso ao banco de dados
  use_cases/     → casos de uso da aplicação
  validators/    → regras de validação
  routes/        → endpoints da API
  support/       → helpers de resposta

config/          → configuração do MongoDB
```

---

## Modelo de Dados

```json
{
  "id": "uuid",
  "title": "string",
  "description": "string",
  "status": "pending | in_progress | completed | cancelled",
  "priority": "low | medium | high",
  "due_date": "date",
  "created_at": "timestamp",
  "updated_at": "timestamp"
}
```

## Regras de Negócio

- O título é obrigatório
- O título deve ter entre 3 e 100 caracteres
- Prioridade válida: `low`, `medium` ou `high`
- Status válido: `pending`, `in_progress`, `completed`, `cancelled`
- Data de vencimento não pode estar no passado
- Tarefas completadas não podem ser editadas

---

## Como rodar o projeto

### 1) Clonar o repositório

```bash
git clone <repo>
cd todo_api
```

### 2) Instalar dependências

```bash
bundle install
```

### 3) Rodar MongoDB

#### Opção 1 — Docker (recomendado)

```bash
docker run -d --name mongo-todo -p 27017:27017 mongo
```

O MongoDB ficará disponível em:

```
mongodb://localhost:27017
```

A aplicação utilizará automaticamente o banco:

```
todo_api
```

#### Opção 2 — MongoDB local

Certifique-se que o MongoDB está rodando em:

```
mongodb://localhost:27017
```

A aplicação se conectará ao banco definido no `.env`:

```
MONGO_URL=mongodb://127.0.0.1:27017/todo_api
```

### 4) Rodar a aplicação

```bash
bundle exec ruby app.rb
```

O servidor irá iniciar em:

```
http://localhost:4567
```

---

## Endpoints da API

### Criar tarefa

`POST /tasks`

**Body:**

```json
{
  "title": "Estudar Golang",
  "description": "Revisar goroutines",
  "priority": "high",
  "due_date": "2026-02-10"
}
```

**Resposta:**

- `201 Created`

---

### Listar tarefas

`GET /tasks`

---

### Buscar tarefa por ID

`GET /tasks/:id`

---

### Atualizar tarefa

`PATCH /tasks/:id`

**Body:**

```json
{
  "status": "in_progress"
}
```

---

### Deletar tarefa

`DELETE /tasks/:id`

---

### Healthcheck

`GET /health`

**Resposta:**

```json
{
  "status": "ok"
}
```

---

## Validações

As validações foram implementadas usando Rule Objects, onde cada regra é isolada em uma classe.

```text
src/validators/rules/
  title_required_rule.rb
  title_length_rule.rb
  priority_rule.rb
  due_date_rule.rb
```

Isso permite:

- fácil manutenção
- reutilização de regras
- validações extensíveis

---

## Organização do Código

A aplicação segue uma separação clara de responsabilidades:

- **Routes**: HTTP / entrada da API
- **Use Cases**: lógica de negócio
- **Validators**: validação de regras
- **Repository**: acesso ao banco de dados
- **Models**: entidades do domínio

---

## Testando a API

Você pode testar usando:

- Postman
- Insomnia
- curl

**Exemplo usando curl:**

```bash
curl -X POST http://localhost:4567/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Estudar Ruby"}'
```

---

## Possíveis melhorias

- Testes automatizados
- Logs estruturados
- Documentação Swagger/OpenAPI
- Containerização completa com Docker Compose

---

## Autor

Projeto desenvolvido como desafio técnico de backend.
