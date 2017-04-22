---
id: 149
title: 'Consejos para programadores J2ME (y BlackBerry) &#8211; 1'
date: 2007-12-07T14:42:14+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/12/07/consejos-para-programadores-j2me-y-blackberry-1/
permalink: /index.php/2007/12/07/consejos-para-programadores-j2me-y-blackberry-1/
categories:
  - blackberry
  - java-me
image: /images/obsolete.jpg
---
Basándome en [un documento](http://www.blackberry.com/knowledgecenterpublic/livelink.exe/fetch/2000/348583/800451/800783/What_is_-_Programming_Tips-_General_Coding_Tips.html?nodeid=800465&vernum=0 "General Coding Tips") de la _Knowledge Base_ de BlackBerry, que es aplicable a dispositivos J2ME en general, voy a exponer una serie de consejos básicos para programadores Java que quieran comenzar a desarrollar en dispositivos móviles.

**Bucles eficientes**

El desarrollo para dispositivos móviles viene marcado por la preocupación extrema (extrema para un programador acostumbrado a PCs y Macs) por el ahorro de recursos. Pese a que ahorrar recursos nunca es malo, en otras plataformas existen factores que suelen tener más peso, como la claridad o economía del código; en los dispositivos móviles estos factores siempre van detrás del consumo de recursos. Un ejemplo:

> `for(int i = 0; i < vector.size(); i++) {<br />
...<br />
}`

Este código nos permite ver en una sola línea que vamos a iterar sobre todos los elementos del objeto vector. Sin embargo no es óptimo en términos de rendimiento:

> `int vectorSize = vector.size();<br />
for(int i = 0; i < vectorSize; i++) {<br />
...<br />
}`

Invocar un método de un objeto en cada iteración del bucle para obtener siempre el mismo resultado es ineficiente, pero con una simple línea más de código nos ahorramos un montón de instrucciones de procesador. De hecho, dado el poco esfuerzo que requiere yo diría que es también una buena práctica para otras plataformas menos limitadas.

En el caso de no importar el orden de iteración, una optimización adicional se consigue con:

> `for(int i = vector.size() - 1; i == 0; i--) {<br />
...<br />
}`

Como la asignación inicial sólo se realiza una vez nos ahorramos una variable local en la pila; y además la comparación se realiza con el valor 0, que es la comparación que más rápidamente se realiza.

En el artículo de la web de BlackBerry que mencioné al principio se sugiere como optimización el cambio del post-incremento de i (i++) por un pre-incremento (++i) por ser este último más rápido. Yo dudo de que esto sea cierto en este caso. El asunto es un tanto complejo, pero no he encontrado ningún razonamiento que sustente esa afirmación, y he encontrado este artículo: [_Eye on performance: Micro performance benchmarking_](http://www.ibm.com/developerworks/library/j-perf12053.html) que parece respaldar lo contrario. Quizás el origen de esta creencia está en C++, donde debido a la forma en la que se sobrecarga el operador ++, el pre-incremento y el post-incremento aplicados a objetos sí presenta diferentes rendimientos.

**Entradas relacionadas:**
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (I)]({% post_url 2007-10-25-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-i %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: J2ME (y II)]({% post_url 2007-10-30-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-j2me-y-ii %})
  
[Introducción al desarrollo de aplicaciones para teléfonos móviles: BlackBerry]({% post_url 2007-11-05-introduccion-al-desarrollo-de-aplicaciones-para-telefonos-moviles-blackberry %})