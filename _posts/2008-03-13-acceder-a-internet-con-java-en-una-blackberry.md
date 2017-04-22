---
id: 191
title: Acceder a Internet con Java en una BlackBerry
date: 2008-03-13T20:00:26+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/03/13/acceder-a-internet-con-java-en-una-blackberry/
categories:
  - blackberry
image: /images/obsolete.jpg
---
Entre las peculiaridades que presentan las BlackBerry como dispositivos programables, la que más quebraderos de cabeza suele causar es la conexión a Internet. El motivo no es la API utilizada, que es la habitual [Generic Connection Framework](http://developers.sun.com/mobility/midp/articles/genericframework/ "Generic Connection Framework") de CLDC 1.0, sino los diferentes tipos de acceso a Internet que se pueden usar en los dispositivos BlackBerry. Los tipos de conexión dependen tanto servicio contratado, del modelo de BlackBerry, de la operadora&#8230; De hecho, lo que viene a continuación no es información contrastada, sino conclusiones que he sacado tras investigar en diversas páginas y manuales que he encontrado por Internet. Es además una exposición simplificada, destinada a desarrolladores que quieran programar en la BlackBerry aplicaciones que se conectan a Internet. Cualquier aportación o corrección es como siempre bienvenida.

Existen dos servicios BlackBerry distintos. Uno es el empresarial, llamado _BlackBerry Enterprise Solution_ (o BES para abreviar), en el cual la empresa tiene un servidor (el [_BlackBerry Enterprise Server_](http://na.blackberry.com/eng/services/server/ "BlackBerry Entreprise Server")) que todas las BlackBerry corporativas usan como punto de acceso. A través de él acceden al correo corporativo o se descargan aplicaciones corporativas. Tambien proporciona un servicio, llamado _Mobile Data Service_, que actúa de proxy para acceder a Internet. Con BES, las únicas restricciones son las que la empresa configure en su servidor.

Para usuarios individuales, o para pequeñas empresas que no puedan permitirse la infraestructura BES, existe el servicio [_BlackBerry Internet Service_](http://na.blackberry.com/eng/services/internet/ "BlackBerry Internet Service") (BIS). Este servicio permite acceder a Internet a través de una pasarela gestionada por RIM, habitualmente con un plan de datos con tarifa plana. Pero, y aquí empieza la complicación, sólo pueden acceder a esta pasarela aquellas aplicaciones que tengan permiso para ello. A día de hoy existen varias aplicaciones que funcionan bajo la pasarela de BIS (por ejemplo, hay una lista, no sé cómo de completa, aquí: [¿Entra en la Tarifa Plana?](http://www.miblackberry.com/2007/09/03/%c2%bfentra-en-la-tarifa-plana.html "¿Entra en la Tarifa Plana?")). Imagino que es neecsario un acuerdo con RIM para que una aplicación tenga acceso a esta pasarela, pero no he conseguido información al respecto.

Además de BIS, las operadoras pueden ofrecer una pasarela propia para acceder a Internet. Esta pasarela puede ser [WAP](http://www.tejedoresdelweb.com/307/article-1873.html#h2_5 "Componentes de WAP") o no (creo que las que ofrecen en España son WAP). Para utilizar estas pasarelas es necesario tener definido un APN (_Access Point Name_) con los parámetros especificados por el operador (nombre, y opcionalmente ip, puerto, usuario y contraseña), aunque también es posible incluir estos parámetros desde el código que abre la conexión.

El problema de las pasarelas que no son BIS es que se cobran aparte, por lo su coste no va incluido en la tarifa plana de BlackBerry; eso sí, es posible no contratar el servicio BIS y contratar una tarifa plana de datos convencional, que sí cubrirá todas nuestras conexiones a Internet. Pero si no se tiene tarifa plana, lo mejor es asegurarse de que no hay APNs configuradas y de que las aplicaciones que usamos funcionan en BIS.

Como conclusión, las aplicaciones Java que hagamos para BlackBerry no podrán acceder a Internet por BIS. Hay que tener en cuenta, además, que con el emulador de BlackBerry sólo podemos probar conexiones a través del MDS, ya que no hay forma de emular un servicio BIS ni una pasarela directa a Internet. Las diferencias son relevantes en el código, ya que por defecto casi todas las BlackBerry intentan conectarse por _Mobile Data Service_.  Los parámetros para especificar un tipo de conexión u otro, así como para especificar una pasarela wap se encuentran en este artículo de la base de conocimiento de BlackBerry: [_What Is &#8211; Different ways to make an HTTP or socket connection_](http://www.blackberry.com/knowledgecenterpublic/livelink.exe/fetch/2000/348583/796557/800451/800563/What_Is_-_Different_ways_to_make_an_HTTP_or_socket_connection.html?nodeid=826935&vernum=0 "What Is - Different ways to make an HTTP or socket connection").

**Referencias:**

[Lo que entra en el plan BB](http://www.miblackberry.cl/lo-que-entra-en-el-plan-bb "Lo que entra en el plan BB")
  
[BESADMIN.es](http://BESADMIN.es "BESADMIN.es")
  
[¿Entra en la Tarifa Plana?](http://www.miblackberry.com/2007/09/03/%C2%BFentra-en-la-tarifa-plana.html#comments "¿Entra en la Tarifa Plana?")