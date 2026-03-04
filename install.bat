@echo off
REM dev-workflow-init skill 安装脚本 (Windows)

setlocal enabledelayedexpansion

echo === dev-workflow-init Skill 安装工具 ===
echo.

REM 检测当前目录
set "CURRENT_DIR=%CD%"
echo 当前目录: %CURRENT_DIR%

REM 检测 AI IDE 类型
set "SKILL_DIR="
set "IDE_TYPE="

if exist ".claude" (
    set "SKILL_DIR=.claude\skills"
    set "IDE_TYPE=Claude Code"
) else if exist ".kiro" (
    set "SKILL_DIR=.kiro\skills"
    set "IDE_TYPE=Kiro"
) else if exist ".agents" (
    set "SKILL_DIR=.agents\skills"
    set "IDE_TYPE=Cursor"
) else (
    echo 未检测到 AI IDE 配置目录，请选择要安装的 IDE：
    echo 1^) Claude Code ^(.claude\skills\^)
    echo 2^) Kiro ^(.kiro\skills\^)
    echo 3^) Cursor ^(.agents\skills\^)
    set /p choice="请输入选项 (1-3): "

    if "!choice!"=="1" (
        set "SKILL_DIR=.claude\skills"
        set "IDE_TYPE=Claude Code"
    ) else if "!choice!"=="2" (
        set "SKILL_DIR=.kiro\skills"
        set "IDE_TYPE=Kiro"
    ) else if "!choice!"=="3" (
        set "SKILL_DIR=.agents\skills"
        set "IDE_TYPE=Cursor"
    ) else (
        echo 无效选项
        exit /b 1
    )
)

echo 检测到 IDE: %IDE_TYPE%

REM 创建 skills 目录
if not exist "%SKILL_DIR%" mkdir "%SKILL_DIR%"
echo 创建目录: %SKILL_DIR%

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
set "SOURCE_DIR=%SCRIPT_DIR%dev-workflow-init"

REM 检查源码目录是否存在
if not exist "%SOURCE_DIR%" (
    echo 错误: 找不到 dev-workflow-init 源码目录
    echo 期望位置: %SOURCE_DIR%
    exit /b 1
)

REM 复制 skill 文件
set "TARGET_DIR=%SKILL_DIR%\dev-workflow-init"

if exist "%TARGET_DIR%" (
    echo 目标目录已存在，是否覆盖？^(y/n^)
    set /p overwrite="> "
    if /i not "!overwrite!"=="y" (
        echo 取消安装
        exit /b 0
    )
    rmdir /s /q "%TARGET_DIR%"
)

echo 复制文件到: %TARGET_DIR%
xcopy /E /I /Y "%SOURCE_DIR%" "%TARGET_DIR%" >nul

REM 验证安装
if exist "%TARGET_DIR%\SKILL.md" (
    echo.
    echo ✓ 安装成功！
    echo.
    echo Skill 已安装到: %TARGET_DIR%
    echo.
    echo 使用方法：
    echo   1. 在 AI 对话框中输入: 启动
    echo   2. 或输入: start
    echo   3. 或明确说: 请使用 dev-workflow-init skill
    echo.
    echo 更多信息请查看: %TARGET_DIR%\README.md
) else (
    echo ✗ 安装失败
    exit /b 1
)

endlocal
