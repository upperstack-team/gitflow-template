#!/usr/bin/env node

const { execSync } = require("child_process");
const { existsSync, copyFileSync, mkdirSync, chmodSync } = require("fs");
const { join } = require("path");

const cwd = process.cwd();
const scriptsDir = join(__dirname, "..", "scripts");

console.log("🚀 Aplicando Git Flow Automático com UpperStack...");

// Copiar scripts para o projeto
const files = ["commit-msg", "pre-commit", "pre-push", "setup-dev.sh", "init-gitflow.sh", "git-pr.sh", "README.md"];
if (!existsSync(join(cwd, "scripts"))) {
  mkdirSync(join(cwd, "scripts"));
}

files.forEach(file => {
  const src = join(scriptsDir, file);
  const dest = join(cwd, "scripts", file);
  copyFileSync(src, dest);
  chmodSync(dest, 0o755); // torna executável
  console.log(`✅ Copiado: ${file}`);
});

// Executar setup e init
try {
  execSync("scripts/setup-dev.sh", { stdio: "inherit" });
  execSync("scripts/init-gitflow.sh", { stdio: "inherit" });
  console.log("🎉 Git Flow configurado com sucesso!");
} catch (error) {
  console.error("❌ Erro ao executar os scripts.");
  process.exit(1);
}
