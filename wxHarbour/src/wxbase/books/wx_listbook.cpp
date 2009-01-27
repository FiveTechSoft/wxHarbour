/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2008 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2008 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wx_Listbook: Implementation
  Teo. Mexico 2008
*/

#include "wx/wx.h"
#include "wxh.h"
#include "wx/listbook.h"

#include "wxbase/wx_listbook.h"

/*
  ~wx_Listbook
  Teo. Mexico 2008
*/
wx_Listbook::~wx_Listbook()
{
  wxh_ItemListDel_WX( this );
}

/*
  wxListbook:New
  Teo. Mexico 2008
*/
HB_FUNC( WXLISTBOOK_NEW )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  WXH_SCOPELIST wxhScopeList = WXH_SCOPELIST( pSelf );

  wx_Listbook* listBook;

  if( hb_pcount() )
  {
    wxWindow* parent = (wxWindow *) hb_par_WX( 1, &wxhScopeList );
    wxWindowID id = ISNIL( 2 ) ? wxID_ANY : hb_parni( 2 );
    const wxPoint& pos = ISNIL( 3 ) ? wxDefaultPosition : hb_par_wxPoint( 3 );
    const wxSize& size = ISNIL( 4 ) ? wxDefaultSize : hb_par_wxSize( 4 );
    long style = ISNIL( 5 ) ? 0 : hb_parnl( 5 );
    const wxString& name = ISNIL( 6 ) ? _T("Listbook") : wxh_parc( 6 );
    listBook = new wx_Listbook( parent, id, pos, size, style, name );
  }
  else
    listBook = new wx_Listbook();

  // Add object's to hash list
  //wxh_ItemListAdd( listBook, pSelf );
  wxh_SetScopeList( listBook, &wxhScopeList );

  hb_itemReturn( pSelf );
}

/*
  wxListbook:AddPage
  Teo. Mexico 2007
*/
HB_FUNC( WXLISTBOOK_ADDPAGE )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  WXH_SCOPELIST wxhScopeList = WXH_SCOPELIST( pSelf );
  wxListbook* Listbook = (wxListbook *) wxh_ItemListGetWX( pSelf );

  wxNotebookPage* page = (wxNotebookPage *) hb_par_WX( 1, &wxhScopeList );

  if( Listbook && page )
  {
    bool select = ISNIL( 3 ) ? false : hb_parl( 3 );
    int imageld = ISNIL( 4 ) ? -1 : hb_parni( 4 );
    Listbook->AddPage( page, wxh_parc( 2 ), select, imageld );
  }
}
