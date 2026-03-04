@echo off
REM 统一 AI Skills 安装脚本（使用符号链接方案）
REM 注意：在 Windows 上创建符号链接需要管理员权限
REM 如果没有管理员权限，脚本会自动降级为复制文件

setlocal enabledelayedexpansion

echo === dev-workflow-init 统一安装工具 ===
echo.

REM 检查管理员权限
net session >nul 2>&1
if %errorLevel% == 0 (
    set "HAS_ADMIN=1"
    echo [管理员模式] 将使用符号链接
) else (
    set "HAS_ADMIN=0"
    echo [普通模式] 将复制文件（建议以管理员身份运行以使用符号链接）
)
echo.

set "CURRENT_DIR=%CD%"
echo 当前目录: %CURRENT_DIR%

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
set "SOURCE_DIR=%SCRIPT_DIR%dev-workflow-init"

if not exist "%SOURCE_DIR%" (
    echo 错误: 找不到 dev-workflow-init 源码目录
    pause
    exit /b 1
)

REM 创建统一的 .ai/skills 目录
set "UNIFIED_SKILLS_DIR=.ai\skills"
echo → 创建统一 skills 目录: %UNIFIED_SKILLS_DIR%
mkdir "%UNIFIED_SKILLS_DIR%" 2>nul

REM 复制 skill 到统一目录
set "TARGET_DIR=%UNIFIED_SKILLS_DIR%\dev-workflow-init"
if exist "%TARGET_DIR%" (
    echo   目录已存在，覆盖...
    rmdir /s /q "%TARGET_DIR%"
)

xcopy /E /I /Y "%SOURCE_DIR%" "%TARGET_DIR%" >nul
echo   ✓ 已复制到: %TARGET_DIR%

REM 为各个 IDE 创建符号链接或复制
call :setup_ide "Claude Code" ".claude\skills"
call :setup_ide "Kiro" ".kiro\skills"
call :setup_ide_cursor "Cursor" ".cursor\skills"
call :setup_ide_vscode "VSCode" ".vscode\skills"
call :setup_ide "Windsurf" ".windsurf\skills"

REM 创建 .ai/README.md
(
    echo # .ai 目录说明
    echo.
    echo 这是项目的统一 AI 配置目录。
    echo.
    echo ## 目录结构
    echo.
    echo ```
    echo .ai/
    echo ├── README.md           # 本文件
    echo └── skills/             # 统一的 skills 存储目录
    echo     └── dev-workflow-init/
    echo         ├── SKILL.md
    echo         └── ...
    echo ```
    echo.
    echo ## 工作原理
    echo.
    if "%HAS_ADMIN%"=="1" (
        echo - 所有 skill 文件实际存储在 `.ai/skills/` 目录中
        echo - 各个 AI IDE 的 skills 目录通过符号链接指向这里
        echo - 这样只需维护一份文件，所有 IDE 都能访问
    ) else (
        echo - 所有 skill 文件存储在 `.ai/skills/` 目录中
        echo - 各个 AI IDE 的 skills 目录包含独立副本
        echo - 更新时需要重新运行安装脚本以同步
    )
    echo.
    echo ## 支持的 IDE
    echo.
    echo - Claude Code
    echo - Kiro
    echo - Cursor
    echo - VSCode ^(with GitHub Copilot^)
    echo - Windsurf
    echo.
    echo ## 添加新 Skill
    echo.
    echo 将新的 skill 文件夹放入 `.ai/skills/` 目录即可。
) > .ai\README.md
echo   ✓ 已创建 .ai\README.md

REM 创建通用 AGENTS.md
if not exist "AGENTS.md" (
    (
        echo # AGENTS 统一规则源
        echo.
        echo ^> 本文件将在项目初始化后自动生成完整内容
        echo.
        echo ## 快速开始
        echo.
        echo 在 AI IDE 中输入以下任一指令启动项目初始化：
        echo - `启动`
        echo - `start`
        echo - `开始`
        echo - `初始化项目`
        echo.
        echo AI 会通过 8 个问题收集需求，然后自动生成完整的项目规则和工作流。
        echo.
        echo ## 技术说明
        echo.
        echo 本项目使用统一的 `.ai/skills/` 目录存储所有 AI skills。
    ) > AGENTS.md
    echo.
    echo → 创建通用配置
    echo   ✓ 已创建 AGENTS.md
)

echo.
echo ✓ 安装完成！
echo.
echo 项目结构：
echo   .ai\skills\dev-workflow-init\  ← 统一存储位置
echo.

if "%HAS_ADMIN%"=="1" (
    echo 符号链接：
    if exist ".claude\skills\dev-workflow-init" echo   • .claude\skills\dev-workflow-init -^> .ai\skills\dev-workflow-init
    if exist ".kiro\skills\dev-workflow-init" echo   • .kiro\skills\dev-workflow-init -^> .ai\skills\dev-workflow-init
    if exist ".cursor\skills\dev-workflow-init" echo   • .cursor\skills\dev-workflow-init -^> .ai\skills\dev-workflow-init
    if exist ".vscode\skills\dev-workflow-init" echo   • .vscode\skills\dev-workflow-init -^> .ai\skills\dev-workflow-init
    if exist ".windsurf\skills\dev-workflow-init" echo   • .windsurf\skills\dev-workflow-init -^> .ai\skills\dev-workflow-init
) else (
    echo 已复制到：
    if exist ".claude\skills\dev-workflow-init" echo   • .claude\skills\dev-workflow-init
    if exist ".kiro\skills\dev-workflow-init" echo   • .kiro\skills\dev-workflow-init
    if exist ".cursor\skills\dev-workflow-init" echo   • .cursor\skills\dev-workflow-init
    if exist ".vscode\skills\dev-workflow-init" echo   • .vscode\skills\dev-workflow-init
    if exist ".windsurf\skills\dev-workflow-init" echo   • .windsurf\skills\dev-workflow-init
)

echo.
echo 使用方法：
echo   1. 用任意支持的 AI IDE 打开此项目
echo   2. 在对话框中输入: 启动
echo   3. 跟随 AI 的提问完成需求访谈
echo.

if "%HAS_ADMIN%"=="1" (
    echo 优势：
    echo   • 只需维护一份 skill 文件（在 .ai\skills\ 中）
    echo   • 更新一次，所有 IDE 同步
    echo   • 项目结构更清晰
) else (
    echo 提示：
    echo   • 以管理员身份运行此脚本可使用符号链接
    echo   • 符号链接可实现一次更新，所有 IDE 同步
)

echo.
pause
goto :eof

:setup_ide
set "ide_name=%~1"
set "ide_skills_dir=%~2"

echo.
echo → 配置 %ide_name%

mkdir "%ide_skills_dir%" 2>nul

set "link_path=%ide_skills_dir%\dev-workflow-init"

REM 删除已存在的链接或目录
if exist "%link_path%" (
    rmdir "%link_path%" 2>nul
    if exist "%link_path%" rmdir /s /q "%link_path%"
)

if "%HAS_ADMIN%"=="1" (
    REM 创建目录符号链接
    mklink /D "%link_path%" "%CD%\%TARGET_DIR%" >nul 2>&1

    if exist "%link_path%" (
        echo   ✓ 已创建符号链接: %link_path% -^> %TARGET_DIR%
    ) else (
        echo   ⚠ 符号链接创建失败，改为复制文件
        xcopy /E /I /Y "%TARGET_DIR%" "%link_path%" >nul
        echo   ✓ 已复制到: %link_path%
    )
) else (
    REM 复制文件
    xcopy /E /I /Y "%TARGET_DIR%" "%link_path%" >nul
    echo   ✓ 已复制到: %link_path%
)

goto :eof

:setup_ide_cursor
set "ide_name=%~1"
set "ide_skills_dir=%~2"

call :setup_ide "%ide_name%" "%ide_skills_dir%"

REM 创建 .cursorrules
if not exist ".cursorrules" (
    (
        echo # AI 开发规则
        echo.
        echo ## 项目初始化
        echo.
        echo 当用户说「启动」、「start」、「开始」或「初始化项目」时，执行以下流程：
        echo.
        echo 1. 通过 8 个问题收集项目需求
        echo 2. 生成 AGENTS.md 规则文件
        echo 3. 推荐适配的 skills 和工具
        echo 4. 编排开发工作流
        echo.
        echo 详细规则请参考: .ai/skills/dev-workflow-init/SKILL.md
    ) > .cursorrules
    echo   ✓ 已创建 .cursorrules
)

goto :eof

:setup_ide_vscode
set "ide_name=%~1"
set "ide_skills_dir=%~2"

call :setup_ide "%ide_name%" "%ide_skills_dir%"

REM 创建 VSCode 配置
if not exist ".vscode\settings.json" (
    (
        echo {
        echo   "github.copilot.chat.codeGeneration.instructions": [
        echo     {
        echo       "file": ".ai/skills/dev-workflow-init/SKILL.md"
        echo     }
        echo   ]
        echo }
    ) > .vscode\settings.json
    echo   ✓ 已创建 .vscode\settings.json
) else (
    echo   ⚠ .vscode\settings.json 已存在，请手动添加配置
)

goto :eof

endlocal
