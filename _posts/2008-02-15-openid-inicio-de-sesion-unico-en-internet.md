---
id: 82
title: 'OpenID: inicio de sesión único en Internet'
date: 2008-02-15T13:30:48+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/?p=82
categories:
  - internet
image: /images/obsolete.jpg
---
Una de las consecuencias del boom de esta cosa llamada Web2.0, en la que las aplicaciones web se cuentan por cientos o miles, es la necesidad de mantener un usuario con su contraseña para cada uno de esos sitios. Tenemos que elegir entre memorizar varias contraseñas y recordar dónde se usa cada una, o bien, como suele ser más común, utilizar el mismo usuario y contraseña (quizás un par de ellas) para todos los sitios que frecuentamos. Esta última opción es bastante peligrosa, pues basta con que alguien con malas intenciones nos capture una contraseña ([y a veces no por nuestra culpa](http://www.codinghorror.com/blog/archives/000953.html "You're Probably Storing Passwords Incorrectly")) para que todas nuestras cuentas queden expuestas.

Una solución habitual a este problema son los sistemas _Single Sign-On_ (Inicio de sesión único), que permiten que nos identifiquemos ante un solo sistema, el cual se encargará de acreditar nuestra identidad a los demás sistemas a los que queramos acceder. Los _Single Sign-On_ son frecuentes en entornos corporativos, donde no tiene sentido que los usuario se autentiquen ante cada aplicación si ya se han autenticado inicialmente en el sistema (al iniciar sesión en la red corporativa, por ejemplo). En internet, sin embargo, el inicio de sesión único sólo está presente para los servicios de una misma empresa (puedo acceder con mi usuario de Google a todos los servicios de Google, con mi usuario de Yahoo! a todos los servicios de Yahoo!, etc.). Para que yo pudiese acceder a los servicios de Yahoo! con mi cuenta de Google, ambos sistemas tendrían que establecer algún tipo de protocolo para poder transmitir información de identificación de usuarios, y además comprometerse a confiar en ella.

Algo así es lo que pretende [OpenID](http://openid.net "OpenID.net"). Desarrollado por Brad Fitzpatrick, el creador del popular sistema de _blogging_ [LiveJournal](http://www.livejournal.com/ "LiveJournal"), OpenID aspira a convertirse en un estándar de internet que permita a los usuarios utilizar una única cuenta para acceder a los servicios que utilice.

**¿Cómo funciona?**

El funcionamiento básico es el siguiente: el usuario crea una cuenta con un proveedor de identidades de OpenID por el procedimiento habitual, con un usuario y una contraseña. A cambio, el proveedor de OpenID da al usuario un identificador, que típicamente es una URL, del estilo http://usuario.dominioop.com. Por ejemplo, yo tengo una cuenta en el proveedor myopenid.com que se llama http://javiercancela.myopenid.com/. Se puede consultar una lista de proveedores aquí: <a href="http://wiki.openid.net/OpenIDServers#Identity_Providers" title="Public OpenID Providers" target="_blank">Public OpenID Providers</a>.

Con este identificador el usuario se dirige al sitio al que quiera acceder con su OpenID (voy a elegir para el ejemplo [Plaxo](http://www.plaxo.com "Plaxo"), una lista de posibles sitios se puede consultar aquí: [Directorio de sitios OpenID](https://www.myopenid.com/directory "Directorio de sitios OpenID")) En la pantalla de inicio de sesión se muestra un recuadro para iniciar sesión con OpenID, que tendrá además este icono: <img src="http://www.plaxo.com/images/openid/login-bg.gif" height="16" width="16" />:

[![Inicio de sesión en Plaxo](http://localhost/wp-content/uploads/2008/02/plaxo.png)](http://localhost/wp-content/uploads/2008/02/plaxo.png "Inicio de sesión en Plaxo")

Al introducir el identificador (http://javiercancela.myopenid.com) el usuario será redirigido al sitio de su proveedor (en mi caso myopenid.com), donde iniciará sesión con su usuario y contraseña (salvo que alguna cookie mantenga la sesión iniciada). Su proveedor le preguntará si quiere confirmar su identidad al servicio al que intenta acceder (en mi caso, Plaxo):

[![Verificación de OpenID](http://localhost/wp-content/uploads/2008/02/verificacion.png)](http://localhost/wp-content/uploads/2008/02/verificacion.png "Verificación de OpenID")

Una vez completado el proceso el usuario se habrá identificado ante el servicio en cuestión sin necesidad de proporcionarle un usuario y una contraseña. Este servicio tendrá acceso además a la información del perfil que haya proporcionado a su proveedor. Así, Plaxo puede saber mi dirección de correo electrónico o mi fecha de cumpleaños, si he proporcionado esta información a myOpenID.com.

**OpenID en nuestra web** 

OpenId es un estándar abierto, así que no es necesario pedir permiso a nadie para convertirse en un proveedor de OpenID. Existen varias herramientas para ello, y aunque la información sobre cómo utilizarlas no es (aún) abundante, dejo aquí un par de enlaces que he encontrado (eso sí, en inglés):

  *  [Run your own identity server](http://wiki.openid.net//Run_your_own_identity_server "Run your own identity server")

  * [Setting up your own OpenID Server](http://www.notsorelevant.com/2007-05-03/setting-up-your-own-openid-server/ "Setting up your own OpenID Server") .

En caso de que simplemente queramos que nuestros usuarios puedan usar sus identificadores OpenID para acceder a nuestro sitio, este tutorial que he visto en Plaxo lo explica todo bastante bien (también en inglés):

  * [A Recipe for OpenID-Enabling Your Site](http://www.plaxo.com/api/openid_recipe "A Recipe for OpenID-Enabling Your Site")

**Situación actual**

OpenID se ha apuntado varios éxitos últimamente, primero con la incorporación de Yahoo! y sus millones de usuarios al proyecto ([Yahoo To Become an OpenID Provider, Giving 248 Million Users Web-Wide Identities](http://blog.wired.com/monkeybites/2008/01/yahoo-leverages.html "Yahoo To Become an OpenID Provider, Giving 248 Million Users Web-Wide Identities")), y posteriormente con la incorporación de Microsoft, Google, Yahoo!, IBM y VeriSign al _<span>OpenID Foundation Board</span>_, el organismo que promociona y supervisa las tecnología y la comunidad OpenID. Sin embargo, más que una apuesta decidida por un estándar abierto de autenticación en internet, estas incoporaciones parecen más bien tomas de posición en una iniciativa con mucho potencial pero todavía con muchas dudas.

Recordando lo que explicábamos anteriormente, existen dos roles que un sitio de internet puede adoptar respecto a OpenID: proveedor de identidad, y cliente de un proveedor. Lógicamente, lo que interesa a los usuarios es que haya el mayor número de clientes; una vez que han elegido su proveedor favorito (su cuenta de Yahoo!, WordPress, myOpenID&#8230;) sólo necesitan que sus sitios habituales les permitan utilizar el identificador de este proveedor. Sin embargo, lo que realmente interesa a las empresas de internet es posicionarse como proveedores. Yahoo!, al permitir que sus cuentas se usen como identificadores OpenID, ha conseguido acceso a un montón de información sobre los hábitos de navegación de sus usuarios. Como además Yahoo! no permite que se usen cuentas OpenID para acceder a sus propios servicios su incorporación al proyecto es todo ganancia. Google hace algo similar en Blogger: las direcciones de BlogSpot se pueden usar como OpenId (si se habilitan para ello), pero las demás cuentas OpenID sólo se pueden usar para comentar en Blogger (algo que probablemente fue la motivación original del sistema, que como dijimos creó el fundador de LiveJournal). Microsoft tiene su propio sistema de autenticación: [Windows CardSpace](http://en.wikipedia.org/wiki/Windows_CardSpace "Windows CardSpace"). Sin embargo, más que una alternativa a OpenID CardSpace es un sistema complementario: permite al usuario autenticarse ante alguien (que puede ser un proveedor OpenID) con un sistema de tarjetas de identidad digitales.

**Conclusiones**

Un sistema de _Single Sign-On_ distribuido como este presenta dos problemas principales: por un lado la privacidad de nuestros datos, ya que nuestro proveedor de autenticación tendrá acceso a todos los sitios que visitemos usando su identificador; por otro lado la seguridad: el sistema de redirección utilizado nos hace vulnerables a sitios que, fingiendo aceptar nuestro OpenID, nos redirijan a una falsificación de la página de autenticación de nuestro proveedor para hacerse con nuestra contraseña, y por tanto con nuestro identificador OpenID.

OpenID es una iniciativa todavía en construcción (en beta, podríamos decir), pero con opciones de convertirse en un estándar de internet si recibe el apoyo necesario. Ya veremos si lo consigue.