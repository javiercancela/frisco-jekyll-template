---
id: 168
title: 'Un ejemplo de aplicación Java para BlackBerry &#8211; Parte II'
date: 2008-01-11T08:00:25+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/01/11/un-ejemplo-de-aplicacion-java-para-blackberry-parte-ii/
categories:
  - blackberry
  - java-me
image: /images/obsolete.jpg
---
Seguimos examinando la clase abstracta BaseApp.

**Crear un menú**

> `protected void makeMenu( Menu menu, int instance) {<br />
Field focus = UiApplication.getUiApplication().getActiveScreen().getLeafFieldWithFocus();<br />
if(focus != null) {<br />
ContextMenu contextMenu = focus.getContextMenu();<br />
if( !contextMenu.isEmpty()) {<br />
menu.add(contextMenu);<br />
menu.addSeparator();<br />
}<br />
}<br />
menu.add(_closeItem);<br />
}`

La clase [`net.rim.device.api.ui.component.Menu`](http://www.blackberry.com/developers/docs/4.1api/net/rim/device/api/ui/component/Menu.html "Class Menu") representa un menú que se despliega desde la parte superior derecha de la pantalla. Está compuesto por objetos MenuItem, de los que ya hablamos en la entrada anterior.

El método `makeMenu` es invocado cuando se produce un evento que tenga que mostrar el menú, como pulsar el _trackwheel_. En la implementación de las interfaces veremos un ejemplo. Este método, a través del objeto aplicación (`UiApplication.getUiApplication()`), obtiene la pantalla activa (`getActiveScreen()`) y de ella el campo hoja que tiene el foco (`getLeafFieldWithFocus()`). Un campo hoja (_Leaf Field_) es aquel que no actúa de contenedor para otro campo.

Si este campo tiene un menú contextual se añade al menú de la pantalla (el objeto `Menu`, que puede tener ya otros elementos), y tras él un separador y el elemento `_closeItem` que vimos en la entrada anterior.

**Implementación de interfaces**

Ahora vamos a ver los métodos de las otras dos interfaces que implementa nuestra clase, `KeyListener` y `TrackwheelListener`.

> `/* Invoked when the trackwheel is clicked. */<br />
public boolean trackwheelClick( int status, int time ) {<br />
Menu menu = new Menu();<br />
makeMenu( menu, 0);<br />
menu.show();<br />
return true;<br />
}<br />
/* Invoked when the trackwheel is released. */<br />
public boolean trackwheelUnclick( int status, int time ) {<br />
return false;<br />
}<br />
/* Invoked when the trackwheel is rolled. */<br />
public boolean trackwheelRoll(int amount, int status, int time) {<br />
return false;<br />
}`

No hacemos nada cuando se suelta el _trackwheel_ o cuando se gira, pero cuando se pulsa creamos un menú, lo construimos y lo mostramos. Hacerlo en este evento es el comportamiento estándar en una BlackBerry.

> `public boolean keyChar(char key, int status, int time) {<br />
/* Intercept the ESC key and exit the application. */<br />
boolean retval = false;<br />
switch (key) {<br />
case Characters.ESCAPE:<br />
onExit();<br />
System.exit(0);<br />
retval = true;<br />
break;<br />
}<br />
return retval;<br />
}<br />
/* Implementation of KeyListener.keyDown(). */<br />
public boolean keyDown(int keycode, int time) {<br />
return false;<br />
}<br />
/* Implementation of KeyListener.keyRepeat(). */<br />
public boolean keyRepeat(int keycode, int time) {<br />
return false;<br />
}<br />
/* Implementation of KeyListener.keyStatus(). */<br />
public boolean keyStatus(int keycode, int time) {<br />
return false;<br />
}<br />
/* Implementation of KeyListener.keyUp(). */<br />
public boolean keyUp(int keycode, int time) {<br />
return false;<br />
}`

De los eventos de teclado (`keyStatus` se dispara cuando se pulsan Shift o Alt) sólo actuamos en `keyChar`, que se dispara cuando se genera un carácter. En concreto nos interesa comprobar si el carácter es un _Escape_. Si es así, terminamos la aplicación.

**Listado completo de `BaseApp`**

A continuación el listado completo de la clase `BaseApp`, que se utilizará en una próxima entrada para la clase `GPSDemo`.

> `/*<br />
* BaseApp.java<br />
* Copyright (C) 2001-2004 Research In Motion Limited. All rights reserved.<br />
*/`
> 
> `package com.rim.samples.docs.baseapp;`
> 
> `import net.rim.device.api.i18n.*;<br />
import net.rim.device.api.system.*;<br />
import net.rim.device.api.ui.container.*;<br />
import net.rim.device.api.ui.*;<br />
import net.rim.device.api.ui.component.*;`
> 
> `public abstract class BaseApp extends UiApplication implements BaseAppResource, KeyListener, TrackwheelListener {<br />
private MenuItem _closeItem;<br />
private static ResourceBundle _resources =<br />
ResourceBundle.getBundle(BUNDLE_ID, BUNDLE_NAME);<br />
/* Constructor for the abstract base class. */<br />
public BaseApp() {<br />
_closeItem = new MenuItem(_resources, MENUITEM_CLOSE, 200000, 10) {<br />
public void run() {<br />
onExit();<br />
System.exit(0);<br />
}<br />
};<br />
}<br />
/* Override this method to add custom menu items. */<br />
protected void makeMenu( Menu menu, int instance) {<br />
Field focus = UiApplication.getUiApplication().getActiveScreen().getLeafFieldWithFocus();<br />
if(focus != null) {<br />
ContextMenu contextMenu = focus.getContextMenu();<br />
if( !contextMenu.isEmpty()) {<br />
menu.add(contextMenu);<br />
menu.addSeparator();<br />
}<br />
}<br />
menu.add(_closeItem);<br />
}<br />
/* Invoked when the trackwheel is clicked. */<br />
public boolean trackwheelClick( int status, int time ) {<br />
Menu menu = new Menu();<br />
makeMenu( menu, 0);<br />
menu.show();<br />
return true;<br />
}<br />
/* Invoked when the trackwheel is released. */<br />
public boolean trackwheelUnclick( int status, int time ) {<br />
return false;<br />
}<br />
/* Invoked when the trackwheel is rolled. */<br />
public boolean trackwheelRoll(int amount, int status, int time) {<br />
return false;<br />
}<br />
public boolean keyChar(char key, int status, int time) {<br />
/* Intercept the ESC key and exit the application. */<br />
boolean retval = false;<br />
switch (key) {<br />
case Characters.ESCAPE:<br />
onExit();<br />
System.exit(0);<br />
retval = true;<br />
break;<br />
}<br />
return retval;<br />
}<br />
/* Implementation of KeyListener.keyDown(). */<br />
public boolean keyDown(int keycode, int time) {<br />
return false;<br />
}<br />
/* Implementation of KeyListener.keyRepeat(). */<br />
public boolean keyRepeat(int keycode, int time) {<br />
return false;<br />
}<br />
/* Implementation of KeyListener.keyStatus(). */<br />
public boolean keyStatus(int keycode, int time) {<br />
return false;<br />
}<br />
/* Implementation of KeyListener.keyUp(). */<br />
public boolean keyUp(int keycode, int time) {<br />
return false;<br />
}<br />
protected abstract void onExit();<br />
}`

### Entradas relacionadas:
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte I]({% post_url 2008/2008-01-09-un-ejemplo-de-aplicacion-java-para-blackberry-parte-i %})
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte III]({% post_url 2008/2008-01-14-mas-sobre-la-firma-de-aplicaciones-symbian %})
  
[Un ejemplo de aplicación Java para BlackBerry &#8211; Parte IV y final]({% post_url 2008/2008-01-16-un-ejemplo-de-aplicacion-java-para-blackberry-parte-iv-y-final %})