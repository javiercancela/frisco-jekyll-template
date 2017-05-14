---
title: Notas rápidas de la semana
date: 2017-05-13 03:00:00 +0200
description: Autenticación en dos pasos, comprimidos con js, y otras cosas
categories:
  - otros
image: /images/varios.jpg
comments: true
---

Algunas notas rápidas sobre cosas que he visto esta semana.

## Nueva autenticación en dos pasos de Google

La autenticación en dos pasos con las cuentas de Google solicita en el primer paso usuario y contraseña, y después envía al móvil un código que se debe introducir en el segundo paso. 

Esta mañana se me ha activado la versión simplificada del mecanismo. Tras preguntarme, durante el login en el ordenador, si quería probarlo, el segundo paso se ha convertido en una simple pregunta en el móvil:

<div style="text-align:center">
    <figure>
        <img alt="Sin necesidad de mensajes SMS" src ="https://2.bp.blogspot.com/-qFPA-JLCm9E/V5ujKPWvyzI/AAAAAAAAEyw/riCGK9YWu8UUGYl-9NElLIBPCidKTTJcACLcB/s1600/Prompt.png" />
        <figcaption>Sin necesidad de mensajes SMS</figcaption>
    </figure>
</div>

Nada de SMSs ni códigos adicionales: simplemente pulsando un botón en el móvil verificamos que el login es legítimo. No sé si es más seguro, pero desde luego es más cómodo.

## ¿_Mashup_?

Buscando información sobre la api de Google Maps me vino a la cabeza la palabra [_mashup_](https://en.wikipedia.org/wiki/Mashup_(web_application_hybrid)), que se utilizaba hace unos años para describir las aplicaciones que mezclan en una aplicación datos obtenidos de otras aplicaciones distintas. El término se usó especialmente con aplicaciones que usaban Google Maps para mostrar todo tipo de información geolocalizada.

Pero mi sensación era que este término dejó de usarse de forma bastante repentina. De hecho, creo que hace años que no me la encuentro es este contexto. Y con motivo, a juzgar por los datos que muestra Google Trends:

<div style="text-align:center">
    <figure>
        <img alt="Evolución del término mashup en los últimos años" src ="/images/mashup-trend.jpg" />
        <figcaption>Evolución del término mashup en los últimos años</figcaption>
    </figure>
</div>

## Zips con javascript en GMail

Google no permite descargar desde GMail una zip que contenga javascript. El servidor detecta que el contenido puede ser peligroso y no permite descargarlo. 

Sin embargo, esta limitación parece sólo de la aplicación web. Usando un cliente de correo electrónico como Thunderbird (que abrí para esto por primera vez desde que instalé Ubuntu) el archivo se descarga sin problemas. Eso sí, conectaros vía IMAP si no queréis descargaros todo el correo que tengáis almacenado en el inbox de GMail (en mi caso, todo el personal correo desde el 2008)

## Visual Studio Code

[Sublime Text 3](https://www.sublimetext.com/3) es un editor estupendo: potente, flexible, multiplataforma y extremadamente rápido. Es superior a las otras opciones que he probado para desarrollo front y Python, creación de documentos Markdown, y gestión de archivos de texto en general.

<div style="text-align:center">
    <figure>
        <img alt="Visual Studio Code, bueno, bonito y barato" src ="/images/vsc.png" />
        <figcaption>Visual Studio Code, bueno, bonito y barato</figcaption>
    </figure>
</div>

Sorprendentemente, la mejora alternativa viene de la mano de Microsoft: [Visual Studio Code](https://code.visualstudio.com/). Gratuito, _open source_, multiplataforma y rápido. Pese al nombre  se parece más a Sublime Text que al [Visual Studio tradicional](https://www.visualstudio.com/es/vs/whatsnew). 

Está orientado al desarrollo desde el inicio, así que incluye de serie depurador para diversos lenguajes, autocompletado, integración con Git... Tiene también un sistema extensiones que permite adaptarlo a casi cualquier necesidad. 

Destaca como entorno de desarrollo _front_, con depuración nativa de javascript, integración con Chrome, _linting_ para diversos sabores de javascript, ... Pero también es una gran herramienta para Python, Go y _scripting_ en general. Totalmente recomendable.
