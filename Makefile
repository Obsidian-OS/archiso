all: obsidianctl mkobsidiansfs obsidian-wizard obsidian-control archiso

obsidianctl:
	@echo "Building obsidianctl..."
	mkdir -p airootfs/usr/bin/
	cd obsidianctl && make
	cp obsidianctl/obsidianctl airootfs/usr/bin/

mkobsidiansfs:
	@echo "Building mkobsidiansfs..."
	mkdir -p airootfs/etc/
	cd mkobsidiansfs && chmod +x mkobsidiansfs
	cd mkobsidiansfs && ./mkobsidiansfs ../config.mkobsfs
	cp mkobsidiansfs/system.sfs airootfs/etc/
	cp mkobsidiansfs/mkobsidiansfs airootfs/usr/bin/

obsidian-wizard:
	@echo Building ObsidianOS Wizard...
	cp obsidian-wizard/obsidian-wizard.py airootfs/usr/bin/obsidian-wizard

obsidian-control:
	@echo Building ObsidianOS Control Center...
	cp obsidian-control/obsidian-control.py airootfs/usr/bin/obsidian-control
	cp obsidian-control/obsidian-control.desktop airootfs/usr/share/applications/

archiso:
	@echo Building ObsidianOS ISO Image...
	mkarchiso -v -r .
