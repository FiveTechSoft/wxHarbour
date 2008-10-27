/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wx_Font: Implementation
  Teo. Mexico 2006
*/

#include "wx/wx.h"
#include "wxh.h"

#include "wxbase/wx_font.h"

/*
  ~wx_Font
  Teo. Mexico 2006
*/
wx_Font::~wx_Font()
{
  wxh_ItemListDel( this );
}

/*
  Constructor: wxFont Object
  Teo. Mexico 2006
*/
HB_FUNC( WXFONT_NEW )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  wx_Font* menu = new wx_Font();

  // Add object's to hash list
  wxh_ItemListAdd( menu, pSelf );

  hb_itemReturn( pSelf );
}

HB_FUNC( WXFONT_GETPOINTSIZE )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  wx_Font* font;
  if( pSelf && (font = (wx_Font *) wxh_ItemListGetWX( pSelf ) ) )
    hb_retni( font->GetPointSize() );
}
