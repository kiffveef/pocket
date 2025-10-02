# 🗂️ pocket

Windows/Linux(WSL)で動作するスクリプトやコードの断片を管理するためのものです。

## 📁 ディレクトリ構成

- `windows/` : 🪟 Windows用スクリプト

## 🛠️ 使い方

### 🔄 scrcpy update

`scrcpy` を `winget` で更新時PATH反映されないため、スクリプトで常にPATH設定する。  
💡 **Tips:** スクリプト実行で自動的にPATHが設定されます。

```powershell
## scrcpy 更新
& '<スクリプト格納フルパス>\scrcpy_update.ps1'

## 存在確認
Get-Command scrcpy
```
