CC=gcc
CFLAGS=-Wall -Wextra -pedantic -std=c99
LIBS=
OBJS=
DEPS=
bindir=/usr/local/bin
PROJECT=
VERSION=v0.0.1

$(PROJECT): $(OBJS)
  $(cc) -o $(PROJECT)-$(VERSION) $(OBJS) $(LIBS)
  rm -f $(OBJS)

$(PROJECT).o: $(DEPS)

clean:
  rm $(PROJECT)

install: $(PROJECT)
  install -g root -o root $(PROJECT) $(bindir)/$(PROJECT)

uninstall: $(bindir)/$(PROJECT)
  rm -f $(bindir)/$(PROJECT)



