# =========================================================================
#     This makefile was generated by
#     Bakefile 0.2.2 (http://bakefile.sourceforge.net)
#     Do not modify, all changes will be overwritten!
# =========================================================================



# -------------------------------------------------------------------------
# These are configurable options:
# -------------------------------------------------------------------------

#  
AR := ar

#  
RANLIB := ranlib

# C++ compiler 
CXX := g++

# Type of compiled binaries [debug,release]
BUILD := debug

# Warning level for the Harbour Compiler [0,1,2,3]
HBWARNL := 3

# Exit severity level for the Harbour Compiler [0,1,2]
HBEXITS := 2

# Output type generated by the Harbour Compiler [c,o,w,h]
HBOUTTYP := o



# -------------------------------------------------------------------------
# Do not modify the rest of this file!
# -------------------------------------------------------------------------

### Variables: ###

CPPDEPS = -MT$@ -MF`echo $@ | sed -e 's,\.o$$,.d,'` -MD
HBFLAGS = -n -a -v -m -g$(HBOUTTYP) $(HBDEBUG) -w$(HBWARNL) -es$(HBEXITS) \
	-dHB_OS_LINUX
HBINCLUDES = -Iinclude -I/usr/include/harbour -I/usr/local/include \
	-I../../include
BUILDDIR = obj/unix/gcc
CPPFLAGS = -Iinclude -I/usr/include/harbour -I/usr/local/include
WXHARBOUR_CXXFLAGS = -W -Wall -O2 $(CPPFLAGS) -fno-strict-aliasing `wx-config \
	--cxxflags`
WXHARBOUR_OBJECTS =  \
	$(BUILDDIR)/wxharbour_wx_menu.o \
	$(BUILDDIR)/wxharbour_wx_toplevelwindow.o \
	$(BUILDDIR)/wxharbour_wx_boxsizer.o \
	$(BUILDDIR)/wxharbour_wx_notebook.o \
	$(BUILDDIR)/wxharbour_wx_statictext.o \
	$(BUILDDIR)/wxharbour_wx_window.o \
	$(BUILDDIR)/wxharbour_wx_functions.o \
	$(BUILDDIR)/wxharbour_wx_textctrl.o \
	$(BUILDDIR)/wxharbour_wx_app.o \
	$(BUILDDIR)/wxharbour_wx_statusbar.o \
	$(BUILDDIR)/wxharbour_wx_gridtablebase.o \
	$(BUILDDIR)/wxharbour_wx_dialog.o \
	$(BUILDDIR)/wxharbour_wx_frame.o \
	$(BUILDDIR)/wxharbour_wx_panel.o \
	$(BUILDDIR)/wxharbour_wx_harbour.o \
	$(BUILDDIR)/wxharbour_wx_menubar.o \
	$(BUILDDIR)/wxharbour_wx_evthandler.o \
	$(BUILDDIR)/wxharbour_wx_object.o \
	$(BUILDDIR)/wxharbour_wx_menuitem.o \
	$(BUILDDIR)/wxharbour_wx_validator.o \
	$(BUILDDIR)/wxharbour_wx_grid.o \
	$(BUILDDIR)/wxharbour_wx_sizer.o \
	$(BUILDDIR)/wxharbour_wx_button.o \
	$(BUILDDIR)/wxharbour_wx_browse.o \
	$(BUILDDIR)/wxharbour_wxhstatictext.o \
	$(BUILDDIR)/wxharbour_wxhframe.o \
	$(BUILDDIR)/wxharbour_wxhcontrol.o \
	$(BUILDDIR)/wxharbour_wxhstatusbar.o \
	$(BUILDDIR)/wxharbour_wxhpanel.o \
	$(BUILDDIR)/wxharbour_wxhmenuitem.o \
	$(BUILDDIR)/wxharbour_wxhwindow.o \
	$(BUILDDIR)/wxharbour_wxhvalidator.o \
	$(BUILDDIR)/wxharbour_wxhapp.o \
	$(BUILDDIR)/wxharbour_wxhnotebook.o \
	$(BUILDDIR)/wxharbour_wxhevthandler.o \
	$(BUILDDIR)/wxharbour_wxhmenu.o \
	$(BUILDDIR)/wxharbour_wxhgridtablebase.o \
	$(BUILDDIR)/wxharbour_wxhgrid.o \
	$(BUILDDIR)/wxharbour_wxhsizer.o \
	$(BUILDDIR)/wxharbour_wxhbrowse.o \
	$(BUILDDIR)/wxharbour_wxhdialog.o \
	$(BUILDDIR)/wxharbour_wxhmenubar.o \
	$(BUILDDIR)/wxharbour_wxhobject.o \
	$(BUILDDIR)/wxharbour_wxhcolumn.o \
	$(BUILDDIR)/wxharbour_wxhtoplevelwindow.o \
	$(BUILDDIR)/wxharbour_wxhtextctrl.o \
	$(BUILDDIR)/wxharbour_wxhbutton.o \
	$(BUILDDIR)/wxharbour_wxhboxsizer.o

### Conditionally set variables: ###

ifeq ($(BUILD),debug)
HBDEBUG = -b
endif


all: $(BUILDDIR)
$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

### Targets: ###

all: $(BUILDDIR)/libwxharbour.a

install: all

uninstall: 

clean: 
	rm -f $(BUILDDIR)/*.o
	rm -f $(BUILDDIR)/*.d
	rm -f $(BUILDDIR)/libwxharbour.a
	(cd samples && $(MAKE) clean)

$(BUILDDIR)/libwxharbour.a: $(WXHARBOUR_OBJECTS)
	rm -f $@
	$(AR) rcu $@ $(WXHARBOUR_OBJECTS)
	$(RANLIB) $@

samples: $(BUILDDIR)/libwxharbour.a
	(cd samples && $(MAKE) all)

$(BUILDDIR)/wxharbour_wx_menu.o: src/wx_menu.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_toplevelwindow.o: src/wx_toplevelwindow.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_boxsizer.o: src/wx_boxsizer.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_notebook.o: src/wx_notebook.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_statictext.o: src/wx_statictext.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_window.o: src/wx_window.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_functions.o: src/wx_functions.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_textctrl.o: src/wx_textctrl.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_app.o: src/wx_app.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_statusbar.o: src/wx_statusbar.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_gridtablebase.o: src/wx_gridtablebase.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_dialog.o: src/wx_dialog.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_frame.o: src/wx_frame.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_panel.o: src/wx_panel.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_harbour.o: src/wx_harbour.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_menubar.o: src/wx_menubar.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_evthandler.o: src/wx_evthandler.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_object.o: src/wx_object.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_menuitem.o: src/wx_menuitem.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_validator.o: src/wx_validator.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_grid.o: src/wx_grid.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_sizer.o: src/wx_sizer.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_button.o: src/wx_button.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wx_browse.o: src/wx_browse.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(BUILDDIR)/wxharbour_wxhstatictext.o: src/wxhstatictext.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhframe.o: src/wxhframe.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhcontrol.o: src/wxhcontrol.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhstatusbar.o: src/wxhstatusbar.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhpanel.o: src/wxhpanel.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhmenuitem.o: src/wxhmenuitem.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhwindow.o: src/wxhwindow.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhvalidator.o: src/wxhvalidator.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhapp.o: src/wxhapp.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhnotebook.o: src/wxhnotebook.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhevthandler.o: src/wxhevthandler.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhmenu.o: src/wxhmenu.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhgridtablebase.o: src/wxhgridtablebase.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhgrid.o: src/wxhgrid.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhsizer.o: src/wxhsizer.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhbrowse.o: src/wxhbrowse.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhdialog.o: src/wxhdialog.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhmenubar.o: src/wxhmenubar.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhobject.o: src/wxhobject.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhcolumn.o: src/wxhcolumn.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhtoplevelwindow.o: src/wxhtoplevelwindow.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhtextctrl.o: src/wxhtextctrl.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhbutton.o: src/wxhbutton.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

$(BUILDDIR)/wxharbour_wxhboxsizer.o: src/wxhboxsizer.prg
	harbour $(HBFLAGS) $(HBINCLUDES) -o$@ $<

.PHONY: all install uninstall clean samples


# Dependencies tracking:
-include $(BUILDDIR)/*.d
