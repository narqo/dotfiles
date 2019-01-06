MAKEFLAGS += --no-builtin-rules

PRJDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

root_prefix = $(HOME)
prefix = $(addprefix $(root_prefix)/,.local)

# === fish related files
fish_files = $(addprefix .local/share/,$(wildcard fish))
fish_files += .config/fish/config.fish

# === vim related files

# === neovim related files
nvim_files = .config/nvim

ignore = $(wildcard \
	GNUmakefile \
	Brewfile \
	Caskfile \
	README* \
	osx \
	fish \
	nvim \
	gitignore \
	package.json \
)

files := $(addprefix .,$(filter-out $(ignore),$(shell ls -1)))
files += $(nvim_files)
files += $(fish_files)

BIN_FILES = $(addprefix $(prefix)/,$(wildcard bin/*))
CONF_DIRS = $(addprefix $(root_prefix)/,.config/ $(addprefix .local/,bin/ share/ opt/))
CONF_FILES = $(addprefix $(root_prefix)/,$(files))

# == Functions
git_up = @git pull
setup = @ln -svfF $(realpath $<) $@

# == Targets
all: ; $(git_up)

$(ignore):
	@echo Skipping $(@)

install: | $(CONF_DIRS) $(CONF_FILES)
	@echo All done

$(root_prefix)/.%: %
	$(setup)

$(root_prefix)/.vim/vimrc: vim/vimrc | $(root_prefix)/.vim
	@git submodule update --init
	vim +PluginInstall +qall

$(root_prefix)/.config/nvim: nvim | $(CONF_DIRS)
	$(setup)

$(root_prefix)/.config/fish/config.fish: $(prefix)/share/fish
	@mkdir -p $(shell dirname $@)/functions
	if [ ! -s "$@" ]; then \
		/usr/bin/env bash -c \
			"{ \
				echo '# vim: ft=conf\n'; \
				echo '# Source the common user config.fish'; \
				echo 'source $$HOME/.local/share/fish/config.fish'; \
			} > $@"; \
	fi

$(root_prefix)/.gitconfig: gitconfig | $(root_prefix)/.config/git $(root_prefix)/.config/git/ignore
	$(setup)

$(root_prefix)/.config/git/ignore: gitignore
	$(setup)

$(prefix)/share/fish: fish | $(prefix)/share
	$(setup)

$(CONF_DIRS) $(root_prefix)/.config/git:
	@mkdir -p $@

clean:
	@-for file in $(CONF_FILES); do \
		test -L "$$file" && rm -rf "$$file"; \
	done

.PHONY: all clean install npm

