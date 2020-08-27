# Makefile for some light dotfile management (macos only)

SHELL = bash
TAG = andrew.dotfile
XDG_FILES = alacritty bat git kitty
HOME_FILES = .vimrc .tmux.conf .hammerspoon
ZSH = $(notdir $(wildcard $(CURDIR)/zsh/.*zsh*))
XDG_CONFIG_DIR = $(if $(XDG_CONFIG_HOME), $(XDG_CONFIG_HOME), $(HOME)/.config)

define symlink
	@echo "$(if $<, $<, $(notdir $(1))) => $(2)"
	@-ln -shiF $(1) $(2) && xattr -ws $(TAG) true $(2)
endef

link: link-home link-xdg

# Link all dotfiles
link-home: $(foreach f, $(ZSH) $(HOME_FILES), link-home-$(f))
link-home-%: %
	$(call symlink, $(CURDIR)/$<, $(HOME)/$<)

# Link files in subdirectories
link-home-%: zsh/%
	$(call symlink, $(CURDIR)/$<, $(HOME)/$(notdir $<))
link-home-%: vim/%
	$(call symlink, $(CURDIR)/$<, $(HOME)/$(notdir $<))

# Link git directory to XDG config location
$(XDG_CONFIG_DIR):
	mkdir -p $(XDG_CONFIG_DIR)
link-xdg: $(XDG_CONFIG_DIR) $(foreach f, $(XDG_FILES), link-xdg-$(f))
link-xdg-%: %
	$(call symlink, $(CURDIR)/$<, $(XDG_CONFIG_DIR)/$<)

# Clean dotfiles explicitly tagged by this Makefile
.PHONY: confirm-clean clean
clean: confirm-clean
	@find $(HOME) $(XDG_CONFIG_DIR) -maxdepth 1 -xattrname andrew.dotfile -delete
	@echo "Done."
confirm-clean:
	@echo "The following symlinks will be removed:"
	@find $(HOME) $(XDG_CONFIG_DIR) -maxdepth 1 -xattrname andrew.dotfile
	@echo -n "Continue? [y/N] " && read ans && [ $${ans:-N} = y ]
