---
id: 152
title: 'Consejos para programadores J2ME (y BlackBerry) &#8211; 3'
date: 2007-12-18T17:47:39+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2007/12/18/consejos-para-programadores-j2me-y-blackberry-3/
categories:
  - blackberry
  - java-me
image: /images/obsolete.jpg
---
**_ClassCastException_ o _instanceof_**

Habitualmente se considera la instrucción `instanceof` como una forma muy poco óptima de comprobar si una clase pertenece un objeto. Sin embargo, en [el portal de BlackBerry](http://www.blackberry.net/developers/javaknowledge/general/kpa0203185136.shtml "General Coding Tips") aconsejan utilizar `instanceof` en vez de esperar a capturar una `ClassCastException` (lo cual es lógico, ya que la excepción debería ser siempre más costosa), debido a ciertas optimizaciones que se realizan cuando se hace el cast justo después de la comprobación:

> `if(x instanceof String) {<br />
(String)x.whatever();<br />
} else {<br />
// something else<br />
}`

Estas optimizaciones deberían evitarnos tener que buscar métodos alternativos, como llamadas a métodos virtuales. Son optimizaciones comunes en las JVM de J2SE, pero que no sé si se da en otras implementaciones de J2ME.

**Programación orientada a objetos**

Sin entrar en debates académicos sobre las ventajas e inconvenientes de la programación orientada a objetos, hay que ser consciente de que algunas de las técnicas de este paradigma son especialmente costosas para la máquina. Aunque programemos en Java, que es un lenguaje de clases y objetos, es conveniente ponerse a pensar de una forma más estructurada, buscando ahorrar recursos a costa de incurrir en algunas cosas que nos enseñaron a evitar cuando aprendimos POO. En concreto:

&#8211; Conviene minimizar el número de clases. Ya no se trata de tener una clase para cada entidad que hayamos detectado en el análisis. Sólo queremos las clases indispensables para dar un poco de sentido al código, aunque los métodos que contengan no guarden mucha relación entre sí. Este es el punto más controvertido, ya que podemos limitarnos a meter todo el código en una clase. Sin embargo no se trata de renunciar por completo al mecanismo de clases, tan solo de ser consciente de que estas tienen un coste importante.

&#8211; Como norma general, nada de _getters_ y _setters_. La encapsulación está bien para los PCs, no para los disposivitos móviles. Unas variables miembro con ámbito _protected_ o _public_ funcionarán mejor. El principal motivo para usar _getters_ y _setter_ es proporcionar una interfaz pública estable que nos permita cambiar la implementación interna en el futuro. Salvo que queramos diseñar una librería pública o trabajemos en un proyecto realmente muy grande, no los necesitamos.

&#8211; Nada de crear interfaces. Están muy bien para llevar a cabo una librería extensible, pero como en el punto anterior, es muy probable que no las necesitemos. Y en cuanto a su uso, cuantos menos interfaces implemente nuestra aplicación, mejor. El ejemplo típico es la interfaz `CommandListener`: en vez de implementarla en cada pantalla, es más efectivo implementarla en una sola clase controladora.

&#8211; Nada de clases abstractas. Ver punto anterior.

Lógicamente ninguna de estas recomendaciones se puede tomar como dogma, pero son útiles para recordar que nuestra mentalidad de programador debe cambiar cuando nos enfrentemos a dispositivos móviles.

Entradas relacionadas:
  
[Consejos para programadores J2ME (y BlackBerry) &#8211; 1](http://javiercancela.com/2007/12/07/consejos-para-programadores-j2me-y-blackberry-1/)
  
[Consejos para programadores J2ME (y BlackBerry) &#8211; 2](http://javiercancela.com/2007/12/17/consejos-para-programadores-j2me-y-blackberry-2/)