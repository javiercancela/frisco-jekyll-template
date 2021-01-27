---
id: 128
title: Primeras impresiones sobre Android
date: 2007-11-13T11:43:09+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/13/primeras-impresiones-sobre-android/
categories:
  - android
image: /images/obsolete.jpg
---
**El sistema**

En la anterior entrada decía que Android es un sistema operativo. En realidad esto no es cierto, como aclara [la propia documentación](http://code.google.com/android/what-is-android.html "What is Android?"). Así que a la documentación me remito:

> _Android is a software stack for mobile devices that includes an operating system, middleware and key applications._
> 
> Android es una pila de software para dispositivos móviles que incluye un sistema operativo, _middleware_ y aplicaciones clave.

Traducción propia, por supuesto. Ese concepto de &#8220;pila de software&#8221; hace referencia a que el sistema está compuesto por capas de software que se colocan una sobre otra, de manera que cada una puede usar directamente a la que tiene inmediatamente debajo. En concreto la disposición se indica en el siguiete dibujo, proveniente del sitio web de Android:

<img src="http://farm3.static.flickr.com/2350/1997144613_f99edd1d96.jpg" alt="Arquitectura de Android" height="359" width="500" />

Podemos distinguir aquí la parte pública, en azul, compuesta por las aplicaciones del dispositivo y las librerías que podemos utilizar con la SDK (_el Application Framework_). En verde tenemos las librerías del sistema, a las que, al menos inicialmente, no tendremos acceso directo y que serán utilizadas por el _Application Framework_.

La clave del sistema es la parte en amarillo, el _Runtime_. Cada aplicación que nosotros programemos tendrá su propio proceso con su propia instancia de la máquina virtual. Las librerías Core que aparecen en el Runtime incluyen la funcionalidad que solemos encontrar en las librerías básicas de Java: java.io, java.lang, java.util, &#8230; Esto no quiere decir que la máquina virtual sea una máquina virtual de Java, sólo que Java es el lenguaje usado para su programación. Veremos más sobre la máquina virtual en un momento.

La parte en rojo la constituye el núcleo (_kernel_) del sistema operativo. Está basado en el núcleo 2.6 de Linux y es la base de todo el sistema. Hay que tener claro que una aplicación Android no se ejecuta directamente sobre este núcleo y no es por tanto una aplicación Linux. Podemos ver a Android como la versión de Google de JavaME o del .NET Compact Framework.

**La máquina virtual**

Un punto clave y muy interesante de todo este sistema es [Dalvik](http://en.wikipedia.org/wiki/Dalvik_virtual_machine "Dalvik virtual machine"), la máquina virtual. Dalvik es una máquina virtual muy ligera, optimizada para usar muy poca memoria, lo cual consigue delegando en el _kernel_ de Linux el _multithreading_ y la gestión de memoria y de procesos. Para programar en Dalvik se utiliza un compilador de Java, pero lo que genera no son Java bytecodes, sino un tipo distinto de bytecodes, por lo que Dalvik no se puede denominar una máquina virtual de Java. Además, ofrece librerías estándar de Java pero sin declarar ninguna compatibilidad con Java SE.

Lo que todo esto parece querer decir es que Google pretende sacarle a Sun parte del pastel de Java, al menos en entornos móviles, con una plataforma que no es una máquina virtual de Java pero lo parece. De esta forma Sun no puede reclarmar ningún derecho sobre ella y Google no necesita permiso de nadie para introducir modificaciones, pero a la vez los programadores acostumbrados a Java apenas notarán diferencias. Parecido a lo que intentó Microsoft con su máquina virtual de Java, pero aprendiendo de los errores de Microsoft.

**La SDK**

En cuanto a la SDK en sí, poco puedo decir de momento, salvo que tiene un buen aspecto. La ventaja de llegar tarde a un entorno tecnológico es que puedes aprender de los demás y careces de lastres en forma de compatibilidad hacia atrás. Las aplicaciones de Android se construyen en torno a cuatro conceptos: las _Activities_ (actividades), que representan pantallas de la aplicación; los _Intent Receivers_ (receptores objetivo), que gestionan eventos; los Services (servicios), que ejecutan código no asociado a una interfaz de usuario; y los Content Provider (proveedores de contenido), que se encargan de almacenar o compartir datos. También es destacable el formato XML para la definición de la interfaz de usuario, que Google promete que acabará con los problemas de _layout_ tan habituales en los dispositivos móviles.

La SDK incluye un plugin para Eclipse, que permite utilizar varias de las herramientas de la SDK desde este IDE, además de añadir los típicos Wizards y asistentes de compilación y despliegue. De todos modos es perfectamente posible utilizar la SDK desde cualquier IDE o editor de texto.