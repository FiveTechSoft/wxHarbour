/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2009 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2009 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wxharbour:
  Teo. Mexico 2009
*/

#include "wx/wx.h"
#include "wx/hashset.h"
#include "wxh.h"

/* PHB_BASEARRAY keys, wxh_Item* values */
WX_DECLARE_HASH_MAP( PHB_BASEARRAY, wxh_Item*, wxPointerHash, wxPointerEqual, MAP_PHB_BASEARRAY );

/* wxObject* keys, wxh_Item* values */
WX_DECLARE_HASH_MAP( wxObject*, wxh_Item*, wxPointerHash, wxPointerEqual, MAP_WXOBJECT );

static MAP_PHB_BASEARRAY map_phbBaseArr;
static MAP_WXOBJECT map_wxObject;

static PHB_ITEM lastTopLevelWindow;

/*
  destructor
  Teo. Mexico 2009
*/
wxh_Item::~wxh_Item()
{
  map_phbBaseArr.erase( this->objHandle );
  map_wxObject.erase( this->wxObj  );

  /* scan the map_childList to release hb items */
  for( MAP_PHB_ITEM::iterator it = this->map_childList.begin(); it != this->map_childList.end(); it++ )
  {
    wxh_Item* pwxhChildItm = wxh_ItemListGet_PWXH_ITEM( it->first );

    if( pwxhChildItm )
    {
      //wxh_ItemListDel_WX( pwxhChildItm->wxObj );
      pwxhChildItm->delete_WX = false;
      delete pwxhChildItm;
    }

    if( it->second )
    {
      it->second = false;
      hb_itemRelease( it->first );
    }
  }

  /* release codeblocks stored in event list */
  if( this->evtList.size() > 0 )
  {
    for( vector<PCONN_PARAMS>::iterator it = this->evtList.begin(); it < this->evtList.end(); it++ )
    {
      PCONN_PARAMS pConnParams = *it;
      if( pConnParams->pItmActionBlock )
      {
        hb_itemRelease( pConnParams->pItmActionBlock );
        pConnParams->pItmActionBlock = NULL;
      }
      delete pConnParams;
    }
  }

  if( delete_WX )
  {
    delete this->wxObj;
  }

  if( pSelf )
  {
    hb_itemRelease( pSelf );
  }

}

/*
  constructor
  Teo. Mexico 2009
*/
wxh_ObjParams::wxh_ObjParams()
{
//   hb_itemCopyFromRef( pSelf, hb_stackSelfItem() );
//   pSelf = hb_itemNew( hb_stackSelfItem() );
  /*hb_itemCopy( pSelf, hb_stackSelfItem() );*/
  pSelf = hb_stackSelfItem();
  pWxh_Item = wxh_ItemListGet_PWXH_ITEM( pSelf );
}

/*
  constructor
  Teo. Mexico 2009
*/
wxh_ObjParams::wxh_ObjParams( PHB_ITEM pHbObj )
{
  pSelf = pHbObj ;
  pWxh_Item = wxh_ItemListGet_PWXH_ITEM( pSelf );
}

/*
  destructor
  Teo. Mexico 2009
*/
wxh_ObjParams::~wxh_ObjParams()
{
  ProcessParamLists();
  //hb_itemRelease( pSelf );
}

/*
  Get_wxObject
  Teo. Mexico 2009
*/
wxObject* wxh_ObjParams::Get_wxObject()
{
  return wxh_ItemListGet_WX( pSelf );
}

/*
  param
  Teo. Mexico 2009
*/
wxObject* wxh_ObjParams::param( const int param )
{
  return wxh_param_WX( param );
}

/*
  paramChild
  Teo. Mexico 2009
*/
wxObject* wxh_ObjParams::paramChild( const int param )
{
  PHB_ITEM pChildItm = hb_param( param, HB_IT_OBJECT );
  wxObject* wxObj = NULL;

  if( pChildItm )
  {
    wxObj = wxh_ItemListGet_WX( pChildItm );

    if( wxObj )
    {
      map_paramListChild[ pChildItm ] = wxObj;
    }
  }

  return wxObj;
}

/*
  paramParent
  Teo. Mexico 2009
*/
wxObject* wxh_ObjParams::paramParent( const int param )
{
  PHB_ITEM pParentItm = hb_param( param, HB_IT_OBJECT );
  wxObject* wxObj = NULL;

  if( pParentItm )
  {
    wxObj = wxh_ItemListGet_WX( pParentItm );

    if( wxObj )
    {
      map_paramListParent[ pParentItm ] = wxObj;
    }
  }

  return wxObj;
}

/*
  ProcessParamLists
  Teo. Mexico 2009
*/
void wxh_ObjParams::ProcessParamLists()
{
  /* add the Parent objects to the child/parent lists */
  while( map_paramListParent.size() > 0 )
  {
    MAP_PHB_ITEM::iterator it = map_paramListParent.begin();
    SetParentChildKey( it->first, pSelf );
    map_paramListParent.erase( it );
  }

  /* add the Child objects to the child/parent lists */
#if 1
  while( map_paramListChild.size() > 0 )
  {
    MAP_PHB_ITEM::iterator it = map_paramListChild.begin();
    SetParentChildKey( pSelf, it->first );
    map_paramListChild.erase( it );
  }
#endif

}

/*
  Return
  Teo. Mexico 2009
*/
void wxh_ObjParams::Return( wxObject* wxObj )
{
  pWxh_Item = NULL;

  /* checks for a valid new pSelf object */
  if( pSelf && ( map_phbBaseArr.find( pSelf->item.asArray.value ) == map_phbBaseArr.end() ) )
  {
    if( hb_clsIsParent( pSelf->item.asArray.value->uiClass, "WXTOPLEVELWINDOW" ) )
    {
      lastTopLevelWindow = pSelf;
    }

    pWxh_Item = new wxh_Item;
    pWxh_Item->wxObj = wxObj;
    pWxh_Item->objHandle = pSelf->item.asArray.value;

    map_phbBaseArr[ pSelf->item.asArray.value ] = pWxh_Item;
    map_wxObject[ wxObj ] = pWxh_Item;

    /* this object is the Harbour var created in the ::New() method
       and the Harbour programmer is responsible to keep it alive */
    //pWxh_Item->pSelf = hb_objSendMsg( pSelf, "SelfReference", 0 );
    hb_objSendMsg( pSelf, "SelfReference", 0 );

    ProcessParamLists();

    hb_itemReturn( pSelf );

  }else
    qoutf("Problemas.");

}

/*
  SetParentChildKey
  Teo. Mexico 2009
*/
void wxh_ObjParams::SetParentChildKey( const PHB_ITEM pParentItm, const PHB_ITEM pChildItm )
{
  wxh_Item* pwxhParentItm = wxh_ItemListGet_PWXH_ITEM( pParentItm );

  if( pwxhParentItm )
  {
    PHB_ITEM pRefItm = hb_itemNew( pChildItm );

    pWxh_Item->map_refList[ pRefItm ] = true;
    pwxhParentItm->map_childList[ pRefItm ] = true;
  }
}

/*
  End Class wxh_ObjParams
*/

/*
  wxh_ItemListDel_WX
  Teo. Mexico 2009
*/
void wxh_ItemListDel_WX( wxObject* wxObj, bool bDeleteWxObj )
{
  wxh_Item* pWxh_Item = wxh_ItemListGet_PWXH_ITEM( wxObj );

  if( pWxh_Item )
  {
    cout << bDeleteWxObj;
    pWxh_Item->delete_WX = bDeleteWxObj;
    delete pWxh_Item;
  }
}

/*
  wxh_ItemListGet_HB
  Teo. Mexico 2009
*/
PHB_ITEM wxh_ItemListGet_HB( wxObject* wxObj )
{
  PHB_ITEM pSelf = NULL;
  wxh_Item* pWxh_Item = wxh_ItemListGet_PWXH_ITEM( wxObj );

  if( pWxh_Item )
  {
    /* search on the parent objects for a reference on his childList */
    if( pWxh_Item->map_refList.size() > 0 )
    {
      pSelf = pWxh_Item->map_refList.begin()->first;
    }else
      pSelf = pWxh_Item->pSelf;

    if( hb_itemType( pSelf ) != HB_IT_OBJECT )
    {
      pSelf = NULL;
    }
  }
//   qout( hb_clsName( pSelf->item.asArray.value->uiClass ) );
  return pSelf;
}

/*
  wxh_ItemListGet_PWXH_ITEM
  Teo. Mexico 2009
*/
wxh_Item* wxh_ItemListGet_PWXH_ITEM( wxObject* wxObj )
{
  wxh_Item* pWxh_Item = NULL;

  if( wxObj && ( map_wxObject.find( wxObj ) != map_wxObject.end() ) )
  {
    pWxh_Item = map_wxObject[ wxObj ];
  }

  return pWxh_Item;
}

/*
  wxh_ItemListGet_PWXH_ITEM
  Teo. Mexico 2009
*/
wxh_Item* wxh_ItemListGet_PWXH_ITEM( PHB_ITEM pSelf )
{
  wxh_Item* pWxh_Item = NULL;

  if( pSelf && ( map_phbBaseArr.find( pSelf->item.asArray.value ) != map_phbBaseArr.end() ) )
  {
    pWxh_Item = map_phbBaseArr[ pSelf->item.asArray.value ];
  }

  return pWxh_Item;
}

/*
  wxh_ItemListGet_WX
  Teo. Mexico 2009
*/
wxObject* wxh_ItemListGet_WX( PHB_ITEM pSelf )
{
  wxObject* wxObj = NULL;

  if( pSelf && ( map_phbBaseArr.find( pSelf->item.asArray.value ) != map_phbBaseArr.end() ) )
  {
    wxObj = map_phbBaseArr[ pSelf->item.asArray.value ]->wxObj;
  }

  return wxObj;
}

/*
  wxh_ItemListReleaseAll
  Teo. Mexico 2009
*/
void wxh_ItemListReleaseAll()
{
  MAP_WXOBJECT::iterator it;
  while( ! map_wxObject.empty() )
  {
    it = map_wxObject.begin();
    //wxh_ItemListDel_WX( it->first );
  }
}

/*
  wxh_param_WX
  Teo. Mexico 2009
*/
wxObject* wxh_param_WX( const int param )
{
  return wxh_ItemListGet_WX( hb_param( param, HB_IT_OBJECT ) );
}

/*
  hb_par_wxArrayString
  Teo. Mexico 2009
*/
wxArrayString hb_par_wxArrayString( int param )
{
  wxArrayString arrayString;

  if( ISARRAY( param ) )
  {
    PHB_ITEM pArray = hb_param( param, HB_IT_ARRAY );
    PHB_ITEM pItm;
    ULONG ulLen = pArray->item.asArray.value->ulLen;
    for( ULONG ulI = 1; ulI <= ulLen; ulI++ )
    {
      pItm = hb_arrayGetItemPtr( pArray, ulI );
      if( hb_itemType( pItm ) && ( HB_IT_STRING || HB_IT_MEMO ) )
      {
        arrayString.Add( wxString( pItm->item.asString.value, wxConvLocal) );
      }
    }
  }

  return arrayString;
}

/*
  hb_par_wxPoint
  Teo. Mexico 2009
*/
wxPoint hb_par_wxPoint( int param )
{
  PHB_ITEM pStruct = hb_param( param, HB_IT_ARRAY );
  if( pStruct && hb_arrayLen( pStruct ) == 2 )
  {
    PHB_ITEM p1,p2;
    p1 = hb_arrayGetItemPtr( pStruct, 1 );
    p2 = hb_arrayGetItemPtr( pStruct, 2 );
    int x = HB_IS_NUMERIC( p1 ) ? p1->item.asInteger.value : -1;
    int y = HB_IS_NUMERIC( p2 ) ? p2->item.asInteger.value : -1;
    return wxPoint( x, y );
  }
  else
    return wxPoint( -1, -1 );
}

/*
  hb_par_wxSize
  Teo. Mexico 2009
*/
wxSize hb_par_wxSize( int param )
{
  PHB_ITEM pStruct = hb_param( param, HB_IT_ARRAY );
  if( pStruct && hb_arrayLen( pStruct ) == 2 )
  {
    PHB_ITEM p1,p2;
    p1 = hb_arrayGetItemPtr( pStruct, 1 );
    p2 = hb_arrayGetItemPtr( pStruct, 2 );
    int x = HB_IS_NUMERIC( p1 ) ? p1->item.asInteger.value : -1;
    int y = HB_IS_NUMERIC( p2 ) ? p2->item.asInteger.value : -1;
    return wxSize( x, y );
  }
  else
    return wxSize( -1, -1 );
}

/*
  wxh_parc
  Teo. Mexico 2009
*/
wxString wxh_parc( int param )
{
  return wxString( hb_parc( param ), wxConvUTF8 );
}

/*
 * wxh_LastTopLevelWindow
 * Teo. Mexico 2009
 */
HB_FUNC( WXH_LASTTOPLEVELWINDOW )
{
  hb_itemReturn( lastTopLevelWindow );
}

/*
  qout
  Teo. Mexico 2009
*/
void qout( const char* text )
{
  static PHB_DYNS s___qout = NULL;

  if( s___qout == NULL )
  {
    s___qout = hb_dynsymGetCase( "QOUT" );
  }
  hb_vmPushDynSym( s___qout );
  hb_vmPushNil();
  hb_vmPushString( text, strlen( text ) );
  hb_vmDo( 1 );
}

/*
  qoutf
  Teo. Mexico 2009
*/
void qoutf( const char* format, ... )
{
  static char text[512];

  va_list argp;

  va_start( argp, format );
  vsprintf( text, format, argp );
  va_end( argp );

  qout( text );
}

static void hb_arrayCloneBody( PHB_BASEARRAY pSrcBaseArray, PHB_BASEARRAY pDstBaseArray, PHB_NESTED_CLONED pClonedList )
{
   PHB_ITEM pSrcItem, pDstItem;
   ULONG ulLen;

   HB_TRACE(HB_TR_DEBUG, ("hb_arrayCloneBody(%p, %p, %p)", pSrcBaseArray, pDstBaseArray, pClonedList));

   pSrcItem = pSrcBaseArray->pItems;
   pDstItem = pDstBaseArray->pItems;

   pDstBaseArray->uiClass = pSrcBaseArray->uiClass;

   for( ulLen = pSrcBaseArray->ulLen; ulLen; --ulLen, ++pSrcItem, ++pDstItem )
      hb_cloneNested( pDstItem, pSrcItem, pClonedList );
}

PHB_ITEM hb_aClone( PHB_BASEARRAY pSrcBaseArray )
{
   PHB_ITEM pDstArray;

   HB_TRACE(HB_TR_DEBUG, ("hb_arrayClone(%p)", pSrcArray));

   pDstArray = hb_itemNew( NULL );
   if( pSrcBaseArray )
   {
      PHB_NESTED_CLONED pClonedList, pCloned;
      ULONG ulSrcLen = pSrcBaseArray->ulLen;

      hb_arrayNew( pDstArray, ulSrcLen );
      pClonedList = ( PHB_NESTED_CLONED ) hb_xgrab( sizeof( HB_NESTED_CLONED ) );
      pClonedList->value = ( void * ) pSrcBaseArray;
      pClonedList->pDest = pDstArray;
      pClonedList->pNext = NULL;

      hb_arrayCloneBody( pSrcBaseArray, pDstArray->item.asArray.value, pClonedList );

      do
      {
         pCloned = pClonedList;
         pClonedList = pClonedList->pNext;
         hb_xfree( pCloned );
      }
      while( pClonedList );
   }
   return pDstArray;
}

HB_FUNC( X_UNREF )
{
  PHB_ITEM pParam = hb_param( 1, HB_IT_OBJECT );

  qoutf( "VALUE: %p, %d", pParam, pParam->item.asArray.value );

  for( int i = -6; i <= 6 ; i++ )
  {
    int j = i;
    PHB_ITEM pLocal = hb_stackLocalVariable( &j );
    qoutf( "value (%d): %p, %d", i, pLocal, pLocal->item.asArray.value );
  }

  if( pParam )
  {
    int j = 1;
    PHB_ITEM pSelf = hb_stackLocalVariable( &j );
    //hb_itemClear( pSelf );
    hb_itemReturnRelease( pSelf );
  }
}