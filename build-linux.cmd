@echo off
REM Build Linux Native AOT packages using official .NET SDK container images
REM This allows building for Linux even when running on Windows

echo Building Linux Native AOT packages using Docker...

REM Clean previous builds
if not exist nupkg mkdir nupkg

REM Build for linux-x64 using the official .NET SDK container
echo Building Native AOT package for linux-x64...
docker run --rm -v "%cd%:/src" -w /src mcr.microsoft.com/dotnet/nightly/sdk:10.0-noble-aot dotnet pack -c Release -o /src/nupkg --runtime-id linux-x64 /p:ContinuousIntegrationBuild=true

REM Build for linux-arm64 using the official .NET SDK container
echo Building Native AOT package for linux-arm64...
docker run --rm -v "%cd%:/src" -w /src mcr.microsoft.com/dotnet/nightly/sdk:10.0-noble-arm64v8-aot dotnet pack -c Release -o /src/nupkg --runtime-id linux-arm64 /p:ContinuousIntegrationBuild=true

echo.
echo Linux Native AOT packages built successfully!
dir /b nupkg\dotnetsay.linux-*.nupkg
