@echo off
REM Build script for creating multi-RID Native AOT packages on Windows
REM This script should be run on each target platform to create the platform-specific packages

echo Building dotnetsay with Native AOT for multiple platforms...

REM Clean previous builds
if exist nupkg rmdir /s /q nupkg
if exist artifacts rmdir /s /q artifacts
mkdir nupkg

REM Detect current platform
set CURRENT_RID=win-x64
if "%PROCESSOR_ARCHITECTURE%"=="ARM64" set CURRENT_RID=win-arm64

echo Detected platform: %CURRENT_RID%

REM Build the root meta-package (no RID)
echo Building root meta-package...
dotnet pack -c Release -o .\nupkg /p:ContinuousIntegrationBuild=true

REM Build the platform-specific Native AOT package for current platform
echo Building Native AOT package for %CURRENT_RID%...
dotnet pack -c Release -o .\nupkg --runtime-id %CURRENT_RID% /p:ContinuousIntegrationBuild=true

REM Build the 'any' runtime fallback package
echo Building 'any' runtime fallback package...
dotnet pack -c Release -o .\nupkg --runtime-id any /p:ContinuousIntegrationBuild=true /p:PublishAot=false

echo.
echo Build complete! Packages created:
dir /b nupkg\*.nupkg

echo.
echo Note: To build for other platforms, run this script on those platforms.
echo    Supported platforms: linux-x64, linux-arm64, osx-x64, osx-arm64, win-x64, win-arm64
