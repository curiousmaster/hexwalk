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

REQ_FILE ?= requirements.txt

# -------------------------------
# DEB Packaging Variables
# -------------------------------
PKG_NAME    = hexwalk
PKG_VERSION = 1.0.0
PKG_ARCH    = all
PKG_MAINT   = Your Name <you@example.com>
PKG_DESC    = HexWalk binary analysis tool

PKG_DIR     = pkg
DEB_FILE    = $(PKG_NAME)_$(PKG_VERSION)_$(PKG_ARCH).deb

.PHONY: all install uninstall clean venv requirements check-root deb

# ---------------------------------------------------------
# Root check
# ---------------------------------------------------------

check-root:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo "Error: This target must be run as root (use sudo)."; \
		exit 1; \
	fi

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

install: check-root requirements
	@echo "Installing hexwalk to $(PREFIX)..."

	$(MKDIR_P) $(BINDIR)
	$(MKDIR_P) $(SHAREDIR)
	$(MKDIR_P) $(MANDIR)

	$(INSTALL_BIN) $(BIN_SRC) $(SHAREDIR)/hexwalk.py

	@echo "Installing shared data..."
	cp -r $(DATA_SRC)/* $(SHAREDIR)/
	chmod -R ugo+r $(SHAREDIR)

	# Include requirements.txt
	cp $(REQ_FILE) $(SHAREDIR)/requirements.txt

	@echo "Creating wrapper..."
	@echo '#!/bin/sh' > $(BINDIR)/hexwalk
	@echo 'exec $(VENV_PY) $(SHAREDIR)/hexwalk.py "$$@"' >> $(BINDIR)/hexwalk
	chmod +x $(BINDIR)/hexwalk

	$(INSTALL_MAN) $(MAN_SRC) $(MANDIR)/hexwalk.1
	@which mandb >/dev/null 2>&1 && mandb || true

	@echo "Install complete."

# ---------------------------------------------------------
# DEB Package
# ---------------------------------------------------------

deb: check-root clean
	@echo "Building .deb package..."

	rm -rf $(PKG_DIR)
	$(MKDIR_P) $(PKG_DIR)/DEBIAN
	$(MKDIR_P) $(PKG_DIR)$(BINDIR)
	$(MKDIR_P) $(PKG_DIR)$(SHAREDIR)
	$(MKDIR_P) $(PKG_DIR)$(MANDIR)

	# Control file
	@echo "Package: $(PKG_NAME)" > $(PKG_DIR)/DEBIAN/control
	@echo "Version: $(PKG_VERSION)" >> $(PKG_DIR)/DEBIAN/control
	@echo "Section: utils" >> $(PKG_DIR)/DEBIAN/control
	@echo "Priority: optional" >> $(PKG_DIR)/DEBIAN/control
	@echo "Architecture: $(PKG_ARCH)" >> $(PKG_DIR)/DEBIAN/control
	@echo "Maintainer: $(PKG_MAINT)" >> $(PKG_DIR)/DEBIAN/control
	@echo "Depends: python3, python3-venv" >> $(PKG_DIR)/DEBIAN/control
	@echo "Description: $(PKG_DESC)" >> $(PKG_DIR)/DEBIAN/control

	# Install files into package
	$(INSTALL_BIN) $(BIN_SRC) $(PKG_DIR)$(SHAREDIR)/hexwalk.py

	cp -r $(DATA_SRC)/* $(PKG_DIR)$(SHAREDIR)/
	chmod -R ugo+r $(PKG_DIR)$(SHAREDIR)

	# Include requirements.txt
	cp $(REQ_FILE) $(PKG_DIR)$(SHAREDIR)/requirements.txt

	# Wrapper
	@echo '#!/bin/sh' > $(PKG_DIR)$(BINDIR)/hexwalk
	@echo 'exec $(VENV_PY) $(SHAREDIR)/hexwalk.py "$$@"' >> $(PKG_DIR)$(BINDIR)/hexwalk
	chmod +x $(PKG_DIR)$(BINDIR)/hexwalk

	# Manpage
	$(INSTALL_MAN) $(MAN_SRC) $(PKG_DIR)$(MANDIR)/hexwalk.1

	# postinst
	@echo '#!/bin/sh' > $(PKG_DIR)/DEBIAN/postinst
	@echo 'set -e' >> $(PKG_DIR)/DEBIAN/postinst
	@echo '' >> $(PKG_DIR)/DEBIAN/postinst
	@echo 'echo "Setting up HexWalk virtual environment..."' >> $(PKG_DIR)/DEBIAN/postinst
	@echo 'if [ ! -d "$(VENV)" ]; then' >> $(PKG_DIR)/DEBIAN/postinst
	@echo '    $(PYTHON) -m venv $(VENV)' >> $(PKG_DIR)/DEBIAN/postinst
	@echo 'fi' >> $(PKG_DIR)/DEBIAN/postinst
	@echo '' >> $(PKG_DIR)/DEBIAN/postinst
	@echo 'echo "Installing Python dependencies..."' >> $(PKG_DIR)/DEBIAN/postinst
	@echo '$(VENV_PY) -m pip install --upgrade pip' >> $(PKG_DIR)/DEBIAN/postinst
	@echo '$(VENV_PY) -m pip install -r $(SHAREDIR)/requirements.txt' >> $(PKG_DIR)/DEBIAN/postinst
	@echo '' >> $(PKG_DIR)/DEBIAN/postinst
	@echo 'echo "Updating man database..."' >> $(PKG_DIR)/DEBIAN/postinst
	@echo 'which mandb >/dev/null 2>&1 && mandb || true' >> $(PKG_DIR)/DEBIAN/postinst

	chmod 0755 $(PKG_DIR)/DEBIAN/postinst

	# Build package
	dpkg-deb --build $(PKG_DIR) $(DEB_FILE)

	@echo "Package created: $(DEB_FILE)"

# ---------------------------------------------------------
# Uninstall
# ---------------------------------------------------------

uninstall: check-root
	@echo "Removing hexwalk from $(PREFIX)..."

	rm -f $(BINDIR)/hexwalk
	rm -f $(MANDIR)/hexwalk.1*
	rm -rf $(SHAREDIR)

	@echo "Uninstall complete."

# ---------------------------------------------------------
# Clean
# ---------------------------------------------------------

clean:
	@echo "Cleaning local artifacts..."
	rm -rf build dist *.egg-info $(PKG_DIR) *.deb
