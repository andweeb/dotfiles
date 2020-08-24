# Makefile for some light dotfile management (macos only)

SHELL = bash
TAG = andrew.dotfile
ZSH = $(notdir $(wildcard $(CURDIR)/zsh/.*zsh*))
DOTFILES = .gitconfig .vimrc .tmux.conf .hammerspoon

define symlink
	@echo "$< => $(2)"
	@-ln -si $(1) $(2) && xattr -ws $(TAG) true $(2)
endef

# Symlink all dotfiles
link: $(foreach f, $(DOTFILES) $(ZSH), link-$(f))
link-%: %
	$(call symlink,$(CURDIR)/$<,$(HOME)/$<)
link-%: zsh/%
	$(call symlink,$(CURDIR)/$<,$(HOME)/$(notdir $<))

# Clean dotfiles explicitly tagged by this Makefile
.PHONY: confirm-clean clean
clean: confirm-clean
	@find ~ -maxdepth 1 -xattrname andrew.dotfile -delete
	@echo "Done."
confirm-clean:
	@echo "The following symlinks will be removed:"
	@find ~ -maxdepth 1 -xattrname andrew.dotfile
	@echo -n "Continue? [y/N] " && read ans && [ $${ans:-N} = y ]
