---
id: 366
title: 'Notificaciones &#8216;push&#8217; en dispositivos móviles'
date: 2009-07-13T07:00:48+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/?p=366
permalink: /index.php/2009/07/13/notificaciones-push-en-dispositivos-moviles/
twitter_cards_summary_img_size:
  - 'a:7:{i:0;i:240;i:1;i:180;i:2;i:1;i:3;s:24:"width="240" height="180"";s:4:"bits";i:8;s:8:"channels";i:3;s:4:"mime";s:9:"image/gif";}'
categories:
  - android
  - blackberry
image: /images/obsolete.jpg
---
**¿Qué es una notificación _push_****?**

[<img class=" alignright" style="border:5px solid black;" title="Jeff Henshaw: Apple's Push Notification Service" src="http://farm4.static.flickr.com/3341/3225601827_3aa6473718_m.jpg" alt="Jeff Henshaw: Apples Push Notification Service" width="240" height="135" />](http://www.flickr.com/photos/jeffhenshaw/3225601827/)

Es un mensaje que una aplicación servidora envía a una aplicación cliente indicándole que tiene algún tipo de información nueva disponible. Lo que distingue a las notificaciones _push_ es que el servidor inicia la comunicación, no espera a que el cliente pregunte si hay algo nuevo. La ventaja es la inmediatez: la información llega al cliente (y por tanto al usuario) en cuanto está disponible en el servidor.

El ejemplo más clásico de este tipo de notificaciones es el correo electrónico. Un usuario tiene una aplicación de correo electrónico ejecutándose en su dispositivo. Alguien le envía un correo, que queda almacenado en el servidor. A partir de ahí pueden ocurrir dos cosas:

  * El cliente de correo electrónico está configurado para consultar al servidor, con una frecuencia predeterminada, si hay nuevos correos. Si la frecuencia es de una vez cada 5 minutos el usuario puede tardar ese tiempo en enterarse de que ha recibido un correo nuevo.
  * El cliente (y el servidor) soportan notificaciones _push_. En este caso el servidor envía un mensaje al cliente para avisarle de que ha llegado un nuevo correo, y el cliente a su vez se lo notifica de alguna forma al usuario para que lo lea si le interesa.

En el caso de las aplicaciones de mensajería instantánea la necesidad de la inmediatez es aún más manifiesta: para que la conversación sea fluida necesitamos que los mensajes nos lleguen en cuanto son enviados, e incluso queremos saber cuándo nuestro interlocutor está escribiendo algo.

**¿Cómo se implementa una notificación _push_****?**

La manera habitual de implementar una notificación _push_ es establecer una conexión TCP de larga duración. El cliente abre una conexión TCP con el servidor y la deja abierta. Sobre esta conexión TCP el servidor enviará las notificaciones al cliente, usando algún protocolo de aplicación. <a title="IMAP" href="http://en.wikipedia.org/wiki/Internet_Message_Access_Protocol" target="_self">IMAP</a> y <a title="XMPP" href="http://en.wikipedia.org/wiki/Extensible_Messaging_and_Presence_Protocol" target="_self">XMPP</a> son ejemplos de protocolos estándar usados para correo y mensajería respectivamente, aunque existen múltiples protocolos propietarios.

**Notificaciones _push_** **en BlackBerry**

[<img class="  alignright" title="BlackBerry" src="http://farm4.static.flickr.com/3547/3500715353_8a83868705_m.jpg" alt="indivisualist - BlackBerry" width="240" height="195" />](http://www.flickr.com/photos/indivisualist/3500715353/)

El éxito de las BlackBerry se debe en parte a su sistema de _push email_. Cuando leer el correo desde el móvil era una experiencia dolorosa en otros sistemas, las BlackBerry ya conseguían que sus usuarios recibiesen el correo de manera instantánea. RIM subscribe un acuerdo con los operadores de telefonía, por el cual se establece una conexión permanente con unos servidores especiales operados por RIM. Estos servidores reciben el correo del usuario desde los servidores [BES](http://en.wikipedia.org/wiki/BlackBerry_Enterprise_Server), y lo notifican de forma inmediata a las BlackBerry.

La tecnología de notificaciones _push_ de RIM está disponible para terceros a través de la <a href="http://na.blackberry.com/eng/developers/javaappdev/pushapi.jsp?CPID=PUSHAPI00" target="_self">BlackBerry Push API</a>.

**Notificaciones _push_** **en iPhone**

Apple incorporó desde el principio un sistema de notificaciones _push_ para el correo electrónico de Yahoo. La aparición de [MobileMe](http://www.apple.com/es/mobileme/) añadió notificaciones _push_ tanto para el correo como para el calendario y los contactos.

Cuando Apple diseñó la SDK del iPhone tomó la decisión de no permitir a los desarrolladores crear aplicaciones que se ejecutasen en segundo plano. Como consecuencia, las aplicaciones desarrolladas por terceros sólo se ejecutan mientras están en primer plano, deteniéndose cuando el usuario quiere realizar otra actividad.

La nueva versión de la SDK incorpora el [Apple Push Notification service](http://developer.apple.com/iphone/program/sdk/), un servicio que envía notificaciones a las aplicaciones del iPhone aunque estas no se estén ejecutando. Para ello la notificación pasa primero por los servidores de Apple, con los que el móvil mantiene siempre una conexión abierta. La notificación se envía al móvil y se muestra al usuario como un mensaje de texto o como una ventana de notificación, que servirán además para lanzar la aplicación y procesar la notificación recibida.

**Notificaciones _push_** **en Android**

Android proporciona notificaciones _push_ para el correo electrónico, calendario y contactos, tanto en el HTC Dream como en el HTC Magic. Como en los casos anteriores, el sistema establece un canal siempre abierto con los los servidores del proveedor (en este caso Google).

Aunque los desarrolladores de Android tienen la opción de programar aplicaciones que se ejecuten en segundo plano el sistema se reserva el derecho de detener cualquier aplicación cuando así lo decida, en función de los recursos disponibles en la máquina. Así que podemos desarrollar un cliente que mantenga conexiones TCP de larga duración con el servidor ejecutándose en _bakcground_, pero no podemos garantizar que la aplicación se esté ejecutando para mantener esta conexión abierta. Claro que este problema se presenta aunque queramos traernos la información usando _pull_, es decir, consultando al servidor de periódicamente.

En las versiones beta de la SDK se incluía un servicio llamada XMPPService o GTalkService, que permitía a los desarrolladores enviar notificaciones utilizando la infraestructura de Google Talk. Este servicio fue retirado de la versión final de la SDK por problemas de seguridad, como se explica aquí: _[Some information on APIs removed in the Android 0.9 SDK beta](http://android-developers.blogspot.com/2008/08/some-information-on-apis-removed-in.html "Some information on APIs removed in the Android 0.9 SDK beta")_. No sería extraño que Google incluyese una versión mejorada en alguna de las próximas versiones de Android.