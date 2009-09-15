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
  wx_Validator: Implementation
  Teo. Mexico 2006
*/

#include "wx/wx.h"
#include "wxh.h"

#include "wxbase/wx_Validator.h"

/*
  wx_Validator()
  Teo. Mexico 2009
*/
wx_Validator::wx_Validator( const wx_Validator& validator ) : wxValidator()
{
  Copy( validator );
  wxh_ItemListSwap( (wxObject *) &validator, this );
}

/*
  TransferFromWindow
  Teo. Mexico 2009
*/
bool wx_Validator::TransferFromWindow()
{
  PHB_ITEM pSelf = wxh_ItemListGet_HB( this );
  bool result = false;

  if( pSelf )
  {
    hb_objSendMsg( pSelf, "TransferFromWindow", 0 );
    result = hb_stackReturnItem()->item.asLogical.value;
  }
  return result;
}

/*
  TransferToWindow
  Teo. Mexico 2009
*/
bool wx_Validator::TransferToWindow()
{
  PHB_ITEM pSelf = wxh_ItemListGet_HB( this );
  bool result = false;
  
  if( pSelf )
  {
    hb_objSendMsg( pSelf, "TransferToWindow", 0 );
    result = hb_stackReturnItem()->item.asLogical.value;
  }
  return result;
}

/*
  Validate
  Teo. Mexico 2009
*/
bool wx_Validator::Validate( wxWindow* parent )
{
  PHB_ITEM pSelf = wxh_ItemListGet_HB( this );
  bool result = false;

  if( pSelf )
  {
    PHB_ITEM pParent = wxh_ItemListGet_HB( parent );
    if( pParent )
    {
      hb_objSendMsg( hb_stackSelfItem(), "Validate", 1, pParent );
      result = hb_stackReturnItem()->item.asLogical.value;
    }
  }
  return result;
}

/*
  ~wx_Validator
  Teo. Mexico 2006
*/
wx_Validator::~wx_Validator()
{
  wxh_ItemListDel_WX( this );
}

/*
  New
  Teo. Mexico 2009
*/
HB_FUNC( WXVALIDATOR_NEW )
{
  wxh_ObjParams objParams = wxh_ObjParams();

  wx_Validator* validator = new wx_Validator;
  
  objParams.Return( validator );
}

/*
  GetWindow()
  Teo. Mexico 2009
*/
HB_FUNC( WXVALIDATOR_GETWINDOW )
{
  wx_Validator* validator = (wx_Validator *) wxh_ItemListGet_WX( hb_stackSelfItem() );

  if( validator )
  {
    wxh_itemReturn( validator->GetWindow() );
  }
}

/*
  SetWindow()
  Teo. Mexico 2009
*/
HB_FUNC( WXVALIDATOR_SETWINDOW )
{
  wxValidator* validator = (wxValidator *) wxh_ItemListGet_WX( hb_stackSelfItem() );

  if( validator )
  {
    validator->SetWindow( (wxWindow *) wxh_par_WX( 1 ) );
  }
}

/*
  TransferFromWindow
  Teo. Mexico 2009
*/
HB_FUNC( WXVALIDATOR_TRANSFERFROMWINDOW )
{
  wxValidator* validator = (wxValidator *) wxh_ItemListGet_WX( hb_stackSelfItem() );

  if( validator )
  {
    hb_retl( false );
  }
}

/*
  TransferToWindow
  Teo. Mexico 2009
*/
HB_FUNC( WXVALIDATOR_TRANSFERTOWINDOW )
{
  wxValidator* validator = (wxValidator *) wxh_ItemListGet_WX( hb_stackSelfItem() );

  if( validator )
  {
    hb_retl( false );
  }
}

/*
  Validate
  Teo. Mexico 2009
*/
HB_FUNC( WXVALIDATOR_VALIDATE )
{
  wxValidator* validator = (wxValidator *) wxh_ItemListGet_WX( hb_stackSelfItem() );

  if( validator )
  {
    hb_retl( false );
  }
}