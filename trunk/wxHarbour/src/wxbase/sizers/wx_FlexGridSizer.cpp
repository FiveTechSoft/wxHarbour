/*
 * $Id$
 */

/*
 wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2006 Teo Fonrouge
 
 This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 (C) 2006 Teo Fonrouge <teo@windtelsoft.com>
 */

/*
 wx_FlexGridSizer: Implementation
 Teo. Mexico 2006
 */

#include "wx/wx.h"
#include "wxh.h"

#include "wxbase/wx_FlexGridSizer.h"

/*
 ~wx_FlexGridSizer
 Teo. Mexico 2006
 */
wx_FlexGridSizer::~wx_FlexGridSizer()
{
	wxh_ItemListDel_WX( this );
}

HB_FUNC( WXFLEXGRIDSIZER_NEW )
{
	wxh_ObjParams objParams = wxh_ObjParams();
	
	wx_FlexGridSizer* flexGridSizer = new wx_FlexGridSizer( hb_parni( 1 ), hb_parni( 2 ), hb_parni( 3 ), hb_parni( 4 ) );
	
	objParams.Return( flexGridSizer );
}

/*
 AddGrowableCol
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_ADDGROWABLECOL )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		flexGridSizer->AddGrowableCol( hb_parnl( 1 ), hb_parni( 2 ) );
}

/*
 AddGrowableRow
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_ADDGROWABLEROW )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		flexGridSizer->AddGrowableRow( hb_parnl( 1 ), hb_parni( 2 ) );
}

/*
 GetFlexibleDirection
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_GETFLEXIBLEDIRECTION )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		hb_retni( flexGridSizer->GetFlexibleDirection() );
}

/*
 GetNonFlexibleGrowMode
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_GETNONFLEXIBLEGROWMODE )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		hb_retni( flexGridSizer->GetNonFlexibleGrowMode() );
}

/*
 RemoveGrowableCol
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_REMOVEGROWABLECOL )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		flexGridSizer->RemoveGrowableCol( hb_parnl( 1 ) );
}

/*
 RemoveGrowableRow
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_REMOVEGROWABLEROW )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		flexGridSizer->RemoveGrowableRow( hb_parnl( 1 ) );
}

/*
 SetFlexibleDirection
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_SETFLEXIBLEDIRECTION )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		flexGridSizer->SetFlexibleDirection( hb_parni( 1 ) );
}

/*
 SetNonFlexibleGrowMode
 Teo. Mexico 2007
 */
HB_FUNC( WXFLEXGRIDSIZER_SETNONFLEXIBLEGROWMODE )
{
	wxFlexGridSizer* flexGridSizer = (wxFlexGridSizer *) wxh_ItemListGet_WX( hb_stackSelfItem() );
	
	if( flexGridSizer )
		flexGridSizer->SetNonFlexibleGrowMode( (wxFlexSizerGrowMode) hb_parni( 1 ) );
}
