CC = gcc
PYTHON = python2

CCFLAGS = -nostdlib -nodefaultlibs -std=c99 -Wl,-e_start -s -mwindows -m32 -municode -Os -w -march=i486
LIBS    = -luser32 -lkernel32 -lgdi32 -lwinmm -lcomctl32 -ladvapi32 -lshell32 -lpsapi

# Don't change the build directory, it is hardcoded on other places
BUILDDIR = Build

CFILES = $(shell find Source -name '*.c' -type f)
HFILES = $(shell find Source -name '*.h' -type f)

DATA = $(wildcard Data/*)


all: dir $(BUILDDIR)/MEMZ-Destructive.exe

dir: $(BUILDDIR)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)
	
$(BUILDDIR)/Data.c $(BUILDDIR)/Data.h: $(DATA)
	$(PYTHON) Data/genData.py $(BUILDDIR)/Data.c $(BUILDDIR)/Data.h

$(BUILDDIR)/MEMZ-Destructive.exe: $(CFILES) $(HFILES) $(BUILDDIR)/Data.c $(BUILDDIR)/Data.h
	echo "#define DESTRUCTIVE" > $(BUILDDIR)/Mode.h
	$(CC) $(CCFLAGS) $(CFILES) $(BUILDDIR)/Data.c $(LIBS) -o $@
	
clean:
	rm -r $(BUILDDIR)

destructive-exe: dir $(BUILDDIR)/MEMZ-Destructive.exe

.PHONY: clean all dir destructive-exe