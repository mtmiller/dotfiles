NULL =
homedir = $(prefix)
dotfiles = \
 Xresources \
 bash_completion \
 bash_logout \
 bash_profile \
 bashrc \
 bazaar/bazaar.conf \
 bazaar/ignore \
 caff/gnupghome/gpg.conf \
 colordiffrc \
 config/git/ignore \
 cshrc \
 cvsignore \
 cvsrc \
 devscripts \
 dircolors \
 emacs \
 gbp.conf \
 gdbinit \
 gitconfig \
 hgignore \
 hgrc \
 inputrc \
 ipython/ipy_user_conf.py \
 ipython/ipythonrc \
 ipython/profile_default/ipython_config.py \
 irbrc \
 lintianrc \
 mk-sbuild.rc \
 octaverc \
 profile \
 quiltrc \
 quiltrc-dpkg \
 re.pl/repl.rc \
 sbuildrc \
 shrc \
 ssh/config \
 tcsh_editing \
 teclarc \
 tmux.conf \
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

.PHONY: compare
TMPINST = $(CURDIR)/tmp
compare:
	@$(MAKE) $(AM_MAKEFLAGS) DESTDIR='$(TMPINST)' install > /dev/null
	@for f in `cd $(TMPINST)$(homedir) && find . -type f -print`; do \
	  f=`echo $$f | sed 's/^\.\///'`; \
	  diff=`diff -u "$(TMPINST)$(homedir)/$$f" "$(homedir)/$$f" 2>/dev/null`; \
	  if test -n "$$diff"; then \
	    echo "diff -Naur $(TMPINST)$(homedir)/$$f $(homedir)/$$f"; \
	    echo "$$diff"; \
	  fi \
	done
	@rm -rf '$(TMPINST)'
