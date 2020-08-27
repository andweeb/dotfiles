# Makefile for some light dotfile management (macos only)

SHELL = bash
TAG = andrew.dotfile
DOTFILES = .vimrc .tmux.conf .hammerspoon
ZSH = $(notdir $(wildcard $(CURDIR)/zsh/.*zsh*))
XDG=$(if $(XDG_CONFIG_HOME), $(XDG_CONFIG_HOME), $(HOME)/.config)

define symlink
	@echo "$(if $<, $<, $(notdir $(1))) => $(2)"
	@-ln -shi $(1) $(2) && xattr -ws $(TAG) true $(2)
endef

# Link all dotfiles
link: $(foreach f, $(ZSH) $(DOTFILES), link-$(f)) link-git
link-%: %
	$(call symlink, $(CURDIR)/$<, $(HOME)/$<)

# Link files in subdirectories
link-%: zsh/%
	$(call symlink, $(CURDIR)/$<, $(HOME)/$(notdir $<))
link-%: vim/%
	$(call symlink, $(CURDIR)/$<, $(HOME)/$(notdir $<))

# Link git directory to XDG config location
link-git:
	$(call symlink, $(CURDIR)/git, $(XDG)/git)

# Clean dotfiles explicitly tagged by this Makefile
.PHONY: confirm-clean clean
clean: confirm-clean
	@find $(HOME) $(XDG) -maxdepth 1 -xattrname andrew.dotfile -delete
	@echo "Done."
confirm-clean:
	@echo "The following symlinks will be removed:"
	@find $(HOME) $(XDG) -maxdepth 1 -xattrname andrew.dotfile
	@echo -n "Continue? [y/N] " && read ans && [ $${ans:-N} = y ]
