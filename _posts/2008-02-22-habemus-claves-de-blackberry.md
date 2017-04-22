---
id: 186
title: Habemus claves de BlackBerry
date: 2008-02-22T09:00:05+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/02/22/habemus-claves-de-blackberry/
permalink: /index.php/2008/02/22/habemus-claves-de-blackberry/
categories:
  - blackberry
image: /images/obsolete.jpg
---
 La gente de RIM me ha enviado unas claves nuevas y, esta vez sí, he conseguido registrarlas. No me han dado más detalles sobre el asunto, pero imagino que hubo algún problema por su parte en la activación de las claves anteriores. Tras el registro he podido probar el proceso de firma desde el JDE y ha funcionado bien: el entorno indica para cada uno de los tres tipos de claves (RBB, RCR y RRT, para APIs de aplicación, criptográficas y de run-time respectivamente) si la firma es requerida u opcional, y automáticamente calcula un hash del código, lo envía a RIM y lo devuelve firmado.

Aún no he tenido tiempo de probar la aplicación firmada en un dispositivo físico, pero ya queda menos para hacer pública una primera versión del plugin para BlackBerry.

_OffTopic_. Como parte de los cambios que estoy haciendo en esta bitácora, he añadido un _widget_ de Ipoki. En realidad es el iFrame que aparece bajo el mapa de cada usuario en la web de Ipoki, añadido a mano a este tema de WordPress. Creo que queda bien.