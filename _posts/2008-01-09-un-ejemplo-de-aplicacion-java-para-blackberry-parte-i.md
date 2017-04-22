---
id: 166
title: 'Un ejemplo de aplicación Java para BlackBerry &#8211; Parte I'
date: 2008-01-09T08:00:23+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/01/09/un-ejemplo-de-aplicacion-java-para-blackberry-parte-i/
permalink: /index.php/2008/01/09/un-ejemplo-de-aplicacion-java-para-blackberry-parte-i/
categories:
  - BlackBerry
  - Java ME
tags:
  - desarrollo móvil
  - Java
  - JavaME
---
**Introducción**

Vamos a hacer un repaso de la estructura y funcionamiento de una aplicación simple para BlackBerry. Para ello nos vamos a basar en un ejemplo de la [_BlackBerry Application Developer Guide_](http://www.blackberry.com/knowledgecenterpublic/livelink.exe/BlackBerry_Application_Developer_Guide_Volume_1.pdf?func=doc.Fetch&nodeId=1007336&docTitle=BlackBerry+Application+Developer+Guide+Volume+1 "BlackBerry Application Developer Guide Volume 1") ([_Vol. 2_](http://www.blackberry.com/knowledgecenterpublic/livelink.exe/BlackBerry_Application_Developer_Guide_Volume_2.pdf?func=doc.Fetch&nodeId=1007339&docTitle=BlackBerry+Application+Developer+Guide+Volume+2 "BlackBerry Application Developer Guide Volume 2")), en concreto el ejemplo _GPSDemo_, que utilizaremos posteriormente para enlazar con la serie de entradas sobre programación de GPS.

El código fuente de dicho ejemplo, así como el de los demás ejemplos de la guía, está disponible aquí: [_BlackBerry Application Developer Guide Samples_](http://www.blackberry.com/knowledgecentersupport/kmsupport/supportknowledgebase/files/BlackBerry_Application_Developer_Guide_samples402.zip "BlackBerry Application Developer Guide Samples").

**La clase `BaseApp`**

Para el desarrollo de la aplicación se define una clase abstracta, llamada `BaseApp`:

> `package com.rim.samples.docs.baseapp;<br />
import net.rim.device.api.i18n.*;<br />
import net.rim.device.api.system.*;<br />
import net.rim.device.api.ui.container.*;<br />
import net.rim.device.api.ui.*;<br />
import net.rim.device.api.ui.component.*;`
> 
> `public abstract class BaseApp extends UiApplication implements BaseAppResource, KeyListener, TrackwheelListener {<br />
...`

La clase hereda de `net.rim.device.api.ui.UiApplication`, que es la clase de la que heredan las aplicaciones que tienen interfaz de usuario. Implementa las interfaces `KeyListener` y `TrackwheelListener`, que veremos más tarde, y `BaseAppResource`, una interfaz especial creada por los archivos de recursos, que se usa para internacionalizar las aplicaciones. Esta interfaz tiene un aspecto como este:

> `package com.rim.samples.docs.baseapp;`
> 
> `public interface BaseAppResource {<br />
// Hash of: "com.rim.samples.docs.baseapp.BaseApp".<br />
long BUNDLE_ID = 0xb2bbab4764b0c17eL;<br />
String BUNDLE_NAME = "com.rim.samples.docs.baseapp.BaseApp";<br />
int MENUITEM_CLOSE = 0;<br />
}`

**Internacionalización de la aplicación**

Siguiendo con la clase `BaseApp`:

> `...<br />
private MenuItem _closeItem;<br />
private static ResourceBundle _resources =<br />
ResourceBundle.getBundle(BUNDLE_ID, BUNDLE_NAME);<br />
...`

Declaramos una variable para una de las opciones del menú, en concreto la opción _Close_, que cerrará la aplicación. `_resources` es una variable estática que nos dará acceso a los recursos definidos para la internacionalización de la aplicación. Esta internacionalización consiste, básicamente, en un archivo .rrh donde definimos los recursos (cadenas de texto) que queremos internacionalizar, y un archivo .rrc por idioma donde mostramos el texto para el idioma correspondiente.

En nuestro caso, sólo vamos a hacer una versión inglesa, pero dejaremos abierta la opción a una futura internacionalización. Definimos un archivo con los recursos a internacionalizar (en este caso, sólo el texto del menú _Close_) en el archivo BaseApp.rhh:

> `package com.rim.samples.docs.baseapp;<br />
MENUITEM_CLOSE#0=0;`

Y definimos el texto en el archivo BaseApp.rrc:

> `MENUITEM_CLOSE#0="Close";`

El entorno de desarrollo JDE nos proporciona una edición visual de estos archivos. Podemos encontrar una explicación detallada en la [guía de desarrollo](http://www.blackberry.com/knowledgecenterpublic/livelink.exe/BlackBerry_Java_Development_Environment_Development_Guide.pdf?func=doc.Fetch&nodeId=1381409&docTitle=BlackBerry+Java+Development+Environment+Development+Guide "Document 	 BlackBerry Java Development Environment Development Guide").

**Constructor**

> `public BaseApp() {<br />
_closeItem = new MenuItem(_resources, MENUITEM_CLOSE, 200000, 10) {<br />
public void run() {<br />
onExit();<br />
System.exit(0);<br />
}<br />
};<br />
}`

Este constructor crea un objeto `MenuItem` en la variable anteriormente declarada. A través del objeto `_recources` y la etiqueta `MENUITEM_CLOSE` definimos el texto del menú. El tercer parámetro sirve para ordenar los elementos en el menú: cuanto más bajo el número más arriba en el menú. El número es muy elevado porque querremos que el elemento _Close_ esté el último en el menú.

Para explicar el último parámetro y el código posterior, hay que tener en cuenta que la clase `MenuItem` implementa la interfaz `Runnable`. O más bien la declara, porque es una clase abstracta, y la implementación de `Runnable` debemos proporcionarla nosotros. Típicamente crearíamos una subclase que heredase de `MenuItem` e implementase el método `run()` de `Runnable`, pero en este caso hemos optado por una solución más simple: implementar `run()` en la creación del objeto.

Es decir, lo que hace el constructor es crear un punto de entrada para la activación del objeto `MenuItem` que acaba de crear. Como queremos que sea una opción de _Close_, lo que haremos será llamar a un método `onExit()` y luego `System.exit(0)`. ¿Por qué la llada a `onExit()`? Porque estamos en una clase abstracta, así que definimos un método `onExit()` abstracto que obligue a cualquier subclase a implementarlo con el código que quiera ejecutar a la salida de la aplicación. Si luego no quiere salir con `System.exit(0)`, ya lo hacemos nosotros.

Seguiremos hablando de la clase `BaseApp` en una próxima entrada.