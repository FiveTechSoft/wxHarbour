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

#xcommand CREATE FRAME <oFrame> ;
          [ PARENT <oParent> ] ;
          [ ID <nID> ] ;
          [ TITLE <cTitle> ] ;
          [ FROM <nTop>, <nLeft> SIZE <nHeight>, <nWidth> ] ;
          [ STYLE <nStyle> ] ;
          [ NAME <cName> ] ;
          => ;
          <oFrame> := wxFrame():New( [<oParent>], [<nID>], <cTitle>, {<nTop>,<nLeft>}, {<nHeight>,<nWidth>}, [<nStyle>], [<cName>] )

#xcommand CREATE DIALOG <oDlg> ;
          [ PARENT <oParent> ] ;
          [ ID <nID> ] ;
          [ TITLE <cTitle> ] ;
          [ FROM <nTop>, <nLeft> SIZE <nHeight>, <nWidth> ] ;
          [ STYLE <nStyle> ] ;
          [ NAME <cName> ] ;
          => ;
          <oDlg> := wxDialog():New( [<oParent>], [<nID>], <cTitle>, {<nTop>,<nLeft>}, {<nHeight>,<nWidth>}, [<nStyle>], [<cName>] )


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
          => ;
          wxh_AddMenuItem( <cLabel>, [<nID>], [<cHelpString>], [wxITEM_<kind>], [<{bAction}>] )

#xcommand ADD SEPARATOR ;
          => ;
          wxh_AddMenuItem( NIL, wxID_SEPARATOR )

#xcommand ENDMENU ;
          => ;
          wxh_EndMenu()

#xcommand ENDMENUBAR ;
          => ;
          wxh_EndMenuBar()

/*
  Button
  Teo. Mexico 2006
*/
#define wxALIGN_EXPAND  wxGROW
#define wxALIGN_        0

#xcommand @ BUTTON [<label>] ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style> ] ;
            [ VALIDATOR <validator> ] ;
            [ NAME <name> ] ;
            [ PROPORTION <proportion> ] ;
            [ ALIGN <align: LEFT, RIGHT, TOP, BOTTOM, CENTRE, EXPAND> ] ;
            [ FLAG <flag> ] ;
            [ BORDER <border> ] ;
          => ;
          wxh_Button( ;
            [<window>], ;
            [<id>],;
            [<label>],;
            ,;
            {<nWidth>,<nHeight>},;
            [<style>],;
            [<validator>],;
            [<name>],;
            [<proportion>],;
            [{wxALL, wxALIGN_<align>, <flag> }],;
            [<border>] )

/*
 * SAY ... GET
 */

#xcommand @ SAY <label> ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style> ] ;
            [ NAME <name> ] ;
            [ PROPORTION <proportion> ] ;
            [ FLAG <flag> ] ;
            [ BORDER <border> ] ;
          => ;
          wxh_Say( [<window>], ;
                   [<id>],;
                   [<label>],;
                   ,;
                   {<nWidth>,<nHeight>},;
                   [<style>],;
                   [<name>],;
                   [<proportion>],;
                   [<flag>],;
                   [<border>] )

#xcommand @ GET <text> ;
            [ ON <window> ] ;
            [ ID <id> ] ;
            [ WIDTH <nWidth> ] [ HEIGHT <nHeight> ] ;
            [ STYLE <style> ] ;
            [ NAME <name> ] ;
          => ;
          wxh_Get( [<window>], ;
                   [<id>],[<text>],;
                   ,;
                   [{<nWidth>,<nHeight>}],;
                   [<style>],;
                   [<name>])

/*
 * SIZERS
 */
#xcommand BEGIN BOXSIZER <type: VERTICAL, HORIZONTAL > ;
          [ PROPORTION <proportion> ] ;
          [ FLAG <flag> ] ;
          [ BORDER <border> ] ;
          => ;
          wxh_DefineBoxSizer( wx<type>, <proportion>, <flag>, <border> )

#xcommand END BOXSIZER ;
          => ;
          wxh_EndDefineBoxSizer()

#xcommand SPACER ;
          [ WIDTH <width> ] ;
          [ HEIGHT <height> ] ;
          [ PROPORTION <proportion> ] ;
          [ FLAG <flag> ] ;
          [ BORDER <border> ] ;
          => ;
          wxh_DefineSpacer( [<width>], [<height>], [<proportion>], [<flag>], [<border>] )