NULL =
homedir = $(prefix)
dotfiles = \
 bash_completion \
 bash_logout \
 bash_profile \
 bashrc \
 bazaar/ignore \
 colordiffrc \
 cshrc \
 cvsignore \
 cvsrc \
 dircolors \
 emacs \
 gitignore \
 hgignore \
 inputrc \
 ipython/ipy_user_conf.py \
 ipython/ipythonrc \
 ipython/profile_default/ipython_config.py \
 irbrc \
 lintianrc \
 octaverc \
 profile \
 quiltrc \
 quiltrc-dpkg \
 re.pl/repl.rc \
 shrc \
 ssh/config \
 tcsh_editing \
 teclarc \
 vim/after/ftplugin/c.vim \
 vim/after/ftplugin/fortran.vim \
 vim/after/ftplugin/perl.vim \
 vim/after/ftplugin/python.vim \
 vim/after/ftplugin/ruby.vim \
 vim/after/ftplugin/sh.vim \
 vim/after/ftplugin/vim.vim \
 vim/after/syntax/m4.vim \
 vim/bundle/nerdtree/doc/NERD_tree.txt \
 vim/bundle/nerdtree/nerdtree_plugin/exec_menuitem.vim \
 vim/bundle/nerdtree/nerdtree_plugin/fs_menu.vim \
 vim/bundle/nerdtree/plugin/NERD_tree.vim \
 vim/bundle/vim-fugitive/doc/fugitive.txt \
 vim/bundle/vim-fugitive/plugin/fugitive.vim \
 vim/bundle/vim-pathogen/autoload/pathogen.vim \
 vim/colors/zenburn.vim \
 vim/plugin/indentprefs.vim \
 vim/vimrc_normal.vim \
 vimrc \
 $(NULL)

# Custom install targets because automake does not support renaming on install
install-data-local: $(dotfiles)
	@$(NORMAL_INSTALL)
	@list='$(dotfiles)'; test -n "$(homedir)" || list=; \
	dir='$(DESTDIR)$(homedir)'; \
	if test -n "$$list"; then \
	  echo " $(MKDIR_P) '$$dir'"; \
	  $(MKDIR_P) "$$dir" || exit 1; \
	fi; \
	for f in $$list; do \
	  p=`echo ".$$f" | sed 's|/*[^/]*$$||'`; \
	  if test -n "$$p"; then \
	    echo " $(MKDIR_P) '$$dir/$$p'"; \
	    $(MKDIR_P) "$$dir/$$p" || exit 1; \
	  else \
	    p=".$$f"; \
	  fi; \
	  echo " $(INSTALL_DATA) '$$f' '$$dir/$$p'"; \
	  $(INSTALL_DATA) "$$f" "$$dir/$$p" || exit 1; \
	done

uninstall-local:
	@$(NORMAL_UNINSTALL)
	@list='$(dotfiles)'; test -n "$(homedir)" || list=; \
	dir='$(DESTDIR)$(homedir)'; \
	for f in $$list; do \
	  echo " rm -f '$$dir/.$$f'"; \
	  p=".$$f"; \
	  rm -f "$$dir/$$p"; \
	done