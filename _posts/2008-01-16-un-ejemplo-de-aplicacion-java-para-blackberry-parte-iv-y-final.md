---
id: 172
title: 'Un ejemplo de aplicación Java para BlackBerry &#8211; Parte IV y final'
date: 2008-01-16T08:00:05+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/01/16/un-ejemplo-de-aplicacion-java-para-blackberry-parte-iv-y-final/
categories:
  - blackberry
  - java-me
image: /images/obsolete.jpg
---
Para la gestión de los waypoints vamos a crear una nueva ventana. Para ello crearemos una nueva clase en el archivo PointScreen.java.

**La clase `PointScreen`**

> `public class PointScreen extends MainScreen implements ListFieldCallback, GPSDemoResResource<br />
{<br />
private Vector _points;<br />
private ListField _listField;<br />
private ResourceBundle _resources;`

`PointScreen` hereda de `MainScreen`, la clase que proporciona la funcionalidad estándar de las ventanas de las aplicaciones BlackBerry. La ventana contendrá una referencia al `ResourceBundle` para la internacionalización de los textos, un objeto `Vector` que almacenará los _waypoints_ y un objeto `ListField`, que se encarga de mostrar en pantalla una lista vertical de _items_ seleccionables. La clase `PointScreen` debe implementar `ListFieldCallback` para manejar los eventos del `ListField`.

> `public PointScreen(Vector points, ResourceBundle resources)<br />
{<br />
_resources = resources;<br />
LabelField title = new LabelField(resources.getString(GPSDEMO_POINTSCREEN_TITLE),<br />
LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);<br />
setTitle(title);<br />
_points = points;<br />
_listField = new ListField();<br />
_listField.setCallback(this);<br />
add(_listField);<br />
reloadWayPointList();<br />
}`
> 
> `private void reloadWayPointList()<br />
{<br />
// Refreshes wayPoint list on screen.<br />
_listField.setSize(_points.size());<br />
}`

El constructor recibe un objeto `Vector` con los _waypoints_ a mostrar, así como la referencia al `ResourceBundle`. Establece el título de la ventana (los parámetros del constructor del `LabelField` indican que se usa todo el ancho de la pantalla, y que si no hay sitio para el texto se acorte con puntos suspensivos), crea el objeto `ListField` y establece al objeto ventana como manejador de los eventos, añade el `ListField` a la ventana y llama al método `reloadWayPointList()`.
  
Este método establece el número de objetos en el `ListField`, provocando que el mismo se redibuje.

**La interfaz `ListFieldCallback`**

> `public void drawListRow(ListField listField, Graphics graphics, int index, int y, int width)<br />
{<br />
if ( listField == _listField && index < _points.size())<br />
{<br />
String name = _resources.getString(GSPDEMO_POINTSCREEN_LISTFIELD_ROWPREFIX) + index;<br />
graphics.drawText(name, 0, y, 0, width);<br />
}<br />
}`

El método `drawListRow` se invoca cada vez que es necesario redibujar el una fila del control `ListField`. Tras cerciorarnos de que el control está creado y de que la fila a dibujar existe, nos limitamos a sacar el texto de `ResourceBundle` (en este caso el texto es &#8220;_Waypoint_&#8220;) y añadirle el índice que tiene en el `Vector`. Luego dibujamos el texto en su posición correspondiente.

> `public Object get(ListField listField, int index)<br />
{<br />
if ( listField == _listField )<br />
{<br />
// If index is out of bounds an exception is thrown,<br />
// but that’s the desired behavior in this case.<br />
return _points.elementAt(index);<br />
}<br />
return null;<br />
}`

El método `get` permite recuperar un objeto del `ListField` a partir de su índice. Está implementado en el ejemplo pese a que no se usa.

> `public int getPreferredWidth(ListField listField)<br />
{<br />
// Use the width of the current LCD.<br />
return Graphics.getScreenWidth();<br />
}`
> 
> `public int indexOfList(ListField listField, String prefix, int start)<br />
{<br />
return -1; // Not implemented.<br />
}`

Los otros dos métodos de la interfaz devuelven el ancho preferido del control (que será el ancho de la pantalla) y el índice del primer objeto que comience por el prefijo indicado (este método no está implementado).

**El menú**

Para el menú, se crea una clase para cada una de los dos opciones que queremos añadir:

> `private class ViewPointAction extends MenuItem<br />
{<br />
private int _index;<br />
public ViewPointAction( int index )<br />
{<br />
super(PointScreen.this._resources.getString(GPSDEMO_POINTSCREEN_MENUITEM_VIEW), 100000, 10);<br />
_index = index;<br />
}<br />
public void run()<br />
{<br />
ViewScreen screen = new ViewScreen( (WayPoint)_points.elementAt(_index), _index, _resources );<br />
UiApplication.getUiApplication().pushModalScreen( screen );<br />
}<br />
}`
> 
> `private class DeletePointAction extends MenuItem<br />
{<br />
private int _index;<br />
public DeletePointAction( int index )<br />
{<br />
super(PointScreen.this._resources.getString(GPSDEMO_POINTSCREEN_MENUITEM_DELETE), 100000, 10);<br />
_index = index;<br />
}`
> 
> `public void run()<br />
{<br />
GPSDemo.removeWayPoint((WayPoint)_points.elementAt(_index));<br />
}<br />
}`
> 
> `protected void makeMenu(Menu menu, int instance)<br />
{<br />
if( _points.size() > 0 )<br />
{<br />
ViewPointAction viewPointAction = new ViewPointAction( _listField.getSelectedIndex() );<br />
menu.add( viewPointAction );<br />
menu.addSeparator();<br />
DeletePointAction deletePointAction = new DeletePointAction( _listField.getSelectedIndex() );<br />
menu.add( deletePointAction );<br />
}<br />
super.makeMenu(menu, instance);<br />
}`

Las dos clases heredan de `MenuItem` e implementan el método run que se ejecutará al invocar la opción de menú correspondiente. El motivo para crear las clases es almacenar, en el momento de creación de las instancias, el índice del elemento del `ListField` seleccionado al invocar el menú. No es la forma más óptima pero sí la más explícita.
  
Cada vez que pulsamos el botón de menú para que este se despliegue, se invoca el método `makeMenu` que construye el mismo. En él creamos los objetos `ViewPointAction` y `DeletePointAction` que sirven de opciones de menú para ver y borrar los _waypoints_. Así, cada vez que invocamos el menú las opciones del mismo hacen referencia al _waypoint_ seleccionado en el `ListField`.
  
La ejecución de `DeletePointAction` se limitá a eleminar el _waypoint_ de la colección (lo hace el método `removeWayPoint` de la clase `GPSDemo`). `ViewPointAction` muestra la información del _waypoint_ seleccionado.

**La clase `ViewScreen`**
  
La información del waypoint se muestra en un nuevo tipo de ventana, la cual se invoca de forma modal a través de `pushModalScreen`.

> `private static class ViewScreen extends MainScreen<br />
{<br />
private ResourceBundle _resources;<br />
private MenuItem _cancel;`
> 
> public ViewScreen(WayPoint point, int count, ResourceBundle resources)
  
> {
  
> super();
  
> _resources = resources;
  
> LabelField title = new LabelField(resources.getString(GPSDEMO\_VIEWSCREEN\_TITLE) + count,
  
> LabelField.ELLIPSIS | LabelField.USE\_ALL\_WIDTH);
  
> setTitle(title);
  
> Date date = new Date(point._startTime);
  
> String startTime = date.toString();
  
> date = new Date(point._endTime);
  
> String endTime = date.toString();
  
> float avgSpeed = point.\_distance/(point.\_endTime &#8211; point._startTime);
  
> add(new BasicEditField(resources.getString(GPSDEMO\_VIEWSCREEN\_STARTFIELD), startTime, 30, Field.READONLY));
  
> add(new BasicEditField(resources.getString(GPSDEMO\_VIEWSCREEN\_ENDFIELD), endTime, 30, Field.READONLY));
  
> add(new BasicEditField(resources.getString(GPSDEMO\_VIEWSCREEN\_HORIZONTALDISTANCEFIELD), Float.toString(point._distance), 30, Field.READONLY));
  
> add(new BasicEditField(resources.getString(GPSDEMO\_VIEWSCREEN\_VERTICALDISTANCEFIELD), Float.toString(point._verticalDistance), 30, Field.READONLY));
  
> add(new BasicEditField(resources.getString(GPSDEMO\_VIEWSCREEN\_AVESPEEDFIELD), Float.toString(avgSpeed), 30, Field.READONLY));
  
> }

El constructor recibe el _waypoint_ y el número que lo identifica (su índice en la colección), construye las fechas, calcula la velocidad y muestra los datos en controles `BasicEditField`.
  
El menú de esta ventana sólo tiene un elemento Cancel. En él se llama a `popScreen` con la instancia de la ventana, ya que al ser una ventana modal no puede permanecer en el stack.

**El código fuente de PointScreen.java**

> `/*<br />
* PointScreen.java<br />
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
import com.rim.samples.docs.resource.*;<br />
import net.rim.device.api.i18n.*;<br />
import javax.microedition.io.*;<br />
import java.util.*;<br />
import java.io.*;<br />
import javax.microedition.location.*;<br />
import com.rim.samples.docs.gpsdemo.GPSDemo.WayPoint;<br />
import com.rim.samples.docs.resource.*;<br />
/*<br />
* PointScreen is a screen derivative that renders the saved WayPoints.<br />
*/<br />
public class PointScreen extends MainScreen implements ListFieldCallback, GPSDemoResResource<br />
{<br />
private Vector _points;<br />
private ListField _listField;<br />
private ResourceBundle _resources;`
> 
> `public PointScreen(Vector points, ResourceBundle resources)<br />
{<br />
_resources = resources;<br />
LabelField title = new LabelField(resources.getString(GPSDEMO_POINTSCREEN_TITLE),<br />
LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);<br />
setTitle(title);<br />
_points = points;<br />
_listField = new ListField();<br />
_listField.setCallback(this);<br />
add(_listField);<br />
reloadWayPointList();<br />
}`
> 
> `private void reloadWayPointList()<br />
{<br />
// Refreshes wayPoint list on screen.<br />
_listField.setSize(_points.size());<br />
}`
> 
> `// ListFieldCallback methods ------------------------------------------------<br />
public void drawListRow(ListField listField, Graphics graphics, int index, int y, int width)<br />
{<br />
if ( listField == _listField && index < _points.size())<br />
{<br />
String name = _resources.getString(GSPDEMO_POINTSCREEN_LISTFIELD_ROWPREFIX) + index;<br />
graphics.drawText(name, 0, y, 0, width);<br />
}<br />
}`
> 
> `public Object get(ListField listField, int index)<br />
{<br />
if ( listField == _listField )<br />
{<br />
// If index is out of bounds an exception is thrown,<br />
// but that’s the desired behavior in this case.<br />
return _points.elementAt(index);<br />
}<br />
return null;<br />
}`
> 
> `public int getPreferredWidth(ListField listField)<br />
{<br />
// Use the width of the current LCD.<br />
return Graphics.getScreenWidth();<br />
}`
> 
> `public int indexOfList(ListField listField, String prefix, int start)<br />
{<br />
return -1; // Not implemented.<br />
}`
> 
> `// Menu items. ---------------------------------------------------------------<br />
private class ViewPointAction extends MenuItem<br />
{<br />
private int _index;<br />
public ViewPointAction( int index )<br />
{<br />
super(PointScreen.this._resources.getString(GPSDEMO_POINTSCREEN_MENUITEM_VIEW), 100000, 10);<br />
_index = index;<br />
}<br />
public void run()<br />
{<br />
ViewScreen screen = new ViewScreen( (WayPoint)_points.elementAt(_index), _index, _resources );<br />
UiApplication.getUiApplication().pushModalScreen( screen );<br />
}<br />
}`
> 
> `private class DeletePointAction extends MenuItem<br />
{<br />
private int _index;<br />
public DeletePointAction( int index )<br />
{<br />
super(PointScreen.this._resources.getString(GPSDEMO_POINTSCREEN_MENUITEM_DELETE), 100000, 10);<br />
_index = index;<br />
}`
> 
> public void run()
  
> {
  
> GPSDemo.removeWayPoint((WayPoint)\_points.elementAt(\_index));
  
> }
  
> }
> 
> `protected void makeMenu(Menu menu, int instance)<br />
{<br />
if( _points.size() > 0 )<br />
{<br />
ViewPointAction viewPointAction = new ViewPointAction( _listField.getSelectedIndex() );<br />
menu.add( viewPointAction );<br />
menu.addSeparator();<br />
DeletePointAction deletePointAction = new DeletePointAction( _listField.getSelectedIndex() );<br />
menu.add( deletePointAction );<br />
}<br />
super.makeMenu(menu, instance);<br />
}<br />
` 
  
> `/**<br />
* Renders a particular Waypoint.<br />
*/<br />
private static class ViewScreen extends MainScreen<br />
{<br />
private ResourceBundle _resources;<br />
private MenuItem _cancel;`
> 
> `public ViewScreen(WayPoint point, int count, ResourceBundle resources)<br />
{<br />
super();<br />
_resources = resources;<br />
LabelField title = new LabelField(resources.getString(GPSDEMO_VIEWSCREEN_TITLE) + count,<br />
LabelField.ELLIPSIS | LabelField.USE_ALL_WIDTH);<br />
setTitle(title);<br />
Date date = new Date(point._startTime);<br />
String startTime = date.toString();<br />
date = new Date(point._endTime);<br />
String endTime = date.toString();<br />
float avgSpeed = point._distance/(point._endTime - point._startTime);<br />
add(new BasicEditField(resources.getString(GPSDEMO_VIEWSCREEN_STARTFIELD), startTime, 30, Field.READONLY));<br />
add(new BasicEditField(resources.getString(GPSDEMO_VIEWSCREEN_ENDFIELD), endTime, 30, Field.READONLY));<br />
add(new BasicEditField(resources.getString(GPSDEMO_VIEWSCREEN_HORIZONTALDISTANCEFIELD), Float.toString(point._distance), 30, Field.READONLY));<br />
add(new BasicEditField(resources.getString(GPSDEMO_VIEWSCREEN_VERTICALDISTANCEFIELD), Float.toString(point._verticalDistance), 30, Field.READONLY));<br />
add(new BasicEditField(resources.getString(GPSDEMO_VIEWSCREEN_AVESPEEDFIELD), Float.toString(avgSpeed), 30, Field.READONLY));<br />
}`
> 
> `private class CancelMenuItem extends MenuItem<br />
{<br />
public CancelMenuItem()<br />
{<br />
// Reuse an identical resource below.<br />
super(ViewScreen.this._resources, GPSDEMO_OPTIONSSCREEN_MENUITEM_CANCEL, 300000, 10);<br />
}<br />
public void run()<br />
{<br />
UiApplication uiapp = UiApplication.getUiApplication();<br />
uiapp.popScreen(ViewScreen.this);<br />
}<br />
};`
> 
> `protected void makeMenu( Menu menu, int instance )<br />
{<br />
if ( _cancel == null )<br />
_cancel = new CancelMenuItem(); // Create on demand.<br />
menu.add(_cancel);<br />
super.makeMenu(menu, instance);<br />
}<br />
}<br />
}`

A partir de aquí, la descripción del código continúa en la serie **Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179)**.

**Entradas relacionadas:**
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte I](http://javiercancela.com/2008/01/09/un-ejemplo-de-aplicacion-java-para-blackberry-parte-i/ "Un ejemplo de aplicación Java para BlackBerry - Parte I")
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte II](http://javiercancela.com/2008/01/11/un-ejemplo-de-aplicacion-java-para-blackberry-parte-ii/ "Un ejemplo de aplicación Java para BlackBerry - Parte II")
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte III](http://javiercancela.com/2008/01/14/un-ejemplo-de-aplicacion-java-para-blackberry-parte-iii/ "Un ejemplo de aplicación Java para BlackBerry - Parte III")
  
[Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) &#8211; Parte I](http://javiercancela.com/2008/01/07/leyendo-nuestro-gps-desde-java-con-la-javame-location-api-jsr-179-parte-i/ "Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) - Parte I")