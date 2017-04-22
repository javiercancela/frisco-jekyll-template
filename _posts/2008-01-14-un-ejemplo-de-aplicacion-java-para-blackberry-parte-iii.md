---
id: 169
title: 'Un ejemplo de aplicación Java para BlackBerry &#8211; Parte III'
date: 2008-01-14T08:00:06+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/01/14/un-ejemplo-de-aplicacion-java-para-blackberry-parte-iii/
permalink: /index.php/2008/01/14/un-ejemplo-de-aplicacion-java-para-blackberry-parte-iii/
categories:
  - blackberry
  - java-me
image: /images/obsolete.jpg
---
Vames a ver ahora una descripción de la aplicación GPSDemo, que viene de ejemplo con la versión 4.1 del JDE de BlackBerry. Esta aplicación nos permite leer el GPS de nuestro dispositivo para mostrar en pantalla información sobre nuestra posición y velocidad, además de grabar durante nuestro recorrido una serie de _waypoints_ que contienen la distancia recorrida, el tiempo y la velocidad media.
  
La aplicación GPSDemo consta de varias clases, agrupadas en dos archivos: GPSDemo.java y `PointScreen.java`. Comenzaremos por el archivo principal.

**GPSDemo.java**

La clase hereda de nuestra clase base `BaseApp`, e implementa la interfaz de los recursos (de la que ya hablamos en la entrada anterior):

> `public class GPSDemo extends BaseApp implements GPSDemoResResource<br />
{`
  
> // Constants. &#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-
  
> // The number of updates in seconds over which the altitude is calculated.
  
> private static final int GRADE_INTERVAL=5;
  
> // com.rim.samples.docs.gpsdemo.GPSDemo.ID
  
> private static final long ID = 0x4e94d9bc9c54fed3L;
  
> private static final int CAPTURE_INTERVAL=10;
  
> // Statics. &#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;
  
> private static ResourceBundle _resources =
  
> ResourceBundle.getBundle(GPSDemoResResource.BUNDLE\_ID, GPSDemoResResource.BUNDLE\_NAME);
  
> // The period of the position query in seconds.
  
> private static int _interval = 1;
  
> private static Vector _previousPoints;
  
> private static float[] _altitudes;
  
> private static float[] _horizontalDistances;

Obtenemos una referencia a los recursos e inicializamos varias variables que usaremos posteriormente. A continuación comprobamos si tenemos datos almacenados en el dispositivo:

> `private static PersistentObject _store;<br />
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
}`

El objeto PersistentStore nos permite persistir información en la BlackBerry a través de pares clave-valor; en este caso utilizamos como clave un ID definido por nostros. Usar este objeto nos obliga a firmar la aplicación para poder instalarla en el dispositivo. De la firma de aplicaciones BlackBerry hablaremos en el futuro.

**Método `main` y constructor** 

> `private long _startTime;<br />
private float _wayHorizontalDistance;<br />
private float _horizontalDistance;<br />
private float _verticalDistance;<br />
private ListField _listField;<br />
private EditField _status;<br />
private StringBuffer _messageString;<br />
private String _oldmessageString;<br />
private LocationProvider _locationProvider;`
> 
> `/* Instantiate the new application object and enter the event loop.<br />
* @param args unsupported. no args are supported for this application<br />
*/<br />
public static void main(String[] args)<br />
{<br />
new GPSDemo().enterEventDispatcher();<br />
}`

La aplicación se inicia en el método estático `main`, que sólo crea una instancia de GPSDemo y pone el thread a la espera de eventos mediante la llamada al método `enterEventDispatcher()`(que se hereda de `BaseApp`, quien lo hereda de `UiApplication` y este a su vez de `Application`, la clase base de las aplicaciones BlackBerry). Vayamos ahora con el constructor:

> `// Constructor<br />
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
}`

Se inicializan variables de instancia y se crea la pantalla principal, a la que añadimos un EditField, que es un campo de texto editable (si no decimos lo contrario en el constructor). Mediante las llamadas a `screen.addKeyListener(this)` y `screen.addTrackwheelListener(this)` le decimos a la pantalla que nosotros (`GPSDemo`) gestionaremos sus eventos de teclado y _trackwheel_, lo cual podemos hacer porque nuestra clase base `BaseApp` implementa las interfaces `KeyListener` y `TrackwheelListener`.
  
Finalmente, añadimos la pantalla a la pila de pantallas. La gestión de ventanas la realiza la clase `UIApplication` como una pila: cuando necesitamos una ventana la metemos en la pila (`pushScreen`) y cuando acabamos con ella la sacamos (`popScreen`). El método `pushScreen` provoca que se pinte la pantalla, así que es importante llamarlo al final, cuando la ventana ya está totalmente construida.

Podemos ver también en el constructor una llamada a `startLocationUpdate()`, pero dejaremos esa parte para más adelante.

**El menú**

Nuestra clase base implementaba una versión básica del método `makeMenu(Menu menu, int instance)`. Sin embargo, nosotros vamos a sustituir (_override_) esta versión con nuestra propia implementación:

> `// Menu items.<br />
// Cache the markwaypoint menu item for reuse.<br />
private MenuItem _markWayPoint = new MenuItem(_resources, GPSDEMO_MENUITEM_MARKWAYPOINT, 110, 10)<br />
{<br />
public void run()<br />
{<br />
GPSDemo.this.markPoint();<br />
}<br />
};`
  
> `<br />
// Cache the view waypoints menu item for reuse.<br />
private MenuItem _viewWayPoints = new MenuItem(_resources, GPSDEMO_MENUITEM_VIEWWAYPOINTS, 110, 10)<br />
{<br />
public void run()<br />
{<br />
GPSDemo.this.viewPreviousPoints();<br />
}<br />
};`
> 
> `// Cache the close menu item for reuse.<br />
private MenuItem _close = new MenuItem(_resources, GPSDEMO_MENUITEM_CLOSE, 110, 10)<br />
{<br />
public void run()<br />
{<br />
System.exit(0);<br />
}<br />
};`
> 
> `protected void makeMenu(Menu menu, int instance)<br />
{<br />
menu.add( _markWayPoint );<br />
menu.add( _viewWayPoints );<br />
menu.add( _close );<br />
menu.addSeparator();<br />
super.makeMenu(menu, instance);<br />
}`

Aparte de mostrar en la pantalla principal información de nuestra posición y velocidad, como veremos más adelante, GPSDemo nos permite crear y gestionar _waypoints_, puntos donde se almacena información sobre la distancia, el tiempo y la velocidad entre una posición y la anterior. Para ello añadimos una opción en el menú que nos permita marcar un _waypoint_ y otra que nos permita acceder a la ventana de gestión de waypoints. Finalmente añadimos un separador y la opción de salir de la aplicación. Se llama después al método de la clase padre, que tenía el código que añadía menús contextuales en caso de hacer click en un control.

**Marcar un _waypoint_**
  
El método al que llama la opción de marcar un _waypoint_ es el siguiente:

> `/* Marks a point in the persistent store. Calculations are based on<br />
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
}`

Se crea un objeto `WayPoint` con la hora en la que se grabó el _waypoint_ anterior, la hora actual, y las distancias horizontal y vertical recorridas. La información de la distancia la establece el código que lee el GPS, que veremos más adelante. La clase `WayPoint` se define dentro de la propia clase `GPSDemo`:

> `/* WayPoint describes a way point, a marker on a journey or point of interest.<br />
* WayPoints are persistable.<br />
* package<br />
*/<br />
static class WayPoint implements Persistable<br />
{<br />
public long _startTime;<br />
public long _endTime;<br />
public float _distance;<br />
public float _verticalDistance;`
  
> `<br />
public WayPoint(long startTime,long endTime,float distance,float verticalDistance)<br />
{<br />
_startTime=startTime;<br />
_endTime=endTime;<br />
_distance=distance;<br />
_verticalDistance=verticalDistance;<br />
}<br />
}`

El wayPoint se añade al vector se declaró al principio de la clase y que se almacena en la flash de la BlackBerry:

> `/* Adds a new WayPoint and commits the set of saved waypoints<br />
* to flash memory.<br />
* @param p The point to add.<br />
*/<br />
/*package*/<br />
synchronized static void addWayPoint(WayPoint p)<br />
{<br />
_previousPoints.addElement(p);<br />
commit();<br />
}<br />
// Commit the waypoint set to flash memory.<br />
private static void commit()<br />
{<br />
_store.setContents(_previousPoints);<br />
_store.commit();<br />
}`

En la siguiente entrada hablaremos de la gestión de los _waypoints_ y de la clase `PointScreen`.

**Entradas relacionadas:**
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte I](http://javiercancela.com/2008/01/09/un-ejemplo-de-aplicacion-java-para-blackberry-parte-i/ "Un ejemplo de aplicación Java para BlackBerry - Parte I")
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte II](http://javiercancela.com/2008/01/11/un-ejemplo-de-aplicacion-java-para-blackberry-parte-ii/ "Un ejemplo de aplicación Java para BlackBerry - Parte II")