/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wxStatusBar
  Teo. Mexico 2006
*/

#include "hbclass.ch"
#include "property.ch"

/*
  DefineStatusBar
  Teo. Mexico 2006
*/
FUNCTION DefineStatusBar( parent, id, style, name, fields, widths )
  LOCAL sb
  LOCAL oW

  oW := iif( parent = NIL, GetLastFrame(), parent )

  sb := wxStatusBar():New( oW, id, style, name )

  IF widths!=NIL .AND. fields=NIL
    fields := Len( widths )
  ENDIF

  IF fields != NIL
    sb:SetFieldsCount( fields, widths )
  ENDIF

  oW:SetStatusBar( sb )

RETURN sb

/*
  wxStatusBar
  Teo. Mexico 2006
*/
CLASS wxStatusBar FROM wxWindow
PRIVATE:
PROTECTED:
PUBLIC:
  CONSTRUCTOR New( parent, id, style, name )
  METHOD SetFieldsCount( number, widths )
PUBLISHED:
ENDCLASS

/*
  EndClass wxStatusBar
*/
