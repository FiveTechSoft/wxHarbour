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
  wxScrolledWindow
  Teo. Mexico 2006
*/
CLASS wxScrolledWindow FROM wxWindow
ENDCLASS

/*
  EndClass wxScrolledWindow
*/


/*
  wxGrid
  Teo. Mexico 2006
*/
CLASS wxGrid FROM wxScrolledWindow
PRIVATE:
PROTECTED:
PUBLIC:
  CONSTRUCTOR New( parent, id, pos, size, style, name )
  METHOD CreateGrid( numRows, numCols, selmode )
  METHOD Fit
  METHOD GetTable
  METHOD SetColLabelSize( height )
  METHOD SetColLabelValue( col, value )
  METHOD SetDefaultColSize( width, resizeExistingCols )
  METHOD SetDefaultRowSize( height, resizeExistingRows )
  METHOD SetRowLabelSize( width )
  METHOD SetTable( table, takeOwnership, selmode )
PUBLISHED:
ENDCLASS

/*
  EndClass wxGrid
*/
