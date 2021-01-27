---
id: 115
title: 'Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (I)'
date: 2007-10-25T21:45:54+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/10/25/introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-i/
categories:
  - java-me
image: /images/obsolete.jpg
---
El nombre real de J2ME es &#8216;_Java Platform, Micro Edition&#8217;_, aunque J2ME sigue siendo el término más habitual.

[J2ME](http://java.sun.com/javame/index.jsp "The Java ME Platform") es un subconjunto de Java orientado a dispositivos con recursos limitados, es decir, a un hardware en el que características como la memoria o la velocidad del procesador son muy inferiores a las de un ordenador convencional. Por ejemplo, un teléfono móvil. Desde el año pasado J2ME es Open Source, y el proyecto que se encarga de mantenerlo y desarrollarlo se llama [phoneME](https://phoneme.dev.java.net/ "phoneME Project").

Al igual que ocurre con el J2SE, la principal virtud de J2ME es su habilidad para ejecutarse en distintas plataformas: casi cualquier móvil de hoy en día incorpora soporte Java (las excepciones más significativas son el iPhone y los móviles con Windows Mobile). Sin embargo, no todos los dispositivos tienen el mismo soporte de J2ME. Veamos por qué.

J2ME se divide en configuraciones (_configurations_), perfiles (_profiles_) y APIs opcionales. Una configuración define un tipo de dispositivo en función de las características de su hardware: sus limitaciones, sus capacidades&#8230; y le asigna una máquina virtual y un conjunto de APIs adecuados a ese hardware. En la actualidad existen dos configuraciones: [CDC](http://java.sun.com/products/cdc/ "Connected Device Configuration (CDC); JSR 36, JSR 218") (_Connected Device Configuration_), utilizada sobre todo en sistemas de telemetría, automoción o domótica, y [CLDC](http://java.sun.com/products/cldc/ "Connected Limited Device Configuration (CLDC); JSR 30, JSR 139") (_Connected Limited Device Configuration_) que es una versión más limitada y que es la que nos interesa por estar presente en la mayoría de los móviles.

Dentro de una configuración, un perfil nos define ciertas características concretas, como la interfaz de usuario. Existen tres perfiles para la configuración CLDC: [MIDP](http://java.sun.com/products/midp/ "Mobile Information Device Profile (MIDP); JSR 37, JSR 118") (_Mobile Information Device Profile_), que es la usada en los teléfonos móviles y por tanto la que nos interesa, [IMP](http://java.sun.com/products/imp/ "Information Module Profile (IMP) JSR-195") (_Information Module Profile_) que es una versión de la anterior sin interfaz de usuario, y [DoJa](http://www.doja-developer.net/ "DoJa Developer Network"), destinado a un tipo de móviles japoneses.

Finalmente, cada dispositivo móvil puede incluir soporte para distintas APIs opcionales. Por ejemplo, un dispositivo con Bluetooth puede disponer de la _Bluetooth API_ [(JSR 82](http://www.jsr82.com/ "Java Bluetooth")), o un móvil de gama media/alta quizás venga preparado para leer y procesar información geolocalizada con la _Location API_ [(JSR 179](http://jcp.org/en/jsr/detail?id=179 "Location API for J2METM")). Como estas capacidades varían de dispositivo en dispositivo, hay que acudir a las especificaciones de cada uno para ver qué APIs soportan. Por ejemplo, [aquí](http://www.forum.nokia.com/devices/matrix_all_1.html "Device specifications") podéis comprobar los modelos Nokia, [aquí](http://developer.motorola.com/products/handsets/ "Handsets") los Motorola o [aquí](http://developer.sonyericsson.com/site/global/products/phonegallery/p_phonegallery.jsp?cc=gb&lc=en&ver=4000&template=pp1&zone=pp&lm=pp "Phone Gallery") los Sony Ericsson. Sun también proporciona una [lista de dispositivos de distintos fabricantes](http://developers.sun.com/mobility/device/device;jsessionid=133D390A2F5E3292FD865279A7DB2F1F "Java ME Device Table").

Ocurre que cada fabricante realiza las implementaciones de las APIs J2ME de sus móviles. Aunque para ello se basan en una implementación de referencia de Sun, en la práctica se pueden encontrar diferencias significativas en el comportamiento de distintos dispositivos para una misma función, fallando en unos móviles lo que funciona en otros. En ocasiones, esto supone la necesidad de desarrollar más de una versión de la misma aplicación.

Recapitulando, para programar móviles usaremos la configuración CLDC con el perfil MIDP. La última versión de CLDC es la 1.1, y la última de MIDP es la 2.0; estos son las versiones que incorporan los móviles recientes, para modelos más antiguos podemos encontrarnos con CLDC 1.0, que por ejemplo no soporta operaciones en punto flotante, y MIDP 1.0, que no da acceso a funciones de sonido o pantalla completa.

### Entradas relacionadas:

[Introducción al desarrollo de aplicaciones para teléfonos móviles: Symbian]({% post_url 2007/2007-10-17-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-symbian %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: Windows Mobile]({% post_url 2007/2007-10-19-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-windows-mobile %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (y II)]({% post_url 2007/2007-10-30-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-y-ii %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: BlackBerry]({% post_url 2007/2007-11-05-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-blackberry %})