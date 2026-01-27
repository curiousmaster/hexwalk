PREFIX ?= /usr/local
BINDIR  = $(PREFIX)/bin
SHAREDIR = $(PREFIX)/share/hexwalk

INSTALL = install
INSTALL_BIN = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 0644
MKDIR_P = mkdir -p

BIN_SRC = bin/hexwalk
DATA_SRC = share/hexwalk

.PHONY: all install uninstall clean

all:
	@echo "Nothing to build. Use 'make install'."

install:
	@echo "Installing hexwalk to $(PREFIX)..."
	$(MKDIR_P) $(BINDIR)
	$(MKDIR_P) $(SHAREDIR)

	$(INSTALL_BIN) $(BIN_SRC) $(BINDIR)/hexwalk
	$(INSTALL_DATA) $(DATA_SRC)/*.txt $(SHAREDIR)/

	@echo "Install complete."

uninstall:
	@echo "Removing hexwalk from $(PREFIX)..."
	rm -f $(BINDIR)/hexwalk
	rm -rf $(SHAREDIR)

	@echo "Uninstall complete."

clean:
	@echo "Nothing to clean."

