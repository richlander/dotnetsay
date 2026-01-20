#!/usr/bin/env bash
set -e

# Build script for creating multi-RID Native AOT packages
# This script should be run on each target platform to create the platform-specific packages

echo "🔨 Building dotnetsay with Native AOT for multiple platforms..."

# Clean previous builds
rm -rf nupkg artifacts
mkdir -p nupkg

# Detect current platform
if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ $(uname -m) == "arm64" ]]; then
        CURRENT_RID="osx-arm64"
    else
        CURRENT_RID="osx-x64"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ $(uname -m) == "aarch64" ]]; then
        CURRENT_RID="linux-arm64"
    else
        CURRENT_RID="linux-x64"
    fi
else
    echo "❌ Unsupported platform: $OSTYPE"
    exit 1
fi

echo "📦 Detected platform: $CURRENT_RID"

# Build the root meta-package (no RID)
echo "📦 Building root meta-package..."
dotnet pack -c Release -o ./nupkg /p:ContinuousIntegrationBuild=true

# Build the platform-specific Native AOT package for current platform
echo "🚀 Building Native AOT package for $CURRENT_RID..."
dotnet pack -c Release -o ./nupkg --runtime-id $CURRENT_RID /p:ContinuousIntegrationBuild=true

# Build the 'any' runtime fallback package
echo "📦 Building 'any' runtime fallback package..."
dotnet pack -c Release -o ./nupkg --runtime-id any /p:ContinuousIntegrationBuild=true /p:PublishAot=false

echo ""
echo "✅ Build complete! Packages created:"
ls -lh nupkg/*.nupkg

echo ""
echo "📝 Note: To build for other platforms, run this script on those platforms."
echo "   Supported platforms: linux-x64, linux-arm64, osx-x64, osx-arm64, win-x64, win-arm64"
