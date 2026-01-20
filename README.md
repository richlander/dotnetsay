# dotnetsay .NET Tool - Modern Edition

A modernized version of the classic dotnetsay .NET tool, now with Native AOT support for blazing-fast startup times and smaller memory footprint!

## Features

- 🚀 **Native AOT compilation** for instant startup on supported platforms
- 📦 **Platform-specific packages** for optimal size and performance
- 🔄 **CoreCLR fallback** for unsupported platforms via the `any` runtime
- ⚡ **Trimmed and optimized** for minimal disk space

## Requirements

- .NET 10 SDK or later to install and use the tool

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

### Platform-specific Native AOT packages

You need to build on each platform you want to target:

```bash
# On Windows x64
dotnet pack -c Release -o ./nupkg --runtime-id win-x64

# On Linux x64
dotnet pack -c Release -o ./nupkg --runtime-id linux-x64

# On macOS ARM64
dotnet pack -c Release -o ./nupkg --runtime-id osx-arm64

# etc.
```

### Install locally

```bash
dotnet tool install --add-source ./nupkg -g dotnetsay
```

## Architecture

This modernized version uses .NET 10's platform-specific tool packaging:

- **Native AOT packages** for `linux-x64`, `linux-arm64`, `osx-x64`, `osx-arm64`, `win-x64`, and `win-arm64`
- **`any` runtime fallback** package for platforms without Native AOT support
- **Version 2** of the `DotNetCliTool` manifest for multi-RID support

## Package Sizes

Thanks to Native AOT and trimming, the platform-specific packages are significantly smaller than traditional packages:

- Native AOT packages: ~2-3 MB per platform
- Traditional multi-framework package: ~90 MB

## License

MIT License - Copyright .NET Foundation
