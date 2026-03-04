@echo off
REM 跨 AI IDE 通用安装脚本 (Windows)
REM 支持: Claude Code, Kiro, Cursor, VSCode Copilot, Windsurf 等

setlocal enabledelayedexpansion

echo === dev-workflow-init 跨 IDE 安装工具 ===
echo.

set "CURRENT_DIR=%CD%"
echo 当前目录: %CURRENT_DIR%

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
set "SOURCE_DIR=%SCRIPT_DIR%dev-workflow-init"

if not exist "%SOURCE_DIR%" (
    echo 错误: 找不到 dev-workflow-init 源码目录
    exit /b 1
)

REM 检测已安装的 AI IDE
set "DETECTED_COUNT=0"
set "DETECTED_IDES="

if exist ".claude" (
    set /a DETECTED_COUNT+=1
    set "DETECTED_IDES=!DETECTED_IDES! claude"
)

if exist ".kiro" (
    set /a DETECTED_COUNT+=1
    set "DETECTED_IDES=!DETECTED_IDES! kiro"
)

if exist ".cursor" (
    set /a DETECTED_COUNT+=1
    set "DETECTED_IDES=!DETECTED_IDES! cursor"
)

if exist ".cursorrules" (
    set /a DETECTED_COUNT+=1
    set "DETECTED_IDES=!DETECTED_IDES! cursor"
)

if exist ".vscode" (
    set /a DETECTED_COUNT+=1
    set "DETECTED_IDES=!DETECTED_IDES! vscode"
)

if exist ".windsurf" (
    set /a DETECTED_COUNT+=1
    set "DETECTED_IDES=!DETECTED_IDES! windsurf"
)

REM 显示检测结果
if %DETECTED_COUNT% EQU 0 (
    echo 未检测到已配置的 AI IDE
    echo 将为所有支持的 IDE 创建配置
    set "INSTALL_ALL=1"
) else (
    echo 检测到以下 IDE:%DETECTED_IDES%
    echo.
    echo 选择安装方式:
    echo 1^) 仅为检测到的 IDE 安装
    echo 2^) 为所有支持的 IDE 安装（推荐）
    set /p choice="请选择 (1-2): "

    if "!choice!"=="2" (
        set "INSTALL_ALL=1"
    ) else (
        set "INSTALL_ALL=0"
    )
)

echo.
echo 开始安装...

REM Claude Code
if "%INSTALL_ALL%"=="1" (
    call :install_claude
) else (
    echo !DETECTED_IDES! | findstr /C:"claude" >nul && call :install_claude
)

REM Kiro
if "%INSTALL_ALL%"=="1" (
    call :install_kiro
) else (
    echo !DETECTED_IDES! | findstr /C:"kiro" >nul && call :install_kiro
)

REM Cursor
if "%INSTALL_ALL%"=="1" (
    call :install_cursor
) else (
    echo !DETECTED_IDES! | findstr /C:"cursor" >nul && call :install_cursor
)

REM VSCode
if "%INSTALL_ALL%"=="1" (
    call :install_vscode
) else (
    echo !DETECTED_IDES! | findstr /C:"vscode" >nul && call :install_vscode
)

REM Windsurf
if "%INSTALL_ALL%"=="1" (
    call :install_windsurf
) else (
    echo !DETECTED_IDES! | findstr /C:"windsurf" >nul && call :install_windsurf
)

REM 创建通用 AGENTS.md
call :create_agents_md

echo.
echo ✓ 安装完成！
echo.
echo 已安装的位置:
if exist ".claude\skills\dev-workflow-init" echo   • .claude\skills\dev-workflow-init\
if exist ".kiro\skills\dev-workflow-init" echo   • .kiro\skills\dev-workflow-init\
if exist ".cursor\skills\dev-workflow-init" echo   • .cursor\skills\dev-workflow-init\
if exist ".vscode\skills\dev-workflow-init" echo   • .vscode\skills\dev-workflow-init\
if exist ".windsurf\skills\dev-workflow-init" echo   • .windsurf\skills\dev-workflow-init\

echo.
echo 使用方法：
echo   1. 用任意支持的 AI IDE 打开此项目
echo   2. 在对话框中输入: 启动
echo   3. 跟随 AI 的提问完成需求访谈

goto :eof

:install_claude
echo.
echo → 安装到 Claude Code
mkdir ".claude\skills" 2>nul
if exist ".claude\skills\dev-workflow-init" rmdir /s /q ".claude\skills\dev-workflow-init"
xcopy /E /I /Y "%SOURCE_DIR%" ".claude\skills\dev-workflow-init" >nul
echo   ✓ 已复制到: .claude\skills\dev-workflow-init
goto :eof

:install_kiro
echo.
echo → 安装到 Kiro
mkdir ".kiro\skills" 2>nul
if exist ".kiro\skills\dev-workflow-init" rmdir /s /q ".kiro\skills\dev-workflow-init"
xcopy /E /I /Y "%SOURCE_DIR%" ".kiro\skills\dev-workflow-init" >nul
echo   ✓ 已复制到: .kiro\skills\dev-workflow-init
goto :eof

:install_cursor
echo.
echo → 安装到 Cursor
mkdir ".cursor\skills" 2>nul
if exist ".cursor\skills\dev-workflow-init" rmdir /s /q ".cursor\skills\dev-workflow-init"
xcopy /E /I /Y "%SOURCE_DIR%" ".cursor\skills\dev-workflow-init" >nul
echo   ✓ 已复制到: .cursor\skills\dev-workflow-init

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
        echo 详细规则请参考: .cursor/skills/dev-workflow-init/SKILL.md
    ) > .cursorrules
    echo   ✓ 已创建 .cursorrules
)
goto :eof

:install_vscode
echo.
echo → 安装到 VSCode
mkdir ".vscode\skills" 2>nul
if exist ".vscode\skills\dev-workflow-init" rmdir /s /q ".vscode\skills\dev-workflow-init"
xcopy /E /I /Y "%SOURCE_DIR%" ".vscode\skills\dev-workflow-init" >nul
echo   ✓ 已复制到: .vscode\skills\dev-workflow-init

REM 创建 VSCode 配置
if not exist ".vscode\settings.json" (
    (
        echo {
        echo   "github.copilot.chat.codeGeneration.instructions": [
        echo     {
        echo       "file": ".vscode/skills/dev-workflow-init/SKILL.md"
        echo     }
        echo   ]
        echo }
    ) > .vscode\settings.json
    echo   ✓ 已创建 .vscode\settings.json
) else (
    echo   ⚠ .vscode\settings.json 已存在，请手动添加配置
)
goto :eof

:install_windsurf
echo.
echo → 安装到 Windsurf
mkdir ".windsurf\skills" 2>nul
if exist ".windsurf\skills\dev-workflow-init" rmdir /s /q ".windsurf\skills\dev-workflow-init"
xcopy /E /I /Y "%SOURCE_DIR%" ".windsurf\skills\dev-workflow-init" >nul
echo   ✓ 已复制到: .windsurf\skills\dev-workflow-init
goto :eof

:create_agents_md
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
        echo ## 支持的 AI IDE
        echo.
        echo - Claude Code
        echo - Kiro
        echo - Cursor
        echo - VSCode ^(with Copilot^)
        echo - Windsurf
    ) > AGENTS.md
    echo   ✓ 已创建 AGENTS.md 占位文件
)
goto :eof

endlocal
