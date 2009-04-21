/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2009 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2009 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wxRadioBox
  Teo. Mexico 2009
*/

#include "hbclass.ch"
#include "property.ch"
#include "wx.ch"

/*
  wxRadioBox
  Teo. Mexico 2009
*/
CLASS wxRadioBox FROM wxControlWithItems
PRIVATE:
PROTECTED:
PUBLIC:

  CONSTRUCTOR New( parent, id, label, point, size, choices, majorDimension, style, validator, name )

  METHOD GetSelection
  METHOD SetSelection( n )

PUBLISHED:
ENDCLASS

/*
  EndClass wxRadioBox
*/

/*
  wxHBRadioBox
  Teo. Mexico 2009
*/
CLASS wxHBRadioBox FROM wxRadioBox
PRIVATE:
  DATA FWXHGet
  METHOD UpdateVar( event )
PROTECTED:
PUBLIC:
  CONSTRUCTOR New( parent, id, label, point, size, choices, majorDimension, style, validator, name, wxhGet )
  PROPERTY WXHGet READ FWXHGet
PUBLISHED:
ENDCLASS

/*
  New
  Teo. Mexico 2009
*/
METHOD New( parent, id, label, point, size, choices, majorDimension, style, validator, name, wxhGet ) CLASS wxHBRadioBox

  IF choices = NIL .AND. wxhGet != NIL .AND. wxhGet:Field != NIL
    choices := wxhGet:GetChoices()
  ENDIF

  Super:New( parent, id, label, point, size, choices, majorDimension, style, validator, name )

  IF name = NIL
    ::SetName( wxhGet:Name )
  ENDIF

  IF label = NIL .AND. wxhGet != NIL .AND. wxhGet:Field != NIL .AND. wxhGet:Field:Label != NIL
    ::SetLabel( wxhGet:Field:Label )
  ENDIF

  ::FWXHGet := wxhGet

  ::SetSelection( ::FWXHGet:GetSelection() )

  /* the update to VAR event */
  ::ConnectCommandEvt( ::GetId(), wxEVT_COMMAND_RADIOBOX_SELECTED, {|event| ::UpdateVar( event ) } )

RETURN Self

/*
  UpdateVar
  Teo. Mexico 2009
*/
METHOD PROCEDURE UpdateVar( event ) CLASS wxHBRadioBox
  LOCAL value

  IF ::FWXHGet == NIL
    RETURN
  ENDIF

  IF event:GetEventType() = wxEVT_COMMAND_RADIOBOX_SELECTED
    value := ::FWXHGet:GetKeyValue( ::GetSelection() )
    IF value != NIL
      ::FWXHGet:Block:Eval( value )
    ENDIF
  ENDIF

RETURN

/*
  End Class wxHBRadioBox
*/