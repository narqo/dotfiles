MAKEFLAGS += --no-builtin-rules

PRJDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DESTDIR := $(HOME)

# === fish related files
fish_files = $(addprefix .local/share/,$(wildcard fish))
fish_files += .config/fish/config.fish

# === vim related files

# === neovim related files
nvim_files = .config/nvim

# === psql related files
psql_files = .config/psqlrc

ignore = $(wildcard \
	GNUmakefile \
	Brewfile \
	Caskfile \
	README* \
	osx \
	fish \
	nvim \
	gitignore \
	psqlrc \
	package.json \
)

files := $(addprefix .,$(filter-out $(ignore),$(shell ls -1)))
files += $(nvim_files)
files += $(fish_files)
files += $(psql_files)

CONF_DIRS = $(addprefix $(DESTDIR)/,.config/ $(addprefix .local/,bin/ lib/ share/ opt/))
CONF_FILES = $(addprefix $(DESTDIR)/,$(files))

# == Functions
gitup = @git pull
setup = @ln -svfF $(realpath $<) $@

# == Targets
all: ; $(gitup)

$(ignore):
	@echo Skipping $(@)

install: | $(CONF_DIRS) $(CONF_FILES)
	@echo All done

$(DESTDIR)/.%: %
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
				echo '# Source the common user config.fish'; \
				echo 'source $$HOME/.local/share/fish/config.fish'; \
			} > $@"; \
	fi

$(DESTDIR)/.gitconfig: gitconfig | $(DESTDIR)/.config/git $(DESTDIR)/.config/git/ignore
	$(setup)

$(DESTDIR)/.config/git/ignore: gitignore
	$(setup)

$(DESTDIR)/.local/share/fish: fish | $(DESTDIR)/.local/share
	$(setup)

$(DESTDIR)/.config/psqlrc: psqlrc
	$(setup)

$(CONF_DIRS) $(DESTDIR)/.config/git:
	@mkdir -p $@

clean:
	@-for file in $(CONF_FILES); do \
		test -L "$$file" && rm -rf "$$file"; \
	done

.PHONY: all clean install
