---
id: 478
title: Nunca se sabe cuándo vas a acabar en la isla…
date: 2009-08-23T18:52:25+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/2009/08/23/nunca-se-sabe-cundo-vas-a-acabar-en-la-isla/
categories:
  - android
image: /images/obsolete.jpg
---
… y los creadores de Android lo han tenido en cuenta.

Echando un vistazo al [código fuente de Android](http://source.android.com/download) para comprobar unas cosas de la clase SensorManager me encontré con esto:

<pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#0000ff;">public</span> <span style="color:#0000ff;">static</span> <span style="color:#0000ff;">final</span> <span style="color:#0000ff;">float</span> GRAVITY_THE_ISLAND      = 4.815162342f;</pre>

&#160;

La verdad es que está [documentado y disponible en la clase SensorManager](http://developer.android.com/reference/android/hardware/SensorManager.html#GRAVITY_THE_ISLAND), pero no había reparado en ello hasta ahora.

También han tenido en cuenta otra posible ubicación de nuestro móvil, aunque no estoy seguro de que Vodafone tenga cobertura aquí:

<div id="codeSnippetWrapper">
  <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#0000ff;">public</span> <span style="color:#0000ff;">static</span> <span style="color:#0000ff;">final</span> <span style="color:#0000ff;">float</span> GRAVITY_DEATH_STAR_I    = 0.000000353036145f;</pre>
  
  <p>
    </div>