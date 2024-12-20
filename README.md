# Windsurf CLI

A command-line interface for opening files and directories in the Windsurf editor.

## Installation

You can install Windsurf CLI in two ways:

### Option 1: Automatic Installation

1. Clone this repository
2. Run the install script:
   ```bash
   ./install.sh
   ```
   This will install the `windsurf` command to `/usr/local/bin`. You can specify a different installation directory:
   ```bash
   ./install.sh /custom/bin/path
   ```

### Option 2: Manual Installation

1. Clone this repository
2. Copy the `windsurf` script to your local bin directory or add it to your PATH
3. Make the script executable: `chmod +x windsurf`

## Usage

```bash
windsurf <path>
```

Opens the specified path in Windsurf editor.

### Examples

```bash
# Open a file
windsurf myfile.txt

# Open a directory
windsurf /path/to/project
```

## Testing

To run the test suite:

```bash
./test.sh
```

The tests verify:
- Basic command functionality
- Error handling
- Path resolution
- Installation script integrity

## Requirements

- Unix-like operating system (Linux, macOS, etc.)
- Windsurf editor installed

## License

MIT License
