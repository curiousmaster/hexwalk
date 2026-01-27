# HexWalk

HexWalk is an interactive terminal-based analysis tool for inspecting binaries, firmware images, and raw data files for embedded strings, artifacts, and security-relevant indicators.  
It is designed for security engineers, reverse engineers, and incident responders who need fast, repeatable insight into unknown or opaque binaries.

HexWalk combines keyword-driven scanning with a curses-based user interface, allowing analysts to explore findings interactively while retaining the ability to export structured results and summaries for reporting.

---

## Key Features

- Interactive terminal user interface (TUI)
- Supports raw binaries, ELF files, and Intel HEX firmware images
- Keyword-based scanning using categorized rule files
- Context-aware hit display with hex + ASCII views
- Stable, non-wrapping layout designed for narrow terminals
- Summary page with per-category and per-keyword breakdown
- Export of findings to JSON
- Export of summaries to human-readable text files
- Clean separation between analysis, presentation, and reporting

---

## Supported File Types

HexWalk can analyze:

- Raw binary files (`.bin`, `.img`, dumps, etc.)
- ELF executables and shared objects
- Intel HEX firmware images (with extended linear address support)
- Text files

The tool automatically detects Intel HEX files and converts them into a flat binary image before analysis.

---

## Installation

### Requirements

- Python 3.9 or newer
- A terminal with curses support (most Linux terminals)
- Read access to the analyzed file
- Write access to the current directory (for exports)

### Install from Source

Clone the repository:

```bash
git clone git@github.com:curiousmaster/hexwalk.git
cd hexwalk

Install into /usr/local:
```bash
make install

This installs:
* hexwalk to /usr/local/bin
* Keyword ryle files to /usr/local/share/hexwalk

To uninstall:
```bash
make uninstall
```

### Usage
Basic usage:
```bash
hexwalk <file>

### User Interface Overview:
HexWalk runs entirely in the terminal and is divided into three primary panes:

1. Categories (left)
2. Hits (center)
3. Details (right)

A separate Summary Page is available and replaces the entire screen.

## Contributing
Contributions are welcome, especially:

* Additional keyword categories
* Improvements to summary reporting
* Export format extensions
* Performance optimizations
* Documentation improvements

Please keep changes consistent with the existing design philosophy.

## LICENSE
HexWalk is released under the MIT License. See `LICENSE.md` for details.
