#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="obsidianos"
iso_label="OBSIDIANOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="ObsidianOS <https://obsidianos.xyz/>"
iso_application="ObsidianOS Live ISO"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('uefi.systemd-boot')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/sudoers"]="0:0:400"
  ["/usr/bin/obsidianctl"]="0:0:755"
  ["/usr/bin/mkobsidiansfs"]="0:0:755"
  ["/usr/bin/obsidian-wizard"]="0:0:755"
  ["/usr/bin/obsidian-control"]="0:0:755"
  ["/usr/bin/mdit"]="0:0:755"
  ["/usr/share/applications/obsidian-control.desktop"]="0:0:755"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/wiki"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
)
