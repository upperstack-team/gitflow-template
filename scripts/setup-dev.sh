#!/bin/bash
echo "🚀 Instalando hooks do Git local..."
mkdir -p .git/hooks

cp scripts/commit-msg .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg

cp scripts/pre-push .git/hooks/pre-push
chmod +x .git/hooks/pre-push

cp scripts/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

if ! git show-ref --quiet refs/heads/develop; then
  echo "🌱 Criando branch 'develop' a partir da 'main'..."
  git checkout main && git pull origin main
  git checkout -b develop && git push -u origin develop
else
  echo "🔄 Branch 'develop' já existe."
fi

echo "✅ Hooks instalados e branch 'develop' pronta!"
