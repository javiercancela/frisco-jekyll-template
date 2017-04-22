---
id: 211
title: 'Programando en Android &#8211; Conceptos iniciales (I)'
date: 2008-05-12T08:00:19+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=211
categories:
  - android
image: /images/obsolete.jpg
---
El primer paso para [relacionar conceptos]({% post_url 2008-05-06-programando-en-android-prologo %}) es conocer los conceptos. Y en Android existen una serie de conceptos que suponen la piedra y el mortero de cualquier aplicación.

**El archivo `AndroidManifest.xml`**

Este archivo está presente en todas las aplicaciones Android. Su contenido especifica los componentes de la aplicación, así como la configuración global de la misma. Su descripción se muestra en [esta página de la documentación](http://code.google.com/android/devel/bblocks-manifest.html "The AndroidManifest.xml File").

En una aplicación habitual, dentro de este archivo habrá un elemento [`<application>`](http://code.google.com/android/reference/android/R.styleable.html#AndroidManifestApplication "<application>"), dentro del cuál habrá uno o varios elementos `<a title="<activity>" href="http://code.google.com/android/reference/android/R.styleable.html#AndroidManifestActivity"><activity></a>`. Cada uno de estos elementos supone una interacción con el usuario (generalmente una ventana), y se corresponde con una clase que hereda de la clase [`Activity`](http://code.google.com/android/reference/android/app/Activity.html "Activity").

**La clase** _**Activity**_

Según la documentación de Google, una _Activity_ es una cosa única con un objetivo determinado que el usuario puede hacer. Esta es una definición abstracta. Podemos concretar más la definición diciendo que una _Activity_ (es decir, una clase de nuestra aplicación que hereda de la clase `Activity`) se presenta al usuario como una ventana. Esta clase crea una ventana que muestra una interfaz de usuario, la cual está definida a su vez en una instancia de otra clase, la clase [`View`](http://code.google.com/android/reference/android/view/View.html "View").

Cuando se ejecuta una aplicación Android lo primero que se muestra al usuario es la ventana definida por la actividad que esté marcada en el `AndroidManifest.xml` como principal. Las actividades se gestionan como una pila, así que desde una actividad se puede llamar a otra, y cuando esta finaliza se retorna a la actividad inicial.

Una actividad puede estar ejecutándose, en pausa o detenida. Simplificando, está en ejecución cuando es visible e interacciona con el usuario, está en pausa cuando es visible pero otra ventana, transparente o que no ocupe toda la pantalla, tiene el foco, y está detenida cuando no es visible. En todos estos casos la clase mantiene su información.

En la documentación encontramos un gráfico que ilustra el ciclo de vida de una actividad:

[<img class="alignnone size-full wp-image-216" src="/images/uploads/2008/05/activity_lifecycle.png" alt="" width="500" height="686" srcset="/images/uploads/2008/05/activity_lifecycle.png 540w, /images/uploads/2008/05/activity_lifecycle-219x300.png 219w" sizes="(max-width: 500px) 100vw, 500px" />](/images/uploads/2008/05/activity_lifecycle.png)

Aunque no es necesario entender de momento todos los detalles de este gráfico, en él se ven los estados por los que puede pasar una actividad (los óvalos coloreados) y los eventos que se disparan en dichos estados (los rectángulos grises):

  * Cuando se crea una actividad, se invoca el evento `onCreate()`. Este evento sólo se invoca la primera vez que se llama a una actividad, o bien cuando se llama después de que el sistema haya tenido que eliminarla por falta de recursos (más sobre esto en próximos artículos).
  * `onStart()` es el evento invocado cuando cada vez que la actividad se muestra al usuario. Es decir, la primera vez que se muestra, y las veces que en las que vuelve a aparecer tras haber estado oculta. En este último caso, se invoca `onStop()` al desaparecer y `onRestart()` inmediatamente antes de reaparecer.
  * `onFreeze()` y `onPause()` son llamadas secuencialmente cuando otra actividad va a pasar en encargarse de la interacción con el usuario. Tras `onPause()` la actividad permanece en un estado de espera en el que puede ocurrir que la aplicación sea destruida, por lo que estos eventos se usan para consolidar la información que no queremos que se pierda. Si la actividad no se destruye volverá al primer plano con el evento `onResume()`.

La idea importante con la que quedarse es que una actividad que esté pausada o detenida (tras `onPause()` u `onStop()`) puede ser destruida por el sistema si previo aviso, por lo que deberemos encargarnos de guardar antes la información necesaria (durante `onFreeze()` y `onPause()`). Los detalles lo veremos en una próxima entrada.

### Entradas relacionadas:
  
[Programando en Android &#8211; Prólogo]({% post_url 2008-05-06-programando-en-android-prologo %})
  
[Programando en Android &#8211; Conceptos iniciales (II)]({% post_url 2008-05-19-programando-en-android-conceptos-iniciales-ii %})

[Programando en Android &#8211; NotePad (I)]({% post_url 2008-05-26-programando-en-android-notepad-i %})

[Programando en Android &#8211; NotePad (II)]({% post_url 2008-06-02-programando-en-android-notepad-ii %})