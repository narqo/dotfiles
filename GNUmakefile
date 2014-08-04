PRJDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

prefix = $(HOME)/.

NPM ?= npm
NPM_ROOT := $(shell $(NPM) root)
NPM_BIN := $(shell $(NPM) bin)

vim_files = $(notdir $(wildcard $(addprefix vim/, vimrc)))
ignore = $(wildcard GNUmakefile README* functions eclipse ssh osx bin node_modules package.json)

files := $(filter-out $(ignore),$(shell ls -1))
files += $(vim_files)

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

$(HOME)/bin::
	@mkdir -p $@

$(prefix)%: %; $(setup)

$(prefix)vimrc: vim/vimrc $(prefix)vim
	$(setup)
	@git submodule update --init
	vim +PluginInstall +qall
	@[ -d $(prefix)vim/bundle/tern_for_vim ] && \
		echo -n "==> tern_for_vim postinstall... "
		cd $(prefix)vim/bundle/tern_for_vim; \
		$(NPM) install; \
		cd $(PRJDIR) \
		echo "done"
	@[ -d $(prefix)vim/bundle/vimproc.vim ] && \
		echo -n "==> vimproc postinstall... "; \
		cd $(prefix)vim/bundle/vimproc.vim; \
		make; \
		cd $(PRJDIR); \
		echo "done"

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

