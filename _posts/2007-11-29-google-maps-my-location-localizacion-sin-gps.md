---
id: 141
title: 'Google Maps My Location: Localización sin GPS'
date: 2007-11-29T12:05:00+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/29/google-maps-my-location-localizacion-sin-gps/
permalink: /index.php/2007/11/29/google-maps-my-location-localizacion-sin-gps/
categories:
  - lbs
image: /images/obsolete.jpg
---
La última versión de [Google Maps para móviles](http://www.google.com/gmm/index.html "Google Maps Mobile") incorpora una nueva característica (en beta, por supuesto) llamada _[My Location](http://www.google.com/gmm/mylocation.html?hl=en "Google Maps with My Location (beta) ")_ que proporciona información sobre la localización del dispositivo móvil aunque este no tenga un GPS incorporado.

Este sistema funciona en los móviles Symbian S60 3rd Edition, en muchos BlackBerry y Windows Mobile, y en los modelos más recientes de Motorola y Sony-Ericsson. Esto es así porque las APIs que el servicio My Location utiliza sólo están disponibles en algunos sistemas y sólo con algunos fabricantes.

Para averiguar la localización del dispositivo, Google utiliza la información que obtiene del móvil y que le dice en qué celda de la red telefónica a la que pertenece se encuentra. Por ejemplo, en Symbian podríamos utilizar la clase [CTelephony](http://www.symbian.com/Developer/techlib/v9.1docs/doc_source/guide/Telephony-subsystem-guide/N1013A/info_network.html "Network information") para obtener la información que nos interesase (en Java Me se suele hacer [mediante propiedades](http://www.paxmodept.com/telesto/blogitem.htm?id=381 "Finding the Cellid from Java ME on Sony Ericsson Devices  ")), como el LAC (Location Area Code) y el Cell Id, que nos identifican la celda a la que estamos conectados, así como la intensidad de la señal. Esa información (y sólo esa, para mantener el anonimato) se envía a los servidores de Google, que devuelven una localización con un radio de error, que es lo que se muestra en Google Maps.

¿Cómo sabe Google la localización de esa celda? Con una base de datos que le diga en qué longitud y latitud está cada celda. Sabiendo dónde está la antena y qué radio aproximado cubre, e incluso aplicando correciones en función de la intesidad de la señal, podemos proporcionar una estimación razonable de la localización del dispositivo. Lo que no sé es de donde ha sacado la información Google, hasta qué punto es completa, qué redes y territorios cubre&#8230; Pero es interesante reseñar que Google puede aprovechar la información de los dispositivos que sí tienen GPS y usan Google Maps para obtener información correcta: si un N95 se conecta a Google Maps con el GPS, Google puede aprovechar la información de ese GPS para mejorar la precisión de la información sobre esa celda.

Habrá que esperar para ver qué tal funciona el sistema por distintos países y con distintos dispositivos, pero sospecho que [este tipo de localización](http://developer.yahoo.com/yrb/zonetag/locatecell.html "http://developer.yahoo.com/yrb/zonetag/locatecell.html") se extenderá durante los próximos meses para proporcionar LBS (_Location Based Services_, servicios basados en la localización) mientras los GPS no sean ubicuos.