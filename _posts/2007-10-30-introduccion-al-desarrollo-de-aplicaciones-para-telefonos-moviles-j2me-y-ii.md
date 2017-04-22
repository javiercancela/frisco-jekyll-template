---
id: 118
title: 'Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (y II)'
date: 2007-10-30T12:39:12+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/10/30/introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-y-ii/
categories:
  - java-me
image: /images/obsolete.jpg
---
¿Qué entorno de desarrollo es el más aconsejable para desarrollar aplicaciones J2ME? Partamos de la suposición, bastante razonable, de que queremos que se ejecute en la mayor variedad de teléfonos móviles posible. Como veíamos en la [primera parte de este artículo](http://javiercancela.com/2007/10/25/introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-i/ "J2ME (I)"), J2ME no puede garantizar que un mismo código se ejecute correctamente en todos los dispositivos aunque estos implementen las mismas especificaciones, por lo que puede ser necesario desarrollar varias versiones de nuestra aplicación.

Las marcas líderes en la comercialización de dispositivos móviles con soporte J2ME varían según el mercado específico al que nos dirijamos, pero casi en cualquier lista nos vamos a encontrar a Nokia, Samsung, Motorola, Sony Ericsson y RIM (los fabricantes de BlackBerry). Dejando de lado las BlackBerry, a las que dedicaré un artículo posterior, una buena idea es montar un entorno de desarrollo que nos permita utilizar las SDKs y los emuladores de estas marcas.

¿Y qué IDE utilizaremos para este desarrollo? Esta vez nos lo han puesto fácil: Nokia, Motorola y Sony Ericsson facilitan herramientas basadas en Eclipse para el desarrollo específico sobre sus plataformas (no he encontrado nada sobre Samsung, su portal de desarrollo es con diferencia el peor de los tres). Armados con estas herramientas, las SDKs correspondientes y la documentación y ejemplos que en ellas se encuentran ya podemos empezar a programar.

Yo personalmente comienzo siempre con Nokia, usando actualmente Eclipse con el plugin EclipseME y la SDK adecuada (por ejemplo, la de S60 3rd Ed. FP2). Para Nokia mucha gente usa [NetBeans con el Mobility Pack](http://bits.netbeans.org/download/6.0/nightly/latest/ "NetBeans IDE 6.0"); también es una opción perfectamente válida (hasta hace no mucho Nokia tenía una herramienta llamada Carbide.j, basada en Eclipse; en la actualidad está discontinuada). Una vez que tengo código que funcione, lo voy probando en los emuladores de otras plataformas y en los móviles que tenga a mano. Si da problemas, lo paso al entorno de desarrollo de la plataforma conflictiva y lo pruebo con sus SDKs modificando aquello que pueda fallar.

Si no queréis andar buscando por las páginas de cada fabricante, aquí dejo unos enlaces:
  
&#8211; [Eclipse](http://www.eclipse.org/downloads/ "Eclipse Downloads")
  
&#8211; [EclipseME](http://www.eclipseme.org/ "eclipseME")
  
&#8211; [SDKs de Nokia](http://www.forum.nokia.com/info/sw.nokia.com/id/6e772b17-604b-4081-999c-31f1f0dc2dbb/S60_Platform_SDKs_for_Symbian_OS_for_Java.html "S60 Platform SDKs for Symbian OS, for Java")
  
&#8211; [MOTODEV Studio](http://developer.motorola.com/docstools/motodevstudio/ "MOTODEV Studio") (entorno de desarrollo de Motorola basado en Eclipse)
  
&#8211; [SDKs de Motorola](http://developer.motorola.com/docstools/sdks/ "Motorola > Documentation & Tools > SDKs")
  
&#8211; [Sony Ericsson &#8211; Herramientas y Doc](http://developer.sonyericsson.com/site/global/docstools/java/p_java.jsp "Java ME Platform Docs & Tools")
  
&#8211; [SDK de Samsung](http://developer.samsungmobile.com/Developer/resources/board_read.jsp?idx=10&tableName=RESOURCESBOARD&blog= "New Samsung Java SDK")

### Entradas relacionadas:

[Introducción al desarrollo de aplicaciones para teléfonos móviles: Symbian]({% post_url 2007-10-17-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-symbian %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: Windows Mobile]({% post_url 2007-10-19-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-windows-mobile %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (I)]({% post_url 2007-10-25-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-i %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: BlackBerry]({% post_url 2007-11-05-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-blackberry %})