#	$Id: Makefile.in,v 1.7 2008-06-25 18:22:04 valerio Exp $
# -*- Mode: Makefile -*-

# niftimatlab System Makefile.
#
# Autoconf/Configure tag.
# Makefile.  Generated from Makefile.in by configure.

#==============================================================================
# (Semi) Standard (GNU form) variable setup.

# General Variables

SHELL = /bin/sh


# Installation Variables

prefix      = /usr/local
exec_prefix = ${prefix}

bindir      = /CBI/bin/matlab/cbi
libdir	    = /CBI/lib

# Targets.

FORCE:

all: FORCE
	cd nifticlib; $(MAKE) install
	cd src; $(MAKE) all
	@echo ''
	@echo "===================================================="
	@echo "System building: done."
	@echo ''

clean: 
	cd src; $(MAKE) -k clean
	cd nifticlib; $(MAKE) -k clean
	@echo ''
	@echo "===================================================="
	@echo "System cleaning: done."
	@echo ''

install: all
	/usr/bin/install -d $(bindir)/@niftifile/private 
	/usr/bin/install -d $(bindir)/@niftiheader/private
	/usr/bin/install matlab/@niftifile/*.m $(bindir)/@niftifile/
	/usr/bin/install matlab/@niftifile/private/*.mex* $(bindir)/@niftifile/private/
	/usr/bin/install matlab/@niftiheader/*.m $(bindir)/@niftiheader/
	/usr/bin/install matlab/@niftiheader/private/*.m $(bindir)/@niftiheader/private/
	/usr/bin/install nifticlib/lib/* $(libdir)/
	@echo ''
	@echo "===================================================="
	@echo "System install: done."
	@echo ''

# end of file -- Makefile --
