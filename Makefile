ISO_PATTERN = *.iso
GPG_KEY ?=       # Use default key unless overridden
SKIPSIGN ?= 0    # Set to 1 to skip signing

all: obsidianctl mkobsidiansfs obsidian-wizard archiso sign

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
    cd mkobsidiansfs && chmod +x mkobsidiansfs
    cd mkobsidiansfs && ./mkobsidiansfs ../config.mkobsfs
    cp mkobsidiansfs/system.sfs airootfs/etc/
    cp mkobsidiansfs/mkobsidiansfs airootfs/usr/bin/

.PHONY: obsidian-wizard
obsidian-wizard:
    @echo "Building ObsidianOS Wizard..."
    cp obsidian-wizard/obsidian-wizard.py airootfs/usr/bin/obsidian-wizard

.PHONY: archiso
archiso:
    @echo "Building ObsidianOS ISO Image..."
    mkarchiso -v -r .

.PHONY: sign
sign:
    ifeq ($(SKIPSIGN),1)
        @echo "Skipping ISO signing (SKIPSIGN=1)"
    else
        @for iso in $(ISO_PATTERN); do \
            if [ -f "$$iso" ]; then \
            if [ -z "$(GPG_KEY)" ]; then \
                echo "Signing $$iso with default GPG key..."; \
                gpg --armor --detach-sign "$$iso"; \
            else \
                echo "Signing $$iso with GPG key $(GPG_KEY)..."; \
                gpg --armor --detach-sign --local-user $(GPG_KEY) "$$iso"; \
                fi \
            else \
                echo "No ISO files found to sign"; \
            fi \
        done
    endif
.PHONY: clean
clean:
    rm -rf airootfs/*
    rm -f *.iso *.iso.asc
    @echo "Cleaned build and ISO files"
