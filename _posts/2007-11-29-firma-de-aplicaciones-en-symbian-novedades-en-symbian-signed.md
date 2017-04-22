---
id: 143
title: 'Firma de aplicaciones en Symbian: novedades en Symbian Signed'
date: 2007-11-29T17:27:46+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/29/firma-de-aplicaciones-en-symbian-novedades-en-symbian-signed/
categories:
  - symbian
image: /images/obsolete.jpg
---
En una [entrada anterior]({% post_url 2007-10-18-symbian-signed-firma-de-aplicaciones-en-symbian %}) hablábamos de Symbian Signed y mencionábamos que se estaban preparando cambios en el sistema de firma de aplicaciones Symbian. Estos cambios empezarán a tener efecto durante diciembre, pero ya se conoce con detalle en qué van a consistir.

**_Publisher ID_**

Como ocurría hasta ahora, para una parte de los casos será necesario un _Publisher ID_. Este identificador es un certificado digital que permitirá acceder a algunas de las opciones de firma de aplicaciones. A partir de ahora habrá que [obtenerlo de TrustCenter](https://www.trustcenter.de/cs-bin/PublisherID.cgi/en/155102 "TC PUBLISHER ID"), por 200 dólares al año, pero seguirán valiendo los ya existentes de VeriSign.

**Tipos de firma**

Existirán tres sistemas de firma:

_Open Signed_ ****

Es un sistema diseñado para firmar aplicaciones que están en fase de pruebas o se van a destinar a uso personal, pues limita el número de móviles en los que se puede instalar la aplicación.

Para utilizarla bastará con enviar la aplicación a través del sitio de Symbian Signed y proporcionar una dirección de correo electrónico válida. La firma será válida durante 3 años y permitirá firmar un solo dispositivo sin _Publisher ID_ (es necesario asociar un IMEI al certificado), o un máximo de 1000 dispositivos si tenemos un _Publisher ID_.

_Express Signed_

Con esta opción necesitaremos siempre un _Publisher ID_ y una cuenta en Symbian Signed. Al enviar las aplicaciones para su firma nos comprometemos a que estas cumplan el _Symbian Signed Test Criteria_ (ver más adelante) y pagaremos 20 dólares por cada firma, que tendrá una duración de diez años.

_Certified Signed_

Este sistema añade al anterior el requisito de que la aplicación haya sido probada por una _Test House_ acreditada, lo cual acarreará un coste económico. A cambio las aplicaciones tendrán acceso a capacidades del dispositivo no accesibles con una firma _Express Signed_.

Una explicación del proceso completo se puede encontrar en [esta guía [pdf]](http://developer.symbian.com/main/learning/press/books/pdf/large_symbian_signed.pdf "A Guide to Symbian Signed").

En [este documento [pdf]](http://developer.symbian.com/main/downloads/files/Symbian_Signed_Grid.pdf "Symbian Signed Grid") podemos ver un cuadro resumen.

**_Capabilities_ (Capacidades)**

Se dividen en tres tipos (podemos ver una lista de la funciones incluidas en cada capacidad en [esta página](http://www.symbian.com/developer/techlib/v9.1docs/doc_source/guide/N10022/GT_9.1/FunctionsByCapablity.html "Functions listed by capability")):

_De usuario_

LocalServices, Location, NetworkServices, ReadUserData, UserEnvironment y WriteUserData.

Están siempre disponibles, aunque en ocasiones se requiere de la aceptación de usuario para usarlas.

_De sistema_

PowerMgmt, ProtServ, ReadDeviceData, SurroundingsDD, SwEvent, TrustedUI y WriteDeviceData las podemos usar siempre.

CommDD, DiskAdmin, NetworkControl y MultimediaDD sólo las podremos usar con _Certified Signed_ o con _Open Signed_ y el _Publiser ID._

_De fabricante_

AllFiles, DRM y TCB. Además de requerir _Certified Signed_ o _Open Signed_ y _Publiser ID_ necesitan también aprobación del fabricante del dispositivo.

**_Symbian Signed Test Criteria_**

El conjunto de pruebas que una aplicación debe superar para poder ser firmada. Con estas pruebas Symbian pretende garantizar que la aplicación se comporta correctamente, sin causar ningún tipo de problema al usuario del dispositivo.

Por ejemplo se pide que la aplicación se ejecute correctamente, finalice correctamente, que se pueda finalizar desde la barra de tareas, que no interfiera en las llamadas de voz, que maneje bien situaciones de baja memoria&#8230; Algunas pruebas son obligatorias siempre y otras sólo cuando se quieren utilizar ciertas capacidades.

La descripción completa del test está en [este documento [pdf]](http://developer.symbian.com/wiki/download/attachments/2208/Symbian+Signed+Test+Criteria+3.0.0_ISSUED.pdf?version=1 "Symbian Signed Test Criteria (v3.0.0 ISSUED)").

**Detalles adicionales**

Este sistema entrará en funcionamiento durante diciembre del 2007. En el caso de Series 60, la firma de aplicaciones no es obligatoria en ningún sistema anterior a S60 3rd Ed. Para dispositivos S60 3rd Ed. la instalación de aplicaciones sin firma será posible si el fabricante del dispositivo lo permite y aun así, si la aplicaciones hace uso determinadas capacidades será necesario que el usuario configuré el móvil para permitir instalaciones de aplicaciones sin firma.

**Más información:**
  
http://developer.symbian.com/main/signed/
  
http://developer.symbian.com/wiki/display/sign/Symbian+Signed+Test+Criteria