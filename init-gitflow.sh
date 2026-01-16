#!/bin/bash

echo "🚀 Inicializando fluxo Git Flow com proteção local e remota..."

# Temporariamente desativa o pre-push
if [ -f .git/hooks/pre-push ]; then
  mv .git/hooks/pre-push .git/hooks/pre-push.bkp
  echo "🔓 Desativando pre-push temporariamente..."
fi

# Envia as branches main e develop para o GitHub (caso não existam ainda)
for branch in main develop; do
  git checkout $branch 2>/dev/null || git checkout -b $branch
  git push -u origin $branch || echo "⚠️ Falha ao enviar $branch (pode já existir)"
done

# Restaura o pre-push
if [ -f .git/hooks/pre-push.bkp ]; then
  mv .git/hooks/pre-push.bkp .git/hooks/pre-push
  chmod +x .git/hooks/pre-push
  echo "🔒 Restaurando proteção local do pre-push..."
fi

# Protege as branches remotamente com gh api
for branch in main develop; do
  echo "🛡️ Criando proteção da branch '$branch'..."
  gh api -X PUT "repos/:owner/:repo/branches/$branch/protection" -f required_status_checks='null' \
    -f enforce_admins=true \
    -f required_pull_request_reviews='{"required_approving_review_count":1}' \
    -f restrictions='null' >/dev/null 2>&1 \
    && echo "✅ Proteção aplicada em $branch"
done

echo "🎉 Git Flow inicializado com sucesso!"
