
help:
	@echo 'make install_emacs'
	@echo 'make install_git'
	@echo 'make install_dev'
	@echo 'make get_dotfiles'
	@echo 'make get_this'
	@echo 'make get_memos'
	@echo 'make get_tgtdev'
	@echo 'make get_pcdev'
	@echo 'make git_config'
	@echo 'make git_setproxy'
	@echo 'make git_unsetproxy'

# ------------------------------------------------
install_git:
	sudo apt update
	sudo apt install git

install_dev:
	sudo apt update
	sudo apt install build-essential

install_basic:
	sudo apt update
	sudo apt install emacs net-tools global


# ------------------------------------------------ samba
## Sambaサーバーの設定手順(Ubuntu18.04)とWindowsからのアクセス方法
## https://aquarius-train.hatenablog.com/entry/Samba%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%89%8B%E9%A0%86%E3%81%A8Windows%E3%81%8B%E3%82%89%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E6%96%B9%E6%B3%95
##
samba_install:
	sudo -E apt update
	sudo -E apt install samba
samba_adduser:
	sudo pdbedit -a hirai
samba_editconf:
	sudo vi /etc/samba/smb.conf
samba_restart:
	sudo service smbd restart
	sudo service nmbd restart
samba_enable:
	sudo systemctl enable smbd
	sudo systemctl enable nmbd

# --------------------------------------------- My dotfiles
get_dotfiles:
	(cd ~; git clone https://github.com/hiraieject/.dotfiles.git)
	(cd ~/.dotfiles; ./link.sh)

# --------------------------------------------- My folders
get_this:
	(cd ..; apt clone https://github.com/hiraieject/linuxenv.git)

get_memos:
	(cd ~; git clone https://github.com/hiraieject/memos.git)
get_tgtdev:
	(cd ~; git clone https://github.com/hiraieject/tgtdev.git)
get_pcdev:
	(cd ~; git clone https://github.com/hiraieject/pcdev.git)

# --------------------------------------------- git
git_config:
	git config --global user.email "you@example.com"
	git config --global user.name "account name"
	git config --global credential.helper store
	@echo 'https://YOUR_ACCOUNT:YOUR_TOKEN@github.com' > ~/.git-credentials
	@chmod og-rwx ~/.git-credentials
	@echo Please edit ~/.git-credentials,  ~/.gitconfig
git_setproxy:
	git config --global http.proxy http://10.77.8.70:8080
	git config --global https.proxy http://10.77.8.70:8080
git_unsetproxy:
	git config --global --unset http.proxy
	git config --global --unset https.proxy

# --------------------------------------------- mozc
install_mozc:
	sudo apt update
	sudo apt install emacs-mozc-bin
#	(mkdir -p ~/.emacs.d/lisp; cd ~/.emacs.d/lisp; \
#	 wget https://raw.githubusercontent.com/google/mozc/master/src/unix/emacs/mozc.el)

# google jpanese input
# (setq default-input-method "japanese-mozc")
# (require 'mozc)

# --------------------------------------------- LXC
## https://www.kkaneko.jp/tools/container/lxc.html
## https://ubuntu.com/server/docs/containers-lxc
## https://linuxcontainers.org/ja/lxc/introduction/#LXC

LXCCON=test1

lxc_install:
	sudo apt update
	sudo apt -y install debootstrap lxc lxctl lxc-templates curl
##	lxc-checkconfig

lxc_templates:
	ls -l /usr/share/lxc/templates
lxc_list:
	sudo lxc-ls 

lxc_create:
	sudo lxc-create -t /usr/share/lxc/templates/lxc-ubuntu -n $(LXCCON)
lxc_destroy:
	sudo lxc-destroy -n $(LXCCON)
lxc_start:
	sudo lxc-start -n $(LXCCON)
lxc_stop:
	sudo lxc-stop -n $(LXCCON)
lxc_attach:
	sudo lxc-attach -n $(LXCCON)
lxc_editconf:
	sudo vi /var/lib/lxc/test1/config
