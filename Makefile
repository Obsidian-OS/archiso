ISO_PATTERN = *.iso
GPG_KEY ?=	   # Use default key unless overridden
SKIPSIGN ?= 0	# Set to 1 to skip signing

all: obsidianctl mkobsidiansfs obsidian-wizard midt archiso sign

.PHONY: mdit
	@echo "Copying MDIT..."
	cp mdit/mdit airootfs/usr/bin/

.PHONY: obsidianctl
obsidianctl:
	@echo "Building obsidianctl..."
	mkdir -p airootfs/usr/bin/
	cd obsidianctl && make
	cp obsidianctl/obsidianctl airootfs/usr/bin/

.PHONY: mkobsidiansfs
mkobsidiansfs:
	@echo "Building mkobsidiansfs..."
	mkdir -p airootfs/etc/
	cd mkobsidiansfs && \
	chmod +x mkobsidian* && \
	cp mkobsidiansfs* ../airootfs/usr/bin && \
	./mkobsidiansfs ../config.mkobsfs && \
	cp system.sfs ../airootfs/etc/

.PHONY: obsidian-wizard
obsidian-wizard:
	@echo "Building ObsidianOS Wizard..."
	cp obsidian-wizard/obsidian-wizard.py airootfs/usr/bin/obsidian-wizard

.PHONY: archiso
archiso:
	@echo "Building ObsidianOS ISO Image..."
	mkarchiso -v -r .

.PHONY: clean
clean:
	rm -rf airootfs/*
	rm -f *.iso *.iso.asc
	@echo "Cleaned build and ISO files"
