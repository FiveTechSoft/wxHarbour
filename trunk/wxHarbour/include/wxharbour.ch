/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wxHarbour.ch
  Teo. Mexico 2006
*/

#ifndef _WXHARBOUR_H_
#define _WXHARBOUR_H_

#include "hbclass.ch"
#include "property.ch"
#include "raddox.ch"
#include "wx.ch"

/*!
 * Build var-codeblock
 */
#xtranslate _WXGET_( <xVar> ) => WXGET( <"xVar"> , <xVar>, {|_xValue| iif( PCount() > 0 , <xVar> := _xValue , <xVar> ) } )

#xcommand CREATE [<type: MDIPARENT,MDICHILD>] FRAME <oFrame> ;
          [ CLASS <fromClass> ] ;
          [ PARENT <oParent> ] ;
          [ ID <nID> ] ;
          [ TITLE <cTitle> ] ;
          [ FROM <nTop>, <nLeft> ] [ SIZE <nHeight>, <nWidth> ] ;
          [ STYLE <nStyle> ] ;
          [ NAME <cName> ] ;
          => ;
          <oFrame> := wx_Frame( [<"type">], [<fromClass>], [<oParent>], [<nID>], <cTitle>, {<nTop>,<nLeft>}, {<nHeight>,<nWidth>}, [<nStyle>], [<cName>] )

#xcommand CREATE DIALOG <oDlg> ;
          [ CLASS <fromClass> ] ;
          [ PARENT <oParent> ] ;
          [ ID <nID> ] ;
          [ TITLE <cTitle> ] ;
          [ FROM <nTop>, <nLeft> ] [ SIZE <nHeight>, <nWidth> ] ;
          [ STYLE <nStyle> ] ;
          [ NAME <cName> ] ;
          => ;
          <oDlg> := wx_Dialog( [<fromClass>], [<oParent>], [<nID>], <cTitle>, {<nTop>,<nLeft>}, {<nHeight>,<nWidth>}, [<nStyle>], [<cName>] )

#xcommand FIT WINDOW <oWnd> ;
          => ;
          iif( <oWnd>:GetSizer() != NIL, <oWnd>:GetSizer():SetSizeHints( <oWnd> ), NIL )

#xcommand CENTRE WINDOW <oWnd> ;
          => ;
          <oWnd>:Centre()

#xcommand SHOW WINDOW <oWnd> [<modal: MODAL>] [<fit: FIT>] [TO <var>] [<centre: CENTRE>];
          => ;
          [<var> := ] wxh_ShowWindow( <oWnd>, <.modal.>, <.fit.>, <.centre.> )

/*
  StatusBar
*/
#xcommand CREATE STATUSBAR [<oSB>] ;
          [ ID <nID> ] ;
          [ STYLE <nStyle> ] ;
          [ NAME <cName> ] ;
          [ FIELDS <nFields> ] ;
          [ WIDTHS <aWidths,...> ] ;
          [ ON <oFrame> ] ;
          => ;
          [<oSB> := ] wxh_DefineStatusBar( [<oFrame>], [<nID>], [<nStyle>], [<cName>], [<nFields>], [{<aWidths>}] ) ;;

#xcommand DEFINE MENUBAR [<oMB>] [STYLE <nStyle>] [ON <oWindow>] ;
          => ;
          [<oMB> := ] wxh_DefineMenuBar( [<oWindow>], [<nStyle>] )

#xcommand DEFINE MENU <cLabel> ;
          => ;
          wxh_DefineMenu( <cLabel> )

#xcommand ADD MENUITEM <cLabel> ;
              [ID <nID>] ;
              [HELPLINE <cHelpString>] ;
              [<kind: CHECK,RADIO>] ;
              [ACTION <bAction> ] ;
              [ENABLED <bEnabled> ] ;
          => ;
          wxh_AddMenuItem( <cLabel>, [<nID>], [<cHelpString>], [wxITEM_<kind>], [<{bAction}>], [<{bEnabled}>] )

#xcommand ADD MENUSEPARATOR ;
          => ;
          wxh_AddMenuItem( NIL, wxID_SEPARATOR )

#xcommand ENDMENU ;
          => ;
          wxh_EndMenu()

#xcommand ENDMENUBAR ;
          => ;
          wxh_EndMenuBar()

/*
 * Button
 * Teo. Mexico 2006
 */

#define wxALIGN_EXPAND  wxGROW
#define wxSTRECH        1

#xcommand @ BUTTON [<label>] ;
            [ VAR <btn> ] ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style> ] ;
            [ VALIDATOR <validator> ] ;
            [ NAME <name> ] ;
            [ <strech: STRECH> ] ;
            [ ALIGN <align: TOP, LEFT, BOTTOM, RIGHT, CENTRE, CENTRE_HORIZONTAL, CENTRE_VERTICAL, CENTER, CENTER_HORIZONTAL, CENTER_VERTICAL, EXPAND> ] ;
            [ BORDER <border> ] ;
            [ SIDEBORDERS <sideborders,...> ] ;
            [ ACTION <bAction> ] ;
          => ;
          wxh_SizerAdd( NIL,;
            [<btn>:=]wxh_Button( ;
              [<window>],;
              [<id>],;
              [<label>],;
              ,;
              [{<nWidth>,<nHeight>}],;
              [<style>],;
              [<validator>],;
              [<name>],;
              [<{bAction}>];
            ),;
            [ wx<strech> ],;
            [ wxALIGN_<align> ],;
            [ <border> ],;
            [ HB_BITOR(0,<sideborders>) ] ;
          )

/*
  Panel
*/
#xcommand @ PANEL ;
            [ VAR <panel> ] ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style> ] ;
            [ NAME <name> ] ;
            [ <strech: STRECH> ] ;
            [ ALIGN <align: TOP, LEFT, BOTTOM, RIGHT, CENTRE, CENTRE_HORIZONTAL, CENTRE_VERTICAL, CENTER, CENTER_HORIZONTAL, CENTER_VERTICAL, EXPAND> ] ;
            [ BORDER <border> ] ;
            [ SIDEBORDERS <sideborders,...> ] ;
          => ;
          wxh_SizerAdd( NIL,;
            [<panel>:=]wxh_Panel( ;
              [<window>],;
              [<id>],;
              ,;
              [{<nWidth>,<nHeight>}],;
              [<style>],;
              [<name>] ;
            ),;
            [ wx<strech> ],;
            [ wxALIGN_<align> ],;
            [ <border> ],;
            [ HB_BITOR(0,<sideborders>) ] ;
          )

/*
 * SAY ... GET
 */
#xcommand @ SAY <label> ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style: LEFT, RIGHT, CENTRE, CENTER> ] ;
            [ NAME <name> ] ;
            [ <strech: STRECH> ] ;
            [ ALIGN <align: TOP, LEFT, BOTTOM, RIGHT, CENTRE, CENTRE_HORIZONTAL, CENTRE_VERTICAL, CENTER, CENTER_HORIZONTAL, CENTER_VERTICAL, EXPAND> ] ;
            [ BORDER <border> ] ;
            [ SIDEBORDERS <sideborders,...> ] ;
          => ;
          wxh_SizerAdd( NIL,;
            wxh_Say( ;
              [<window>],;
              [<id>],;
              <label>,;
              ,;
              [{<nWidth>,<nHeight>}],;
              [wxALIGN_<style>],;
              [<name>];
            ),;
            [ wx<strech> ],;
            [wxALIGN_<align>],;
            [<border>],;
            [ HB_BITOR(0,<sideborders>) ] ;
          )

#xcommand @ GET <var> ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ VALUE <value> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style> ] ;
            [ VALIDATOR <validator> ] ;
            [ NAME <name> ] ;
            [ <strech: STRECH> ] ;
            [ ALIGN <align: TOP, LEFT, BOTTOM, RIGHT, CENTRE, CENTRE_HORIZONTAL, CENTRE_VERTICAL, CENTER, CENTER_HORIZONTAL, CENTER_VERTICAL, EXPAND> ] ;
            [ BORDER <border> ] ;
            [ SIDEBORDERS <sideborders,...> ] ;
            [ PICTURE <picture> ] ;
            [ WARNING [<warnMsg>] WHEN <warnWhen> ] ;
            [ HELP <help> ] ;
            [ HELPLINE <hlpLine> ] ;
            [ <refresh: REFRESH ALL> ] ;
          => ;
          wxh_SizerAdd( NIL,;
            wxh_Get(;
              [@<var>],;
              [<window>],;
              [<id>],;
              [<value>],;
              ,;
              [{<nWidth>,<nHeight>}],;
              [<style>],;
              [<validator>],;
              [<name>],;
              [<picture>],;
              [{<{warnWhen}>,<warnMsg>}],;
              [<{help}>],;
              [<{hlpLine}>],;
              [<.refresh.>] ;
            ),;
            [ wx<strech> ],;
            [ wxALIGN_<align> ],;
            [ <border> ],;
            [ HB_BITOR(0,<sideborders>) ] ;
          )

#xcommand @ SAY [<sayclauses,...>] GET [<getclauses,...>] ;
          => ;
          BEGIN BOXSIZER HORIZONTAL ALIGN EXPAND ;;
          @ SAY [<sayclauses>] ;;
          @ GET [<getclauses>] STRECH ;;
          END SIZER

#xcommand @ SAY ABOVE [<sayclauses,...>] GET [<getclauses,...>] ;
          => ;
          BEGIN BOXSIZER VERTICAL ALIGN EXPAND ;;
          @ SAY [<sayclauses>] ;;
          @ GET [<getclauses>] STRECH ;;
          END SIZER

/*
  WXBROWSEDB
*/
#xcommand @ WXBROWSEDB [ [VAR] <wxBrw> ] ;
            [ TABLE <table> ] ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style> ] ;
            [ VALIDATOR <validator> ] ;
            [ NAME <name> ] ;
            [ <strech: STRECH> ] ;
            [ ALIGN <align: TOP, LEFT, BOTTOM, RIGHT, CENTRE, CENTRE_HORIZONTAL, CENTRE_VERTICAL, CENTER, CENTER_HORIZONTAL, CENTER_VERTICAL, EXPAND> ] ;
            [ BORDER <border> ] ;
            [ SIDEBORDERS <sideborders,...> ] ;
          => ;
          wxh_SizerAdd( NIL,;
            [<wxBrw>:=]wxh_BrowseDb( ;
              [<table>],;
              [<window>],;
              [<id>],;
              ,;
              [{<nWidth>,<nHeight>}],;
              [<style>],;
              [<name>] ;
            ),;
            [ wx<strech> ],;
            [ wxALIGN_<align> ],;
            [ <border> ],;
            [ HB_BITOR(0,<sideborders>) ] ;
          )

/*
  WXBCOLUMN
*/
#xcommand WXCOLUMN [<zero: ZERO>] <wxBrw> [ [TITLE] <title>] BLOCK <block> [PICTURE <picture>] [WIDTH <width>];
          => ;
          wxh_Column( <.zero.>, <wxBrw>, <title>, {|o| <block> }, [<picture>], [<width>] )

/*
 * SIZERS
 *
 * TODO: On ALIGN CENTER we need to create a wxALIGN_CENTER_[HORIZONTAL|VERTICAL]
 *       in sync with the parent sizer, currently we do just wxALIGN_CENTER
 *
 */
#xcommand BEGIN BOXSIZER <orient: VERTICAL, HORIZONTAL> ;
          [ [LABEL] <label> ] ;
          [ <strech: STRECH> ] ;
          [ ALIGN <align: TOP, LEFT, BOTTOM, RIGHT, CENTRE, CENTRE_HORIZONTAL, CENTRE_VERTICAL, CENTER, CENTER_HORIZONTAL, CENTER_VERTICAL, EXPAND> ] ;
          [ BORDER <border> ] ;
          [ SIDEBORDERS <sideborders,...> ] ;
          => ;
          wxh_BeginBoxSizer( ;
            [wxStaticBox():New( ;
              wxh_LastTopLevelWindow(),;
              wxID_ANY,;
              <label> ;
            )],;
            wx<orient>,;
            [ wx<strech> ],;
            [ wxALIGN_<align> ],;
            [ <border> ],;
            [ HB_BITOR(0,<sideborders>) ] ;
          )

#xcommand BEGIN GRIDSIZER [ROWS <rows>] [COLS <cols>] [VGAP <vgap>] [HGAP <hgap>] ;
          [ <strech: STRECH> ] ;
          [ ALIGN <align: TOP, LEFT, BOTTOM, RIGHT, CENTRE, CENTRE_HORIZONTAL, CENTRE_VERTICAL, CENTER, CENTER_HORIZONTAL, CENTER_VERTICAL, EXPAND> ] ;
          [ BORDER <border> ] ;
          [ SIDEBORDERS <sideborders,...> ] ;
          => ;
          wxh_BeginGridSizer( ;
            [ <rows> ],;
            [ <cols> ],;
            [ <vgap> ],;
            [ <hgap> ],;
            [ wx<strech> ],;
            [ wxALIGN_<align> ],;
            [ <border> ],;
            [ HB_BITOR(0,<sideborders>) ] ;
          )

#xcommand END SIZER ;
          => ;
          wxh_EndSizer()


#xcommand @ SPACER ;
          [ WIDTH <width> ] ;
          [ HEIGHT <height> ] ;
          [ <strech: STRECH> ] ;
          [ FLAG <flag> ] ;
          [ BORDER <border> ] ;
          => ;
          wxh_Spacer( ;
            [<width>],;
            [<height>],;
            [ wx<strech> ],;
            [<flag>],;
            [<border>] ;
          )

#endif
