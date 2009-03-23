/*
  wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2008 Teo Fonrouge

  This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

  (C) 2008 Teo Fonrouge <teo@windtelsoft.com>
*/

#include "wx/wx.h"
#include "wxh.h"

HB_FUNC( WXEVT_FIRST )
{
  hb_retnl( wxEVT_COMMAND_BUTTON_CLICKED + hb_parnl(1) - 1 );
}

/*
  wxGetUserId
  Teo. Mexico 2008
*/
HB_FUNC( WXGETUSERID )
{
  hb_retc( wxGetUserId().mb_str() );
}

/*
  wxGetUserName
  Teo. Mexico 2008
*/
HB_FUNC( WXGETUSERNAME )
{
  hb_retc( wxGetUserName().mb_str() );
}

/*
  wxGetOsDescription
  Teo. Mexico 2007
*/
HB_FUNC( WXGETOSDESCRIPTION )
{

  hb_retc( wxGetOsDescription().mb_str() );

};

/*
  wxNow
  Teo. Mexico 2007
*/
HB_FUNC( WXNOW )
{
  hb_retc( wxNow().mb_str() );
}