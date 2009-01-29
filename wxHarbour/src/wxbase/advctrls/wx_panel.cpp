/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wx_Panel: Implementation
  Teo. Mexico 2006
*/

#include "wx/wx.h"
#include "wxh.h"

#include "wxbase/wx_panel.h"

/*
  ~wx_Panel
  Teo. Mexico 2006
*/
wx_Panel::~wx_Panel()
{
  wxh_ItemListDel_WX( this );
}

/*
bool Create(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxTAB_TRAVERSAL, const wxString& name = "panel")
*/

HB_FUNC( WXPANEL_NEW )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  WXH_SCOPELIST wxhScopeList = WXH_SCOPELIST( pSelf );

  wx_Panel* panel;

  if( hb_pcount() )
  {
    wxWindow* parent = (wxWindow *) wxh_param_WX_Parent( 1, &wxhScopeList );
    wxWindowID id = ISNIL( 2 ) ? wxID_ANY : hb_parni( 2 );
    const wxPoint& pos = ISNIL( 3 ) ? wxDefaultPosition : hb_par_wxPoint( 3 );
    const wxSize& size = ISNIL( 4 ) ? wxDefaultSize : hb_par_wxSize( 4 );
    long style = ISNIL( 5 ) ? wxTAB_TRAVERSAL : hb_parnl( 5 );
    const wxString& name = ISNIL( 6 ) ? _T("panel") : wxh_parc( 6 );
    panel = new wx_Panel( parent, id, pos, size, style, name );
  }
  else
    panel = new wx_Panel();

  // Add object's to hash list
  //wxh_ItemListAdd( panel, pSelf, wxhScopeList );
  wxhScopeList.PushObject( panel );

  hb_itemReturn( pSelf );
}
