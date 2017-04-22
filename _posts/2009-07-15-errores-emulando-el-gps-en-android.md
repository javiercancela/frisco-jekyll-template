---
id: 390
title: Errores emulando el GPS en Android
date: 2009-07-15T07:00:47+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=390
categories:
  - android
image: /images/obsolete.jpg
---
<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  Existen dos formas de enviar datos al GPS del emulador de Android: con el DDMS (Dalvik Debug Monitor Service) y con la instrucción &#8216;geo&#8217; de la consola del emulador (como se explica en la documentación [http://developer.android.com/guide/topics/location/index.html#location]). El DDMS es especialmente útil, ya que permite cargar archivos kml o gpx a partir de los cuales enviar actualizaciones periódicas al emulador. Sin embargo, en la versión 1.5 r2 de la SDK de Android hay dos bugs que resultan bastante molestos para desarrollar aplicaciones que usan el GPS.
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  El primero de ellos está relacionado con el formato de las coordenadas enviadas al emulador. Por algún motivo (probablemente relacionado con el caracter usado para separa los decimales, &#8216;,&#8217; en español y &#8216;.&#8217; en inglés) el emulador sólo recibe correctamente las actualizaciones si la configuración regional está establecida a idioma inglés. En realidad no es necesario cambiar la configuración local de todo el sistema. Usando DDMS, basta con establecer la siguiente variable de entorno: &#8216;java_debug=-Duser.language=en&#8217;, o, si usamos el plugin para Eclipse, añadir &#8216;-Duser.language=en&#8217; al eclipse.ini. Más información en la incidencia abierta en Google Code [http://code.google.com/p/android/issues/detail?id=915].
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  El segundo error se produce cuando intentamos enviar varias actualizaciones al GPS del emulador. Por algún motivo las localizaciones enviadas después de la primera no llegan al emulador. Esto significa que el método onLocationChanged sólo será invocado una vez. En la discusión sobre la incidencia abierta [http://code.google.com/p/android/issues/detail?id=2545] se indica una solución provisional: cancelar la subscripción al LocationListener y volverla a subscribir:
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  public void onLocationChanged(Location location) {
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  <span style="white-space:pre;"> </span>mLocationManager.removeUpdates(locationListener);
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  <span style="white-space:pre;"> </span>mLocationManager.requestLocationUpdates(
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  LocationManager.GPS_PROVIDER,
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  3000,
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  1,
</div>

<div id="_mcePaste" style="position:absolute;width:1px;height:1px;top:0;left:-10000px;">
  locationListener);
</div>

Existen dos formas de enviar datos al GPS del emulador de Android: con el DDMS (Dalvik Debug Monitor Service) y con la instrucción &#8216;geo&#8217; de la consola del emulador (como se explica en la [documentación](http://developer.android.com/guide/topics/location/index.html#location)). El DDMS es especialmente útil, ya que permite cargar archivos kml o gpx a partir de los cuales enviar actualizaciones periódicas al emulador. Sin embargo, en la versión 1.5 r2 de la SDK de Android hay dos bugs que resultan bastante incómodos.

**El GPS no recibe ninguna señal**

El primero de ellos está relacionado con el formato de las coordenadas enviadas al emulador. Por algún motivo (probablemente relacionado con el carácter usado para separa los decimales, la coma en español y punto en inglés) el emulador sólo recibe correctamente las actualizaciones si la configuración regional está establecida a idioma inglés.

Para solucionar este problema basta cambiar el _locale_ del runtime de java. Usando DDMS, se establece la siguiente variable de entorno: &#8216;java_debug=-Duser.language=en&#8217;, o, si usamos el plugin para Eclipse, se añade &#8216;-Duser.language=en&#8217; al archivo eclipse.ini. Más información en la [incidencia abierta en Google Code](http://code.google.com/p/android/issues/detail?id=915).

**El GPS sólo recibe la primera localización**

<table border="0" cellspacing="0" cellpadding="2" width="460">
  <tr>
    <td width="458" valign="top">
      <span style="color:#ff0000;">Actualización: La versión 1.5 release 3 de la SDK ya corrige este error</span>
    </td>
  </tr>
</table>

El segundo error se produce cuando intentamos enviar varias actualizaciones al GPS del emulador. Por algún motivo las localizaciones enviadas después de la primera no llegan al emulador. Esto significa que el método onLocationChanged sólo será invocado una vez. En la discusión sobre la [incidencia abierta](http://code.google.com/p/android/issues/detail?id=2545) se indica una solución provisional: cancelar la subscripción al LocationListener y volverla a subscribir:

> <pre>public void onLocationChanged(Location location) {
<span style="white-space:pre;"> </span>mLocationManager.removeUpdates(locationListener);
<span style="white-space:pre;"> </span>mLocationManager.requestLocationUpdates(
LocationManager.GPS_PROVIDER,
3000,
1,
locationListener);
...
}</pre>

No he podido confirmar que este error afecte a todo el mundo que usa la SDK 1.5 r2, aunque sí está bastante extendido. Es de suponer que Google lo corregirá en la próxima revisión de la SDK.