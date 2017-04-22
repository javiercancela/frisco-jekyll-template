---
id: 122
title: 'Introducción al desarrollo de aplicaciones para teléfonos móviles: BlackBerry'
date: 2007-11-05T19:22:24+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/05/introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-blackberry/
categories:
  - blackberry
image: /images/obsolete.jpg
---
Aunque la plataforma para desarrollar aplicaciones para BlackBerry es JavaME y por lo tanto la mayoría de lo escrito en los [artículos]({% post_url 2007-10-25-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-i %}) [correspondientes]({% post_url 2007-10-30-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-y-ii %}) es aplicable a este, existen una serie de peculiaridades que hacen que valga la pena escribir un artículo aparte. En primer lugar, las BlackBerry son dispositivos orientados a negocios. O más bien, dispositivos pensados para ser clientes de una red corporativa, que incluya una solución integral con correo electrónico, servicios web, seguridad integrada&#8230; No vamos a hablar aquí de las [plataformas empresariales de BlackBerry](http://na.blackberry.com/eng/solutions/ "BlackBerry® Business Solutions ") (BlackBerry Enterprise Solution, BlackBerry Internet Solution&#8230;). Sin embargo es conveniente saber que existe un entorno de desarrollo de aplicaciones empresariales para BlackBerry: el [BlackBerry MDS Studio](http://na.blackberry.com/eng/developers/downloads/studio.jsp "BlackBerry MDS Studio"); básicamente es un editor que permite crear interfaces de usuario con la técnica de &#8220;drag and drop&#8221; (y opcionalmente algo de javascript) con el objeto de acceder a través de servicios web a datos situados en un servidor empresarial.

Nosotros nos centraremos en las aplicaciones standalone. Decíamos que el desarrollo de aplicaciones para BlackBerry se lleva a cabo a través de JavaME. Esto no es del todo cierto: se desarrolla contra un sistema llamado BlackBerry Handheld Software, que ofrece por un lado las APIs de CLDC 1.1 y de MIDP 2.0, y por otro lado unas [APIs Java propias de BlackBerry](http://www.blackberry.com/developers/docs/4.1api/overview-summary.html "RIM Device Java Library"). Estas APIs BlackBerry ofrecen servicios básicos, como interfaz de usuario, localización, acceso a redes; y servicios &#8220;controlados&#8221;, como criptografía avanzada, sincronización y mensajería. Estos servicios son &#8220;controlados&#8221; porque para ser instalados en un móvil BlackBerry el código debe ir firmado con un [certificado autorizado por RIM](http://na.blackberry.com/eng/developers/downloads/signing.jsp "BlackBerry Signing Authority").

Por lo tanto, a la hora de desarrollar una aplicación para BlackBerry tenemos la opción de acudir a JavaME, con lo que obtendremos código que nos valdrá (probablemente con algunos retoques, como siempre) para otros dispositivos con el mismo soporte CLDC 1.1 y MIDP 2.0, y la opción de desarrollar específicamente para BlackBerry con sus propias APIs, que será la opción obligada si queremos darle a la aplicación el &#8220;look&#8221; característico de BlackBerry o queremos utilizar algunas de las funciones más avanzadas.

BlackBerry proporciona gratuitamente un entorno de desarrollo, el [BlackBerry Java Development Enviroment](http://na.blackberry.com/eng/developers/downloads/jde.jsp "BlackBerry Java Development Enviroment") o BlackBerry JDE. Este IDE nos da acceso tanto las APIs de JavaME como a las propias de BlackBerry, e incorpora una serie de simuladores de disposivos BlackBerry sobre los que depurar nuestro código.

Más información:
  
[BlackBerry Technical Knowledge Center](http://www.blackberry.com/knowledgecenterpublic/livelink.exe?func=ll&objId=1195446&objAction=browse&sort=name "BlackBerry Technical Knowledge Center")

### Entradas relacionadas:

[Introducción al desarrollo de aplicaciones para teléfonos móviles: Symbian]({% post_url 2007-10-17-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-symbian %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: Windows Mobile]({% post_url 2007-10-19-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-windows-mobile %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (I)]({% post_url 2007-10-25-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-i %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (y II)]({% post_url 2007-10-30-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-y-ii %})
