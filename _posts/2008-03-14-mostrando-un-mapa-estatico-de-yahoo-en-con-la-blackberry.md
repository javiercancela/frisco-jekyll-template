---
id: 192
title: Mostrando un mapa estático de Yahoo! en con la BlackBerry
date: 2008-03-14T07:30:31+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/03/14/mostrando-un-mapa-estatico-de-yahoo-en-con-la-blackberry/
permalink: /index.php/2008/03/14/mostrando-un-mapa-estatico-de-yahoo-en-con-la-blackberry/
categories:
  - blackberry
image: /images/obsolete.jpg
---
Veíamos en un artículo anterior ([Cómo mostrar imágenes de mapas en el móvil](http://javiercancela.com/2008/02/25/como-mostrar-imagenes-de-mapas-en-el-movil/ "Cómo mostrar imágenes de mapas en el móvil")) distintas opciones para mostrar mapas estáticos (simples imágenes de mapas, nada de JavaScript). Vamos a ver con un poco de código cómo utilizar la Yahoo! Map Image API en BlackBerry (que con algunos cambios se podrá adaptar a cualquier aplicación Java ME).

La API acepta varios parámetros para elegir la ubicación del mapa a mostrar, y nosotros vamos a utilizar como parámetros la longitud y latitud del punto central, así como el nivel de zoom y el tamaño de la imagen:

> `String url = "http://local.yahooapis.com/MapsService/V1/mapImage?appid=mi_yahoo_appid"`
  
>  `+ "&latitude=" + latitude + "&longitude=" + longitude +<br />
"&image_height=" + height + "&image_width=" + width + "&zoom=" + zoom;`

El parámetro `mi_yahoo_appid` es nuestro id de aplicación de Yahoo!, que se puede obtener gratuitamente aquí: [_Yahoo! Application ID_](http://developer.yahoo.com/wsregapp/index.php "Yahoo! Application ID"). Con la url formada podemos realizar la llamada a la API.

> `StreamConnection s = (StreamConnection)Connector.open(url);<br />
HttpConnection httpConn = (HttpConnection)s;<br />
int status = httpConn.getResponseCode();<br />
if (status == HttpConnection.HTTP_OK)<br />
{<br />
try<br />
{<br />
DocumentBuilder doc = DocumentBuilderFactory.newInstance().newDocumentBuilder();<br />
DataInputStream dis = s.openDataInputStream();<br />
Document d = doc.parse(dis);<br />
Element el = d.getDocumentElement();<br />
url = el.getFirstChild().getNodeValue() ;<br />
dis.close();<br />
}<br />
catch(SAXException e)<br />
{<br />
System.err.println(e.toString());<br />
}<br />
catch(ParserConfigurationException e)<br />
{<br />
System.err.println(e.toString());<br />
}`

Realizamos la conexión de forma normal, y si todo ha ido bien Yahoo! nos devolverá un documento XML:

> `<?xml version="1.0" encoding="UTF-8"?><br />
<Result xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><br />
http://img.maps.yahoo.com/mapimage?MAPDATA=eJz6K.d6wXVM6myr2yRPfx6.kl.uMGgD3Tu4JtDQzr_33pFEsTT<br />
SaosZ9OCtsiDrsLv9t65fzjz0CJm6JO2v_ZIHLflY9gto.xWMK9ovlRJVmrBLO4FoSsh3Ipsr<br />
</Result>`

Este documento contiene un único elemento, cuyo texto es otra url que contiene la imagen solicitada en formato PNG. Para acceder a esta url, en el _package_ `net.rim.device.api.xml.parsers` encontramos la clase `DocumentBuilder`, que nos permite convertir un `InputStream` en un objeto `Document` de `org.w3c.dom`, a partir del cual accedemos fácilmente al valor del elemento. Con esta segunda url volvemos a abrir una conexión:

> `s = (StreamConnection)Connector.open(url);<br />
httpConn = (HttpConnection)s;<br />
status = httpConn.getResponseCode();<br />
if (status == HttpConnection.HTTP_OK)<br />
{<br />
java.io.InputStream input = s.openInputStream();<br />
byte[] data = new byte[1];<br />
ByteVector bv = new ByteVector();<br />
while ( -1 != input.read(data) )<br />
{<br />
bv.addElement(data[0]);<br />
}<br />
Bitmap bitmap = Bitmap.createBitmapFromPNG(bv.getArray(), 0, -1);<br />
// Mostramos la imagen almacenada en el bitmap<br />
}`

Esta vez utilizamos el flujo de bytes devuelto para crear un `Bitmap`. No podemos utilizar el método `getLength()` de la conexión para averiguar el número de bytes total porque las cabeceras de la página no incluyen el campo Content-Length. Así que recorremos byte byte el stream para obtener un array de bytes con el que generar el `Bitmap`.
  
Ya tenemos nuestro `Bitmap` para mostrar. Bastará añadir, por ejemplo, un `BitmapField` y asignarle el `Bitmap` recién creado.