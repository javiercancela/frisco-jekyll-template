---
id: 187
title: Cómo mostrar imágenes de mapas en el móvil
date: 2008-02-25T12:47:08+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/02/25/como-mostrar-imagenes-de-mapas-en-el-movil/
permalink: /index.php/2008/02/25/como-mostrar-imagenes-de-mapas-en-el-movil/
categories:
  - Varios
tags:
  - desarrollo móvil
  - geolocalización
  - Google Maps
  - Google Static Maps API
  - Microsoft Visual Earth
  - Yahoo! Map Image API
  - Yahoo! Maps
---
En realidad esta entrada no se centra en cómo mostrar las imágenes, sino en cómo obtenerlas. Imaginemos que queremos programar una aplicación para móviles que se encargue de mostrar información geolocalizada. Existen abundantes APIs web que nos permiten mostrar todo tipo de información sobre un mapa, como las de [Google](http://code.google.com/apis/maps/ "http://code.google.com/apis/maps/"), [Yahoo](http://developer.yahoo.com/maps/ "Yahoo! Maps Web Services") o [Microsoft](http://dev.live.com/virtualearth "Microsoft Virtual Earth™"), por citar sólo las tres más conocidas. El problema es que a estos servicios se accede usando JavaScript o Flash, ya que están pensados para visualizar la información en un navegador. Si no podemos renderizar esta información en nuestra aplicación, por ejemplo por falta de soporte javascript en el dispositivo, necesitamos buscar una alternativa que nos permita mostrar una imagen estática con la misma información.

**Ingeniería inversa**

Una práctica que se utiliza desde hace ya tiempo consiste en acudir a las mismas fuentes que el código Ajax o Flash, ya que al fin y al cabo los mapas que nos muestran los _mash-ups_ habituales están compuestos por imágenes estáticas que se encuentran en algún sitio. Si por ejemplo abrimos la dirección [http://code.google.com/apis/maps/documentation/examples/map-simple.html](http://code.google.com/apis/maps/documentation/examples/map-simple.html "http://code.google.com/apis/maps/documentation/examples/map-simple.html"), que es el mapa de ejemplo de la documentación de Google, con Firefox y el plugin Firebug instalado o una herramienta similar, comprobamos que el mapa está compuesto de imágenes adyacentes, como si fuese un enlosado, cuyas direcciones tiene esta forma: [http://mt2.google.com/mt?n=404&v=ap.69&hl=es&x=1315&y=3175&zoom=4&s=](http://mt2.google.com/mt?n=404&v=ap.69&hl=es&x=1315&y=3175&zoom=4&s= "http://mt2.google.com/mt?n=404&v=ap.69&hl=es&x=1315&y=3175&zoom=4&s=").

<img src="http://mt2.google.com/mt?n=404&v=ap.69&hl=es&x=1315&y=3175&zoom=4&s=" height="256" width="256" />

Los parámetros _x_ e _y_ nos muestran la posición de cada imagen en el enlosado, el _zoom_ es autodescriptivo,&#8230; Con un poco de ingenio y paciencia es posible establecer una relación entre latitud y longitud y esos parámetros, o bien buscar en Internet a quien ya lo haya hecho.

Existen dos pegas a este procedimiento: la primera, que probablemente va contra los términos de uso de la API, así que si lo usamos en nuestras aplicaciones es posible que recibamos un aviso de Google, Yahoo! o Microsoft invitándonos a abandonar esta práctica. La segunda pega es la habitual al utilizar un procedimiento no documentado: en cualquier momento la especificación puede cambiar sin mantener ningún tipo de compatibilidad, inutilizando nuestro código.

**Google Static Maps API**

Una alternativa más segura es la nueva API de Google: la [Static Maps API](http://code.google.com/apis/maps/documentation/staticmaps/index.html "Static Maps API"). Esta API es básicamente una URL que acepta varios parámetros, de la forma [http://maps.google.com/staticmap?center=40.714728,-73.998672&zoom=14&size=512&#215;512&maptype=mobile\ &markers=40.702147,-74.015794,blues%7C40.711614,-74.012318,greeng%7C40.718217,-73.998284,redc\ &key=MAPS\_API\_KEY](http://maps.google.com/staticmap?center=40.714728,-73.998672&zoom=14&size=512x512&maptype=mobile%5C%20&markers=40.702147,-74.015794,blues%7C40.711614,-74.012318,greeng%7C40.718217,-73.998284,redc%5C%20&key=MAPS_API_KEY "http://maps.google.com/staticmap?center=40.714728,-73.998672&zoom=14&size=512x512&maptype=mobile\ &markers=40.702147,-74.015794,blues%7C40.711614,-74.012318,greeng%7C40.718217,-73.998284,redc\ &key=MAPS_API_KEY").

<img src="http://maps.google.com/staticmap?center=51.477222,0&zoom=14&size=400x400&key=ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA" height="400" width="400" />

Estos parámetros están bien documentados y permiten mostrar mapas indicando la posición, el zoom, la presencia de marcadores,&#8230;con la seguridad de que nadie nos va a cambiar los parámetros el mes que viene. La pega: las limitaciones en el número de peticiones a realizar. Cada usuario, y por lo que entiendo en la documentación el usuario es el dueño de la API key, puede hacer 1000 peticiones al día. Como nuestra API key irá en nuestra aplicación, todos nuestros usuarios contarán como el mismo para Google, con lo que esta API no es una solución práctica.

**Yahoo! Map Image API**

Yahoo! también tiene desde hace algún tiempo una API similar a la de Google: la [Map Image API](http://developer.yahoo.com/maps/rest/V1/mapImage.html "Map Image API"). Al igual que la anterior funciona componiendo una URL con parámetros: <http://local.yahooapis.com/MapsService/V1/mapImage?appid=YahooDemo&street=701+First+Avenue&city=Sunnyvale&state=CA> (en este caso lleva parámetros de búsqueda, pero también acepta latitud y longitud). Esta llamada no devuelve directamente una imagen, sino un xml que contiene, esta vez sí, la URL de la imagen solicitada:

`<?xml version="1.0" encoding="UTF-8"?><br />
<Result xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><br />
http://img.maps.yahoo.com/mapimage?MAPDATA=eJz6K.d6wXVM6myr2yRPfx6.kl.uMGgD3Tu4JtDQzr_33pFEsTT<br />
SaosZ9OCtsiDrsLv9t65fzjz0CJm6JO2v_ZIHLflY9gto.xWMK9ovlRJVmrBLO4FoSsh3Ipsr<br />
</Result>`

<img src="http://img.maps.yahoo.com/mapimage?MAPDATA=eJz6K.d6wXVM6myr2yRPfx6.kl.uMGgD3Tu4JtDQzr_33pFEsTTSaosZ9OCtsiDrsLv9t65fzjz0CJm6JO2v_ZIHLflY9gto.xWMK9ovlRJVmrBLO4FoSsh3Ipsr" height="250" width="310" />

La ventaja de la API de Yahoo! es que permite realizar 50000 peticiones por día y por IP, lo que la convierte en la alternativa más interesante de todas.