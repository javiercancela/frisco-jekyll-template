---
id: 175
title: 'Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) &#8211; Parte II'
date: 2008-01-18T08:00:32+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/01/18/leyendo-nuestro-gps-desde-java-con-la-javame-location-api-jsr-179-parte-ii/
permalink: /index.php/2008/01/18/leyendo-nuestro-gps-desde-java-con-la-javame-location-api-jsr-179-parte-ii/
categories:
  - BlackBerry
  - Java ME
tags:
  - AGPS
  - desarrollo móvil
  - GPS
  - JavaME
  - Nokia
---
Esta entrada completa la explicación del ejemplo tratado en la serie de entradas **Un ejemplo de aplicación Java para BlackBerry**. Ver enlaces al final.

**Recapitulando**

GPSDemo es una aplicación para BlackBerry que hace uso de la API JSR-179 para mostrar información de la posición y velocidad obtenidas de un dispositivo GPS o similar (ver la entrada [Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) &#8211; Parte I](http://javiercancela.com/2008/01/07/leyendo-nuestro-gps-desde-java-con-la-javame-location-api-jsr-179-parte-i/ "Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) - Parte I") para una explicación de las posibles fuentes de información).

Habíamos dejado pendiente de describir el método `startLocationUpdate()` que se llama desde el constructor de la clase `GPSDemo`:

> `private void startLocationUpdate()<br />
{<br />
try<br />
{<br />
_locationProvider = LocationProvider.getInstance(null);<br />
if ( _locationProvider == null )<br />
{<br />
Dialog.alert("GPS is not supported on this platform, exiting...");<br />
System.exit(0);<br />
}<br />
_locationProvider.setLocationListener(new LocationListenerImpl(), _interval, 1, 1);<br />
}<br />
catch (LocationException le)<br />
{<br />
System.err.println("Failed to add a location listener. Exiting...");<br />
System.err.println(le);<br />
System.exit(0);<br />
}<br />
}`

Lo primero que hacemos es obtener un proveedor de contenidos, con los criterios por defecto. En caso de no poder obtener uno, salimos de la aplicación.
  
La otra cosa que hace este método es establecer el objeto responsable de escuchar la información que llega del GPS. La variable _internal se estableció previamente al valor 1, con lo que la información se actualizará aproxamadamente una vez por segundo. Los dos últimos parámetros establecen el _timeout_ y la caducidad de los datos.
  
Para actuar como _listener_ del GPS una clase debe implementar la interfaz `LocationListener`.

**La clase `LocationListenerImpl`**

De forma más bien descriptiva, la clase _listener_ de nuestro ejemplo se llama `LocationListenerImpl`:

> `private class LocationListenerImpl implements LocationListener<br />
{<br />
// Members. --------------------------------------------------------------<br />
private int captureCount;`
> 
> `public void providerStateChanged(LocationProvider provider, int newState)<br />
{<br />
// No operation defined.<br />
}<br />
...`

La interfaz tiene dos métodos. providerStateChanged nos avisa de los cambios de estado de nuestro proveedor de localización, básicamente cuando deja de estar disponible por algún tipo de problema; como estamos pensando sólo en el GPS, que no va a quedar fuera de servicio, no implementamos este método.
  
El otro método es el que nos avisa de que el GPS ha suministrado una nueva localización:

> `public void locationUpdated(LocationProvider provider, Location location)<br />
{<br />
if(location.isValid())<br />
{<br />
float heading = location.getCourse();<br />
double longitude = location.getQualifiedCoordinates().getLongitude();<br />
double latitude = location.getQualifiedCoordinates().getLatitude();<br />
float altitude = location.getQualifiedCoordinates().getAltitude();<br />
float speed = location.getSpeed();<br />
// Horizontal distance.<br />
float horizontalDistance = speed * _interval;<br />
_horizontalDistance += horizontalDistance;<br />
// Horizontal distance for this waypoint.<br />
_wayHorizontalDistance += horizontalDistance;<br />
// Distance over the current interval.<br />
float totalDist = 0;<br />
// Moving average grade.<br />
for(int i = 0; i  0) _verticalDistance = _verticalDistance + altGain;<br />
captureCount += _interval;<br />
// If we’re mod zero then it’s time to record this data.<br />
captureCount %= CAPTURE_INTERVAL;<br />
// Information to display on the device.<br />
StringBuffer sb = new StringBuffer();<br />
sb.append("Longitude: " + longitude+ "\n");<br />
sb.append("Latitude: " + latitude+ "\n");<br />
sb.append("Altitude: " + altitude + " m\n");<br />
sb.append("Heading relative to true north: " + heading + "\n");<br />
sb.append("Speed : " + speed + +" m/s\n");<br />
sb.append("Grade : ");<br />
if(Float.isNaN(grade))<br />
sb.append(" Not available");<br />
else<br />
sb.append(grade+" %");<br />
GPSDemo.this.updateLocationScreen(sb.toString());<br />
}<br />
}`

Mucho código, pero muy simple. Se nos pasa como parámetros el `LocationProvider`, que no necesitamos, y un objeto `Location` que contiene, además de las coordenadas, la velocidad, la dirección y un método (`isValid()`) que nos dice si el objeto Location tiene coordenadas o no. En caso de utilizar como proveedor de contenidos un servicio de pago del operador, podríamos tener información adicional en el mismo objeto, como una dirección postal.

**Código de GPSDemo.java**

> `/**<br />
* A GPS sample application using the JSR 179 APIs.<br />
*<br />
* Copyright (C) 2005 Research In Motion Limited.<br />
*/<br />
package com.rim.samples.docs.gpsdemo;<br />
import net.rim.device.api.ui.*;<br />
import net.rim.device.api.ui.component.*;<br />
import net.rim.device.api.ui.container.*;<br />
import com.rim.samples.docs.baseapp.*;<br />
import net.rim.device.api.io.*;<br />
import net.rim.device.api.system.*;<br />
import net.rim.device.api.i18n.*;<br />
import javax.microedition.io.*;<br />
import java.util.*;<br />
import java.io.*;<br />
import javax.microedition.location.*;<br />
import net.rim.device.api.util.*;<br />
import com.rim.samples.docs.resource.*;<br />
/* This application acts as a simple travel computer, recording route coordinates,<br />
* speed, and altitude.<br />
* Recording begins as soon as the application is invoked.<br />
*/<br />
public class GPSDemo extends BaseApp implements GPSDemoResResource<br />
{<br />
// Constants. ----------------------------------------------------------------<br />
// The number of updates in seconds over which the altitude is calculated.<br />
private static final int GRADE_INTERVAL=5;<br />
// com.rim.samples.docs.gpsdemo.GPSDemo.ID<br />
private static final long ID = 0x4e94d9bc9c54fed3L;<br />
private static final int CAPTURE_INTERVAL=10;<br />
// Statics. ------------------------------------------------------------------<br />
private static ResourceBundle _resources =<br />
ResourceBundle.getBundle(GPSDemoResResource.BUNDLE_ID, GPSDemoResResource.BUNDLE_NAME);<br />
// The period of the position query in seconds.<br />
private static int _interval = 1;<br />
private static Vector _previousPoints;<br />
private static float[] _altitudes;<br />
private static float[] _horizontalDistances;<br />
private static PersistentObject _store;<br />
// Initialize or reload the persistent store.<br />
static<br />
{<br />
_store = PersistentStore.getPersistentObject(ID);<br />
if(_store.getContents()==null)<br />
{<br />
_previousPoints= new Vector();<br />
_store.setContents(_previousPoints);<br />
}<br />
_previousPoints=(Vector)_store.getContents();<br />
}<br />
private long _startTime;<br />
private float _wayHorizontalDistance;<br />
private float _horizontalDistance;<br />
private float _verticalDistance;<br />
private ListField _listField;<br />
private EditField _status;<br />
private StringBuffer _messageString;<br />
private String _oldmessageString;<br />
private LocationProvider _locationProvider;<br />
/* Instantiate the new application object and enter the event loop.<br />
* @param args unsupported. no args are supported for this application<br />
*/<br />
public static void main(String[] args)<br />
{<br />
new GPSDemo().enterEventDispatcher();<br />
}<br />
// Constructors. -------------------------------------------------------------<br />
public GPSDemo()<br />
{<br />
// Used by waypoints; represents the time since the last waypoint.<br />
_startTime = System.currentTimeMillis();<br />
_altitudes=new float[GRADE_INTERVAL];<br />
_horizontalDistances=new float[GRADE_INTERVAL];<br />
_messageString= new StringBuffer();<br />
MainScreen screen = new MainScreen();<br />
screen.setTitle(new LabelField(_resources.getString(GPSDEMO_TITLE), LabelField.USE_ALL_WIDTH));<br />
_status = new EditField();<br />
screen.add(_status);<br />
screen.addKeyListener(this);<br />
screen.addTrackwheelListener(this);<br />
// Start the GPS thread that listens for updates.<br />
startLocationUpdate();<br />
// Render our screen.<br />
pushScreen(screen);<br />
}<br />
/* Update the GUI with the data just received.<br />
*/<br />
private void updateLocationScreen(final String msg)<br />
{<br />
invokeLater(new Runnable()<br />
{<br />
public void run()<br />
{<br />
_status.setText(msg);<br />
}<br />
});<br />
}<br />
// Menu items. ---------------------------------------------------------------<br />
// Cache the markwaypoint menu item for reuse.<br />
private MenuItem _markWayPoint = new MenuItem(_resources, GPSDEMO_MENUITEM_MARKWAYPOINT, 110, 10)<br />
{<br />
public void run()<br />
{<br />
GPSDemo.this.markPoint();<br />
}<br />
};<br />
// Cache the view waypoints menu item for reuse.<br />
private MenuItem _viewWayPoints = new MenuItem(_resources, GPSDEMO_MENUITEM_VIEWWAYPOINTS, 110, 10)<br />
{<br />
public void run()<br />
{<br />
GPSDemo.this.viewPreviousPoints();<br />
}<br />
};<br />
// Cache the close menu item for reuse.<br />
private MenuItem _close = new MenuItem(_resources, GPSDEMO_MENUITEM_CLOSE, 110, 10)<br />
{<br />
public void run()<br />
{<br />
System.exit(0);<br />
}<br />
};<br />
protected void makeMenu(Menu menu, int instance)<br />
{<br />
menu.add( _markWayPoint );<br />
menu.add( _viewWayPoints );<br />
menu.add( _close );<br />
menu.addSeparator();<br />
super.makeMenu(menu, instance);<br />
}<br />
/* Invokes the Location API with the default criteria.<br />
*/<br />
private void startLocationUpdate()<br />
{<br />
try<br />
{<br />
_locationProvider = LocationProvider.getInstance(null);<br />
if ( _locationProvider == null )<br />
{<br />
Dialog.alert("GPS is not supported on this platform, exiting...");<br />
System.exit(0);<br />
}<br />
// A single listener can be associated with a provider,<br />
// and unsetting it involves the same call but with null,<br />
// so there is no need to cache the listener instance.<br />
// Request an update every second.<br />
_locationProvider.setLocationListener(new LocationListenerImpl(), _interval, 1, 1);<br />
}<br />
catch (LocationException le)<br />
{<br />
System.err.println("Failed to add a location listener. Exiting...");<br />
System.err.println(le);<br />
System.exit(0);<br />
}<br />
}<br />
/* Marks a point in the persistent store. Calculations are based on<br />
* all data collected since the previous way point, or from the start<br />
* of the application if no previous waypoints exist.<br />
*/<br />
private void markPoint()<br />
{<br />
long current = System.currentTimeMillis();<br />
WayPoint p= new WayPoint(_startTime, current, _wayHorizontalDistance, _verticalDistance);<br />
addWayPoint(p);<br />
// Reset the waypoint variables.<br />
_startTime = current;<br />
_wayHorizontalDistance = 0;<br />
_verticalDistance = 0;<br />
}<br />
// View the saved waypoints.<br />
private void viewPreviousPoints()<br />
{<br />
PointScreen pointScreen = new PointScreen(_previousPoints, _resources);<br />
pushScreen(pointScreen);<br />
}<br />
// Called by the framework when this application is losing focus.<br />
protected void onExit()<br />
{<br />
if ( _locationProvider != null )<br />
{<br />
_locationProvider.reset();<br />
_locationProvider.setLocationListener(null, -1, -1, -1);<br />
}<br />
}<br />
/* Adds a new WayPoint and commits the set of saved waypoints<br />
* to flash memory.<br />
* @param p The point to add.<br />
*/<br />
/*package*/<br />
synchronized static void addWayPoint(WayPoint p)<br />
{<br />
_previousPoints.addElement(p);<br />
commit();<br />
}<br />
/* Removes a waypoint from the set of saved points and<br />
* commits the modifed set to flash memory.<br />
* @param p the point to remove<br />
*/<br />
/*package*/<br />
synchronized static void removeWayPoint(WayPoint p)<br />
{<br />
_previousPoints.removeElement(p);<br />
commit();<br />
}<br />
// Commit the waypoint set to flash memory.<br />
private static void commit()<br />
{<br />
_store.setContents(_previousPoints);<br />
_store.commit();<br />
}<br />
/* Implementation of the LocationListener interface.<br />
*/<br />
private class LocationListenerImpl implements LocationListener<br />
{<br />
// Members. --------------------------------------------------------------<br />
private int captureCount;<br />
// Methods. --------------------------------------------------------------<br />
public void locationUpdated(LocationProvider provider, Location location)<br />
{<br />
if(location.isValid())<br />
{<br />
float heading = location.getCourse();<br />
double longitude = location.getQualifiedCoordinates().getLongitude();<br />
double latitude = location.getQualifiedCoordinates().getLatitude();<br />
float altitude = location.getQualifiedCoordinates().getAltitude();<br />
float speed = location.getSpeed();<br />
// Horizontal distance.<br />
float horizontalDistance = speed * _interval;<br />
_horizontalDistance += horizontalDistance;<br />
// Horizontal distance for this waypoint.<br />
_wayHorizontalDistance += horizontalDistance;<br />
// Distance over the current interval.<br />
float totalDist = 0;<br />
// Moving average grade.<br />
for(int i = 0; i  0) _verticalDistance = _verticalDistance + altGain;<br />
captureCount += _interval;<br />
// If we’re mod zero then it’s time to record this data.<br />
captureCount %= CAPTURE_INTERVAL;<br />
// Information to display on the device.<br />
StringBuffer sb = new StringBuffer();<br />
sb.append("Longitude: " + longitude+ "\n");<br />
sb.append("Latitude: " + latitude+ "\n");<br />
sb.append("Altitude: " + altitude + " m\n");<br />
sb.append("Heading relative to true north: " + heading + "\n");<br />
sb.append("Speed : " + speed + +" m/s\n");<br />
sb.append("Grade : ");<br />
if(Float.isNaN(grade))<br />
sb.append(" Not available");<br />
else<br />
sb.append(grade+" %");<br />
GPSDemo.this.updateLocationScreen(sb.toString());<br />
}<br />
}<br />
public void providerStateChanged(LocationProvider provider, int newState)<br />
{<br />
// No operation defined.<br />
}<br />
}<br />
/* WayPoint describes a way point, a marker on a journey or point of interest.<br />
* WayPoints are persistable.<br />
* package<br />
*/<br />
static class WayPoint implements Persistable<br />
{<br />
public long _startTime;<br />
public long _endTime;<br />
public float _distance;<br />
public float _verticalDistance;<br />
public WayPoint(long startTime,long endTime,float distance,float verticalDistance)<br />
{<br />
_startTime=startTime;<br />
_endTime=endTime;<br />
_distance=distance;<br />
_verticalDistance=verticalDistance;<br />
}<br />
}<br />
}`

**Entradas relacionadas:**
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte I](http://javiercancela.com/2008/01/09/un-ejemplo-de-aplicacion-java-para-blackberry-parte-i/ "Un ejemplo de aplicación Java para BlackBerry - Parte I")
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte II](http://javiercancela.com/2008/01/11/un-ejemplo-de-aplicacion-java-para-blackberry-parte-ii/ "Un ejemplo de aplicación Java para BlackBerry - Parte II")
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte III](http://javiercancela.com/2008/01/14/un-ejemplo-de-aplicacion-java-para-blackberry-parte-iii/ "Un ejemplo de aplicación Java para BlackBerry - Parte III")
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte IV y final](http://javiercancela.com/2008/01/16/un-ejemplo-de-aplicacion-java-para-blackberry-parte-iv-y-final/ "Un ejemplo de aplicación Java para BlackBerry - Parte IV y final")
  
[Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) &#8211; Parte I](http://javiercancela.com/2008/01/07/leyendo-nuestro-gps-desde-java-con-la-javame-location-api-jsr-179-parte-i/ "Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) - Parte I")