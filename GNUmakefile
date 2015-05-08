PRJDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

root_prefix = $(HOME)/.
prefix = $(addprefix $(root_prefix),local/)

NPM ?= npm -g --prefix=$(prefix)
NPM_ROOT := $(shell $(NPM) root)
NPM_BIN := $(shell $(NPM) bin)

# === fish related files
fish_files = $(addprefix local/share/,$(wildcard fish))
fish_files += config/fish/config.fish

# === vim related files
vim_files = $(notdir $(wildcard $(addprefix vim/, vimrc)))

ignore = $(wildcard GNUmakefile Brewfile Caskfile README* osx fish package.json)

files := $(filter-out $(ignore),$(shell ls -1))
files += $(vim_files)
files += $(fish_files)

BIN_FILES = $(addprefix $(prefix),$(wildcard bin/*))
CONF_DIRS = $(addprefix $(root_prefix),config/ $(addprefix local/,bin/ share/ opt/))
CONF_FILES = $(addprefix $(root_prefix),$(files))

# == Functions
git_up = @git pull
setup = @ln -svfF $(realpath $<) $@

# == Targets
all: ; $(git_up)

$(ignore):
	@echo Skipping $(@)

install:: $(CONF_DIRS) $(CONF_FILES)
	@echo All done

$(root_prefix)%: %; $(setup)

$(root_prefix)vimrc: vim/vimrc $(root_prefix)vim
	$(setup)
	@git submodule update --init
	vim +PluginInstall +qall
	@if [ -d $(root_prefix)vim/bundle/tern_for_vim ]; then \
		( \
			echo "==> tern_for_vim postinstall... "; \
			cd $(root_prefix)vim/bundle/tern_for_vim; \
			npm install; \
			echo "done"; \
		) \
	fi
	@if [ -d $(prefix)vim/bundle/vimproc.vim ]; then \
		( \
			echo "==> vimproc postinstall... "; \
			cd $(prefix)vim/bundle/vimproc.vim; \
			make; \
			echo "done"; \
		) \
	fi

$(root_prefix)config/fish/config.fish: $(prefix)share/fish
	@mkdir -p $(shell dirname $@)/functions
	if [ ! -s "$@" ]; then \
		touch $@; \
		/usr/bin/env bash -c \
			"echo -e '# vim: ft=conf\n\n# Source the common user config.fish\nsource $$HOME/.local/share/fish/config.fish' \
				> $@"; \
	fi

$(root_prefix)gitconfig: gitconfig $(CONF_DIRS)
	@mkdir -p $(root_prefix)config/git
	$(setup)

$(prefix)share/fish: fish $(prefix)share
	$(setup)

$(CONF_DIRS):
	@mkdir -p $@

clean:
	@-for file in $(CONF_FILES); do \
		test -L "$$file" && rm -rf "$$file"; \
	done

.PHONY: all clean install npm

