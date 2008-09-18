/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
*/

#include "hbclass.ch"
#include "property.ch"

/*
  wx_Dialog
  Teo. Mexico 2008
*/
FUNCTION wx_Dialog( fromClass, oParent, nID, cTitle, nTopnLeft, nHeightnWidth, nStyle, cName )
  LOCAL dlg

  IF Empty( fromClass )
    RETURN wxDialog():New( oParent, nID, cTitle, nTopnLeft, nHeightnWidth, nStyle, cName )
  ENDIF

  dlg := __ClsInstFromName( fromClass ):New( oParent, nID, cTitle, nTopnLeft, nHeightnWidth, nStyle, cName )

  IF !dlg:IsDerivedFrom( "wxDialog" )
    dlg:IsNotDerivedFrom_wxDialog()
  ENDIF

RETURN dlg

/*
  wxDialog
  Teo. Mexico 2006
*/
CLASS wxDialog FROM wxTopLevelWindow
PRIVATE:
PROTECTED:
PUBLIC:
  CONSTRUCTOR New( parent, id, title, pos, size, style, name )
  METHOD Centre( direction )
  METHOD CreateButtonSizer( flags )
  METHOD CreateStdDialogButtonSizer( flags )
  METHOD EndModal( retCode )
  METHOD Show( show )
  METHOD ShowModal
PUBLISHED:
  PROPERTY ColCount READ GetColCount
ENDCLASS

/*
  EndClass wxDialog
*/