---
id: 136
title: Cambios en la máquina virtual Java de S60
date: 2007-11-23T15:59:12+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/11/23/cambios-en-la-maquina-virtual-java-de-s60/
categories:
  - java-me
  - symbian
image: /images/obsolete.jpg
---
Parece que los chicos de Symbian apuestan por Java como lenguaje de desarrollo para su plataforma S60 (que, [recordemos](http://javiercancela.com/2007/10/17/introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-symbian/ "http://javiercancela.com/2007/10/17/introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-symbian/"), es la plataforma entre otros de la mayoría de los teléfonos Nokia). Digo esto porque en la nueva versión de S60, _S60 3rd Edition FP2_, incluirán una nueva versión de la máquina virtual de Java en la que las librerías no irán compiladas dentro del mismo ejecutable, sino que se almacenarán por separado y se cargarán bajo demanda.

Esta nueva arquitectura, además de mejorar el rendimiento, permitirá a Symbian incluir nuevas librerías propias que aumenten la potencia de las aplicaciones Java para S60 (a costa de perder portabilidad a otras plataformas). Así, ya está anunciado el nuevo kit de desarrollo de interfaces de usuario [eSWT](http://wiki.forum.nokia.com/index.php/ESWT "ESWT - Forum Nokia Wiki"), destinado a combatir las limitaciones de [LCDUI](http://www.j2medev.com/api/midp/javax/microedition/lcdui/package-summary.html "Package javax.microedition.lcdui") permitiendo a los desarrolladores Java construir interfaces de usuario similares a las que tienen las aplicaciones nativas.

Habrá que esperar a ver la SDK de la nueva versión de S60 para comprobar qué tal funcionan eSWT y todas la novedades que la nueva Java VM incorpore.

 **Más información:**
  
[http://blogs.s60.com/java/2007/11/new\_java\_features\_of\_3rd\_ed\_fp.html](http://blogs.s60.com/java/2007/11/new_java_features_of_3rd_ed_fp.html)
  
[http://blogs.s60.com/java/2007/10/eswt\_available\_for_development.html](http://blogs.s60.com/java/2007/10/eswt_available_for_development.html)
  
 <http://mobilephonedevelopment.com/archives/492>