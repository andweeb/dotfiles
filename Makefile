# Makefile for some light dotfile management (macos only)
SHELL = bash
TAG = andrew.dotfile
ZSH = $(notdir $(wildcard $(CURDIR)/zsh/.*zsh*))
DOTFILES = .gitconfig .vimrc .tmux.conf .hammerspoon

# Symlink all dotfiles
dotfiles: zsh $(foreach f, $(DOTFILES), dotfiles-$(f))
dotfiles-%: %
	@echo "$< => $(HOME)/$<"
	@ln -si $(CURDIR)/$< $(HOME)/$(notdir $<) && xattr -ws $(TAG) true $(HOME)/$(notdir $<)

# Symlink zsh dotfiles
zsh: $(foreach f, $(ZSH), zsh-$(f))
zsh-%: zsh/%
	@echo "$< => $(HOME)/$(notdir $<)"
	@ln -si $(CURDIR)/$< $(HOME)/$(notdir $<) && xattr -ws $(TAG) true $(HOME)/$(notdir $<)

# Clean dotfiles explicitly tagged by this Makefile
.PHONY: confirm_clean clean
clean: confirm_clean
	@find ~ -maxdepth 1 -xattrname andrew.dotfile -delete
	@echo "Done."
confirm_clean:
	@echo "The following symlinks will be removed:"
	@find ~ -maxdepth 1 -xattrname andrew.dotfile
	@echo -n "Continue? [y/N] " && read ans && [ $${ans:-N} = y ]
