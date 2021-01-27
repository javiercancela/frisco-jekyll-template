---
id: 129
title: 'Redes de telefonía móvil: 3G'
date: 2007-11-15T18:36:24+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/15/redes-de-telefonia-movil-3g/
categories:
  - otros
image: /images/obsolete.jpg
---
3G: un número y una letra tras los que se oculta una maraña de acrónimos, términos técnicos, especificaciones, tecnologías, estándares&#8230; Es casi irónico pensar que todo partió de un intento inicial de establecer un sistema 3G global en la banda de los 2GHz. Este sistema único no prosperó debido a que las principales regiones del mundo ya habían asignado parte de ese espectro a otros usos, por lo que se decidió desarrollar varios estándares distintos diseñados bajo una pauta común. La [Unión Internacional de Telecomunicaciones](http://es.wikipedia.org/wiki/Uni%C3%B3n_Internacional_de_Telecomunicaciones "Unión Internacional de Telecomunicaciones") estableció el estándar global IMT-2000, que define seis interfaces de radio.

Una interfaz de radio es una especificación técnica del acceso a la red, que indica por ejemplo el ancho de banda de cada canal o la codificación de los datos. Así, aunque puede haber más de una tecnología que utilice una interfaz dada, se asegura un mínimo de interoperabilidad. A su vez, cada tecnología puede utilizar diferentes protocolos de transmisión de datos. Para desarrollar las tecnologías que usen estas interfaces se constituyó por parte de diversas asociaciones de telecomunicaciones la [3GPP](http://en.wikipedia.org/wiki/3GPP "3rd Generation Partnership Project"), que basa sus especificaciones en evoluciones de GSM.

**Interfaces**

Veamos cuales son las interfaces definidas por IMT-2000:

  * _IMT-SC, Single Carrier_

También conocido como [EDGE](http://en.wikipedia.org/wiki/Enhanced_Data_Rates_for_GSM_Evolution "Enhanced Data Rates for GSM Evolution"), de la que ya hablamos en un [artículo anterior]({% post_url 2007/2007-11-10-redes-de-telefonia-movil-25g %}).

  * _IMT-MC, Multi-Carrier_

Otro nombre para esta interfaz es CDMA2000. También hablamos de esta tecnología en el anterior artículo, pero sólo para su variante más básica. Las variantes más avanzadas, [EV-DO](http://en.wikipedia.org/wiki/Evolution-Data_Only "Evolution-Data Optimized") y [EV-DV](http://en.wikipedia.org/wiki/CDMA2000#CDMA2000_EV-DV "Evolution-Data/Voice"), son plenamente 3G y alcanzan los 3.1 Mbps (Megabits por segundo).

  * IMT-DS, Direct-Sequence

Otros nombres para esta interfaz son [W-CDMA](http://en.wikipedia.org/wiki/W-CDMA "W-CDMA") o UTRA-FDD. Destacan dos tecnologías que utilizan esta interfaz: [UMTS](http://en.wikipedia.org/wiki/UMTS "Universal Mobile Telecommunications System") y [FOMA](http://en.wikipedia.org/wiki/Freedom_of_Mobile_Multimedia_Access "Freedom of Mobile Multimedia Access"). En un momento hablamos de la primera.

  * IMT-TD, Time-Division

En realidad hay dos interfaces aquí: [TD-CDMA](http://en.wikipedia.org/wiki/UMTS-TDD#TD-CDMA "Time Division - Code Division Multiple Access") y [TD-SCDMA](http://en.wikipedia.org/wiki/TD-SCDMA "Time Division-Synchronous Code Division Multiple Access"). TD-SCDMA es el estándar de referencia elegido en China. Hay que destacar que existe una versión de UMTS, llamada [UMTS-TDD](http://en.wikipedia.org/wiki/UMTS-TDD "UMTS-TDD"), que utiliza IMT-TD orientada a la conexión a Internet; esto es debido a que IMT-DS utiliza multiplexación por división de tiempo, mientras que IMT-TD utiliza multiplexación por división de frecuencia, más adecuada para la naturaleza asimétrica de las conexiones a Internet.

  * IMT-FT, Frequency Time

Esta es la interfaz de [DECT](http://en.wikipedia.org/wiki/DECT "Digital Enhanced Cordless Telecommunications"), el estándar europeo para teléfonos inalámbricos.

  * IMT-OFDMA, TDD WMAN

[WiMAX](http://en.wikipedia.org/wiki/WiMAX "WiMAX"), la última incorporación a IMT-2000. De WiMAX hablaremos en otro artículo.

**UMTS**

El _Universal Mobile Telecommunications System_ (Sistema Universal de Telecomunicaciones Móviles) es la tecnología 3G que ofrecen casi todos los operadores de telefonía en Europa (podemos ver una lista, no sé cómo de actualizada, en este artículo de la Wikipedia: [List of UMTS networks](http://en.wikipedia.org/wiki/List_of_Deployed_UMTS_networks#Europe "List of UMTS networks")). Utiliza la infraestructura de GSM y la interfaz W-CDMA, y soporta tasas de transferencia de hasta 14 Mbps. En la práctica, las redes comerciales disponibles no superan los 3.6 Mbps, y eso con terminales que soporten el protocolo [HSDPA](http://es.wikipedia.org/wiki/HSDPA "High-Speed Downlink Packet Access"). Para terminales con 3G &#8220;clásica&#8221; (R99) la tasa desciende a 386 kbps. Debido a su mayor ancho de banda, a UMTS con HSDPA en ocasiones se le llama 3.5G.

En la actualidad los operadores de telefonía móvil cubren una buena parte del territorio europeo con tecnología HSDPA. Sin embargo, antes de contratar el servicio conviene cerciorarse de que el operador elegido da servicio 3G/HDSPA en la zona que nos interese, y hay que tener en cuenta que necesitaremos un terminal con soporte HDSPA para poder aprovechar este servicio.

### Entradas relacionadas:

[Redes de telefonía móvil: 2G]({% post_url 2007/2007-11-04-redes-de-telefonia-movil-2g %})

[Redes de telefonía móvil: 2.5G]({% post_url 2007/2007-11-10-redes-de-telefonia-movil-25g %})
  
[Redes de telefonía móvil: WiMAX]({% post_url 2007/2007-11-21-redes-de-telefonia-movil-wimax %})