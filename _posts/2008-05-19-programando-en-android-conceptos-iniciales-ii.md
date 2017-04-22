---
id: 222
title: 'Programando en Android &#8211; Conceptos iniciales (II)'
date: 2008-05-19T08:00:12+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=222
categories:
  - otros
image: /images/obsolete.jpg
---
**_Intents_**

Si las _Activities_ son básicamente pantallas, las &#8220;intenciones&#8221; o [_Intents_](http://code.google.com/android/reference/android/content/Intent.html "Intent") son la manera de invocar estas _Activities_. La definición breve de la documentación es: &#8220;Un intent es la descripción abstracta de una operación que se va a llevar a cabo&#8221;. O dicho de otro modo, un _Intent_ es una clase que permite especificar una _Activity_ a ejecutar, llamando a uno de los métodos de la clase _Activity_ con ese _Intent_ de parámetro. Parece fácil, pero he de confesar que en la documentación de Android el asunto me pareció un poco confuso, sobre todo por la cantidad de información que puede ir asociada a estas clases.

**Dos formas de llamar a una _Activity_**

Explicitamente o implicitamente. La forma explícita es simple de entender: creamos un Intent indicando el nombre de la clase correspondiente a la actividad y el paquete, llamamos a startActivity (o startSubActivity si queremos que nos notifiquen cuándo finaliza dicha actividad) y listo. El sistema busca la clase y crea la instancia, pasándo los datos que podamos haber añadido al _Intent_ en el objeto _Bundle_ del método _onCreate_ de la nueva instancia.

> `// ClaseActividad1 es la clase de la actividad`
  
> //`que queremos iniciar. El parámetro this indica` 
  
> //`el Context actual, para saber en qué` 
  
> // `package buscar esta clase<br />
Intent i = new Intent(this, ClaseActividad1.class);<br />
// Esta información se recuperará en el objeto Bundle de onCreate<br />
i.putExtra("NombreParametro", valorParametro);<br />
startActivity(i);`

La invocación implícita de una actividad se realiza también a través de la clase _Intent_. Es implícita porque no se indica el nombre de la clase correspondiente a la actividad a invocar, sino que se establecen una serie de criterios, y se deja que el sistema elija una actividad que cumpla esos criterios.

**Intenciones y criterios**

A un _Intent_ podemos asociarle una acción, unos datos y una categoría. Y aquí está el verdadero _quid_ de esta clase.  Las actividades pueden declarar el tipo de acciones que pueden llevar a cabo y los tipos de datos que pueden gestionar. Las acciones son cadenas de texto estándar que describen lo que que la actividad puede hacer. Por ejemplo, <span>android.intent.action.VIEW es una acción que indica que la actividad puede mostrar datos al usuario. Esta acción viene predefinida en la clase Intent, pero es posible definir nuevas acciones para nuestras actividades. La misma actividad puede declarar que el tipo de datos del que se ocupa es, por ejemplo, </span>&#8220;vnd.android.cursor.dir/person&#8221;. También puede declarar una categoría, que básicamente indica si la actividad va a ser lanzada desde el lanzador de aplicaciones, desde el menú de otra aplicación o directamente desde otra actividad. En el AndroidManifest.xml quedaría algo así:

> `<intent-filter><br />
<action android:name="<span>android.intent.action.VIEW</span>" /><br />
<category android:name="android.intent.category.DEFAULT" /><br />
<data android:mimeType="vnd.android.cursor.dir/person" /><br />
</intent-filter>`

Así, para llamar implícitamente a una actividad a través de un _intent_, en vez de asignar el nombre de la clase le asignamos una de las acciones que esta puede llevar a cabo, con el tipo de datos adecuado. Las reglas exactas se indican en la documentación de la clase [IntentFilter](http://code.google.com/android/reference/android/content/IntentFilter.html "IntentFilter").

**Conclusiones**

_Activities_ e _Intents_ son los dos ejes sobre los que gira la arquitectura de las aplicaciones Android. Existen muchos más conceptos importantes, por supuesto, pero a partir de aquí lo mejor es verlo funcionando todo en una aplicación ejemplo. Pero eso será en la próxima entrada.

### Entradas relacionadas:
  
[Programando en Android &#8211; Prólogo]({% post_url 2008-05-06-programando-en-android-prologo %})
  
[Programando en Android &#8211; Conceptos iniciales (I)]({% post_url 2008-05-12-programando-en-android-conceptos-iniciales-i %})
  
[Programando en Android &#8211; NotePad (I)]({% post_url 2008-05-26-programando-en-android-notepad-i %})

[Programando en Android &#8211; NotePad (II)]({% post_url 2008-06-02-programando-en-android-notepad-ii %})