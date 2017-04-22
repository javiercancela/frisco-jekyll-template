---
id: 231
title: 'Programando en Android &#8211; NotePad (I)'
date: 2008-05-26T08:00:41+00:00
author: javiercancela
layout: post
guid: http://javiercancela.com/?p=231
categories:
  - android
image: /images/obsolete.jpg
---
La mayoría de los mortales olvidamos cualquier conocimiento abstracto en la décima parte del tiempo que nos costó adquirir dicho conocimiento (dato completamente inventado, pero en mi caso muy próximo a la realidad). Así que lo que vamos a hacer en concretar este conocimiento, y ponernos a programar.

El programa [NotePad](http://code.google.com/android/samples/NotePad/index.html) es un ejemplo que se incluye en la documentación de Google y en la SDK. Es un programa muy simple: permite crear notas, editarlas, borrarlas y modificar el título. Vamos a ver cómo funciona.

**El ejemplo NotePad. El archivo Manifest.
  
** 

Comencemos por el [_Manifest_](http://code.google.com/android/samples/NotePad/AndroidManifest.html "AndroidManifest.xml"), que es donde se definen los componentes de la aplicación. El manifest.xml es, como su extensión indica, un archivo xml, que desde hace unos años se convertido en un formato habitual para contener configuraciones. El elemento raíz se llama manifest y contiene el namespace de la aplicación. Dentro se define el elemento aplicación:

> `<application android:icon="@drawable/app_notes" android:label="@string/app_name">`

Aquí asociamos un nombre y un icono a la aplicación. La &#8216;@&#8217; nos indica una referencia a un recurso. En general tiene este formato: `@[package:]type/name`, donde el paquete es opcional y sólo se indica cuando no pertenece a nuestra aplicación, el tipo corresponde a uno de los definidos en la carpeta `res`, y el nombre indica el identificador del recurso.  En nuestro caso, el icono se encuentra bajo la carpeta `drawable`, y la `app_name` se define en el archivo `strings.xml` de la carpeta `values`.

Dentro del elemento application lo primero que aparece es un provider, que nos dará acceso a la base de datos y que veremos más adelante. Tras él podemos ver definidas tres _Activities_: `NotesList`, `NoteEditor` y `TitleEditor`. Corresponderán a cada una de las ventanas: la que muestra las notas, la que las edita y la que modifica el título. Por ejemplo, este el elemento `TitleEditor`:

> `<activity android:name="TitleEditor" android:label="@string/title_edit_title" android:theme="@android:style/Theme.Dialog">`

Además de indicar el nombre de la actividad, y la etiqueta que aparecerá en la ventana asociada, también especificamos que vamos a utilizar un tema concreto para esta actividad. Los temas nos permiten cambiar el _look&feel_ de las aplicaciones con temas predefinidos o creados por nosotros. En este caso podemos ver como el recurso correspondiente al tema se referencia a través del paquete `android`, ya que está definido en el sistema, no en nuestra aplicación.

Dentro de cada `activity` hay definidos `intent-filters`, que permiten concretar el ámbito en el que se van a ejecutar, como ya vimos [anteriormente](http://javiercancela.com/2008/05/19/programando-en-android-conceptos-iniciales-ii/ "Programando en Android - Conceptos iniciales (II)"). Por ejemplo, en NotesList encontramos:

> `<intent-filter><br />
<action android:name="android.intent.action.MAIN" /><br />
<category android:name="android.intent.category.LAUNCHER" /><br />
</intent-filter>`;

que indica que esta es la actividad principal de la aplicación, y que aparecerá en el menú de aplicaciones del sistema. El filtro

> `<intent-filter><br />
<action android:name="android.intent.action.VIEW" /><br />
<action android:name="android.intent.action.EDIT" /><br />
<action android:name="android.intent.action.PICK" /><br />
<category android:name="android.intent.category.DEFAULT" /><br />
<data android:mimeType="vnd.android.cursor.dir/vnd.google.note" /><br />
</intent-filter>`

nos indica que la actividad está disponible para ver, editar o seleccionar elementos del tipo `vnd.android.cursor.dir/vnd.google.note`, que es el tipo que definiremos más adelante para las notas. Finalmente, el filtro

> <intent-filter>
  
> <action android:name=&#8221;android.intent.action.GET_CONTENT&#8221; />
  
> <category android:name=&#8221;android.intent.category.DEFAULT&#8221; />
  
> <data android:mimeType=&#8221;vnd.android.cursor.item/vnd.google.note&#8221; />
  
> </intent-filter>

permite al usuario seleccionar el tipo de dato `vnd.android.cursor.dir/vnd.google.note`. A diferencia de la acción `android.intent.action.PICK`, donde se selecciona un elemento de un conjunto de datos, aquí se selecciona un tipo de dato para que el usuario haga algo con él.

Todo esto se verá más claro al examinar el código de las actividades.

**Entradas anteriores:**
  
[Programando en Android &#8211; Conceptos iniciales (II)](http://javiercancela.com/2008/05/19/programando-en-android-conceptos-iniciales-ii/)
  
[Programando en Android &#8211; Conceptos iniciales (I)](http://javiercancela.com/2008/05/12/programando-en-android-conceptos-iniciales-i/)
  
[Programando en Android &#8211; Prólogo](http://javiercancela.com/2008/05/06/programando-en-android-prologo/)