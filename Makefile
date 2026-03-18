PREFIX     = /usr/local
BINDIR     = $(PREFIX)/bin
SHAREDIR   = $(PREFIX)/share/hexwalk
MANDIR     = $(PREFIX)/share/man/man1

PYTHON     ?= python3
VENV       = $(SHAREDIR)/venv
VENV_PY    = $(VENV)/bin/python
VENV_PIP   = $(VENV)/bin/pip

INSTALL        = install
INSTALL_BIN    = $(INSTALL) -m 0755
INSTALL_MAN    = $(INSTALL) -m 0644
MKDIR_P        = mkdir -p

BIN_SRC   = bin/hexwalk
DATA_SRC  = share/hexwalk
MAN_SRC   = documentation/hexwalk.1

# Use this if you later create a lock file
REQ_FILE ?= requirements.txt
# REQ_FILE ?= requirements.lock

.PHONY: all install uninstall clean venv requirements

# ---------------------------------------------------------
# Default
# ---------------------------------------------------------

all:
	@echo "Nothing to build. Use 'make install'."

# ---------------------------------------------------------
# Virtual Environment Setup
# ---------------------------------------------------------

venv:
	@echo "Setting up virtual environment..."
	@if [ ! -d "$(VENV)" ]; then \
		$(PYTHON) -m venv $(VENV); \
	else \
		echo "Venv already exists."; \
	fi

# ---------------------------------------------------------
# Install Python Requirements
# ---------------------------------------------------------

requirements: venv
	@echo "Installing Python dependencies..."
	$(VENV_PIP) install --upgrade pip
	$(VENV_PIP) install -r $(REQ_FILE)

# ---------------------------------------------------------
# Install
# ---------------------------------------------------------

install: requirements
	@echo "Installing hexwalk to $(PREFIX)..."

	# Create directories
	$(MKDIR_P) $(BINDIR)
	$(MKDIR_P) $(SHAREDIR)
	$(MKDIR_P) $(MANDIR)

	# Install main script (NOT directly executable from /bin)
	$(INSTALL_BIN) $(BIN_SRC) $(SHAREDIR)/hexwalk.py

	# Install shared data (keywords, etc.)
	@echo "Installing shared data..."
	cp -r $(DATA_SRC)/* $(SHAREDIR)/
	chmod -R ugo+r $(SHAREDIR)

	# Create wrapper launcher
	@echo "Creating wrapper..."
	@echo '#!/bin/sh' > $(BINDIR)/hexwalk
	@echo 'exec $(VENV_PY) $(SHAREDIR)/hexwalk.py "$$@"' >> $(BINDIR)/hexwalk
	chmod +x $(BINDIR)/hexwalk

	# Install man page
	$(INSTALL_MAN) $(MAN_SRC) $(MANDIR)/hexwalk.1
	@which mandb >/dev/null 2>&1 && mandb || true

	@echo "Install complete."

# ---------------------------------------------------------
# Uninstall
# ---------------------------------------------------------

uninstall:
	@echo "Removing hexwalk from $(PREFIX)..."

	rm -f $(BINDIR)/hexwalk
	rm -f $(MANDIR)/hexwalk.1*
	rm -rf $(SHAREDIR)

	@echo "Uninstall complete."

# ---------------------------------------------------------
# Clean (local project only)
# ---------------------------------------------------------

clean:
	@echo "Cleaning local artifacts..."
	rm -rf build dist *.egg-info
