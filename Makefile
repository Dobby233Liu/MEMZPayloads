CC = gcc
PYTHON = python2

CCFLAGS = -nostdlib -nodefaultlibs -std=c99 -Wl,-e_start -s -mwindows -m32 -municode -Os -w -march=i486
LIBS    = -luser32 -lkernel32 -lgdi32 -lwinmm -lcomctl32 -ladvapi32 -lshell32 -lpsapi

# Don't change the build directory, it is hardcoded on other places
BUILDDIR = Build

CFILES = $(shell find Source -name '*.c' -type f)
HFILES = $(shell find Source -name '*.h' -type f)

DATA = $(wildcard Data/*)

FNAMES := 0 1 2 3 4 5 6 7 8 9 10

all: dir destructive-exe

dir: $(BUILDDIR)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)
	
$(BUILDDIR)/Data.c $(BUILDDIR)/Data.h: $(DATA)
	$(PYTHON) Data/genData.py $(BUILDDIR)/Data.c $(BUILDDIR)/Data.h

destructive-exe: dir $(CFILES) $(HFILES) $(BUILDDIR)/Data.c $(BUILDDIR)/Data.h
	echo "#define DESTRUCTIVE" > $(BUILDDIR)/Mode.h
	# $(CC) $(CCFLAGS) $(CFILES) $(BUILDDIR)/Data.c $(LIBS) -o $@ -DPLNUM=0
	for name in `echo $(FNAMES)`; \
	do \
		$(CC) $(CCFLAGS) $(CFILES) $(BUILDDIR)/Data.c $(LIBS) -o MEMZPayloads-$$name.exe -DPL2=$$name \
	done
	
clean:
	rm -r $(BUILDDIR)

.PHONY: clean all dir destructive-exe