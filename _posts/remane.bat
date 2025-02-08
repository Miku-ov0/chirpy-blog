@echo off
setlocal enabledelayedexpansion

REM 设置目录路径
set "target_dir=%1"

REM 检查是否提供了目录参数
if "%target_dir%"=="" (
    echo 请提供一个目录路径作为参数。
    exit /b 1
)

REM 遍历目录及其所有子目录中的 .md 文件
for /r "%target_dir%" %%f in (*.md) do (
    set "filename=%%~nxf"
    set "filepath=%%~dpf"
    
    REM 检查文件名是否以 yyyy-MM-dd 开头
    echo !filename! | findstr /r "^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-" >nul 2>&1
    if errorlevel 1 (
        REM 如果不是以 yyyy-MM-dd- 开头，则添加前缀
        ren "%%f" "2022-01-01-!filename!"
        echo 已重命名: %%f -> !filepath!2022-01-01-!filename!
    )
)

echo 文件重命名完成。
endlocal