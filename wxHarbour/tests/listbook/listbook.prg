/*
  listbook sample
  Teo. Mexico 2009
*/

#include "wxharbour.ch"

#define GRANGE  100

FUNCTION Main
  LOCAL MyApp

  MyApp := MyApp():New()

  IMPLEMENT_APP( MyApp )

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

  CREATE FRAME oWnd ;
         TITLE "ListNotebook Sample"

  DEFINE MENUBAR STYLE 1 ON oWnd
    DEFINE MENU "&File"
      ADD MENUITEM E"Quit \tCtrl+Q" ID wxID_EXIT ACTION oWnd:Close() ;
          HELPLINE "Quits this sample..."
    ENDMENU
    DEFINE MENU "Help"
      ADD MENUITEM "About..."
    ENDMENU
  ENDMENU

  BEGIN BOXSIZER VERTICAL

    BEGIN LISTBOOK  SIZERINFO ALIGN EXPAND STRETCH

      ADD BOOKPAGE "Button" FROM
        @ BUTTON "Button1"

      ADD BOOKPAGE "Grid" FROM
        @ GRID ROWS 10 COLS 5

      ADD BOOKPAGE "Sub-AuiNotebook" FROM
        BEGIN LISTBOOK
          @ SAY "Page 1"
          @ SAY "Page 2"
        END LISTBOOK

    END LISTBOOK

    @ BUTTON ID wxID_EXIT ACTION oWnd:Close() SIZERINFO ALIGN RIGHT

  END SIZER

  SHOW WINDOW oWnd FIT CENTRE

RETURN .T.
