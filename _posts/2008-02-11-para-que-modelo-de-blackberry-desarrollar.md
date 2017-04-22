---
id: 182
title: ¿Para qué modelo de BlackBerry desarrollar?
date: 2008-02-11T18:38:25+00:00
author: javiercancela
layout: post
guid: 'http://javiercancela.com/2008/02/11/%c2%bfpara-que-modelo-de-blackberry-desarrollar/'
categories:
  - blackberry
image: /images/obsolete.jpg
---
A la hora de desarrollar software para dispositivos BlackBerry, y para que nuestro producto sea compatible con la mayor cantidad posible de modelos, es útil tener en cuenta dos cosas:

  * Con el JDE desarrollamos para una versión concreta del BlackBerry Handheld Software, el &#8220;sistema operativo&#8221; del dispositivo. Teóricamente existe compatibilidad hacia atrás, de forma que con el JDE 4.1 obtendremos una aplicación capaz de ejecutarse en dispositivos con versiones 4.1, 4.2 o 4.3 del BlackBerry Handheld Software. Así, conviene siempre utilizar la versión menor que permita desarrollar la aplicación que queremos.
  * Los dispositivos BlackBerry son actualizables: para cada familia de BlackBerrys se liberan versiones actualizadas del sistema, generalmente por parte de las propias operadoras. Una lista actualizada con el último sistema disponible para cada dispositivo se puede encontrar en los foros de [BlackBerryFORUMS](http://www.blackberryforums.com/blackberry-general-forums/ "BlackBerryFORUMS").

Actualizar el software de la BlackBerry no es demasiado complejo, y para la mayoría de las BlackBerry recientes existe una actualización para la versión 4.2 del software. Para saber qué versión tiene un dispositivo basta con ir a Options->About.