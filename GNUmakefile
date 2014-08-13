PRJDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

prefix = $(HOME)/.

NPM ?= npm
NPM_ROOT := $(shell $(NPM) root)
NPM_BIN := $(shell $(NPM) bin)

# === fish related files
fish_confdir = $(wildcard fish)
fish_files = $(addprefix local/share/,$(wildcard $(fish_confdir)/*))
fish_files += config/fish/config.fish

# === vim related files
vim_files = $(notdir $(wildcard $(addprefix vim/, vimrc)))

ignore = $(wildcard GNUmakefile README* functions eclipse ssh osx bin node_modules package.json)
ignore += $(fish_confdir)

files := $(filter-out $(ignore),$(shell ls -1))
files += $(vim_files)
files += $(fish_files)

BIN_FILES = $(addprefix $(HOME)/,$(wildcard bin/*))
NPMBIN_FILES = $(addprefix $(HOME)/,$(subst $(NPM_ROOT)/.,,$(wildcard $(NPM_BIN)/*)))

CONF_FILES = $(addprefix $(prefix),$(files))

# == Functions
git_up = @git pull
setup = @ln -svfF $(realpath $<) $@

# == Targets
all: ; $(git_up) $(npm)

$(ignore):
	@echo Skipping $(@)

install:: $(NPM_BIN) $(BIN_FILES) $(NPMBIN_FILES) $(CONF_FILES)
	@echo All done

$(HOME)/bin/%:: $(HOME)/bin
	@echo trying $@

$(HOME)/bin:
	mkdir -p $@

$(prefix)%: %; $(setup)

$(prefix)gitconfig: gitconfig
	$(setup)
	mkdir -p $(prefix)gitconfig.d

$(prefix)vimrc: vim/vimrc $(prefix)vim
	$(setup)
	@git submodule update --init
	vim +PluginInstall +qall
	@if [ -d $(prefix)vim/bundle/tern_for_vim ]; then \
		echo -n "==> tern_for_vim postinstall... "; \
		cd $(prefix)vim/bundle/tern_for_vim; \
		$(NPM) install; \
		cd $(PRJDIR) \
		echo "done"; \
	fi
	@if [ -d $(prefix)vim/bundle/vimproc.vim ]; then \
		echo -n "==> vimproc postinstall... "; \
		cd $(prefix)vim/bundle/vimproc.vim; \
		make; \
		cd $(PRJDIR); \
		echo "done"; \
	fi

$(prefix)config/fish/config.fish:
	if [ ! -s "$@" ]; then \
		touch $@; \
		echo "# vim: ft=conf\\n\\n# Source the common user config.fish\\nsource ~/.local/share/fish/config.fish" > $@; \
	fi

$(prefix)local/share/fish/%: fish/% $(prefix)local/share/fish
	$(setup)

$(prefix)local/share/fish::
	mkdir -p $@

clean:
	@- for file in $(CONF_FILES); do \
		test -L "$$file" && "$(RM) -r $$file"; \
	done

$(NPM): $(NPM_BIN)
	@echo $(NPMBIN_FILES)

$(NPM_BIN): package.json
	@$(NPM) install

.PHONY: all clean install npm

define setup_binaries

$$(HOME)/bin/$(notdir $1):: $(1) $$(HOME)/bin
	$$(setup)

endef

$(foreach b,$(wildcard bin/*),$(eval $(call setup_binaries,$(b))))
$(foreach b,$(wildcard $(NPM_BIN)/*),$(eval $(call setup_binaries,$b)))

