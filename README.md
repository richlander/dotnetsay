# dotnetsay .NET Tool - Modern Edition

A modernized version of the classic dotnetsay .NET tool, now with Native AOT support for blazing-fast startup times and smaller memory footprint!

## Features

- 🚀 **Native AOT compilation** for instant startup on supported platforms
- 📦 **Platform-specific packages** for optimal size and performance
- 🔄 **CoreCLR fallback** for unsupported platforms via the `any` runtime
- ⚡ **Trimmed and optimized** for minimal disk space

## Requirements

- **.NET 10 SDK**: Get the best experience with Native AOT for instant startup
- **.NET 8 or 9 SDK**: Still works! Uses the framework-dependent fallback package

## Installation

Install the tool globally:

```bash
dotnet tool install -g dotnetsay
dotnetsay
```

Or run it once without installing using `dnx`:

```bash
dnx dotnetsay
```

## Usage

Basic usage:

```bash
dotnetsay
```

With a custom message:

```bash
dotnetsay "Hello from Native AOT!"
```

From piped input:

```bash
echo "This is awesome" | dotnetsay
```

## Uninstall

```bash
dotnet tool uninstall -g dotnetsay
```

## Building from Source

### Framework-dependent package (with fallback)

```bash
dotnet pack -c Release -o ./nupkg
```

### Native AOT - Current platform only

```bash
# Automatically detects your platform (macOS, Linux, Windows)
./build.sh         # macOS/Linux
build.cmd          # Windows
```

### Native AOT - All platforms

```bash
# Builds for current platform + Linux via Docker
./build-all.sh     # macOS/Linux

# Or build Linux packages separately via Docker
./build-linux.sh   # macOS/Linux  
build-linux.cmd    # Windows
```

The Docker-based builds use official Microsoft .NET SDK AOT container images to cross-compile Linux Native AOT binaries from any platform.

### Install locally

```bash
dotnet tool install --add-source ./nupkg -g dotnetsay
```

## Architecture

This modernized version uses .NET 10's platform-specific tool packaging with backward compatibility:

- **Native AOT packages** for `linux-x64`, `linux-arm64`, `osx-x64`, `osx-arm64`, `win-x64`, and `win-arm64` (requires .NET 10 SDK)
- **`any` runtime fallback** package targeting .NET 8, 9, and 10 for maximum compatibility
- **Version 2** of the `DotNetCliTool` manifest for multi-RID support

When you install with .NET 10 SDK, you get the blazing-fast Native AOT version. With .NET 8/9 SDK, you automatically get the framework-dependent version that works everywhere.

## Package Sizes

Thanks to Native AOT and trimming, the platform-specific packages are significantly smaller than traditional packages:

- Native AOT packages: ~2-3 MB per platform
- Traditional multi-framework package: ~90 MB

## License

MIT License - Copyright .NET Foundation
