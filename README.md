# dotnetsay .NET Tool

A .NET tool that displays messages with a friendly ASCII bot. It is modeled after [cowsay](https://en.wikipedia.org/wiki/Cowsay), which includes much fancier features.

This tool was created as part of the .NET Core 2.1 project to provide a basic tool to test the (at that time) new `dotnet tool install` capability. It has been updated multiple times with new features and is now a [file-based app](https://learn.microsoft.com/en-us/dotnet/core/sdk/file-based-apps).

## Requirements

- .NET 8, 9, or 10 SDK

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

```bash
dotnet pack -c Release -o ./nupkg /p:ContinuousIntegrationBuild=true
```

### Install locally

```bash
dotnet tool install --add-source ./nupkg -g dotnetsay
```

## Architecture

This is a traditional framework-dependent .NET tool that:
- Multi-targets .NET 8, 9, and 10 for maximum compatibility
- Works on any platform (Windows, macOS, Linux)
- Requires the .NET runtime to be installed on the target machine
- Uses `RollForward=LatestMajor` to work with newer runtime versions

## License

MIT License - Copyright .NET Foundation
