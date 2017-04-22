---
id: 126
title: 'Redes de telefonía móvil: 2.5G'
date: 2007-11-10T00:02:25+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/10/redes-de-telefonia-movil-25g/
categories:
  - otros
image: /images/obsolete.jpg
---
El término [2.5G](http://en.wikipedia.org/wiki/2.5G "2.5G") se utiliza para referirse al conjunto de tecnologías que se encuentran a medio camino entre la 2G y la 3G. Lógicamente no es un término definido oficialmente en ningún sitio (ni siquiera creo que se le pueda dar mucho sentido al concepto de &#8216;media generación&#8217; que implica), pero es útil para etiquetar algunos protocolos que se quedan un poco cortos para ser 3G.

En realidad, en la mayoría de las ocasiones 2.5G quiere decir [GPRS](http://es.wikipedia.org/wiki/General_Packet_Radio_Service "General Packet Radio Service"). El _General Packet Radio Service_ (algo así como Servicio General de Paquetes por Radio) es un servicio de las redes GSM que nos permite conectarnos a Internet con paquetes de datos (y no estableciendo un circuito, como veíamos en el [artículo anterior]({% post_url 2007-11-04-redes-de-telefonia-movil-2g %})), de forma que se nos pueda aplicar una tarifa por datos transferidos, y no según el tiempo de conexión. Las operadoras añaden a sus estaciones base dos nodos que se encargan de enrutar los paquetes de datos y conectarlos a Internet (ver por ejemplo el artículo [IRM GPRS & 3G Security Overview](http://www.irmplc.com/index.php/74-IRM-GPRS-&-3G-Security-Overview "IRM GPRS & 3G Security Overview"), en inglés). La modificación es sencilla y poco costosa, por lo que todas las operadoras dan cobertura GPRS, pero este sistema obliga a que el tráfico de datos circule sobre la red GSM, y habitualmente con menor prioridad que la información de voz. De las distintas configuraciones GPRS que existen, la mejor de ellas nos proporciona 80 kbps (kilobits por segundo) de bajada y 60 kbps de subida. Además, debido a la baja prioridad de los paquetes de datos, puede existir un retardo (_lag_) muy considerable.

Otra tecnología que en ocasiones se denomina 2.5G es [HSCSD](http://en.wikipedia.org/wiki/High-Speed_Circuit-Switched_Data "High-Speed Circuit-Switched Data") (_High-Speed Circuit-Switched Data_). Es el sistema original con el que GSM transmitía datos, y utiliza la técnica de conmutación de circuitos. La máxima tasa de trasferencia que alcanza es de 57.6 kbps.

[EDGE](http://en.wikipedia.org/wiki/Enhanced_Data_Rates_for_GSM_Evolution "Enhanced Data Rates for GSM Evolution") (_Enhanced Data Rates for GSM Evolution_) es una mejora sobre GPRS que se utiliza sobre todo en Estados Unidos. Aunque técnicamente es una tecnología 3G (como veremos en el siguiente artículo las tecnologías 3G se definen en los estándares de IMT-2000, y EDGE está entre ellos), su baja velocidad de trasferencia hace que se le catalogue como 2.5G (y como dice la Wikipedia, en ocasiones hasta como 2.75G). Su ancho de banda depende del tipo de implementación, pudiendo alcanzar los 236.8 kbps.

La última tecnología 2.5G que mecionaremos es [CDMA2000](http://en.wikipedia.org/wiki/CDMA2000 "CDMA2000"). Al igual que EDGE, CDMA2000 es considerada una tecnología 3G. Sin embargo, su estándar principal, 1xRTT, que suele estar limitado a 144 kbps, y cuyo ancho de banda más frecuente es de unos 80 kbps, no se considera verdaderamente 3G. Esto permite que en algunos países se implante fuera de las frecuencias asignadas a la 3G.

Como vemos, estas tecnologías nos proporcionan anchos de banda típicos de las conexiones a Internet en la época del módem y el teléfono. Pero si se quiere ofrecer un terminal móvil como plataforma real de acceso a Internet debemos ofrecer anchos de banda que permitan navegación instantánea, streaming de vídeo y todos los servicios a los que estamos acostumbrados en nuestro ordenador de sobremesa.

Para eso se creó 3G. Y de eso hablaremos en el próximo artículo.

### Entradas relacionadas:

[Redes de telefonía móvil: 2G]({% post_url 2007-11-04-redes-de-telefonia-movil-2g %})

[Redes de telefonía móvil: 3G]({% post_url 2007-11-15-redes-de-telefonia-movil-3g %})
  
[Redes de telefonía móvil: WiMAX]({% post_url 2007-11-21-redes-de-telefonia-movil-wimax %})