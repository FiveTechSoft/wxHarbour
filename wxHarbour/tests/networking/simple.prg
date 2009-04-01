/*
 * Simple
 * Teo. Mexico 2008
 */

#include "hbclass.ch"
#include "property.ch"
#include "wx.ch"
#include "wxharbour.ch"

FUNCTION Main()
  LOCAL MyApp

  MyApp := MyApp():New()

  IMPLEMENT_APP( MyApp )

RETURN NIL

/*
  MyApp
  Teo. Mexico 2008
*/
CLASS MyApp FROM wxApp
PRIVATE:
PROTECTED:
PUBLIC:
  METHOD OnInit
PUBLISHED:
ENDCLASS

/*
  EndClass MyApp
*/

/*
  OnInit
  Teo. Mexico 2008
*/
METHOD FUNCTION OnInit() CLASS MyApp
  LOCAL oWnd
  LOCAL port
  LOCAL ipv4,ipv4_a
  LOCAL socketServer
  LOCAL newConn
  LOCAL s

  port := "27960"

  ipv4 := wxIPV4Address():New()
  ipv4:Service(port)

  socketServer := wxSocketServer():New( ipv4 )

  ipv4:Hostname( "localhost" )

  ? "IP:",ipv4:IPAddress()
  ? "Service:",ipv4:Service()
  ? "IsLocalHost:",ipv4:IsLocalHost()
  ?
  ? "Server OK:",socketServer:IsOk()
  ? "Accepting on port " + port

  newConn := socketServer:Accept( .T. )

  IF newConn != NIL

    ipv4_a := wxIPV4Address():New()

    ? "New Conn Accepted."
    ? "OK:", newConn:IsOk
    ? "GetPeer:",newConn:GetPeer( ipv4_a )
    ? "Hostname/Service:",ipv4_a:Hostname(),ipv4_a:IPAddress,ipv4_a:Service()

    s := "Welcome to this Server..."

    ? "Sending message to the client..."
    newConn:Write( @s, Len( s ) )

    s := Space( 10 )
    ? "Waiting for 10 bytes from the client..."
    newConn:Read( @s, 10 )

    ? "Client answer is: " + s

  ELSE
    ? "Accept connection failed..."
  ENDIF

  CREATE FRAME oWnd ;
         WIDTH 500 HEIGHT 400 ;
         ID 999 ;
         TITLE "Simple"

  oWnd:Show()

  ? "Limpiando oWnd ", @oWnd

  oWnd := NIL

  ? "Saliendo de OnInit..."

RETURN .T.