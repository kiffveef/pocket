# スクリプト開始
Write-Host "🔍 scrcpy のアップデートを確認中..."

# scrcpy のアップデート確認
$upgradeInfo = winget upgrade --id Genymobile.scrcpy | Out-String

$shouldUpdate = $true
if ($upgradeInfo -match "No available upgrade found" -or $upgradeInfo -match "利用可能な更新は見つかりませんでした") {
    Write-Host "✅ scrcpy はすでに最新バージョンです。PATH を更新します..."
    $shouldUpdate = $false
}

# scrcpy のアップデート実行（必要な場合）
if ($shouldUpdate) {
    Write-Host "⬆️ scrcpy のアップデートを実行します..."
    $upgradeResult = winget upgrade --id Genymobile.scrcpy --silent --accept-package-agreements --accept-source-agreements | Out-String

    if ($upgradeResult -match "Successfully installed" -or $upgradeResult -match "成功") {
        Write-Host "✅ scrcpy のアップデートが完了しました。PATH を更新します..."
    } else {
        Write-Host "⚠️ scrcpy のアップデートに失敗しましたが、PATH の更新を試みます..."
    }
}

# scrcpy.exe の最新パスを取得して PATH に追加
$basePath = "$env:LOCALAPPDATA\Microsoft\WinGet\Packages"
$scrcpyExe = Get-ChildItem -Path $basePath -Recurse -Filter scrcpy.exe -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($scrcpyExe) {
    $scrcpyDir = $scrcpyExe.Directory.FullName
    $currentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User)

    if ($currentPath -notlike "*$scrcpyDir*") {
        $newPath = "$currentPath;$scrcpyDir"
        [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::User)
        Write-Host "✅ PATH に scrcpy の最新パスを追加しました:`n$scrcpyDir"
    } else {
        Write-Host "ℹ️ PATH はすでに scrcpy の最新パスを含んでいます。"
    }
} else {
    Write-Host "❌ scrcpy.exe が見つかりませんでした。PATH の更新はスキップされました。"
}

Write-Host "`n🎯 スクリプト完了。PowerShell を再起動すると PATH が反映されます。"