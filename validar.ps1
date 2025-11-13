# Script de Validação Completa - Global Solution
# Execute: .\validar.ps1

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  VALIDAÇÃO COMPLETA DO PROJETO" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$erros = 0
$sucessos = 0

# TESTE 1: Endpoint /info
Write-Host "=== TESTE 1: Endpoint /info ===" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8081/info" -UseBasicParsing -ErrorAction Stop
    $json = $response.Content | ConvertFrom-Json
    
    if ($response.StatusCode -eq 200) {
        Write-Host "  ✅ Status: 200 OK" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ Status: $($response.StatusCode)" -ForegroundColor Red
        $erros++
    }
    
    if ($json.tema) {
        Write-Host "  ✅ Tema presente: $($json.tema)" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ Tema ausente" -ForegroundColor Red
        $erros++
    }
    
    if ($json.membro1) {
        Write-Host "  ✅ Membro1 presente: $($json.membro1)" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ Membro1 ausente" -ForegroundColor Red
        $erros++
    }
    
    if (-not ($json.PSObject.Properties.Name -contains 'membro2')) {
        Write-Host "  ✅ Membro2 removido corretamente" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ Membro2 ainda presente" -ForegroundColor Red
        $erros++
    }
} catch {
    Write-Host "  ❌ Erro ao acessar endpoint: $_" -ForegroundColor Red
    $erros++
}

# TESTE 2: Swagger UI
Write-Host "`n=== TESTE 2: Swagger UI ===" -ForegroundColor Yellow
try {
    $swagger = Invoke-WebRequest -Uri "http://localhost:8081/swagger-ui.html" -UseBasicParsing -ErrorAction Stop
    if ($swagger.StatusCode -eq 200) {
        Write-Host "  ✅ Swagger UI acessível" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ Swagger UI com erro: $($swagger.StatusCode)" -ForegroundColor Red
        $erros++
    }
} catch {
    Write-Host "  ❌ Erro ao acessar Swagger: $_" -ForegroundColor Red
    $erros++
}

# TESTE 3: OpenAPI JSON
Write-Host "`n=== TESTE 3: OpenAPI JSON ===" -ForegroundColor Yellow
try {
    $openapi = Invoke-WebRequest -Uri "http://localhost:8081/v3/api-docs" -UseBasicParsing -ErrorAction Stop
    $openapiJson = $openapi.Content | ConvertFrom-Json
    
    if ($openapi.StatusCode -eq 200) {
        Write-Host "  ✅ OpenAPI JSON acessível" -ForegroundColor Green
        $sucessos++
    }
    
    $endpoints = $openapiJson.paths.PSObject.Properties.Count
    Write-Host "  ✅ Endpoints encontrados: $endpoints" -ForegroundColor Green
    $openapiJson.paths.PSObject.Properties | ForEach-Object {
        Write-Host "     - $($_.Name)" -ForegroundColor Cyan
    }
    $sucessos++
} catch {
    Write-Host "  ❌ Erro ao acessar OpenAPI: $_" -ForegroundColor Red
    $erros++
}

# TESTE 4: Estrutura de Arquivos
Write-Host "`n=== TESTE 4: Estrutura do Projeto ===" -ForegroundColor Yellow
$arquivos = @(
    @{Nome="Dockerfile"; Path="Dockerfile"},
    @{Nome="pom.xml"; Path="pom.xml"},
    @{Nome="README.md"; Path="README.md"},
    @{Nome="mvnw"; Path="mvnw"},
    @{Nome="mvnw.cmd"; Path="mvnw.cmd"},
    @{Nome="versioning.yaml"; Path=".github\workflows\versioning.yaml"},
    @{Nome="ci.yaml"; Path=".github\workflows\ci.yaml"},
    @{Nome="cd.yaml"; Path=".github\workflows\cd.yaml"}
)

foreach ($arquivo in $arquivos) {
    if (Test-Path $arquivo.Path) {
        Write-Host "  ✅ $($arquivo.Nome)" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ $($arquivo.Nome) - AUSENTE" -ForegroundColor Red
        $erros++
    }
}

# TESTE 5: Verificação pom.xml
Write-Host "`n=== TESTE 5: Configuração pom.xml ===" -ForegroundColor Yellow
$pom = Get-Content "pom.xml" -Raw
$hasDatabase = $pom -match "mysql|postgres|h2|jpa|data-jpa"
$hasSwagger = $pom -match "springdoc"

if (-not $hasDatabase) {
    Write-Host "  ✅ Sem banco de dados" -ForegroundColor Green
    $sucessos++
} else {
    Write-Host "  ❌ Dependências de banco encontradas" -ForegroundColor Red
    $erros++
}

if ($hasSwagger) {
    Write-Host "  ✅ Swagger configurado" -ForegroundColor Green
    $sucessos++
} else {
    Write-Host "  ❌ Swagger não configurado" -ForegroundColor Red
    $erros++
}

# TESTE 6: Verificação application.properties
Write-Host "`n=== TESTE 6: Configuração application.properties ===" -ForegroundColor Yellow
$props = Get-Content "src\main\resources\application.properties"
$port = ($props | Select-String "server.port=8081")

if ($port) {
    Write-Host "  ✅ Porta 8081 configurada" -ForegroundColor Green
    $sucessos++
} else {
    Write-Host "  ❌ Porta 8081 não configurada" -ForegroundColor Red
    $erros++
}

# TESTE 7: Verificação Dockerfile
Write-Host "`n=== TESTE 7: Verificação Dockerfile ===" -ForegroundColor Yellow
$dockerfile = Get-Content "Dockerfile" -Raw
$hasExpose = $dockerfile -match "EXPOSE 8081"
$hasJava17 = $dockerfile -match "17"

if ($hasExpose) {
    Write-Host "  ✅ EXPOSE 8081 presente" -ForegroundColor Green
    $sucessos++
} else {
    Write-Host "  ❌ EXPOSE 8081 ausente" -ForegroundColor Red
    $erros++
}

if ($hasJava17) {
    Write-Host "  ✅ Java 17 configurado" -ForegroundColor Green
    $sucessos++
} else {
    Write-Host "  ❌ Java 17 não configurado" -ForegroundColor Red
    $erros++
}

# TESTE 8: Verificação README
Write-Host "`n=== TESTE 8: Verificação README.md ===" -ForegroundColor Yellow
$readme = Get-Content "README.md" -Raw
$checks = @(
    @{Nome="Nome do membro"; Match="Samuel Schaeffer Aguiar"},
    @{Nome="RM"; Match="550212"},
    @{Nome="URL Docker Hub"; Match="docker.com|Docker Hub"},
    @{Nome="Descrição workflows"; Match="workflows|CI/CD"},
    @{Nome="Instruções execução"; Match="mvn|docker|Execução"}
)

foreach ($check in $checks) {
    if ($readme -match $check.Match) {
        Write-Host "  ✅ $($check.Nome)" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ $($check.Nome) - AUSENTE" -ForegroundColor Red
        $erros++
    }
}

# TESTE 9: Verificação TemaController
Write-Host "`n=== TESTE 9: Verificação TemaController ===" -ForegroundColor Yellow
$controller = Get-Content "src\main\java\com\github\gs\vrarworkspaces\controller\TemaController.java" -Raw
$checks = @(
    @{Nome="@GetMapping"; Match="@GetMapping"},
    @{Nome="@RequestMapping /info"; Match="@RequestMapping.*info"},
    @{Nome="Tema correto"; Match="Ambientes de trabalho com Realidade Virtual"},
    @{Nome="Membro1 presente"; Match="Samuel Schaeffer Aguiar"},
    @{Nome="Membro2 removido"; Match="membro2"; Invert=$true}
)

foreach ($check in $checks) {
    $found = $controller -match $check.Match
    if ($check.Invert) {
        $found = -not $found
    }
    
    if ($found) {
        Write-Host "  ✅ $($check.Nome)" -ForegroundColor Green
        $sucessos++
    } else {
        Write-Host "  ❌ $($check.Nome)" -ForegroundColor Red
        $erros++
    }
}

# RESUMO FINAL
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RESUMO FINAL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ Sucessos: $sucessos" -ForegroundColor Green
Write-Host "❌ Erros: $erros" -ForegroundColor $(if ($erros -eq 0) {'Green'} else {'Red'})
Write-Host "`n"

if ($erros -eq 0) {
    Write-Host "TODOS OS TESTES PASSARAM!" -ForegroundColor Green
    Write-Host "Projeto pronto para entrega!`n" -ForegroundColor Green
} else {
    Write-Host "ATENCAO: $erros erro(s) encontrado(s)" -ForegroundColor Yellow
    Write-Host "   Revise os itens marcados com X`n" -ForegroundColor Yellow
}

Write-Host "Proximos passos:" -ForegroundColor Cyan
Write-Host "   1. Fazer push no GitHub" -ForegroundColor White
Write-Host "   2. Verificar workflows em: Actions" -ForegroundColor White
Write-Host "   3. Confirmar publicacao no Docker Hub`n" -ForegroundColor White

