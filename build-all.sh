#!/usr/bin/env bash
set -e

# Complete build script for all platforms
# Builds Native AOT packages for all supported platforms using Docker and local SDK

echo "🔨 Building complete dotnetsay package set..."
echo ""

# Clean previous builds
rm -rf nupkg artifacts
mkdir -p nupkg

# 1. Build the root meta-package (no RID)
echo "📦 Building root meta-package..."
dotnet pack -c Release -o ./nupkg /p:ContinuousIntegrationBuild=true
echo ""

# 2. Build the 'any' runtime fallback package
echo "📦 Building 'any' runtime fallback package (multi-target: net8.0, net9.0, net10.0)..."
dotnet pack -c Release -o ./nupkg --runtime-id any /p:ContinuousIntegrationBuild=true /p:PublishAot=false
echo ""

# 3. Build Linux Native AOT packages using Docker
echo "🐳 Building Linux Native AOT packages using Docker..."
echo "   This requires Docker to be installed and running"
echo ""

if command -v docker &> /dev/null; then
    echo "🚀 Building Native AOT package for linux-x64..."
    docker run --rm -v "$(pwd):/src" -w /src mcr.microsoft.com/dotnet/nightly/sdk:10.0-noble-aot \
        dotnet pack -c Release -o /src/nupkg --runtime-id linux-x64 /p:ContinuousIntegrationBuild=true
    echo ""
    
    echo "🚀 Building Native AOT package for linux-arm64..."
    docker run --rm -v "$(pwd):/src" -w /src mcr.microsoft.com/dotnet/nightly/sdk:10.0-noble-arm64v8-aot \
        dotnet pack -c Release -o /src/nupkg --runtime-id linux-arm64 /p:ContinuousIntegrationBuild=true
    echo ""
else
    echo "⚠️  Docker not found - skipping Linux Native AOT packages"
    echo "   Install Docker to build Linux packages on macOS/Windows"
    echo ""
fi

# 4. Build current platform Native AOT package
if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ $(uname -m) == "arm64" ]]; then
        CURRENT_RID="osx-arm64"
    else
        CURRENT_RID="osx-x64"
    fi
    echo "🚀 Building Native AOT package for $CURRENT_RID..."
    dotnet pack -c Release -o ./nupkg --runtime-id $CURRENT_RID /p:ContinuousIntegrationBuild=true
    echo ""
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -m) == "aarch64" ]]; then
        CURRENT_RID="linux-arm64"
    else
        CURRENT_RID="linux-x64"
    fi
    echo "🚀 Building Native AOT package for $CURRENT_RID..."
    dotnet pack -c Release -o ./nupkg --runtime-id $CURRENT_RID /p:ContinuousIntegrationBuild=true
    echo ""
fi

# 5. Show results
echo ""
echo "✅ Build complete! Packages created:"
echo ""
ls -lh nupkg/*.nupkg | awk '{printf "   %-50s %8s\n", $9, $5}'
echo ""
echo "📊 Package breakdown:"
echo "   • Root meta-package: dotnetsay.3.0.0.nupkg"
echo "   • Fallback (net8-10): dotnetsay.any.3.0.0.nupkg"
echo "   • Native AOT: dotnetsay.{platform}.3.0.0.nupkg"
echo ""
echo "📝 Note: Windows packages (win-x64, win-arm64) must be built on Windows"
echo "   Run build.cmd or build.sh on a Windows machine to create those packages"
