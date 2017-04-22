---
id: 107
title: 'Introducción al desarrollo de aplicaciones para teléfonos móviles: Symbian'
date: 2007-10-17T18:34:08+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/10/17/introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-symbian/
categories:
  - symbian
image: /images/obsolete.jpg
---
[Symbian](http://www.symbian.com/index.html "Symbian OS") es un sistema operativo para dispositivos móviles cuyo mayor accionista es Nokia, pero en el que también participan Ericsson, Panasonic, Samsung, Siemens y Sony Ericsson. Esto quiere decir que una buena parte de los móviles de estas compañías disponen de Symbian OS.

La última versión este S.O. que se puede encontrar en móviles comercializados es la 9.3, aunque ya está anunciada la versión 9.5. Supongamos que queremos desarrollar una aplicación para Symbian: bastará con desarrollar una aplicación para una versión del sistema operativo y esta funcionará en cualquier móvil que lleve esa versión, ¿no? No.

El problema está en que, aún llevando el mismo sistema operativo, existen móviles con características muy distintas, especialmente en lo referente a la interfaz de usuario. De hecho, Symbian define una serie de plataformas de interfaz de usuario (_UI platforms_) que permiten definir familias de móviles según su sistema operativo y sus características de IU. Por ejemplo, para la versión 9.1 de Symbian tenemos la plataforma _S60 3rd Edition_, para móviles como el Nokia E70 (la plataforma S60 es la de la mayoría de los Nokia); y para esa misma versión de Symbian tenemos también la plataforma _UIQ 3_, para móviles con pantalla táctil como el Sony Ericsson P990.

En general, cada versión de cada plataforma consiste en un conjunto de APIs* que da acceso a las funciones de las que dispone el móvil. El conjunto de funciones que necesite nuestra aplicación determinará la versión de la plataforma que necesitemos. Por ejemplo, si nuestra aplicación va a comprobar DRMs de archivos multimedia, necesitaremos la _DRM License Checker API_, disponible a partir de _S60 2nd Edition FP2_; mientras que si además queremos incorporar mensajería instantánea usaremos la _Instant Messaging API_, que nos obligará a restringirnos a dispositivos _S60 3rd Edition_ o superior.
  
Una vez definida nuestra plataforma objetivo, podemos descargar e instalar la SDK correspondiente ([aquí](http://developer.uiq.com/devtools_uiqsdk.html "UIQ SDK") las de UIQ y [aquí](http://www.forum.nokia.com/info/sw.nokia.com/id/4a7149a5-95a5-4726-913a-3c6f21eb65a5/S60-SDK-0616-3.0-mr.html "S60 Platform SDKs for Symbian OS, for C++") las de S60). El paquete descargado incluye las librerías necesarias, documentación, ejemplos y un emulador para poder probar nuestras aplicaciones en distintas configuraciones sin tener un dispositivo físico. El emulador es indispensable en las primeras fases del desarrollo, pero siempre hay que tener en cuenta que su funcionamiento no es totalmente idéntico al de los dispositivos reales, así que es necesario realizar pruebas finales en ellos.

Finalmente, el IDE. Opciones: CodeWarrior, VisualStudio.NET y Carbide.c++. Históricamente CodeWarrior era la herramienta de referencia, pero ya desde hace algún tiempo Nokia apuesta únicamente por [Carbide.c++](http://www.forum.nokia.com/main/resources/tools_and_sdks/carbide_cpp/index.html "Carbide Development Tools for Symbian OS C++ "), que está basado en Eclipse y tiene una versión gratuita. (Para UIQ existe también un IDE llamado [VistaMax](http://www.wirelexsoft.com/VistaMax.html "VistaMax"), pero no tengo referencias de él)

* Cuando hablo de APIs aquí me refiero a librerías a las que acceder desde C++. El caso de Java lo trataremos por separado en el capítulo dedicado a J2ME. Además, aparte de C++ y Java existen run-times para muchos otros lenguajes, como Python, Perl o Ruby.

### Entradas relacionadas:

[Introducción al desarrollo de aplicaciones para teléfonos móviles: Windows Mobile]({% post_url 2007-10-19-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-windows-mobile %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (I)]({% post_url 2007-10-25-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-i %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (y II)]({% post_url 2007-10-30-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-y-ii %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: BlackBerry]({% post_url 2007-11-05-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-blackberry %})