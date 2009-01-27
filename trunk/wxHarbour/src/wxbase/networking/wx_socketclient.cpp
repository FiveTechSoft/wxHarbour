/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2008 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2008 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
  wx_SocketClient: Implementation
  Teo. Mexico 2008
*/

#include "wx/wx.h"
#include "wxh.h"

#include "wxbase/wx_socketclient.h"

/*
  ~wx_SocketClient
  Teo. Mexico 2008
*/
wx_SocketClient::~wx_SocketClient()
{
  wxh_ItemListDel_WX( this );
}

/*
  Constructor: Object
  Teo. Mexico 2008
*/
HB_FUNC( WXSOCKETCLIENT_NEW )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  WXH_SCOPELIST wxhScopeList = WXH_SCOPELIST( pSelf );

  wx_SocketClient* socketClient;
  wxSocketFlags flags = ISNUM( 1 ) ? hb_parni( 1 ) : wxSOCKET_NONE;

  socketClient = new wx_SocketClient( flags );

  // Add object's to hash list
  //wxh_ItemListAdd( socketClient, pSelf );
  wxh_SetScopeList( socketClient, &wxhScopeList );

  hb_itemReturn( pSelf );

}

/*
  bool Connect
  Teo. Mexico 2008
*/
HB_FUNC( WXSOCKETCLIENT_CONNECT )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  WXH_SCOPELIST wxhScopeList = WXH_SCOPELIST( pSelf );
  wx_SocketClient* socketClient = (wx_SocketClient*) wxh_ItemListGetWX( pSelf );

  wxSockAddress* local = NULL;
  bool paramFail;

  char callingMode;

  wxSockAddress* address = (wxSockAddress *) hb_par_WX( 1, &wxhScopeList );

  if( ISLOG( 2 ) || ISNIL( 2 ) )
  {
    callingMode = 1;
    paramFail = !address;
  }
  else
  {
    callingMode = 2;
    local = (wxSockAddress *) hb_par_WX( 2, &wxhScopeList );
    paramFail = !address && !local;
  }

  if( paramFail )
  {
//     hb_errRT_BASE_SubstR( EG_ARG, 3012, "WXSOCKETCLIENT:", &hb_errFuncName, HB_ERR_ARGS_BASEPARAMS );
    return;
  }

  if( socketClient )
  {
    if( callingMode == 1 )
      hb_retl( socketClient->Connect( *address, ISLOG( 2 ) ? hb_parl( 2 ) : true ) );
    else
      hb_retl( socketClient->Connect( *address, *local, ISLOG( 3 ) ? hb_parl( 3 ) : true ) );
  }
}

/*
  bool WaitOnConnect
  Teo. Mexico 2008
*/
HB_FUNC( WXSOCKETCLIENT_WAITONCONNECT )
{
  PHB_ITEM pSelf = hb_stackSelfItem();
  wx_SocketClient* socketClient = (wx_SocketClient*) wxh_ItemListGetWX( pSelf );

  if( socketClient )
  {
    long seconds = ISNUM( 1 ) ? hb_parnl( 1 ) : -1;
    long millisecond = hb_parnl( 2 );
    hb_retl( socketClient->WaitOnConnect( seconds, millisecond ) );
  }
}
