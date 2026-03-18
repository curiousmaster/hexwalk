PREFIX   ?= /usr/local
BINDIR    = $(PREFIX)/bin
SHAREDIR  = $(PREFIX)/share/hexwalk
MANDIR    = $(PREFIX)/share/man/man1

INSTALL       = install
INSTALL_BIN   = $(INSTALL) -m 0755
INSTALL_MAN   = $(INSTALL) -m 0644
MKDIR_P       = mkdir -p

BIN_SRC   = bin/hexwalk
DATA_SRC  = share/hexwalk
MAN_SRC   = documentation/hexwalk.1

.PHONY: all requirements install uninstall clean

all:
	@echo "Nothing to build. Use 'make install'."

requirements:
	@echo "Installing hexwalk requirements"
	pip install -r requirements.txt

install:
	@echo "Installing hexwalk to $(PREFIX)..."

	# Create directories
	$(MKDIR_P) $(BINDIR)
	$(MKDIR_P) $(SHAREDIR)
	$(MKDIR_P) $(MANDIR)

	# Install requirements
	python -m venv ${SHAREDIR}/venv
	${SHAREDIR}/venv/bin/python -m pip install -r requirements.txt

	# Install binary
	$(INSTALL_BIN) $(BIN_SRC) $(BINDIR)/hexwalk

	# Install shared data (including keywords tree)
	@echo "Installing shared data..."
	cp -r $(DATA_SRC)/* $(SHAREDIR)/
	chmod -R ugo+r $(SHAREDIR)

	# Install man page
	$(INSTALL_MAN) $(MAN_SRC) $(MANDIR)/hexwalk.1
	mandb

	@echo "Install complete."

uninstall:
	@echo "Removing hexwalk from $(PREFIX)..."
	rm -f $(BINDIR)/hexwalk
	rm -rf $(SHAREDIR)
	rm -f $(MANDIR)/hexwalk.1*
	@echo "Uninstall complete."

clean:
	@echo "Nothing to clean."

