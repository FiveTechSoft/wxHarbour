/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2008 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2008 Teo Fonrouge <teo@windtelsoft.com>
*/

#ifdef __XHARBOUR__
#include "wx_hbcompat.ch"
#endif

#include "hbclass.ch"
#include "property.ch"
#include "inkey.ch"
#include "wxharbour.ch"

/*
  wxhBrowse
  Teo. Mexico 2008
*/
CLASS wxhBrowse FROM wxPanel
PRIVATE:
  DATA FDataSource
  DATA FDataSourceType
  DATA FRecNo           INIT 0
  METHOD GetColCount INLINE Len( ::gridTableBase:ColumnList )
  METHOD GetColPos
  METHOD GetRecNo
  METHOD GetRowCount
  METHOD GetRowPos
  METHOD SelectRowIndex( rowIndex )
  METHOD SetColPos( colPos )
  METHOD SetDataSource( dataSource )
  METHOD SetRowCount( rowCount )
  METHOD SetRowPos( rowPos )
PROTECTED:
PUBLIC:

  DATA grid
  DATA gridTableBase

  CONSTRUCTOR New( dataSource, window, id, pos, size, style, name )
  METHOD wxNew( window, id, pos, size, style, name )

  /* Begin TBrowse compatible */
  /* TBrowse compatible vars */
  DATA cargo
  DATA GoBottomBlock
  DATA GoTopBlock
  DATA SkipBlock

  PROPERTY ColCount READ GetColCount
  PROPERTY RowCount READ GetRowCount WRITE SetRowCount
  PROPERTY ColPos READ GetColPos WRITE SetColPos
  PROPERTY RowPos READ GetRowPos WRITE SetRowPos

  /* TBrowse compatible methods */
  METHOD AddColumn( column )
  METHOD DelColumn( pos )
  METHOD Down
  METHOD End
  METHOD GoBottom
  METHOD GoTop
  METHOD Home
  METHOD Left
  METHOD PageDown
  METHOD PageUp
  METHOD RefreshAll
  METHOD Right
  METHOD Up
  /* End TBrowse compatible */

  DATA BottomFirst INIT .F.
  DATA KeyEventBlock INIT {|| .F. }
  DATA SelectCellBlock

  METHOD AddAllColumns
  METHOD SetColWidth( col, width ) /* in pointSize * width */
  METHOD OnKeyDown( event )
  METHOD OnSelectCell( event )

  PROPERTY BlockParam READ gridTableBase:GetBlockParam WRITE gridTableBase:SetBlockParam
  PROPERTY ColumnList READ gridTableBase:GetColumnList WRITE gridTableBase:SetColumnList
  PROPERTY ColumnZero READ gridTableBase:GetColumnZero WRITE gridTableBase:SetColumnZero
  PROPERTY DataSource READ FDataSource WRITE SetDataSource
  PROPERTY RecNo READ GetRecNo

PUBLISHED:
ENDCLASS

/*
  New
  Teo. Mexico 2008
*/
METHOD New( dataSource, window, id, label, pos, size, style, name, onKey ) CLASS wxhBrowse

  /* TODO: Optimize this many calls: remove this New method, implement it in c++ */
  ::grid := wxhGridBrowse() /* no New() because we want to create the c++ object in wxNew and attach this hb obj*/
  ::gridTableBase := wxhBrowseTableBase():New( Self )
  ::wxNew( ::grid, ::gridTableBase, window, id, label, pos, size, style, name )

  IF !onKey = NIL
    ::KeyEventBlock := onKey
  ENDIF

  IF dataSource != NIL
    ::SetDataSource( dataSource )
  ENDIF

RETURN Self

/*
  AddAllColumns
  Teo. Mexico 2008
*/
  STATIC FUNCTION buildBlock( Self, col )
  RETURN {|| ::DataSource[ ::RecNo, col ] }

METHOD PROCEDURE AddAllColumns CLASS wxhBrowse
  LOCAL fld

  DO CASE
  CASE ValType( ::FDataSource ) = "O" .AND. ::FDataSource:IsDerivedFrom( "TTable" )

    wxh_BrowseAddColumn( .T., Self, "RecNo", {|| ::FDataSource:RecNo }, "9999999" )//, fld:Size )

    FOR EACH fld IN ::FDataSource:FieldList
      wxh_BrowseAddColumn( .F., Self, fld:Label, ::FDataSource:GetDisplayFieldBlock( fld:__enumIndex() ), fld:Picture )//, fld:Size )
    NEXT

  CASE ValType( ::FDataSource ) = "A"

    wxh_BrowseAddColumn( .T., Self, "", {|| ::RecNo }, "9999" )
    
    IF ValType( ::FDataSource[ 1 ] ) = "A"
      FOR EACH fld IN ::FDataSource[ 1 ]
        wxh_BrowseAddColumn( .F., Self, NTrim( fld:__enumIndex() ), buildBlock( Self, fld:__enumIndex() ) )
      NEXT
    ELSE
      wxh_BrowseAddColumn( .F., Self, "", {|| ::FDataSource[ ::RecNo ] } )
    ENDIF

  ENDCASE

RETURN

/*
  AddColumn
  Teo. Mexico 2008
*/
METHOD PROCEDURE AddColumn( column ) CLASS wxhBrowse
  AAdd( ::gridTableBase:ColumnList, column )
  ::gridTableBase:AppendCols( 1 )
  IF column:Width != NIL
    ::SetColWidth( Len( ::gridTableBase:ColumnList ), column:Width )
  ENDIF
  //::grid:AutoSizeColumn( Len( ::gridTableBase:ColumnList ) - 1 )
RETURN

/*
  DelColumn
  Teo. Mexico 2008
*/
METHOD FUNCTION DelColumn( pos ) CLASS wxhBrowse
  LOCAL column
  LOCAL length := ::ColCount

  IF !Empty( pos ) .AND. pos > 0 .AND. pos <= length .AND. ::gridTableBase:DeleteCols( pos - 1, 1 )
    column := ::gridTableBase:ColumnList[ pos ]
    ADel( ::gridTableBase:ColumnList, pos )
    ASize( ::gridTableBase:ColumnList, length - 1 )
  ENDIF

RETURN column

/*
  Down
  Teo. Mexico 2008
*/
METHOD FUNCTION Down CLASS wxhBrowse

  IF ::RowPos < ::RowCount
    ::RowPos += 1
  ELSE
    IF ::SkipBlock:Eval( 1 ) = 1
      ADel( ::gridTableBase:GridBuffer, 1 )
      ::gridTableBase:GetGridRowData( ::RowCount )
      ::RefreshAll()
      ::grid:SetGridCursor( ::grid:GetGridCursorRow(), ::grid:GetGridCursorCol() )
    ENDIF
  ENDIF

RETURN Self

/*
  End
  Teo. Mexico 2008
*/
METHOD FUNCTION End CLASS wxhBrowse
  ::SetColPos( ::ColCount() )
  ::grid:MakeCellVisible( ::grid:GetGridCursorRow(), ::grid:GetNumberCols() - 1 )
RETURN Self

/*
  GetRecNo
  Teo. Mexico 2008
*/
METHOD FUNCTION GetRecNo CLASS wxhBrowse
  IF ::FDataSourceType = "O"
    RETURN ::FDataSource:RecNo
  ENDIF
RETURN ::FRecNo

/*
  GoBottom
  Teo. Mexico 2008
*/
METHOD FUNCTION GoBottom CLASS wxhBrowse

  ::GoBottomBlock:Eval()
  ::gridTableBase:FillGridBuffer()
  ::RowPos := ::RowCount

  ::RefreshAll()

RETURN Self

/*
  GoTop
  Teo. Mexico 2008
*/
METHOD FUNCTION GoTop CLASS wxhBrowse

  ::GoTopBlock:Eval()
  ::gridTableBase:FillGridBuffer()
  ::RowPos := 1

  ::RefreshAll()

RETURN Self

/*
  Home
  Teo. Mexico 2008
*/
METHOD FUNCTION Home CLASS wxhBrowse
  ::SetColPos( 1 ) /* no freeze cols yet implemented */
  ::grid:MakeCellVisible( ::grid:GetGridCursorRow(), 0 )
RETURN Self

/*
  Left
  Teo. Mexico 2008
*/
METHOD FUNCTION Left CLASS wxhBrowse
  ::grid:MoveCursorLeft()
RETURN Self

/*
  OnKeyDown
  Teo. Mexico 2008
*/
METHOD PROCEDURE OnKeyDown( keyEvent ) CLASS wxhBrowse

  SWITCH keyEvent:GetKeyCode()
  CASE WXK_UP
    ::Up()
    EXIT
  CASE WXK_DOWN
    ::Down()
    EXIT
  CASE WXK_LEFT
    ::Left()
    EXIT
  CASE WXK_RIGHT
    IF keyEvent:GetModifiers() = wxMOD_CONTROL
      keyEvent:Skip( .F. )
    ELSE
      ::Right()
    ENDIF
    EXIT
  CASE WXK_HOME
    IF keyEvent:GetModifiers() = wxMOD_CONTROL
      ::Home()
    ELSE
      ::RowPos := 1
    ENDIF
    EXIT
  CASE WXK_END
    IF keyEvent:GetModifiers() = wxMOD_CONTROL
      ::End()
    ELSE
      ::RowPos := ::RowCount
    ENDIF
    EXIT
  CASE WXK_PAGEUP
    IF keyEvent:GetModifiers() = wxMOD_CONTROL
      ::GoTop()
    ELSE
      IF ::RowPos = 1
        ::PageUp()
      ELSE
        ::RowPos := 1
      ENDIF
    ENDIF
    EXIT
  CASE WXK_PAGEDOWN
    IF keyEvent:GetModifiers() = wxMOD_CONTROL
      ::GoBottom()
    ELSE
      IF ::RowPos = ::RowCount
        ::PageDown()
      ELSE
        ::RowPos := ::RowCount
      ENDIF
    ENDIF
    EXIT
  OTHERWISE
    keyEvent:Skip()
  END

RETURN

/*
  OnSelectCell
  Teo. Mexico 2008
*/
METHOD PROCEDURE OnSelectCell( gridEvent ) CLASS wxhBrowse

  IF !gridEvent:Selecting()
    gridEvent:Skip()
    RETURN
  ENDIF

  ::SelectRowIndex( gridEvent:GetRow() )

  IF ::SelectCellBlock != NIL .AND. ::RowCount > 0
    ::SelectCellBlock:Eval( Self, gridEvent )
  ENDIF

  gridEvent:Skip()

RETURN

/*
  PageDown
  Teo. Mexico 2008
*/
METHOD FUNCTION PageDown CLASS wxhBrowse

  ::SkipBlock:Eval( ::RowCount - ::RowPos + 1 )
  ::gridTableBase:FillGridBuffer()

  ::RefreshAll()

RETURN Self

/*
  PageUp
  Teo. Mexico 2008
*/
METHOD FUNCTION PageUp CLASS wxhBrowse

  ::SkipBlock:Eval( -::RowPos - ::RowCount + 1)
  ::gridTableBase:FillGridBuffer()

  ::RefreshAll()

RETURN Self

/*
  Right
  Teo. Mexico 2008
*/
METHOD FUNCTION Right CLASS wxhBrowse
  ::grid:MoveCursorRight()
RETURN Self

/*
  SelectRowIndex
  Teo. Mexico 2008
*/
METHOD PROCEDURE SelectRowIndex( rowIndex ) CLASS wxhBrowse

  IF rowIndex >= ::RowCount
    RETURN
  ENDIF

  IF Empty( ::gridTableBase:GridBuffer )
    IF ::BottomFirst
      ::GoBottom()
    ELSE
      ::GoTop()
    ENDIF
  ENDIF

  ::gridTableBase:CurRowIndex := rowIndex

RETURN

/*
  SetDataSource
  Teo. Mexico 2008
*/
METHOD PROCEDURE SetDataSource( dataSource ) CLASS wxhBrowse
  LOCAL table
  LOCAL oldPos
  LOCAL vt := ValType( dataSource )

  ::FDataSourceType := NIL
  ::ColumnList := {}
  ::ColumnZero := NIL
  ::BlockParam := NIL

  ::FDataSource := NIL

  SWITCH vt
  CASE 'A'        /* Array browse */
    ::FDataSource := dataSource
    ::FDataSourceType := "A"

    ::GoTopBlock    := {|| ::FRecNo := 1 }
    ::GoBottomBlock := {|| ::FRecNo := Len( dataSource ) }
    ::SkipBlock     := {|n| oldPos := ::FRecNo, ::FRecNo := iif( n < 0, Max( 1, ::FRecNo + n ), Min( Len( dataSource ), ::FRecNo + n ) ), ::FRecNo - oldPos }

    EXIT

  CASE 'C'        /* path/filename for a database browse */
    table := TTable():New()
    table:TableName := dataSource
    table:Open()

    ::SetDataSource( table )

    EXIT

  CASE 'H'        /* Hash browse */
    /* TODO: Implement this */
    ::FDataSource := dataSource
    ::FDataSourceType := "H"

    EXIT

  CASE 'O'
    ::FDataSource := dataSource
    ::FDataSourceType := "O"
    ::BlockParam := dataSource:DisplayFields()

    ::GoTopBlock    := {|| dataSource:DbGoTop() }
    ::GoBottomBlock := {|| dataSource:DbGoBottom() }
    ::SkipBlock     := {|n| dataSource:SkipBrowse( n ) }

    EXIT

  END

RETURN

/*
  Up
  Teo. Mexico 2008
*/
METHOD FUNCTION Up CLASS wxhBrowse

  IF ::RowPos > 1
    ::RowPos -= 1
  ELSE
    IF ::SkipBlock:Eval( -1 ) = -1
      AIns( ::gridTableBase:GridBuffer, 1 )
      ::gridTableBase:GetGridRowData( 1 )
      ::RefreshAll()
      ::grid:SetGridCursor( ::grid:GetGridCursorRow(), ::grid:GetGridCursorCol() )
    ENDIF
  ENDIF

RETURN Self

/*
  End Class wxhBrowse
*/
