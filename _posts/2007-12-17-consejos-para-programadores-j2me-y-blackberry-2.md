---
id: 151
title: 'Consejos para programadores J2ME (y BlackBerry) &#8211; 2'
date: 2007-12-17T14:43:35+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/12/17/consejos-para-programadores-j2me-y-blackberry-2/
categories:
  - blackberry
  - java-me
image: /images/obsolete.jpg
---
**Preprocesado**

Tanto Netbeans como EclipseME soportan directivas de preprocesado, que resultan extremadamente útiles para proyectos dirigidos a más de una plataforma, de forma que no nos volvamos locos con esos pequeños cambios que hacen que nuestro código funcione en una plataforma concreta. Instrucciones del estilo

> `//#ifdef PLATAFORMA1<br />
// Código específico de la Plataforma1<br />
//#endif`

nos ayudan a organizar nuestro código. [Este artículo](http://www.devx.com/wireless/Article/32622 "Automate Your J2ME Application Porting with Preprocessing") incide sobre este asunto.

**Optimización de divisiones**

La idea es: cada vez que quieras dividir por un múltiplo de dos, haz un desplazamiento a la derecha.

> `int i = j / 4;    // lento<br />
int i = j >> 2; // rápido`

Para enteros positivos, lo único que hay que tener en cuenta es que esta división nos redondea hacia abajo (ya que perdemos los bits de la derecha). Entiendo que detrás de esta optimización existen dos circunstancias: algunos procesadores no incluyen hardware específico para divisiones, y en cualquier caso a la máquina virtual de java le resulta más simple desplazar que dividir.

**Gestión de memoria (_Garbage collection_)**

Este es un asunto espinoso. Veamos algunos hechos sobre J2ME y el recolector de basura:

&#8211; No existe ninguna obligación por parte de la JVM de liberar recursos tras una llamada a System.gc(). La máquina virtual puede ignorarnos o esperar a una liberación que tuviese planeada. Incluso es posible que la máquina virtual no tenga _Garbage Collector_.

&#8211; Habitualmente el _Garbage Collector_ se ejecuta en su propio _thread_, lo que ralentizará la ejecución de nuestra aplicación en el momento más inesperado.

&#8211; La única condición que existe para que un objeto sea elegible por el _Garbage Collector_, y por tanto el único control que tenemos sobre el mismo, es que no exista ningún _thread_ vivo que pueda tener acceso al objeto; es decir, o bien todos los _threads_ que tienen referencias al objeto han finalizado, o bien han establecido sus referencias a _null_.

Conclusión: lo importante en la gestión de memoria no es llamar a System.gc() continuamente, sino reducir al mínimo las referencias que tenemos de cada objeto y asegurarnos de ponerlas a _null_ o finalizar el _thread_ tan pronto como sea posible.

Más información: [J2ME Wiki &#8211; Memory Management](http://www.j2meforums.com/wiki/index.php/FAQ#Memory_Management)

Entradas relacionadas:
  
[Consejos para programadores J2ME (y BlackBerry) &#8211; 1](http://javiercancela.com/2007/12/07/consejos-para-programadores-j2me-y-blackberry-1/)