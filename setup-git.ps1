# Script de Setup do Git para GS-2-VR-ARWorkspaces
# Execute este script no PowerShell para configurar o repositório Git

Write-Host "=== Configuração do Repositório Git ===" -ForegroundColor Green
Write-Host ""

# Verificar se já é um repositório git
if (Test-Path .git) {
    Write-Host "Repositório Git já inicializado." -ForegroundColor Yellow
} else {
    Write-Host "Inicializando repositório Git..." -ForegroundColor Cyan
    git init
}

# Adicionar todos os arquivos
Write-Host "Adicionando arquivos ao staging..." -ForegroundColor Cyan
git add .

# Fazer commit inicial
Write-Host "Criando commit inicial..." -ForegroundColor Cyan
git commit -m "Initial commit - GS VR/AR Workspaces API"

# Configurar branch main
Write-Host "Configurando branch main..." -ForegroundColor Cyan
git branch -M main

# Adicionar remote
Write-Host "Adicionando repositório remoto..." -ForegroundColor Cyan
Write-Host "IMPORTANTE: Certifique-se de ter criado o repositório no GitHub primeiro!" -ForegroundColor Yellow
Write-Host "Repositório: https://github.com/samuelaguiarr/gs-2-vr-arworkspaces.git" -ForegroundColor Yellow
Write-Host ""

$addRemote = Read-Host "Deseja adicionar o remote agora? (S/N)"
if ($addRemote -eq "S" -or $addRemote -eq "s") {
    git remote add origin https://github.com/samuelaguiarr/gs-2-vr-arworkspaces.git
    Write-Host "Remote adicionado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "Execute manualmente: git remote add origin https://github.com/samuelaguiarr/gs-2-vr-arworkspaces.git" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Próximos Passos ===" -ForegroundColor Green
Write-Host "1. Crie o repositório no GitHub: https://github.com/new" -ForegroundColor Cyan
Write-Host "2. Nome do repositório: gs-2-vr-arworkspaces" -ForegroundColor Cyan
Write-Host "3. Execute: git push -u origin main" -ForegroundColor Cyan
Write-Host "4. Crie a branch develop: git checkout -b develop && git push -u origin develop" -ForegroundColor Cyan
Write-Host ""

