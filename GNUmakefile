prefix = $(HOME)/.

npm_root := $(shell npm root)
npm_bin := $(shell npm bin)

vim_files = $(notdir $(wildcard $(addprefix vim/, vimrc)))
ignore = $(wildcard GNUmakefile README* functions eclipse ssh osx bin node_modules package.json)

files := $(filter-out $(ignore),$(shell ls -1))
files += $(vim_files)

bin := $(addprefix $(HOME)/,$(wildcard bin/*))
conf := $(addprefix $(prefix),$(files))

npmbin = $(addprefix $(HOME)/,$(subst $(npm_root)/.,,$(wildcard $(npm_bin)/*)))

git_up = @git pull
setup = @ln -svfF $(realpath $<) $@

all: ; $(git_up) $(npm)

$(ignore):
	@echo Skipping $(@)

install:: $(npm_bin) $(bin) $(npmbin) $(conf)
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
		cd $(prefix)vim/bundle/tern_for_vim; \
		npm install; \
		cd -; \
		echo "tern_for_vim post install done"

clean:
	@- for file in $(conf); do \
		test -L "$$file" && "$(RM) -r $$file"; \
	done

npm: $(npm_bin)
	@echo $(npmbin)

$(npm_bin): package.json
	@npm install

.PHONY: all clean install npm

define setup_binaries

$$(HOME)/bin/$(notdir $1):: $(1) $$(HOME)/bin
	$$(setup)

endef

$(foreach b,$(wildcard bin/*),$(eval $(call setup_binaries,$(b))))
$(foreach b,$(wildcard $(npm_bin)/*),$(eval $(call setup_binaries,$b)))

