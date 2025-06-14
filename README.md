# NixOS Dotfiles

Nix FlakesとHome Managerを使用したNixOSの宣言的なシステム設定リポジトリです。

## 概要

このリポジトリは、完全なNixOSシステムの設定を管理しています：

- **デスクトップ環境**: KDE Plasma 6
- **開発ツール**: JetBrains IDEスイート、Neovim、Node.js環境
- **日本語対応**: 完全な日本語ロケールとFcitx5 + Mozc IME
- **ゲーミング**: Steam、NVIDIAドライバー、ハードウェアアクセラレーション
- **モダンCLIツール**: bat、eza、ripgrep、starship

## システム構成

### 主要設定ファイル
- `flake.nix` - メインのFlake設定（入力、出力、開発環境の定義）
- `configuration.nix` - システムレベルのNixOS設定（ハードウェア、サービス、システムパッケージ）
- `home.nix` - Home Manager設定（すべてのユーザー空間モジュールをインポート）

### モジュラー構造
各ツール/サービスごとに独自の`.nix`ファイル：
- `zsh.nix` - モダンCLIツール付きZshシェル（bat、eza、ripgrep）
- `starship.nix` + `starship.toml` - シェルプロンプト設定
- `jetbrains.nix` - プラグイン付き完全なJetBrains IDEセットアップ
- `vim.nix` - Neovim設定
- `git.nix` - GitとGitHub CLI設定
- `apps.nix` - デスクトップアプリケーション
- `browser.nix` - ブラウザー設定
- `locale.nix` - 日本語ロケール設定

## 基本コマンド

```bash
# NixOS設定の再構築と適用
nrs

# 開発シェルに入る（Node.js、Prisma、npm含む）
nix develop

# Flakeの入力を最新バージョンに更新
nix flake update

# Home Manager設定の変更を適用
home-manager switch --flake .
```

## 開発ワークフロー

1. 関連する`.nix`ファイルに変更を加える
2. `nrs`コマンドで設定をテスト
3. 必要に応じて`nix flake update`で依存関係を更新
4. 開発環境はdirenvまたは`nix develop`で自動的に利用可能

## 主な機能

### ハードウェア対応
- NVIDIA GPU（安定版ドライバー）
- Logitechデバイス（Solaar含む）
- XanModカーネル

### 日本語環境
- 日本語ロケール（ja_JP.UTF-8）
- Fcitx5 + Mozc IME
- 日本語フォント（Noto CJK、Migu）

### 開発環境
- JetBrains IDEスイート（IntelliJ IDEA Ultimate、WebStorm、RustRover、Android Studio）
- Neovim with OneDark テーマ
- Node.js + Prisma開発環境
- 各種CLI開発ツール

### ゲーミング
- Steam（リモートプレイ対応）
- Wine
- Prism Launcher（Minecraft）

### ネットワーク
- Tailscale VPN
- NetworkManager

## カスタムエイリアス

```bash
cat → bat        # シンタックスハイライト付きcat
ls → eza         # モダンなls代替
grep → rg        # 高速なgrep代替
```

## 注意事項

- システムはnixpkgs-unstableチャンネルを使用して最新パッケージを提供
- すべてのユーザーアプリケーションはHome Managerモジュールで管理
- 再現可能な環境のためすべてをNix式で宣言
- 開発環境はdirenvによって自動的に利用可能
