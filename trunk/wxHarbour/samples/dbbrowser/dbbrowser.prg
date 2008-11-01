/*
  (C) 2008 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  DbBrowser: Simple browser
  Teo. Mexico 2008
*/

#include "hbclass.ch"
#include "property.ch"
#include "wx.ch"
#include "wxharbour.ch"

#include "wxh/filedlg.ch"

FUNCTION Main()
  LOCAL profiler := HBProfile():New()
  LOCAL MyApp

  MyApp := MyApp():New()

  __setProfiler( .T. )

  IMPLEMENT_APP( MyApp )

  //profiler:Gather()
  ? HBProfileReportToString():new( profiler:timeSort() ):generate( {|o| o:nTicks > 10000 } )
  ? Replicate("=",40)
  ? "  Total Calls: " + str( profiler:totalCalls() )
  ? "  Total Ticks: " + str( profiler:totalTicks() )
  ? "Total Seconds: " + str( profiler:totalSeconds() )

RETURN NIL

/*
  MyApp
  Teo. Mexico 2008
*/
CLASS MyApp FROM wxApp
PRIVATE:
PROTECTED:
PUBLIC:
  METHOD OnInit
PUBLISHED:
ENDCLASS
/*
  EndClass MyApp
*/

/*
  OnInit
  Teo. Mexico 2008
*/
METHOD FUNCTION OnInit() CLASS MyApp
  LOCAL oWnd
  LOCAL text := ""
  LOCAL textCtrl
  LOCAL b

  CREATE FRAME oWnd ;
         WIDTH 800 HEIGHT 600 ;
         ID 999 ;
         TITLE "Simple Dbf Browser"

  DEFINE MENUBAR STYLE 1 ON oWnd
    DEFINE MENU "&File"
      ADD MENUITEM E"Quit \tCtrl+Q" ID wxID_EXIT ACTION oWnd:Close() ;
          HELPLINE "Quits this sample..."
    ENDMENU
    DEFINE MENU "Help"
      ADD MENUITEM "Fit Grid" ACTION b:Fit()
      ADD MENUSEPARATOR
      ADD MENUITEM "About..."
    ENDMENU
  ENDMENU

  BEGIN BOXSIZER VERTICAL
    @ BROWSE VAR b DATASOURCE "main" ;
      ONKEY {|b,keyEvent| k_Process( b, keyEvent:GetKeyCode() ) } ;
      SIZERINFO ALIGN EXPAND STRETCH
    BEGIN BOXSIZER VERTICAL "" ALIGN EXPAND
      @ GET text VAR textCtrl MULTILINE SIZERINFO ALIGN EXPAND STRETCH
      BEGIN BOXSIZER HORIZONTAL
        @ BUTTON "GoTop" ACTION b:GoTop()
        @ BUTTON "GoBottom" ACTION b:GoBottom()
        @ BUTTON "PgUp" ACTION b:PageUp()
        @ BUTTON "PgDown" ACTION b:PageDown()
        @ BUTTON "Up" ACTION b:Up()
        @ BUTTON "Down" ACTION b:Down()
        @ BUTTON "RefreshAll" ACTION b:RefreshAll()
      END SIZER
      @ BUTTON ID wxID_EXIT ACTION oWnd:Close() SIZERINFO ALIGN RIGHT
    END SIZER
  END SIZER

//   b:Fit()

  b:SelectCellBlock := {|| textCtrl:AppendText( b:DataSource:Field_First:AsString + E"\n" ) }

  b:AddAllColumns()

  @ STATUSBAR

  SHOW WINDOW oWnd CENTRE

RETURN .T.

/*
  k_Process
  Teo. Mexico 2008
*/
STATIC FUNCTION k_Process( b, nKey )

  DO CASE
  CASE nKey = 127
    ? "Delete on",b:DataSource:RecNo(),"First",b:DataSource:Field_First:Value
  OTHERWISE
    RETURN .F.
  ENDCASE

  b:RefreshAll()

RETURN .T.
