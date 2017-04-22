---
id: 121
title: 'Redes de telefonía móvil: 2G'
date: 2007-11-04T19:55:55+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/04/redes-de-telefonia-movil-2g/
categories:
  - varios
image: /images/obsolete.jpg
---
Una de las preguntas recurrentes de los usuarios de [hipoqih](http://hipoqih.com/ "hipoqih") es: ¿cuánto cuesta utilizar este sistema? La respuesta es que el sistema es gratuito, pero para utilizarlo plenamente es necesario conectarse a Internet desde un dispositivo con GPS, como un móvil. Y si la conexión se realiza con un teléfono móvil puede tener un coste económico.

Como es lógico los operadores ofrecen distintas tarifas, con diferentes planes que se adaptan a las necesidades de sus usuarios. O eso dicen. En el caso de España, [Yoigo](http://yoigo.es/ "Yoigo") ofrece una tarifa de conexión única de 1,39€ al día (no indica ningún límite, no sé si no lo tiene o si no lo han puesto en la web). [Vodafone](http://www.vodafone.es/particulares/internet/conexion/ "Conexión con tu teléfono") cobra 0.50€ + IVA por sesión de 10 minutos o 256KB (lo que se agote antes), pero ofrece varios planes 3G con distintas cuotas de precios y datos transferidos. Algo parecido ocurre con [Orange](http://movil.orange.es/contrato/tarifas_internet_movil/ "tarifas Internet móvil"), aunque no me queda claro cuánto cobran por cada conexión si no tienes ninguna Tarifa Plana contratada. En cuanto a [Movistar](http://www.movistar.es/fwk/cda/controller/controller/0,2189,8887_107734411_9721_0_0,00.html "NAVEGACIÓN Y CORREO PDA"), sin sus Tarifas Planas 3&#8217;5G nos cobrarán 1&#8217;16€ cada 10MB, aunque una vez que llegas a los 100MB el mismo día ya no te cobran hasta el día siguiente.

Así que más o menos ya sabemos cuánto nos van a cobrar y cuánto tráfico nos van a permitir. Nos falta otro dato: el ancho de banda. Paseando por las páginas web de los operadores nos encontramos una serie de términos relacionados con las conexiones a Internet desde el móvil: [GPRS](http://es.wikipedia.org/wiki/General_Packet_Radio_Service "General Packet Radio Service"), [UMTS](http://es.wikipedia.org/wiki/Universal_Mobile_Telecommunications_System "Universal Mobile Telecommunications System"), 3G, 3.5G&#8230; Y no es raro encontrarse en Internet o en medios convencionales otros términos que también parecen tener alguna relación: EDGE, HSPA, 4G&#8230; Para intentar sacarle un poco de sentido a tanto término vamos a realizar un recorrido por la historia más reciente de la telefonía móvil, centrándonos en los tipos de redes usadas para dar este servicio.

Para los que tengan curiosidad por la historia de la telefonía móvil desde sus orígenes, la Wikipedia en español tiene [una breve reseña](http://es.wikipedia.org/wiki/Historia_del_tel%C3%A9fono_m%C3%B3vil "Historia del teléfono móvil"), y la inglesa tiene [abundante información](http://en.wikipedia.org/wiki/History_of_mobile_phones "History of mobile phones"). Yo quiero empezar con la segunda generación, o 2G, que supuso el paso de la telefonía analógica a la digital. En Europa, la historia comienza a principios de los 80, cuando un grupo de 26 países se reune en la _Conference of European Postal and Telecommunications Administrations_ y proyectan un sistema de telefonía celular para toda Europa en la banda de los 900 MHz. En 1990 se publica la especificación DCS1800 (posteriormente GSM1800) para el rango de los 1800 MHz. Las redes comerciales [GSM](http://es.wikipedia.org/wiki/Sistema_Global_para_las_Comunicaciones_M%C3%B3viles "Sistema Global para las Comunicaciones Móviles") comenzaron a operar a mediados de 1991 y siguen activas en la actualidad. El motivo de este acuerdo está el las nueve estándares distintos que existían en la telefonía analógica europea, que imposibilitaba el _roaming_ entre distintos países.

En Estados Unidos, donde no existían estándares tan variados, se eligió un sistema ya existente y más atrasado tecnológicamente que el GSM: [Digital AMPS](http://en.wikipedia.org/wiki/D-AMPS "Digital AMPS") (D-AMPS o IS-54). Esta tecnología sigue siendo la más extendida en Norteamérica, aunque está siendo sustituida en muchos sitios por GSM o [CDMA2000](http://en.wikipedia.org/wiki/CDMA2000 "CDMA2000"). En Japón y en buena parte de Asia la tecnología [PHS](http://en.wikipedia.org/wiki/Personal_Handyphone_System "Personal Handy-phone System") de NTT, en el rango de los 1900 MHz, fue la más habitual durante cierto tiempo, aunque actualmente las migraciones a GSM o a redes 3G han vuelto obsoleta esta tecnología en los países más desarrollados; su bajo coste la hace popular en los países más pobres.

La creciente popularización de Internet durante los años 90 hizo que las operadoras telefónicas comenzaran a pensar cada vez más en servicios orientados a datos en lugar de a voz. Enviar datos a través de redes 2G presenta un problema principal: las comunicaciones entre dos terminales se realizan a través de [conmutación de circuitos](http://en.wikipedia.org/wiki/Circuit_switching "Circuit switching"). Con este sistema se establece durante toda la duración de la llamada un circuito entre los dos terminales, circuito que nadie más puede utilizar. Este sistema es muy efectivo para llamadas de voz, donde el flujo de información es muy constante durante toda la llamada. Pero para otros usos, como navegar por Internet, los datos sólo circulan por la red durante una pequeña fracción de tiempo, quedando el circuito demasiado desocupado. Con un sistema de [conmutación de paquetes](http://es.wikipedia.org/wiki/Conmutaci%C3%B3n_de_paquetes "Conmutación de paquetes") no hay un circuito fijo para comunicar dos nodos, y cada paquete se envía por alguna ruta disponible. Así, la primera etapa de la evolución de los sistemas 2G consistió en la introducción de un servicio de conmutación de paquetes: el GPRS. Lo veremos más a fondo en el próximo artículo.

Más información:
  
http://www.gsmworld.com/technology/what.shtml
  
http://www.privateline.com/PCS/history10.htm
  
[S60 Programming: A Tutorial Guide](http://www.amazon.com/S60-Programming-Tutorial-Guide-Symbian/dp/0470027657/ref=sr_1_1/105-2237837-3087649?ie=UTF8&s=books&qid=1194198047&sr=8-1 "A Tutorial Guide")

**Entradas relacionadas:**
  
### Entradas relacionadas:

[Redes de telefonía móvil: 2.5G]({% post_url 2007-11-10-redes-de-telefonia-movil-25g %})
  
[Redes de telefonía móvil: 3G]({% post_url 2007-11-15-redes-de-telefonia-movil-3g %})
  
[Redes de telefonía móvil: WiMAX]({% post_url 2007-11-21-redes-de-telefonia-movil-wimax %})