# 📜 Scripts de Automação Git + GitHub Flow

Este diretório contém scripts prontos para automatizar um fluxo Git profissional, seguro e produtivo — com validações locais, criação de PRs automatizada e integração com GitHub CLI.

---

## ⚙️ Scripts disponíveis

### `setup-dev.sh`

Instala os hooks Git localmente:

- `commit-msg`: valida padrão de commit (conventional + emoji)  
- `pre-push`: bloqueia push direto para `main` e `develop`, valida nome de branch  
- `pre-commit`: reservado para lint/tests  

```bash
chmod +x scripts/setup-dev.sh
./scripts/setup-dev.sh
```

---

### `init-gitflow.sh`

Configura o fluxo Git Flow e protege as branches `main` e `develop` localmente e via GitHub API.

```bash
chmod +x scripts/init-gitflow.sh
./scripts/init-gitflow.sh
```

Ele realiza:

- ✅ Criação das branches `main` e `develop`  
- 🚀 Push para o repositório remoto  
- 🔒 Aplicação de regras de proteção (review obrigatório, push bloqueado)  
- 🪝 Restauração automática dos hooks  

> ⚠️ Requer que o `gh` (GitHub CLI) esteja autenticado com permissão para modificar branches protegidas.

---

### `git-pr.sh`

Cria Pull Requests automaticamente com base no último commit.

- Detecta a branch atual (`feature/`, `hotfix/`, etc.)  
- Usa o último commit como título e corpo  
- Aplica labels automaticamente (`type:feat`, `type:fix`, etc.)  
- Define reviewers padrão  

```bash
chmod +x scripts/git-pr.sh
./scripts/git-pr.sh
```

💡 Dica: adicione um alias global para `git pr`:

```bash
git config --global alias.pr '!sh scripts/git-pr.sh'
```

---

## 🪝 Hooks incluídos

| Hook         | Função                                                                 |
|--------------|------------------------------------------------------------------------|
| `commit-msg` | Valida padrão Conventional Commit com emoji no início                  |
| `pre-push`   | Bloqueia push direto em `main` e `develop`; valida nome de branch      |
| `pre-commit` | (Reservado para validações automáticas, ex: lint, tests, secrets)      |

---

## 📦 Como reutilizar esta pasta `scripts/` em outros projetos?

Sim! Esta pasta foi desenhada para ser **portável e reutilizável** em qualquer repositório.

---

### ✅ Opção 1: Copiar manualmente

1. Copie a pasta `scripts/` para seu novo projeto.  
2. Execute os comandos abaixo no projeto copiado:

```bash
./scripts/setup-dev.sh
./scripts/init-gitflow.sh
```

---

### 🔄 Opção 2: Usar como repositório template

1. Crie um repositório chamado `git-flow-scripts`  
2. Em outro projeto, clone apenas a pasta:

```bash
git clone https://github.com/sua-org/git-flow-scripts scripts
cd scripts
./setup-dev.sh
./init-gitflow.sh
```

---

### ⚙️ Opção 3: Empacotar como CLI (futuro)

É possível evoluir este setup para um pacote executável via:

```bash
npx @upperstack/gitflow-init
```

Este comando poderia:

- Copiar os scripts localmente  
- Executar os setups automaticamente  
- Configurar os aliases via `git config`

---

## 🧠 Requisitos

- ✅ Git configurado localmente  
- ✅ GitHub CLI (`gh`) instalado e autenticado  
- ✅ Permissões na organização para proteger branches (via API)

---

## 🚀 Sugestões futuras

- Integração com **Codex**: gerar tarefas a partir de branches e commits  
- Geração automática de changelogs com base nos commits semânticos com emojis  
- Templates personalizados de PRs e Issues  
- Integração com GitHub Actions (CI, lint, test, security)

---

## 👨‍💻 Autor

Desenvolvido por **[@icaroalbar](https://github.com/icaroalbar)** como parte do setup da **Upper Stack Sustentação**.