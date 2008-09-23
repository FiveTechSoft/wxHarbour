/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
*/

#include "hbclass.ch"
#include "property.ch"
#include "wx.ch"

#include "wxharbour.ch"

/*
  wxhGET
*/
CLASS wxhGET
PRIVATE:
  DATA FBlock EXPORTED
  DATA FName
  DATA FVar EXPORTED
PROTECTED:
PUBLIC:

  CONSTRUCTOR New( varName, block )

  METHOD AsString

  PROPERTY Name READ FName

PUBLISHED:
ENDCLASS

/*
  New
  Teo. Mexico 2008
*/
METHOD New( name, var, block )
  ::FName  := name
  ::FVar   := var
  ::FBlock := block
RETURN Self

/*
  AsString
  Teo. Mexico 2008
*/
METHOD FUNCTION AsString CLASS wxhGET
  LOCAL value
  IF HB_ISOBJECT( ::FVar )
    IF ::FVar:IsDerivedFrom( "TField" )
      value := ::FVar:AsString()
    ELSE
      value := "<unknown>"
    ENDIF
  ELSE
    value := ::FBlock:Eval()
  ENDIF
RETURN value

/*
  End Class wxGET
*/

/*
  wxHBTextCtrl
*/
CLASS wxHBTextCtrl FROM wxTextCtrl
PRIVATE:
PROTECTED:
PUBLIC:
  CONSTRUCTOR New( window, id, wxhGet, pos, size, style, validator, name )
PUBLISHED:
ENDCLASS

/*
  New
*/
METHOD New( window, id, wxhGet, pos, size, style, validator, name ) CLASS wxHBTextCtrl

  Super:New( window, id, wxhGet:AsString(), pos, size, style, validator, name )

  IF name = NIL
    ::SetName( wxhGet:Name )
    ::SetLabel( wxhGet:Name )
  ENDIF

RETURN Self

/*
  End Class wxHBTextCtrl
*/
