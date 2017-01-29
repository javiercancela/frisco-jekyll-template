---
title: Un blog en GitHub (y V - Últimos ajustes)
date: 2017-02-19 03:00:00 +0200
description: La experiencia de montar un blog en GitHub
categories:
  - blog
  - github
image: https://source.unsplash.com/V4EOZj7g1gw/2000x1322
comments: true
---
Los blogs, y los sites en general, albergados en GitHub son totalmente estáticos. Es decir, al acceder a una url de nuestro blog no se ejecuta código en el servidor, tan solo se devuelven archivos html, js, css, multimedia, ... tal como están guardados en el mismo.

Las partes dinámicas que pueda haber (comentarios en los posts, formularios de contacto, ...) se consiguen mediante integraciones con otras páginas web. Como ejemplo, este blog tiene comentarios en las entradas, pero todo el código relativo a ellos se encuentra en el servidor de [Disqus](https://disqus.com/).

## Jekyll y GitHub Pages
En los posts anteriores hemos visto cómo utilizar un lenguaje de marcado, [Liquid](http://shopify.github.io/liquid/), para generar dinámicamente algunas partes del sitio web. Podría pensarse entonces que Jekyll funciona como un servidor de aplicaciones generando estas páginas según las vamos solicitando. Sin embargo, lo que hace Jekyll es compilar los archivos con Liquid, y los demás recursos del repositorio, para generar un sitio web estático convencional que almacena en la carpeta `_site`.

Hasta ahora hemos dejado que el Jekyll de GitHub se encargase de la generación del site. Al subir nuestro código al repositorio GitHub Pages se encarga de realizar la compilación, tal como ocurre cuando la hacemos en local con 
```
bundle exec jekyll serve
```

## Generación fuera de GitHub

Pero hay una diferencia: por motivos de seguridad GitHub Pages restringe qué plugins se pueden utilizar en el repositorio. La lista concreta de plugins, así como sus versiones y las versiones de los demás componentes utilizados, la podemos ver [aquí](https://pages.github.com/versions/).

Uno de los plugins más útiles excluidos por GitHub Pages es `jekyll-archive`, que se encarga de generar una estructura de carpetas y páginas para poder acceder a un archivo del blog por fechas o por tags. Este blog utiliza este plugin para poder mostrar todos los posts de una etiqueta específica. Así que vamos a ver cómo podemos librar a nuestras páginas de esta restricción.


### Generación local
La primera opción para usar este plugin, o cualquier otro, es utilizar la compilación del Jekyll local. Para servir nuestro site, GitHub Pages analiza el contenido de la carpeta `master` de nuestro repositorio `nombreusuario.github.io` (al menos en páginas personales). Si en el directorio raíz del repositorio no hay un archivo `_config.yml`, GitHub Pages servirá los contenidos existentes como un servidor web normal. Así, si subimos a `master` el contenido de nuestra carpeta `_site` local (sólo el contenido, sin la carpeta en sí) tendremos publicado en GitHub Pages el mismo sitio web que está publicando nuestro Jekyll local.

### Codeship
Otra opción interesante la encontré en este post: [Deploying a Jekyll Site to Github Pages Without Using Github’s Jekyll](https://www.drinkingcaffeine.com/deploying-jekyll-to-github-pages-without-using-githubs-jekyll/) (en inglés). La idea aquí es utilizar una aplicación web de integración continua para generar la compilación en dicho sitio, y copiar los contenidos automáticamente en el repositorio. El post utiliza como ejemplo [Codeship](https://codeship.com/), que permite lanzar, al detectar un cambio en nuestro repositorio, un script en una máquina virtualizada que ya tiene todo el software que necesitamos. Este es el sistema que yo utilizo: Codeship se dispara cuando hay cambios en la rama `release` de mi repositorio, y lanza este script:
```
git  clone git@github.com:javiercancela/javiercancela.github.io.git _site
cd _site
git checkout master || git checkout --orphan master
cd ..
rm -rf _site/**/* || exit 0
bundle install
bundle exec jekyll build
cd _site
git config user.email <mi email>
git config user.name "javiercancela"
git add -A .
git commit -m "Deploy to Github Pages: ${CI_COMMIT_ID} --skip-ci"
git push origin master
```
De esta forma, cada vez que publico una nueva versión en la rama `release`, se publica en GitHub Pages una versión compilada sin restricciones de plugins.

## Imágenes
GitHub Pages tiene un límite de 1GB para el tamaño de los sites alojados. Aunque es un límite amplio, si no queremos superarlo tenemos que tener un poco de cuidado con el tamaño de los archivos que subamos. Una buena práctica es alojar los archivos multimedia en aplicaciones destinadas a ellos, como [YouTube](https://www.youtube.com/) para vídeos. Para los imágenes yo estoy usando [Unsplash](https://unsplash.com/), un repositorio de imágenes muy fácil de usar, que descubrí gracias a la plantilla de Jekyll que estoy usando.

## Conclusión
GitHub Pages no es el alojamiento más indicado para cualquier persona que quiera crear un blog personal, pero es una gran opción parar quien quiera crear, sin pagar nada, un blog completamente personalizado. A cambio, eso sí, de emplear un poco de esfuerzo adicional.

