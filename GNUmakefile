# =========================================================================
#     This makefile was generated by
#     Bakefile 0.2.3 (http://www.bakefile.org)
#     Do not modify, all changes will be overwritten!
# =========================================================================



# -------------------------------------------------------------------------
# These are configurable options:
# -------------------------------------------------------------------------

# 'install' program location 
INSTALL := install

# Location where the package is installed by 'make install' 
prefix := /usr/local

# Destination root (/ is used if empty) 
DESTDIR := 

#  
AR := ar

#  
RANLIB := ranlib

# C++ compiler 
CXX := g++

# Standard preprocessor flags (common for CC and CXX) 
CPPFLAGS := 

# Standard flags for Harbour compiler 
HBFLAGS := -n -a -v -m -go

# [x]Harbour compiler 
HCC := harbour

# ---------------------------------------------------------------
# Harbour compiler flags
# ---------------------------------------------------------------
# 
# Type of Harbour compiled binaries [debug,release]
BUILD := release

# Warning level for the Harbour Compiler [0,1,2,3]
HBWARNL := 3

# Exit severity level for the Harbour Compiler [0,1,2]
HBEXITSL := 2

# Where to search for Harbour Includes 
HB_INC_PATH := /usr/include/harbour

# Where the object and lib files are built 
__BUILDDIR__ := obj/gcc-unix

#  [ansi,unicode]
WX_ENCODING := unicode

#  [release,debug]
WX_BUILD := release



# -------------------------------------------------------------------------
# Do not modify the rest of this file!
# -------------------------------------------------------------------------

### Variables: ###

CPPDEPS = -MT$@ -MF`echo $@ | sed -e 's,\.o$$,.d,'` -MD
WXHARBOUR_CXXFLAGS = -Iinclude -I$(HB_INC_PATH) -I$(prefix)/include -W -Wall -O2 \
	$(__D_WX_UNICODE_p) $(__D_WX_DEBUG_p) $(__WX_DEBUG_INFO_2) -Iinclude \
	$(CPPFLAGS) -fno-strict-aliasing `wx-config --cxxflags`
WXHARBOUR_OBJECTS =  \
	$(__BUILDDIR__)/wxharbour_wxhfuncs.o \
	$(__BUILDDIR__)/wxharbour_wxhcolumn.o \
	$(__BUILDDIR__)/wxharbour_wxhbrowse.o \
	$(__BUILDDIR__)/wxharbour_wxhapp.o \
	$(__BUILDDIR__)/wxharbour_wxhtoplevelwindow.o \
	$(__BUILDDIR__)/wxharbour_wxhwindow.o \
	$(__BUILDDIR__)/wxharbour_wxhdialog.o \
	$(__BUILDDIR__)/wxharbour_wxhbutton.o \
	$(__BUILDDIR__)/wxharbour_wxhcontrol.o \
	$(__BUILDDIR__)/wxharbour_wxhstaticbox.o \
	$(__BUILDDIR__)/wxharbour_wxhstatictext.o \
	$(__BUILDDIR__)/wxharbour_wxhtextctrl.o \
	$(__BUILDDIR__)/wxharbour_wxhevthandler.o \
	$(__BUILDDIR__)/wxharbour_wxhframe.o \
	$(__BUILDDIR__)/wxharbour_wxhmenu.o \
	$(__BUILDDIR__)/wxharbour_wxhmenubar.o \
	$(__BUILDDIR__)/wxharbour_wxhmenuitem.o \
	$(__BUILDDIR__)/wxharbour_wxhgrid.o \
	$(__BUILDDIR__)/wxharbour_wxhgridtablebase.o \
	$(__BUILDDIR__)/wxharbour_wxhnotebook.o \
	$(__BUILDDIR__)/wxharbour_wxhpanel.o \
	$(__BUILDDIR__)/wxharbour_wxhstatusbar.o \
	$(__BUILDDIR__)/wxharbour_wxhipv4address.o \
	$(__BUILDDIR__)/wxharbour_wxhsocketbase.o \
	$(__BUILDDIR__)/wxharbour_wxhsocketclient.o \
	$(__BUILDDIR__)/wxharbour_wxhsocketserver.o \
	$(__BUILDDIR__)/wxharbour_wxhobject.o \
	$(__BUILDDIR__)/wxharbour_wxhvalidator.o \
	$(__BUILDDIR__)/wxharbour_wxhboxsizer.o \
	$(__BUILDDIR__)/wxharbour_wxhgridsizer.o \
	$(__BUILDDIR__)/wxharbour_wxhsizer.o \
	$(__BUILDDIR__)/wxharbour_wxhstaticboxsizer.o \
	$(__BUILDDIR__)/wxharbour_wxhxmldocument.o \
	$(__BUILDDIR__)/wxharbour_wx_harbour.o \
	$(__BUILDDIR__)/wxharbour_wx_browse.o \
	$(__BUILDDIR__)/wxharbour_wx_app.o \
	$(__BUILDDIR__)/wxharbour_wx_panel.o \
	$(__BUILDDIR__)/wxharbour_wx_toplevelwindow.o \
	$(__BUILDDIR__)/wxharbour_wx_window.o \
	$(__BUILDDIR__)/wxharbour_wx_dialog.o \
	$(__BUILDDIR__)/wxharbour_wx_button.o \
	$(__BUILDDIR__)/wxharbour_wx_staticbox.o \
	$(__BUILDDIR__)/wxharbour_wx_statictext.o \
	$(__BUILDDIR__)/wxharbour_wx_textctrl.o \
	$(__BUILDDIR__)/wxharbour_wx_evthandler.o \
	$(__BUILDDIR__)/wxharbour_wx_frame.o \
	$(__BUILDDIR__)/wxharbour_wx_menu.o \
	$(__BUILDDIR__)/wxharbour_wx_menubar.o \
	$(__BUILDDIR__)/wxharbour_wx_menuitem.o \
	$(__BUILDDIR__)/wxharbour_wx_grid.o \
	$(__BUILDDIR__)/wxharbour_wx_gridtablebase.o \
	$(__BUILDDIR__)/wxharbour_wx_notebook.o \
	$(__BUILDDIR__)/wxharbour_wx_statusbar.o \
	$(__BUILDDIR__)/wxharbour_wx_ipv4address.o \
	$(__BUILDDIR__)/wxharbour_wx_socketbase.o \
	$(__BUILDDIR__)/wxharbour_wx_socketclient.o \
	$(__BUILDDIR__)/wxharbour_wx_socketserver.o \
	$(__BUILDDIR__)/wxharbour_wx_object.o \
	$(__BUILDDIR__)/wxharbour_wx_validator.o \
	$(__BUILDDIR__)/wxharbour_wx_boxsizer.o \
	$(__BUILDDIR__)/wxharbour_wx_gridsizer.o \
	$(__BUILDDIR__)/wxharbour_wx_sizer.o \
	$(__BUILDDIR__)/wxharbour_wx_staticboxsizer.o \
	$(__BUILDDIR__)/wxharbour_wx_xmldocument.o
WXHARBOUR_HBFLAGS = $(HBFLAGS) -w$(HBWARNL) -es$(HBEXITSL) $(__HBDEBUG__) \
	-dHB_OS_LINUX -Iinclude -I$(HB_INC_PATH) -I$(prefix)/include \
	$(__D_WX_UNICODE_p) $(__D_WX_DEBUG_p) -Iinclude

### Conditionally set variables: ###

ifeq ($(BUILD),debug)
__HBDEBUG__ = -b -d_DEBUG_
endif
ifeq ($(WX_BUILD),release)
ifeq ($(WX_ENCODING),ansi)
WXHLIBNAME = wxHarbour
endif
endif
ifeq ($(WX_BUILD),debug)
ifeq ($(WX_ENCODING),ansi)
WXHLIBNAME = wxHarbour-$(WX_BUILD)
endif
endif
ifeq ($(WX_BUILD),release)
ifeq ($(WX_ENCODING),unicode)
WXHLIBNAME = wxHarbour-$(WX_ENCODING)
endif
endif
ifeq ($(WX_BUILD),debug)
ifeq ($(WX_ENCODING),unicode)
WXHLIBNAME = wxHarbour-$(WX_ENCODING)-$(WX_BUILD)
endif
endif
ifeq ($(WX_BUILD),debug)
__WX_DEBUG_INFO_2 = -g
endif
ifeq ($(WX_ENCODING),unicode)
__D_WX_UNICODE_p = -D_UNICODE
endif
ifeq ($(WX_BUILD),debug)
__D_WX_DEBUG_p = -D__WXDEBUG__
endif


all: $(__BUILDDIR__)
$(__BUILDDIR__):
	@mkdir -p $(__BUILDDIR__)

### Targets: ###

all: $(__BUILDDIR__)/lib$(WXHLIBNAME).a

install: all install_wxharbour

uninstall: uninstall_wxharbour

clean: 
	rm -f $(__BUILDDIR__)/*.o
	rm -f $(__BUILDDIR__)/*.d
	rm -f $(__BUILDDIR__)/lib$(WXHLIBNAME).a
	-(cd samples && $(MAKE) clean)

$(__BUILDDIR__)/lib$(WXHLIBNAME).a: $(WXHARBOUR_OBJECTS)
	rm -f $@
	$(AR) rcu $@ $(WXHARBOUR_OBJECTS)
	$(RANLIB) $@

install_wxharbour: 
	$(INSTALL) -d $(DESTDIR)$(prefix)/lib
	$(INSTALL) -m 644 $(__BUILDDIR__)/lib$(WXHLIBNAME).a $(DESTDIR)$(prefix)/lib

uninstall_wxharbour: 
	rm -f $(DESTDIR)$(prefix)/lib/lib$(WXHLIBNAME).a

samples: $(__BUILDDIR__)/lib$(WXHLIBNAME).a
	(cd samples && $(MAKE) all)

$(__BUILDDIR__)/wxharbour_wxhfuncs.o: ./src/common/wxhfuncs.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhcolumn.o: ./src/hrbcompat/tbcolumn/wxhcolumn.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhbrowse.o: ./src/hrbcompat/tbrowse/wxhbrowse.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhapp.o: ./src/wxbase/app/wxhapp.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhtoplevelwindow.o: ./src/wxbase/basicwindows/wxhtoplevelwindow.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhwindow.o: ./src/wxbase/basicwindows/wxhwindow.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhdialog.o: ./src/wxbase/commdialogs/wxhdialog.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhbutton.o: ./src/wxbase/controls/wxhbutton.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhcontrol.o: ./src/wxbase/controls/wxhcontrol.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhstaticbox.o: ./src/wxbase/controls/wxhstaticbox.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhstatictext.o: ./src/wxbase/controls/wxhstatictext.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhtextctrl.o: ./src/wxbase/controls/wxhtextctrl.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhevthandler.o: ./src/wxbase/events/wxhevthandler.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhframe.o: ./src/wxbase/manwindows/wxhframe.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhmenu.o: ./src/wxbase/menus/wxhmenu.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhmenubar.o: ./src/wxbase/menus/wxhmenubar.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhmenuitem.o: ./src/wxbase/menus/wxhmenuitem.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhgrid.o: ./src/wxbase/miscwindows/wxhgrid.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhgridtablebase.o: ./src/wxbase/miscwindows/wxhgridtablebase.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhnotebook.o: ./src/wxbase/miscwindows/wxhnotebook.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhpanel.o: ./src/wxbase/miscwindows/wxhpanel.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhstatusbar.o: ./src/wxbase/miscwindows/wxhstatusbar.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhipv4address.o: ./src/wxbase/networking/wxhipv4address.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhsocketbase.o: ./src/wxbase/networking/wxhsocketbase.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhsocketclient.o: ./src/wxbase/networking/wxhsocketclient.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhsocketserver.o: ./src/wxbase/networking/wxhsocketserver.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhobject.o: ./src/wxbase/rtti/wxhobject.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhvalidator.o: ./src/wxbase/validators/wxhvalidator.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhboxsizer.o: ./src/wxbase/winlayout/wxhboxsizer.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhgridsizer.o: ./src/wxbase/winlayout/wxhgridsizer.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhsizer.o: ./src/wxbase/winlayout/wxhsizer.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhstaticboxsizer.o: ./src/wxbase/winlayout/wxhstaticboxsizer.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wxhxmldocument.o: ./src/wxbase/xmlclasses/wxhxmldocument.prg
	$(HCC) $(WXHARBOUR_HBFLAGS) -o$@ $<

$(__BUILDDIR__)/wxharbour_wx_harbour.o: ./src/common/wx_harbour.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_browse.o: ./src/hrbcompat/tbrowse/wx_browse.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_app.o: ./src/wxbase/app/wx_app.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_panel.o: ./src/wxbase/basicwindows/wx_panel.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_toplevelwindow.o: ./src/wxbase/basicwindows/wx_toplevelwindow.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_window.o: ./src/wxbase/basicwindows/wx_window.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_dialog.o: ./src/wxbase/commdialogs/wx_dialog.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_button.o: ./src/wxbase/controls/wx_button.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_staticbox.o: ./src/wxbase/controls/wx_staticbox.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_statictext.o: ./src/wxbase/controls/wx_statictext.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_textctrl.o: ./src/wxbase/controls/wx_textctrl.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_evthandler.o: ./src/wxbase/events/wx_evthandler.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_frame.o: ./src/wxbase/manwindows/wx_frame.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_menu.o: ./src/wxbase/menus/wx_menu.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_menubar.o: ./src/wxbase/menus/wx_menubar.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_menuitem.o: ./src/wxbase/menus/wx_menuitem.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_grid.o: ./src/wxbase/miscwindows/wx_grid.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_gridtablebase.o: ./src/wxbase/miscwindows/wx_gridtablebase.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_notebook.o: ./src/wxbase/miscwindows/wx_notebook.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_statusbar.o: ./src/wxbase/miscwindows/wx_statusbar.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_ipv4address.o: ./src/wxbase/networking/wx_ipv4address.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_socketbase.o: ./src/wxbase/networking/wx_socketbase.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_socketclient.o: ./src/wxbase/networking/wx_socketclient.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_socketserver.o: ./src/wxbase/networking/wx_socketserver.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_object.o: ./src/wxbase/rtti/wx_object.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_validator.o: ./src/wxbase/validators/wx_validator.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_boxsizer.o: ./src/wxbase/winlayout/wx_boxsizer.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_gridsizer.o: ./src/wxbase/winlayout/wx_gridsizer.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_sizer.o: ./src/wxbase/winlayout/wx_sizer.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_staticboxsizer.o: ./src/wxbase/winlayout/wx_staticboxsizer.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

$(__BUILDDIR__)/wxharbour_wx_xmldocument.o: ./src/wxbase/xmlclasses/wx_xmldocument.cpp
	$(CXX) -c -o $@ $(WXHARBOUR_CXXFLAGS) $(CPPDEPS) $<

.PHONY: all install uninstall clean install_wxharbour uninstall_wxharbour samples


# Dependencies tracking:
-include $(__BUILDDIR__)/*.d
