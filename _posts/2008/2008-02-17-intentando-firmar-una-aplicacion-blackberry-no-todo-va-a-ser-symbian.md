---
id: 184
title: Intentando firmar una aplicación BlackBerry (no todo va a ser Symbian)
date: 2008-02-17T12:10:36+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/02/17/intentando-firmar-una-aplicacion-blackberry-no-todo-va-a-ser-symbian/
categories:
  - blackberry
  - ipoki
image: /images/obsolete.jpg
---
Como parte del proceso de desarrollo del plugin de Ipoki para BlackBerry, solicité a RIM unas claves para firmar la aplicación, que utiliza algunas clases marcadas como Signed en la documentación. Estas clases obligan a que la aplicación esté firmada antes de ser instalada en un dispositivo. Para solicitar las claves existen dos posibilidades: rellenar [este formulario](https://www.blackberry.com/SignedKeys/ "BlackBerry Code Signing Keys Order Form"), o descargar esta [versión del formulario en pdf](http://www.blackberry.com/developers/pdfs/JDE%20API%20Key%20Order%20Form.pdf "Order Form"), imprimirla, firmarla y enviarla por fax. La existencia de esta última opción es el primer indicio de que RIM todavía no ha entrado en el siglo XXI.

Conseguir la claves cuesta 20 dólares, una cifra bastante económica que en la [página que describe el proceso de solicitud](http://na.blackberry.com/eng/developers/downloads/api.jsp "Controlled APIs and Code Signing") justifican por los costes administrativos. En realidad se hace fundamentalmente para tener los datos del titular de la tarjeta de crédito. En esta misma página se nos dice qué ocurrirá tras el envío de la solicitud (traducción propia):

> Nota: Típicamente, las claves son enviadas por email en un plazo de 48 horas tras el envío de los formularios necesarios, pero ocasionalmente el proceso puede llevar hasta 10 días laborables. Si no ha recibido sus claves en el plazo de 10 días laborables desde el envío del formulario de registro, por favor póngase en contacto con el soporte de BlackBerry en el número 1-877-255-2377.

Sinceramente, sólo se me ocurre un motivo por el cual puedan tardar diez días en enviarte por correo tres archivos de menos de un KByte que obviamente un ordenador genera de forma inmediata: quieren comprobar mis datos con el FBI. ¿Y el motivo por el cual mi único opción de ponerme en contacto con soporte es un número de teléfono norteamericano (eso sí, [gratuito para llamadas desde USA o Canadá](http://www.bennetyee.org/ucsd-pages/area.html#877 "Area Code Listing, by Number"))? Será para que el FBI pueda rastrear mi llamada&#8230;

Mi experiencia con el proceso transcurrió así: cubro mis datos, doy mi tarjeta y envío el formulario aceptando unas condiciones que por supuesto no he leído. La página me informa de que mi solicitud ha sido procesada, pero a mi correo no llega ninguna confirmación, ningún ticket de seguimiento, nada que me confirme que han tomado nota y que mis 20 dólares van a servir de algo. Tras cuatro días preguntándome si habría escrito bien mi dirección de correo electrónico recibo las claves, en tres correos distintos pero con el mismo texto explicando la instalación de las mismas. La instalación es simple:

> To register the attachment, please follow the instructions below:
> 
> 1) Double-click on the attachment.
  
> 2) If a dialog box appears that states that a private key cannot be found, complete steps 3 through 6 before you continue. Otherwise, proceed to step 7.
  
> 3) Click &#8220;Yes&#8221; to create a new key pair file.
  
> 4) Type a password for your private key, and type it again to confirm.
  
> 5) Click &#8220;Ok&#8221;
  
> 6) Move your mouse to generate date for a new private key.
  
> 7) In the &#8220;Registration PIN&#8221; field, type the PIN number that you supplied on the signature key request form.
  
> 8 ) In the Private Key password field, type a password of at least 8 characters. This is your private key password, which protects your private key. Please remember this password as you will be prompted for it each time signing is attempted.
  
> 9) Click &#8220;Register&#8221;.
  
> 10) Click &#8220;Exit&#8221;.
> 
> Note: All 3 keys (RBB, RCR, RRT) received should be installed on the same PC. The same password must be specified for all keys on the same PC.

Así que hago doble click a una de las claves, le doy a _Yes_ y&#8230; no pasa nada. Pruebo varias veces con cada una de las claves y me cercioro de que efectivamente no funciona. Tras un poco de Google llego a la conclusión de que es culpa de la versión de Java. Teóricamente el JDE 4.1 funciona con Java5 y no con Java6. Esto no es cierto, yo sólo tengo Java6 instalado y el JDE me va perfectamente. Sin embargo, hago la prueba para ver si la firma falla por eso. Instalo Java5 y desinstalo Java6 y&#8230;.¡Tachán! La clave me pide una contraseña para su instalación. Problema resuelto.

Ahora sólo tengo que introducir la clave de privada y la clave de registro y&#8230;

> &#8220;Registration request failed because client ID xxxxxxxxxx is not set up to be registered (that is, the ID was not in the authorisation database)&#8221;

De este no me salva ni Google. Primero porque no hay ninguna referencia a un error con ese texto, y segundo porque tiene toda la pinta de ser algún error en el proceso de registro, no en mi ordenador. Lo único que me queda es ponerme en contacto con el soporte de BlackBerry para contarles lo que me ha ocurrido. Por suerte el correo con las claves incluía también una dirección de correo electrónico de soporte.

De momento no he tenido noticias de RIM; tampoco es que esperase que tuviesen un servicio 24&#215;7 para esto. Por lo que he visto hasta ahora el servicio de firma de aplicaciones de RIM no es todo lo satisfactorio de se podría esperar. Y aún falta la firma real, en la cual se envía un hash del código que RIM debe devolver firmado. Veremos cómo acaba todo.