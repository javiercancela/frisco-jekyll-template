---
id: 198
title: ¿Cuándo es antiguo un móvil?
date: 2008-04-01T20:41:08+00:00
author: javiercancela
layout: post
guid: 'http://javiercancela.com/2008/04/01/%c2%bfcuando-un-movil-es-antiguo/'
permalink: /index.php/2008/04/01/cuando-un-movil-es-antiguo/
categories:
  - Varios
tags:
  - Android
  - cformsII
  - CLDC
  - iPhone
  - S60
---
Un lector del blog me ha escrito un correo a una de las cuentas de Ipoki y me ha hecho pensar en un par de cosas.

Primero, en que no tenía formulario de contacto. El plugin [cformsII](http://deliciousdays.com/cforms-plugin "cformsII") para WordPress se ha encargado de [arreglarlo](http://javiercancela.com/contactar/ "Contactar").

Segundo, en lo difícil que resulta decidir cuándo un móvil es &#8220;antiguo&#8221;. El correo hablaba de la dificultad de trabajar con números en punto flotante<sup>(1)</sup> en móviles con CLDC 1.0, ya que no hay soporte nativo. Estos móviles no tienen hardware dedicado a trabajar con punto flotante y las emulaciones por software son excesivamente lentas. El caso es que, pese a ser móviles antiguos (creo el último de Nokia con CLDC 1.0 es el [3230](http://www.forum.nokia.com/devices/3230 "Nokia 3230") y es del 2004), todavía existe un número importante de ellos en uso.

Así que la pregunta es: ¿cuándo compensa tener en cuenta estos móviles en el desarrollo? Mi respuesta: nunca. No debemos ser tímidos a la hora de descartar dispositivos por su antigüedad, ya que el número de potenciales usuarios perdidos disminuye con el tiempo, y a mucha velocidad. Preocuparnos de cómo hacer que algo funcione en un dispositivo de hace tres años consumirá recursos que estarán mejor empleados en una versión para el [iPhone](http://javiercancela.com/2008/03/08/primeras-impresiones-sobre-la-sdk-del-iphone/ "iPhone"), o para [S60 3rd Ed. FP2](http://javiercancela.com/2008/03/19/nueva-sdk-de-symbian-s60-3rd-edition-feature-pack-2/ "S60 3rd Ed. FP2"), o para [Android](http://javiercancela.com/2007/11/13/primeras-impresiones-sobre-android/ "Android"). Si es posible que funcione en mi viejo N70 con algunos cambios menores, estupendo. Pero los dispositivos más recientes proporcionan formas cada vez más cómodas y eficaces de hacer las cosas, y generalmente no vale la pena tomarse el trabajo de pensar cómo hacer las mismas cosas para teléfonos de una generación anterior. Hablo por supuesto de desarrolladores amateurs, o de autónomos o pequeñas empresas. Las empresas grandes (o veteranas) tienen herramientas, recursos y metodologías para sacar el último juego Java para un montón de modelos distintos y rentabilizar el desarrollo. Pero no es mi caso, e imagino que tampoco el da la mayoría de lectores de este blog.

<sup>(1)</sup> Realmente en español lo correcto es &#8220;coma flotante&#8221;, pero no puedo evitar que me suene raro. Históricamente el punto es utilizado sobre todo en el mundo anglosajón, con la coma siendo la norma en Europa y Sudamérica, entre otros sitios. Imagino que la influencia de Internet acabará decantando la balanza a favor del punto.