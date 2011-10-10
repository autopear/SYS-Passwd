# Makefile for gcc compiler for iPhone

PROJECTNAME="SYS Passwd"
APPFOLDER=$(PROJECTNAME).app
INSTALLFOLDER=$(PROJECTNAME).app

CC=arm-apple-darwin9-gcc
LD=$(CC)
LDFLAGS = -fno-exceptions -arch arm  -Os -Wall -Werror -pipe
LDFLAGS += -lobjc -bind_at_load
LDFLAGS += -multiply_defined suppress
LDFLAGS += -framework CoreFoundation 
LDFLAGS += -framework CoreGraphics 
LDFLAGS += -framework Foundation 
LDFLAGS += -framework UIKit 

CFLAGS =  -Os -Wall -NDEBUG -pipe 
CFLAGS += -DMAC_OS_X_VERSION_MAX_ALLOWED=1050
#CFLAGS += -I"./passwd"

#SRCDIR1=./passwd
#OBJS=$(patsubst %.c,%.o,$(wildcard $(SRCDIR1)/*.c))

#SRCDIR=./Classes
#OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/*.m))

all:	dist

$(PROJECTNAME)_:	$(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o:	%.m
	$(CC) -c $(CFLAGS) $< -o $@
%.o:	%.c
	$(CC) -c $(CFLAGS) $< -o $@

dist:	$(PROJECTNAME)_
	arm-apple-darwin9-strip -SXx $(PROJECTNAME)_
clean:
	@rm -f $(SRCDIR)/*.o
	@rm -rf $(BUILDDIR)
	@rm -f $(PROJECTNAME)_

