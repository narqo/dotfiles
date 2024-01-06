MAKEFLAGS += --no-builtin-rules

PRJDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DESTDIR := $(HOME)

# === general dot files
dot_files = \
	.bash_aliases \
	.bash_prompt \
	.bashrc \
	.colordiffrc \
	.editorconfig \
	.gitconfig \
	.hgignore \
	.hgrc \
	.pip \
	.profile \
	.vim \

# === fish related files
fish_files = $(addprefix .local/share/,$(wildcard fish))
fish_files += .config/fish/config.fish

# === vim related files

# === neovim related files
nvim_files = .config/nvim

# === psql related files
psql_files = \
	.config/psqlrc \
	.config/pspgconf

# === wezterm
wezterm_files = .config/wezterm

files := $(dot_files)
files += $(nvim_files)
files += $(fish_files)
files += $(psql_files)
files += $(wezterm_files)

CONF_DIRS = $(addprefix $(DESTDIR)/,.config/ $(addprefix .local/,bin/ lib/ share/ opt/))
CONF_FILES = $(addprefix $(DESTDIR)/,$(files))

setup = @ln -svfF $(realpath $<) $@

all: 
	@git pull

$(ignore):
	@echo Skipping $(@)

install: | $(CONF_DIRS) $(CONF_FILES)
	@echo All done

$(DESTDIR)/.%: %
	$(setup)

$(DESTDIR)/.config/%: %
	$(setup)

$(DESTDIR)/.vim/vimrc: vim/vimrc | $(DESTDIR)/.vim
	@git submodule update --init
	vim +PluginInstall +qall

$(DESTDIR)/.config/nvim: nvim | $(CONF_DIRS)
	$(setup)

$(DESTDIR)/.config/fish/config.fish: $(DESTDIR)/.local/share/fish
	@mkdir -p $(shell dirname $@)/functions
	if [ ! -s "$@" ]; then \
		/usr/bin/env bash -c \
			"{ \
				echo '# vim: ft=conf\n'; \
				echo ''; \
				echo 'set -q PATH; or set PATH ""; set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin \$$PATH'; \
				echo 'set -q MANPATH; or set MANPATH ""; set -gx MANPATH /opt/homebrew/share/man \$$MANPATH'; \
				echo 'set -q INFOPATH; or set INFOPATH ""; set -gx INFOPATH /opt/homebrew/share/info \$$INFOPATH'; \
				echo ''; \
				echo '# Source the common user config.fish'; \
				echo 'source $$HOME/.local/share/fish/config.fish'; \
			} > $@"; \
	fi

$(DESTDIR)/.gitconfig: gitconfig | $(DESTDIR)/.config/git $(DESTDIR)/.config/git/ignore
	$(setup)

$(DESTDIR)/.config/git/ignore: gitignore
	$(setup)

$(CONF_DIRS) $(DESTDIR)/.config/git:
	@mkdir -p $@

$(DESTDIR)/.local/share/fish: fish | $(DESTDIR)/.local/share
	$(setup)

clean:
	@-for file in $(CONF_FILES); do \
		test -L "$$file" && rm -rf "$$file"; \
	done

.PHONY: all clean install
