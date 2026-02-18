@echo off
setlocal

set SKILL_DIR=%USERPROFILE%\.claude\skills\bseoa
set SKILL_FILE=bseoa\SKILL.md

echo Installing Black SEO Analyzer Claude skill...

if not exist "%SKILL_FILE%" (
    echo Error: bseoa\SKILL.md not found. Run this script from the bseoa-claude-skill directory.
    exit /b 1
)

if not exist "%SKILL_DIR%" (
    mkdir "%SKILL_DIR%"
)

xcopy /E /Y "bseoa\*" "%SKILL_DIR%\"

echo.
echo Installed to: %SKILL_DIR%
echo.
echo Restart Claude Code and use /bseoa to activate the skill.
