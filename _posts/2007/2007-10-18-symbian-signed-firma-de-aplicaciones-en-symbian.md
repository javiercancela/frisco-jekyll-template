---
id: 110
title: 'Symbian Signed: Firma de aplicaciones en Symbian'
date: 2007-10-18T17:36:40+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/10/18/symbian-signed-firma-de-aplicaciones-en-symbian/
categories:
  - symbian
image: /images/obsolete.jpg
---
La [nota de prensa](http://www.apple.com/hotnews/) de Steve Jobs sobre la SDK del iPhone decía textualmente:

> “Nokia, for example, is not allowing any applications to be loaded onto some of their newest phones unless they have a digital signature that can be traced back to a known developer. While this makes such a phone less than “totally open,” we believe it is a step in the right direction.”

Que traducido viene a decir:

> <p align="left">
>   “Nokia, por ejemplo, no permite que se cargue ninguna aplicación en algunos de sus teléfonos más recientes salvo que tengan una firma digital que se pueda rastrear hasta un desarrollador conocido. Aunque esto convierte a un teléfono así en algo menos que ‘totalmente abierto’, creemos que es un paso en la dirección correcta”.
> </p>

<p align="left">
  ¿Cómo funciona exactamente esta restricción de Nokia?
</p>

<p align="left">
  Todo parte de una iniciativa de Symbian (por lo tanto no sólo de Nokia) llamada <a href="https://www.symbiansigned.com/app/page" title="Symbian Signed">Symbian Signed</a>. A partir de la versión 9 de Symbian OS se introduce este mecanismo que permite obligar a que una aplicación esté digitalmente firmada antes de instalarla. Para firmar una aplicación necesitamos:
</p>

<p align="left">
  &#8211; Un Publisher ID proporcionado (por un precio) por algún distribuidor autorizado (Verisign, Trust Center…) y que utilizaremos para firmar las aplicaciones.
</p>

<p align="left">
  &#8211; Enviar la aplicación a una Test House que, también por un precio, verificará que la aplicación cumple con los criterios de Symbian Signed.
</p>

<p align="left">
  &#8211; Para aplicaciones gratuitas Symbian <a href="https://www.symbiansigned.com/app/page/overview/freeware" title="Freeware">proporciona la opción</a> de firmar la aplicación con un Publisher independiente, que también se encargaría de comprobar que pasa todos los criterios de Symbian Signed.
</p>

¿Es necesario firmar cualquier aplicación?

Symbian Signed no es obligatorio en versiones de Symbian anteriores a v9.x (aunque puede utilizarse en ellas), ni se utiliza en aplicaciones J2ME (Sun tiene su propio mecanismo de firma).

Para aplicaciones C++ (o AppForge MobileVB) destinadas a S60 3rd Edtion o UIQ 3.x es necesario examinar qué APIs vamos a usar para ver cómo necesitamos firmar el ejecutable.

Symbian Signed divide parte de las APIs de Symbian en grupos llamados Capacidades (_Capabilities_) en base a su funcionalidad y al riesgo que conlleva su uso. Aproximadamente el 60% de Symbian queda fuera de estos grupos y es de libre acceso. Symbian Signed no obliga a firmar una aplicación que sólo haga uso de la parte no restringida de las APIs. Sin embargo, la implementación final de cada móvil puede hacerlo. En la práctica, los móviles UIQ 3.x aceptan instalaciones sin firma, pero los S60 3rd Ed. obligan a que el ejecutable tenga al menos un tipo de firma llamada autofirmado (_selfsigned_), aunque para esta firma sólo es necesario usar una aplicación disponible en la SDK, no necesitamos Publisher ID ni realizar ningún pago.

Las _Capabilities_ de las que hablábamos son 20. Podemos ver [aquí](http://www.symbian.com/developer/techlib/v9.1docs/doc_source/guide/N10022/GT_9.1/FunctionsByCapablity.html "Functions By Capability") que funciones incluyen cada una, y en la última página de este [pdf](http://sw.nokia.com/id/285569bb-6918-478a-83aa-83c8550642f7/Symbian_Platform_Security_Granting_Sensitive_Capabilities_v1_0_en.pdf "Granting Sensitive Capabilities") vemos cómo se distribuyen. Siete de ellas sólo las podremos usar si pedimos una licencia específica al fabricante o a Symbian; de las otras trece, algunas las podremos utilizar con el _selfsigned_, mientras que otras requerirán que la aplicación esté _Symbian Signed_ (utiliando por tanto el Publisher ID). Para saber a qué atenerse lo mejor es consultar la documentación de la SDK que estemos usando.

Existe un certificado especial para desarrolladores que se puede solicitar para el proceso de desarrllo; es gratuito si sólo queremos hacer pruebas con las 13 capabilities menos restringidas y en un solo móvil (la firma se asocia al IMEI), y tiene un coste si necesitamos usar más IMEIs o las siete Capabilities más restringidas. Este [pdf](http://developer.symbian.com/main/downloads/papers/Developer_Certificate_Request_Process_v2.0 "Developer Certificate Request Process") muestra cómo funciona este tipo de firma.

Precisamente ayer mismo Symbian [anunciaba](http://www.allaboutsymbian.com/news/item/6092_Symbian_Signed_Announce_New_20.php "Symbian Signed Announce New $20 'Express Signed' Component") [algunos cambios](http://developer.symbian.com/main/signed/) sobre los tipos de certificados de Symbian Signed, que afectan fundamentalmente al número de IMEIs utilizables y al precio.

Más información:

[Faq de Symbian Signed](https://www.symbiansigned.com/app/page/overview/faq)
  
 [Faq en Symbian](http://www3.symbian.com/faq.nsf/webform2?openform&view=vlWebAllSubCatFAQInBrief&viewnamedisplay=By%20Category&categorylabel=By%20Category&count=15&start=1&defaultsortname=FAQTitle&returncol=1&key1=Symbian%20Signed)
  
[Foro de desarrolladores sobre Symbian Signed](http://developer.symbian.com/forum/forum.jspa?forumID=2&start=0)

[](http://developer.symbian.com/forum/forum.jspa?forumID=2&start=0)[Update 19/10/2007: añadida la referencia a la firma de aplicaciones gratuitas]