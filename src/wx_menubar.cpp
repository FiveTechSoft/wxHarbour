/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wx_MenuBar: Implementation
  Teo. Mexico 2006
*/

#include "wx/wx.h"
#include "wxh.h"

#include "wx_menu.h"
#include "wx_menubar.h"

/*
  ~wx_MenuBar
  Teo. Mexico 2006
*/
wx_MenuBar::~wx_MenuBar()
{
  wx_ObjList_wxDelete( this );
}

static PHB_ITEM oLastMenuBar;

/*
  Constructor: wxMenuBar Object
  Teo. Mexico 2006
*/
HB_FUNC( WXMENUBAR_NEW )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  wx_MenuBar* menuBar = new wx_MenuBar( hb_parnl(1) );

  // Add object's to hash list
  wx_ObjList_New( menuBar, pSelf );


  oLastMenuBar = wx_ObjList_hbGet( menuBar );

  hb_itemReturn( pSelf );
}

HB_FUNC( WXMENUBAR_APPEND )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  wx_MenuBar* menuBar;
  wx_Menu* menu;
  if ( pSelf &&
        ( menuBar = (wx_MenuBar *) wx_ObjList_wxGet( pSelf ) ) &&
        ( menu = (wx_Menu *) hb_par_WX( 1 ) ) )
    menuBar->Append( menu, wxString( hb_parcx(2), wxConvLocal ) );
}

/*
  GetLastMenuBar()
  Teo. Mexico 2006
*/
HB_FUNC( GETLASTMENUBAR )
{
  hb_itemReturn( oLastMenuBar );
}









