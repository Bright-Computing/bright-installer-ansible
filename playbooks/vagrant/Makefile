BRIGHT_PKG_MIRROR ?= http://bright_pkg_mirror.example.com  # should be set accordingly
BRIGHT_ISO_MIRROR ?= http://bright_iso_mirror.example.com  # should be set accordingly

init:
	# install needed pip modules
	pip install -r requirements/pip.txt
	# install needed ansible collections
	ansible-galaxy collection install -r requirements/ansible.yml
.PHONY: init

files/cm-config-cm.noarch.rpm:
	wget ${BRIGHT_PKG_MIRROR}/$(notdir $@) -O $@

files/cm-config-yum.noarch.rpm:
	wget ${BRIGHT_PKG_MIRROR}/$(notdir $@) -O $@

download-repo-packages: | files/cm-config-yum.noarch.rpm files/cm-config-cm.noarch.rpm

files/bright9.2-rocky8u5.iso:
	wget ${BRIGHT_ISO_MIRROR}/$(notdir $@) -O $@

files/bright9.2-rocky8u5.iso.md5:
	wget ${BRIGHT_ISO_MIRROR}/$(notdir $@) -O $@

download-iso: | files/bright9.2-rocky8u5.iso files/bright9.2-rocky8u5.iso.md5

clean:
	rm -rvf files/*.rpm files/*.deb files/*.iso*
.PHONY: clean
