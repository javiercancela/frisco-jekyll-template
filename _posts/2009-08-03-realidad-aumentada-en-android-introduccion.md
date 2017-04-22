---
id: 421
title: 'Realidad aumentada en Android &#8211; Introducción'
date: 2009-08-03T08:00:05+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/?p=421
permalink: /index.php/2009/08/03/realidad-aumentada-en-android-introduccion/
twitter_cards_summary_img_size:
  - 'a:7:{i:0;i:240;i:1;i:188;i:2;i:2;i:3;s:24:"width="240" height="188"";s:4:"bits";i:8;s:8:"channels";i:3;s:4:"mime";s:10:"image/jpeg";}'
categories:
  - android
image: /images/obsolete.jpg
---
<div>
  <strong>¿Qué es la realidad aumentada?</strong>
</div><figure style="width: 240px" class="wp-caption alignright">

[<img class=" " title="Handheld Augmented Reality" src="http://farm4.static.flickr.com/3128/2756996849_b15bb86dac_m_d.jpg" alt="Handheld Augmented Reality" width="240" height="188" />](http://www.flickr.com/photos/jamais_cascio/2756996849/)<figcaption class="wp-caption-text">Buscando descuentos con el móvil</figcaption></figure> 

Un sistema de realidad aumentada es aquel que combina datos generados por ordenador con imágenes del entorno obtenidas en tiempo real. Un sistema básico de realidad aumentada consiste en dispositivo compuesto por una cámara, una fuente de datos y una pantalla donde se muestra la imagen capturada por la cámara con los datos superpuestos. Los datos que aparecen dependerán de la posición y orientación de la cámara, o bien de la presencia en la imagen (y por lo tanto en la escena real) de marcadores que indiquen la información a mostrar.

<div>
  Dos ejemplos para que quede claro de qué estamos hablando:
</div>

<div>
  <ul>
    <li>
      <a id="dkp8" title="Wikitude AR Travel Guide" href="http://www.youtube.com/watch?v=8EA8xlicmT8">Wikitude AR Travel Guide</a>
    </li>
    <li>
      <a id="qps_" title="Augmented Reality Tower Defense" href="http://www.youtube.com/watch?v=zyWVH6jkDHg">Augmented Reality Tower Defense</a>
    </li>
  </ul>
</div>

<div>
  <strong>¿Cómo funciona la realidad aumentada?</strong>
</div>

<div>
  Un sistema de realidad aumentada proporciona información contextual, donde el contexto es el mundo que nos rodea. Añade datos de interés a lo que podemos apreciar a simple vista,  superponiéndolos en la pantalla. No es una ideanueva, pero ha adquirido relevancia en los últimos meses gracias a la aparición de los móviles de última generación, que poseen las características necesarias para hacer funcionar aplicaciones basadas en esta idea:
</div><figure style="width: 240px" class="wp-caption alignright">

[<img title="Augmented Reality" src="http://farm4.static.flickr.com/3433/3215919363_85017cc879_m_d.jpg" alt="" width="240" height="160" />](http://www.flickr.com/photos/sputz/3215919363/)<figcaption class="wp-caption-text">Los seis marcadores de la mesa se conviernte en figuras en la pantalla</figcaption></figure> 

<div>
  <ul>
    <li>
      Una cámara. No es necesario que grabe vídeo, basta con que la pantalla del móvil sirva como visor.
    </li>
    <li>
      Una interfaz de programación que permita acceder a la imagen proporcionada por la cámara.
    </li>
  </ul>
  
  <div>
    Estas dos características bastaría para desarrollar una aplicación de realidad aumentada basada en marcadores. Solo tendríamos que identificar y procesar estos marcadores para sustituirlos por la información apropiada. Sin embargo, dos sensores cada vez más habituales en los dispositivos móviles nos permiten ampliar las posibilidades:
  </div>
  
  <div>
    <ul>
      <li>
        El GPS.
      </li>
      <li>
        El sensor de orientación
      </li>
    </ul>
    
    <div>
      <figure style="width: 240px" class="wp-caption alignleft"><a href="http://www.flickr.com/photos/ericrice/3180390313/"><img title="iPhone Augmented Reality concept" src="http://farm4.static.flickr.com/3500/3180390313_08f8263850_m_d.jpg" alt="" width="240" height="128" /></a><figcaption class="wp-caption-text">La Acrópolis restaurada virtualmente</figcaption></figure> 
      
      <p>
        Imaginemos que queremos diseñar una aplicación de realidad virtual que identifique edificios y lugares de interés turístico, mostrando sobre los mismos su nombre, fecha de construcción, horarios de visita&#8230; En este caso se plantea el problema técnico de mostrar esta información sobre la parte de la pantalla donde se esté viendo el lugar correspondiente. Para ello necesitamos que la información esté geoposicionada (disponer de las coordenadas del lugar), y necesitamos una forma de relacionar estas coordenadas con la posición y la orientación de la cámara, las cuales obtendremos de los sensores del dispositivo.
      </p>
    </div>
    
    <p>
      Esta última parte es la más complicada desde un punto del desarrollador. En los próximos artículos vamos a ver una serie de ejemplos básicos, con código, para hacernos una idea de cómo se podría desarrollar una aplicación de este tipo.
    </p>
  </div>
</div>