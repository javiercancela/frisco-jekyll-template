---
title: Notas rápidas sobre la api javascript de Google Maps
date: 2017-04-30 03:00:00 +0200
description: Y otras cosas
categories:
  - javascript
  - google-maps
image: /images/google-maps.jpg
comments: true
---

Algunas notas rápidas sobre Google Maps. Y sobre otras cosas.

## API de Google Maps

Una de las cosas que te da la experiencia es una cierta intuición sobre cómo de difícil es hacer algo que no hayas hecho nunca antes. Y resulta muy molesto cuando esa intuición falla.

Necesitaba una prueba de concepto de una animación del mapa del mundo con javascript. Mi idea era hacerlo con la api de Google Maps, que sólo he utilizado para cosas muy básicas. El planteamiento era el siguiente: una animación de la tierra tal como se ve en Google Earth, que muestre, por ejemplo, Europa con unos indicadores encima; pasado un tiempo la animación hace zoom sobre una ciudad mostrando otros indicadores, tras lo cual se aleja para cambiar de continente y bla bla bla. _Piece of cake_, que dicen los ingleses.

Empiezo a buscar y me encuentro con que [la api de Google Earth ya no está soportada](https://developers.google.com/earth/) (ups!), pero Google Maps tiene un modo 3D nativo que imita el efecto (¡bien!). Así que cojo mi [_key_ de Google Maps](https://developers.google.com/maps/documentation/javascript/get-api-key) y empiezo a probar. "No debería llevar más de media hora", me digo.

<div style="text-align:center">
    <figure>
        <img alt="El mundo según Google Maps. Pero no según su API" src ="/images/google-earth.jpg" />
        <figcaption>El mundo según Google Maps. Pero no según su API</figcaption>
    </figure>
</div>


Pues no se puede. Resulta que el modo 3D de Google Maps no está soportado en mapas embebidos dentro de aplicaciones. Y tampoco es fácil verlo, porque no he encontrado referencias a ello en la docuemtación. Probablemente se pueda en alguna versión futura, pero de momento no.

De hecho, la versión para incrustar está aún más limitada. Después de asumir que no iba a mostrar el mapa del mundo, me puse a jugar con las animaciones en 2D, buscando transiciones entre puntos y niveles de zoom lo más fluidas posible. Lo que descubrí fue que no es posible hacerlas tan fluidas como las que se ven en la página de Google Maps. La única explicación que encontré al respecto es [esta respuesta stackoverflow](http://stackoverflow.com/a/34154254). La web de Google Maps utiliza un objeto _canvas_ para pintar una versión vectorizada del mapa, mientras que la API trae un conjunto de imágenes para cada nivel de zoom. No sé si es correcto, pero es consistente con lo que se observa en las pruebas.

Hay alternativas a la API de Google Maps: [mapbox](https://www.mapbox.com/mapbox-gl-js/api/) (de pago) o  [cesiumjs](https://cesiumjs.org/) (gratuita). Esta última tiene varios orígenes de datos cartográficos posibles, entre ellos los mapas de Bing (Microsoft).

<div style="text-align:center">
    <figure>
        <img alt="El mundo visto a través de Cesium y Bing" src ="/images/cesiumjs.jpg" />
        <figcaption>El mundo visto a través de Cesium y Bing</figcaption>
    </figure>
</div>

## ¿_Mashup_?

Buscando información sobre los mapas me vino a la cabeza la palabra [_mashup_](https://en.wikipedia.org/wiki/Mashup_(web_application_hybrid)), que se utilizaba hace unos años para describir las aplicaciones que mezclan en una aplicación datos obtenidos de otras aplicaciones distintas. El término se usó especialmente con aplicaciones que usaban Google Maps para mostrar todo tipo de información geolocalizada.

Pero mi sensación era que este término dejó de usarse de forma bastante repentina. De hecho, creo que hace años que no me la encuentro es este contexto. Y con motivo, a juzgar por los datos que muestra Google Trends:

<div style="text-align:center">
    <figure>
        <img alt="Evolución del término mashup en los últimos años" src ="/images/mashup-trend.jpg" />
        <figcaption>Evolución del término mashup en los últimos años</figcaption>
    </figure>
</div>

## Zips con javascript en GMail

¿Sabéis otra cosa que Google ya no deja hacer? Descargar desde GMail una zip que contenga javascript. El servidor detecta que el contenido puede ser peligroso y no permite descargarlo. 

Sin embargo, esta limitación parece sólo de la aplicación web. Usando un cliente de correo eletrónico como Thunderbird (que abrí para esto por primera vez desde que instalé Ubuntu) el archivo se desarga sin problemas. Eso sí, contectaros vía IMAP si no queréis descargaros todo el correo que tengáis almacenado en el inbox de GMail (en mi caso, todo el personal correo desde el 2008)

## Visual Studio Code

[Sublime Text 3](https://www.sublimetext.com/3) es un editor estupendo: potente, flexible, multiplataforma y extremadamente rápido. Es superior a las otras opciones que he probado para desarrollo front y Python, creación de documentos Markdown, y gestión de archivos de texto en general.

<div style="text-align:center">
    <figure>
        <img alt="Visual Studio Code, bueno, bonito y barato" src ="/images/vsc.png" />
        <figcaption>Visual Studio Code, bueno, bonito y barato</figcaption>
    </figure>
</div>

Sorprendentemente, la mejora alternativa viene de la mano de Microsoft: [Visual Studio Code](https://code.visualstudio.com/). Gratuito, _open source_, multiplataforma y rápido. Pese al nombre  se parece más a Sublime Text que al [Visual Studio tradicional](https://www.visualstudio.com/es/vs/whatsnew). 

Está orientado al desarrollo desde el inicio, así que incluye de serie depurador para diversos lenguajes, autocompletado, integración con Git... Tiene también un sistema extensiones que permite adaptarlo a casi cualquier necesidad. 

Destaca como entorno de desarrollo _front_, con depuración nativa de javascript, integración con Chrome, _linting_ para diversos sabores de javascript, ... Pero también es una gran herramienta para Python, Go y _scripting_ en general. Totalmente recomendable.
