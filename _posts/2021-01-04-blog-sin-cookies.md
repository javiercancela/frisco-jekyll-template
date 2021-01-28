---
title: Cómo montar un blog sin (casi) cookies
date: 2021-01-4 22:00:00 +0200
description: 
categories:
  - blog
image: /images/cookies.jpg

excerpt: Para cumplir la GRDP hay que añadir un aviso de cookies... o no usar cookies
---

# Cómo eliminar las cookies del blog

No creo que la [Agencia Española de Protección de Datos](https://www.aepd.es/es) esté muy pendiente de un blog con 500 visitas al mes alojado en USA, pero aun así hay que tener las cosas en regla. 

La Agencia tiene una práctica [guía de uso de cookies](https://www.aepd.es/sites/default/files/2020-07/guia-cookies.pdf) donde se explica en detalle todo lo que hay que saber para cumplir con la legislación. De todo lo que hay que saber sobre este tema lo más importante es: **si no necesitas cookies, no las uses.**

Las cookies son pequeños archivos que el navegador almacena y asocia a un dominio. Podemos ver qué cookies se almacenan en cada página desde las herramientas del navegador. Por ejemplo, en Chrome pulsamos F12 y vamos a la pestaña Application:

<div style="text-align:center">
    <figure>
        <img alt="Cookies en Chrome." src ="/images/cookies-chrome.jpg" />
        <figcaption>Cookies en Chrome.</figcaption>
    </figure>
</div>

## Qué cookies tenía

Pues únicamente tres: la de [Google Analytics](https://analytics.google.com/analytics/web/), la del sistema de comentarios, [Disqus](https://disqus.com/), y la de [CloudFlare](https://www.cloudflare.com/es-es/). 

### Cómo quitar la cookie de Disqus

Quitando Disqus.

Lo de los comentarios ya no se lleva, y menos en un blog que nadie visita. Si alguien quiere contactar conmigo, por [email](mailto:javier.cancela@hey.com), [Twitter](https://twitter.com/javier_cancela_) o incluso [LinkedIn](https://www.linkedin.com/in/javiercancela).

### Cómo quitar la cookie CloudFlare

[Esperando a que desaparezca](https://blog.cloudflare.com/deprecating-cfduid-cookie/). No es una web que comprometa la privacidad del usuario, pero como explican en el post el nombre queda feo.

¿Que por qué hay una cookie de CloudFlare? Porque es lo que usa Git Hub de proxy inverso, así que en realidad es a CloudFlare a quien llegan inicialmente las peticiones a este blog. Como ocurre con [más del 15% de internet](https://w3techs.com/technologies/details/cn-cloudflare).

<div style="text-align:center">
    <figure>
        <a title="H2g2bob, CC0, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Reverse_proxy_h2g2bob.svg">
          <img alt="Reverse proxy h2g2bob" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Reverse_proxy_h2g2bob.svg/256px-Reverse_proxy_h2g2bob.svg.png"></a>

        <figcaption>Imagen random de un proxy inverso sacada de la Wikipedia.</figcaption>
    </figure>
</div>

### Cómo quitar la cookie de Google Analytics

En principio es sencillo. El código para incluir Analytics es algo así:

```javascript
     <!-- Google Analytics -->
    <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-XXXXX-Y', 'auto');
    ga('send', 'pageview');
    </script>
    <!-- End Google Analytics -->
```

Si queremos deshabilitar las cookies basta con sustituir esto:
```javascript
    ga('create', 'UA-XXXXX-Y', 'auto');
```
por esto:
```javascript
 ga('create', 'UA-XXXXX-Y', {
      'storage': 'none'
    });
```

Problema: perdemos cualquier tipo de seguimiento del cliente. Si yo accedo a una página con esta configuración y hago click en un enlace Google Analytics interpretará ambos accesos como independientes, con lo que no podremos saber cómo navegan los usuarios por nuestro sitio, cuánto tiempo están, etc...

Una solución de compromiso la encontré en [este artículo](https://helgeklein.com/blog/2020/06/google-analytics-cookieless-tracking-without-gdpr-consent/). La idea es no delegar en GA la generación de un id que se almacene temporalmente en el navegador, sino proporcionar un id que podamos generar de forma más o menos individual para cada visitante de nuestra página. El código propuesto en el artículo es este:

```javascript
const cyrb53 = function(str, seed = 0) {
   let h1 = 0xdeadbeef ^ seed,
      h2 = 0x41c6ce57 ^ seed;
   for (let i = 0, ch; i < str.length; i++) {
      ch = str.charCodeAt(i);
      h1 = Math.imul(h1 ^ ch, 2654435761);
      h2 = Math.imul(h2 ^ ch, 1597334677);
   }
   h1 = Math.imul(h1 ^ h1 >>> 16, 2246822507) ^ Math.imul(h2 ^ h2 >>> 13, 3266489909);
   h2 = Math.imul(h2 ^ h2 >>> 16, 2246822507) ^ Math.imul(h1 ^ h1 >>> 13, 3266489909);
   return 4294967296 * (2097151 & h2) + (h1 >>> 0);
};

let clientIP = "{$_SERVER['REMOTE_ADDR']}";
let validityInterval = Math.round (new Date() / 1000 / 3600 / 24 / 4);
let clientIDSource = clientIP + ";" + window.location.host + ";" + navigator.userAgent + ";" + navigator.language + ";" + validityInterval;
let clientIDHashed = cyrb53(clientIDSource).toString(16);

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'YOUR-GA-TRACKING-CODE', {
   'storage': 'none',
   'clientId': clientIDHashed
});
ga('set', 'anonymizeIp', true);
ga('send', 'pageview');
```

Lo que hace este código es generar un hash a partir de la ip del cliente, el user agent, el idioma del navegador y el número de bloques de 4 días desde enero de 1970 (`new Date() / 1000 / 3600 / 24 / 4`), de forma que el hash cambie cada cuatro días.

El problema de este código es que el parámetro más importante es la IP, que desde mi blog no puedo obtener porque no ejecuta código en el servidor. Como alternativa, modifiqué el código para usar un _fingerprint_ basado en la librería [fingerprintjs](https://github.com/fingerprintjs/fingerprintjs):

```javascript
<script>
    function initFingerprintJS() {
        FingerprintJS.load().then(fp => {
            // The FingerprintJS agent is ready.
            // Get a visitor identifier when you'd like to.
            fp.get().then(result => {
                // This is the visitor identifier:
                const visitorId = result.visitorId;


                (function(i, s, o, g, r, a, m) {
                    i['GoogleAnalyticsObject'] = r;
                    i[r] = i[r] || function() {
                        (i[r].q = i[r].q || []).push(arguments)
                    }, i[r].l = 1 * new Date();
                    a = s.createElement(o),
                        m = s.getElementsByTagName(o)[0];
                    a.async = 1;
                    a.src = g;
                    m.parentNode.insertBefore(a, m)
                })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

                ga('create', 'UA-58458863-1', {
                    'storage': 'none',
                    'clientId': visitorId
                });
                ga('set', 'anonymizeIp', true);
                ga('send', 'pageview');
            });
        });
    }
</script>
<script async src="//cdn.jsdelivr.net/npm/@fingerprintjs/fingerprintjs@3/dist/fp.min.js" onload="initFingerprintJS()"></script>
```
La idea es la misma, pero para compensar la falta de IP se usan otros parámetros como la resolución del navegador, los plugins instalados y, en general, cualquier dato que el navegador proporcione que pueda servir para afinar la identificación.

El resultado de este script no es óptimo, y habrá un porcentaje de falsos positivos (usuarios distintos con el mismo id) y falsos negativos (el mismo usuario que aparece como dos distintos tras hacer algún cambio, como mover el navegador), pero es suficiente para tener una idea aproximada de cómo está funcionando el blog sin perjudicar la privacidad de los usuarios ni incumplir la ley.

