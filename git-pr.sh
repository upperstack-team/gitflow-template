#!/bin/bash

set -e

# 🧠 Detectar nome da branch atual
branch=$(git rev-parse --abbrev-ref HEAD)
base_branch="develop"

# 🎯 Validar nome da branch com Git Flow
if ! echo "$branch" | grep -Eq "^(feature|hotfix|release|chore)/[a-z0-9._-]+$"; then
  echo "❌ Nome da branch '$branch' inválido para PR."
  echo "✅ Use prefixos: feature/, hotfix/, release/, chore/"
  exit 1
fi

# 📦 Título e corpo do último commit
commit_title=$(git log -1 --pretty=%s)
commit_body=$(git log -1 --pretty=%b)

# 🏷️ Gerar label automática com base no tipo do commit
label=""
case "$commit_title" in
  feat:*|✨*)
    label="type:feat"
    ;;
  fix:*|🐛*)
    label="type:fix"
    ;;
  chore:*|🔧*)
    label="type:chore"
    ;;
  refactor:*|♻️*)
    label="type:refactor"
    ;;
  docs:*|📚*)
    label="type:docs"
    ;;
  test:*|🧪*)
    label="type:test"
    ;;
  perf:*|⚡*)
    label="type:perf"
    ;;
  *)
    label="type:other"
    ;;
esac

# 👥 Reviewers padrão (edite conforme sua equipe)
reviewers="icaroalbar"

# 🚀 Criar PR com gh
echo "📤 Criando Pull Request de '$branch' para '$base_branch'..."

gh pr create \
  --base "$base_branch" \
  --head "$branch" \
  --title "$commit_title" \
  --body "$commit_body" \
  --label "$label" \
  --reviewer "$reviewers"

echo "✅ Pull Request criado com sucesso!"
