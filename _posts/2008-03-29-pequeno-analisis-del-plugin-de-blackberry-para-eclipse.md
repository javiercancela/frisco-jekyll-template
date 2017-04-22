---
id: 196
title: Pequeño análisis del plugin de BlackBerry para Eclipse
date: 2008-03-29T22:02:05+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/2008/03/29/pequeno-analisis-del-plugin-de-blackberry-para-eclipse/
categories:
  - blackberry
image: /images/obsolete.jpg
---
Las vacaciones de semana santa, el trabajo y un problema en el servidor, que volvió inaccesible este blog durante varias horas del miércoles, se han conjurado para hacerme establecer un nuevo record de días sin publicar nada. Pero hay mucho sobre lo que escribir, así que confío en que la próxima semana compense esta que acaba.

Contaba en una entrada anterior que había aparecido un [plugin de BlackBerry para Eclipse]({% post_url 2008-03-20-plugin-de-blackberry-para-eclipse %}), sin que yo supiese siquiera que se estaba preparando uno. El JDE de RIM no es un entorno de desarrollo de mi gusto, así he instalado el plugin con la esperanza de que resulte una alternativa más interesante. Y así es.

Al contrario que los plugins habituales de Eclipse, el plugin de BlackBerry es un instalable de Windows que copia en la carpeta plugins del IDE tanto los habituales jar como exes y dlls. Una vez completada la instalación, Eclipse se muestra con una nueva opción en la barra de menús:

[<img src="http://farm3.static.flickr.com/2238/2371285733_81c9686bd2.jpg" height="92" width="500" />](http://farm3.static.flickr.com/2238/2371285733_acab266fcb_o.png)

Desde esta opción podremos acceder a la aplicación de petición de firmas digitales o a algunas propiedades del proyecto:

[<img src="http://farm4.static.flickr.com/3022/2371285695_1b8cab5c78.jpg" height="359" width="500" />](http://farm4.static.flickr.com/3022/2371285695_572f706325_o.png)

La configuración en Eclipse está bastante dispersa, así que el habitual menú _Project->Properties_ de Eclipse podemos definir varias propiedades específicas de Eclipse:

[<img src="http://farm4.static.flickr.com/3251/2371285767_6c8bd81e6e.jpg" height="399" width="500" />](http://farm4.static.flickr.com/3251/2371285767_3ec7eee4db_o.png)

incluyendo el tipo de aplicación: CLDC, Midlet&#8230;

[<img src="http://farm4.static.flickr.com/3035/2371285809_7703de9f18.jpg" height="399" width="500" />](http://farm4.static.flickr.com/3035/2371285809_31a12019fd_o.png)

Y en el menú de ejecución (también en el de depuración) podemos configurar, entre otras cosas, el emulador que queremos usar con acceso a todos los parámetros del mismo:

[<img src="http://farm3.static.flickr.com/2130/2372121072_01889a989a.jpg" height="381" width="500" />](http://farm3.static.flickr.com/2130/2372121072_478f7b1f7d_o.png)

El plugin encontró sin problemas todos los simuladores instalados, y también los que instalé tras el plugin.

En Window->Preferences podemos configurar una opción clave: los componentes BlackBerry a usar, es decir, con qué versión del sistema vamos a compilar. El plugin encuentra tantos las instalaciones completas de JDE como las instalaciones de los componentes independientes, y enlaza la ayuda correspondiente. En esta ventana establecemos también la versión de la JDK a usar:

[<img src="http://farm4.static.flickr.com/3152/2371305165_a49a5b02f6.jpg" height="434" width="500" />](http://farm4.static.flickr.com/3152/2371305165_8e8f104781_o.png)

En resumen, para los que estamos acostumbrados a Eclipse programar para BlackBerry se ha vuelto una experiencia familiar, y para los que no han usado Eclipse antes, este plugin supone una alternativa que sin duda resultará más satisfactoria.