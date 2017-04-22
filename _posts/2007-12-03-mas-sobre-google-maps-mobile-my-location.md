---
id: 145
title: 'Más sobre Google Maps Mobile: My Location'
date: 2007-12-03T17:56:28+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/12/03/mas-sobre-google-maps-mobile-my-location/
permalink: /index.php/2007/12/03/mas-sobre-google-maps-mobile-my-location/
categories:
  - lbs
image: /images/obsolete.jpg
---
Hablábamos en [una entrada anterior](http://javiercancela.com/2007/11/29/google-maps-my-location-localizacion-sin-gps/ "Localización sin GPS") del servicio My Location de Google Maps Mobile, que permite localizar un móvil sin GPS con un margen de error variable.

Sobre las formas que tiene Google de averiguar la localización del móvil, [un ingeniero de Vodafone UK](http://www.vodafonebetavine.net/web/guest/projects/resources/location_enhanced_services?p_p_id=bvblogs&p_p_action=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-2&p_p_col_pos=1&p_p_col_count=2&_bvblogs_struts_action=%2Fext%2Fbvblogs%2FviewPost&_bvblogs_postId=267&#p_bvblogs "Welcome to the Betavine Location Enhanced Services Blog") apunta que en el Reino Unido es la propia Vodafone quien proporciona a Google la información sobre la celda en la que se encuentra el usuario, así como una distancia aproximada y una orientación con respecto a la celda. La ventaja que poseen las operadoras es que saben no sólo en qué celda se encuentra el móvil, sino qué otras celdas están cerca, y en el caso de las antenas direccionales conocen la dirección aproximada respecto a la antena ([esta información](http://tech.groups.yahoo.com/group/momolondon/message/3316 "Google Maps location service for mobile") se indica esquemáticamente en un foro de yahoo que exige registro).

Así, para los teléfonos Vodafone UK se utilizaría una versión de Google Maps Mobile que enviaría la información necesaria para identificar en qué red funciona y localizar al dispositivo dentro de esa red (quizás todas las versiones de GMM lo hagan y sólo se aproveche cuando se pueda), y se enviaría esa información a Google para que la convirtiese en una ubicación en el mapa.

Decía también que Google tenía una base de datos con ubicaciones de las celdas de telefonía móvil propia con datos conseguidos de distintas fuentes. Lo que no sabía es que esa información es pública en algunos países. Podemos consultar algunos de ellos (no España, ni ningún país hispanohablante) en el [Mobile Manufacterers Forum](http://www.mmfai.org/public/locatingbasestations.cfm?lang=es "Localización de Estaciones de Base").

**Vía:**
  
Mobile Phone Development: [Google MyLocation: How Does it Work?](http://mobilephonedevelopment.com/archives/504)