---
id: 163
title: 'Leyendo nuestro GPS desde Java con la JavaME Location API (JSR-179) &#8211; Parte I'
date: 2008-01-07T10:09:33+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/01/07/leyendo-nuestro-gps-desde-java-con-la-javame-location-api-jsr-179-parte-i/
categories:
  - blackberry
  - java-me
image: /images/obsolete.jpg
---
**Introducción**

La especificación [_JSR-179 Location API for J2ME_](http://jcp.org/en/jsr/detail?id=179 "Location API for J2ME") pone a nuestra disposición una serie de clases que permiten acceder desde Java a información relacionada con la posición y el movimiento de nuestro dispositivo.

Lo que vamos a ver es una descripción básica de estas clases. Para probarlo necesitaremos un móvil que implemente al especificación JSR-179, como la mayoría de los Nokia o BlackBerry modernos.

Hay que tener en cuenta que no es necesario que el móvil disponga de GPS. La _Location API_ nos aisla del origen de los datos, que puede ser un GPS o puede ser un servicio de pago proporcionado por la operadora. Debido a esto la API nos ofrece una serie de parámetros para filtrar qué tipo de servicios nos interesan de aquellos disponibles.

**Fuentes de localización
  
** 

En lo referente a localización, existen habitualmente tres fuentes posibles de datos:

&#8211; GPS: nuestro móvil incorpora un GPS, o está conectado a uno (habitualmente a través de Bluetooth).

&#8211; Assisted GPS: además de un GPS, nuestro móvil tiene acceso a información de localización que evita que el GPS pase hasta varios minutos obteniendo esa información de los satélites antes de dar la primera posición. Para ello es necesario un servicio específico ofrecido por algunas operadoras, habitualmente de pago.

&#8211; Cell Id: el móvil no tiene acceso a un GPS, pero sí a un servicio que le proporciona información basada en el identificador de la célula telefónica en la que se encuentra. También suele ser un servicio de pago por parte de las operadoras.

La _Location API_ está preparada para el dispositivo tenga acceso a todo tipo de _Location Providers_ o Proveedores de Localización, que es como se denominan a estas fuentes de datos. Para poder seleccionar entre las opciones actuales y futuras existe una clase que nos permite definir una serie de criterios que deba cumplir el proveedor que nos interese.

**Estableciendo criterios**

La clase `javax.microedition.location.Criteria` proporciona funciones que nos van a permitir filtrar los proveedores de localización disponibles. Veamos qué podemos definir en esta clase:

  * La precisión horizontal y vertical.
  
    Se establece mediante los métodos `setHorizontalAccuracy` y `setVerticalAccuracy`. La precisión de los datos depende de su origen. Así, si indicamos una precisión de 50 metros excluiremos los datos provenientes de localización por celda telefónica, que suelen tener precisiones de cientos de metros, pero aceptaremos los datos del GPS, con precisiones típicas de pocos metros.
  * El permiso para obtener datos a cambio de un precio.
  
    Mediante el método `setCostAllowed(false)` (el valor por defecto es true) impedimos que nos cobren por obtener datos de localización. Esto excluye habitualmente el A-GPS y la localización por celda telefónica, que necesitan comunicación con la red telefónica para obtener la información, además de un posible sobrecoste por el servicio.
  * El nivel de consumo de batería.
  
    A través del método `setPreferredPowerConsumption` podemos indicar si permitiremos un nivel de consumo bajo, medio o alto. Hay que tener en cuenta que es el fabricante del dispositivo quien decide qué es alto, medio o bajo, pero probablemente el uso de un dispositivo GPS interno o bluetooth tendrá un consumo medio o alto.
  * Otros criterios.
  
    El tiempo de respuesta, la velocidad o información relativa a la dirección postal. Para una descripción más extensa, véase la [referencia de la clase `Criteria`](http://www-users.cs.umn.edu/~czhou/docs/jsr179/lapi/javax/microedition/location/Criteria.html "Class Criteria").

**Accediendo al GPS**

Una vez definidos los criterios, obtendremos una referencia al proveedor de contenidos. La clase `LocationProvider` implementa un método estático [`getInstance(Criteria criteria)`](http://www-users.cs.umn.edu/~czhou/docs/jsr179/lapi/javax/microedition/location/LocationProvider.html#getInstance(javax.microedition.location.Criteria) "getInstance") que devuelve un proveedor que se adapte a los criterios que hemos indicado. Si ninguno de los proveedores disponibles encaja en los criterios indicados, el método devolverá `null`. En caso de que no exista ningún proveedor de localización disponible se lanzará una `LocationException`. Es posible llamar a `getInstance` pasando `null` como parámetro: de esta forma se especifican los parámetros menos restrictivos para la selección.

Utilizaremos la instancia obtenida de `LocationProvider` para obtener la posición mediante el método [`getLocation`](http://www-users.cs.umn.edu/~czhou/docs/jsr179/lapi/javax/microedition/location/LocationProvider.html#getLocation(int) "getLocation"). En el podemos especificar un _timeout_, o tiempo que queremos que espere el sistema para obtener una posición. Una vez obtenida dispondremos de un objeto `Location` que contendrá, entre otras cosas, las coordenadas de nuestra ubicación.

**Un ejemplo sencillo**

Juntemos todo en un ejemplo muy sencillo, sólo útil para hacerse una idea del código descrito:

> `// Establecemos los criterios. Queremos sólo un GPS interno o Bluetooth<br />
Criteria criteria = new Criteria();<br />
criteria.setCostAllowed(false);<br />
// Como el valor por defecto de los siguientes parámetros<br />
// es NO_REQUIREMENT, las siguientes líneas no son necesarias<br />
criteria.setHorizontalAccuracy(NO_REQUIREMENT);<br />
criteria.setVerticalAccuracy(NO_REQUIREMENT);<br />
criteria.setPreferredPowerConsumption(NO_REQUIREMENT);`
  
> `<br />
// Aquí falta capturar la posible excepción y verificar que el<br />
// valor devuelto no es null<br />
LocationProvider lp = LocationProvider.getInstance(criteria);<br />
// Con -1 indicamos el timeout por defecto<br />
Location location = lp.getLocation(-1);`
> 
> `Coordinates coordinates = location.getQualifiedCoordinates();<br />
System.out.println("Latitud: " + coordinates.getLatitude());<br />
System.out.println("Longitud: " + coordinates.getLongitude());`

**Referencias**:

[Documentación on-line de la Location API](http://www-users.cs.umn.edu/~czhou/docs/jsr179/lapi/ "JSR179 Location API for J2ME")