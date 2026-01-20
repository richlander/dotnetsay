#!/usr/bin/env bash
set -e

# Build Linux Native AOT packages using official .NET SDK container images
# This allows building for Linux even when running on macOS or Windows

echo "🐳 Building Linux Native AOT packages using Docker..."

# Clean previous builds
mkdir -p nupkg

# Build for linux-x64 using the official .NET SDK container
echo "🚀 Building Native AOT package for linux-x64..."
docker run --rm -v "$(pwd):/src" -w /src mcr.microsoft.com/dotnet/nightly/sdk:10.0-noble-aot \
  dotnet pack -c Release -o /src/nupkg -r linux-x64 /p:ContinuousIntegrationBuild=true

# Build for linux-arm64 using the official .NET SDK container
echo "🚀 Building Native AOT package for linux-arm64..."
docker run --rm -v "$(pwd):/src" -w /src mcr.microsoft.com/dotnet/nightly/sdk:10.0-noble-arm64v8-aot \
  dotnet pack -c Release -o /src/nupkg -r linux-arm64 /p:ContinuousIntegrationBuild=true

echo ""
echo "✅ Linux Native AOT packages built successfully!"
ls -lh nupkg/dotnetsay.linux-*.nupkg
