# gs-2-vr-arworkspa

API para Ambientes de trabalho com Realidade Virtual ou Aumentada

## Membros do Grupo

### Membro 1
- **Nome:** Samuel Schaeffer Aguiar
- **RM:** 550212

## Descrição do Tema

**Ambientes de trabalho com Realidade Virtual ou Aumentada**

Este projeto foca no desenvolvimento de soluções tecnológicas que integram Realidade Virtual (VR) e Realidade Aumentada (AR) em ambientes de trabalho. A proposta visa transformar a forma como equipes colaboram, treinam e interagem, criando espaços de trabalho imersivos e inovadores que transcendem as limitações físicas e geográficas.

## Finalidade da API

Esta API foi desenvolvida como parte da Global Solution para fornecer uma base de integração para sistemas de ambientes de trabalho com VR/AR. A API oferece endpoints para:

- Consulta de informações sobre o tema do projeto
- Integração com sistemas de colaboração virtual
- Suporte para futuras funcionalidades relacionadas a ambientes de trabalho imersivos

A API é projetada para ser escalável, moderna e preparada para implantação em nuvem, utilizando dockerização e seguindo as melhores práticas de desenvolvimento.

## Tecnologias Utilizadas

- **Java 17**
- **Spring Boot 3.4.3**
- **SpringDoc OpenAPI** (Swagger)
- **Maven**
- **Docker**

## Execução Local

### Pré-requisitos

- Java 17 ou superior
- Maven 3.6+ ou superior
- Docker (opcional, para execução via container)

### Passo a Passo

1. **Clone o repositório:**
```bash
git clone https://github.com/samuelaguiarr/gs-2-vr-arworkspa.git
cd gs-2-vr-arworkspa
```

2. **Compile o projeto:**
```bash
mvn clean package
```

3. **Execute a aplicação:**
```bash
java -jar target/app.jar
```

Ou usando Maven:
```bash
mvn spring-boot:run
```

4. **Acesse a aplicação:**
- API: http://localhost:8081
- Swagger UI: http://localhost:8081/swagger-ui.html
- Endpoint de informações: http://localhost:8081/info

### Execução com Docker

1. **Build da imagem:**
```bash
docker build -t gs-2-vr-arworkspa .
```

2. **Execute o container:**
```bash
docker run -p 8081:8081 gs-2-vr-arworkspa
```

## Docker Hub

A imagem Docker está disponível em:
**https://hub.docker.com/r/samuelschaeffer/gs-2-vr-arworkspa**

Para fazer pull da imagem:
```bash
docker pull samuelschaeffer/gs-2-vr-arworkspa:latest
```

## Workflows CI/CD

O projeto implementa três workflows principais no GitHub Actions:

### 1. Versionamento (versioning.yaml)
- **Trigger:** Push na branch `main`
- **Funcionalidade:** Gera tags automáticas no GitHub usando release-please
- **Evidência:** Tags criadas automaticamente no repositório após cada push na main

### 2. Continuous Integration (ci.yaml)
- **Trigger:** Push nas branches `feature/**`, `release` ou `hotfix`
- **Funcionalidades:**
  - Build da aplicação
  - Execução de testes unitários
  - Build da imagem Docker (verificação)
- **Evidência:** Execução registrada em Actions para validação do código

### 3. Continuous Delivery (cd.yaml)
- **Trigger:** Pull request na branch `develop`
- **Funcionalidade:** Envia imagem automaticamente ao Docker Hub
- **Evidência:** Imagem atualizada no Docker Hub após merge do PR

## Endpoints da API

### GET /info
Retorna informações sobre o tema do projeto, membros do grupo e descrição.

**Resposta:**
```json
{
  "tema": "Ambientes de trabalho com Realidade Virtual ou Aumentada",
  "membro1": "Samuel Schaeffer Aguiar",
  "membro2": "N/A",
  "descricao": "Esta API foi desenvolvida para suportar ambientes de trabalho inovadores que utilizam tecnologias de Realidade Virtual (VR) e Realidade Aumentada (AR)..."
}
```

## Documentação da API

A documentação completa da API está disponível via Swagger/OpenAPI:

- **Swagger UI:** http://localhost:8081/swagger-ui.html
- **OpenAPI JSON:** http://localhost:8081/v3/api-docs

## Estrutura do Projeto

```
gs-2-vr-arworkspa/
├── .github/
│   └── workflows/
│       ├── versioning.yaml
│       ├── ci.yaml
│       └── cd.yaml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/github/gs/vrarworkspaces/
│   │   │       ├── VrArWorkspacesApplication.java
│   │   │       └── controller/
│   │   │           └── TemaController.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
├── Dockerfile
├── pom.xml
└── README.md
```

## Configuração de Secrets e Variables no GitHub

Para que os workflows funcionem corretamente, é necessário configurar:

### Secrets:
- `RELEASE_PLEASE_TOKEN`: Token do GitHub para criação de releases
- `DOCKER_TOKEN`: Token do Docker Hub para push de imagens

### Variables:
- `DOCKER_USER`: samuelschaeffer (usuário do Docker Hub)

## Licença

Este projeto foi desenvolvido como parte da Global Solution.
