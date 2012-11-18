prefix = $(HOME)/.

vim_files = $(notdir $(wildcard $(addprefix vim/, vimrc)))
ignore = $(wildcard GNUmakefile README* functions eclipse ssh osx bin)

files := $(filter-out $(ignore),$(shell ls -1))
files += $(vim_files)

bin := $(addprefix $(HOME)/,$(wildcard bin/*))
conf := $(addprefix $(prefix),$(files))

git_up = @git pull
setup = @ln -svfF $(realpath $<) $@

all: ; $(git_up)

install: $(bin) $(conf)
	@echo All done

$(HOME)/bin/%: bin/%
	@mkdir -p $(HOME)/bin
	$(setup)

$(prefix)%: %; $(setup)

$(prefix)vimrc: vim/vimrc $(prefix)vim
	$(setup)
	@git submodule init; \
		git submodule update
	vim +BundleInstall +qall

$(ignore):
	@echo Skipping $(ignore)

clean:
	@- for file in $(conf); do \
		test -L "$$file" && "$(RM) -r $$file"; \
	done

.PHONY: all clean install

