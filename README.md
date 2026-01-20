# dotnetsay .NET Tool

A classic .NET tool that displays messages with a friendly ASCII bot.

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
