---
id: 238
title: 'Programando en Android &#8211; NotePad (II)'
date: 2008-06-02T08:00:41+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=238
permalink: /index.php/2008/06/02/programando-en-android-notepad-ii/
categories:
  - android
image: /images/obsolete.jpg
---
**La clase NotesList**
  
La actividad principal de la aplicación NotePad es NotesList, como se puede ver en el _manifest_. La clase NotesList se define en el archivo [NotesList.java](http://code.google.com/android/samples/NotePad/src/com/google/android/notepad/NotesList.html), y es la responsable de la pantalla principal de la aplicación, mostrando una lista de las notas disponibles. Para ello hacemos que esta clase herede de [ListActivity](http://code.google.com/android/reference/android/app/ListActivity.html), un tipo de actividad especial diseñada para enlazarse a un cursor y mostrar los elementos del cursor en una lista.

Al iniciar la aplicación se invoca esta clase a través de su método onCreate:

<div>
  <div style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   1:</span> @Override</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   2:</span> <span style="color:#0000ff;">protected</span> <span style="color:#0000ff;">void</span> onCreate(Bundle icicle) {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   3:</span>     super.onCreate(icicle);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   4:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   5:</span>     setDefaultKeyMode(SHORTCUT_DEFAULT_KEYS);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   6:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   7:</span>     Intent intent = getIntent();</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   8:</span>     <span style="color:#0000ff;">if</span> (intent.getData() == <span style="color:#0000ff;">null</span>)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   9:</span>         intent.setData(NotePad.Notes.CONTENT_URI);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  10:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  11:</span>     setupListStripes();</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  12:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  13:</span>     Uri uri = intent.getData();</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  14:</span>     mCursor = managedQuery(uri, PROJECTION, <span style="color:#0000ff;">null</span>, <span style="color:#0000ff;">null</span>);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  15:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  16:</span>     ListAdapter adapter = <span style="color:#0000ff;">new</span> SimpleCursorAdapter(<span style="color:#0000ff;">this</span>,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  17:</span>             R.layout.noteslist_item, mCursor,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  18:</span>             <span style="color:#0000ff;">new</span> String[] {NotePad.Notes.TITLE},</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  19:</span>             <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">int</span>[] {android.R.id.text1});</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  20:</span>     setListAdapter(adapter);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  21:</span> }</pre>
  </div>
</div>

En la línea 5 simplemente habilitamos los atajos de teclado. Las líneas 7-9 establecen el esquema de datos sobre el que vamos a operar, que se define en la clase NotePad. Lo veremos más adelante.

Las líneas 13 y 14 acceden a los datos. Las referencias a los orígenes de datos son objetos de tipo [Uri](http://code.google.com/android/reference/android/net/Uri.html), y en nuestro caso tienen esta forma:

<div>
  <div style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">static</span> final Uri CONTENT_URI =</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   2:</span>     Uri.parse(<span style="color:#006080;">"content://com.google.provider.NotePad/notes"</span>);</pre>
  </div>
</div>

El enlace entre este Uri y la base de datos se realiza en la clase NotePadProvider, que veremos en otra entrada. Basta decir por ahora que la línea 14 accede a la base de datos para abrir un cursor con las columnas especificadas por PROJECTION, que se define al comienzo de la clase NotesList:

<div>
  <div style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">static</span> final String[] PROJECTION = <span style="color:#0000ff;">new</span> String[] {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   2:</span>     NotePad.Notes._ID, NotePad.Notes.TITLE };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   3:</span> <span style="color:#0000ff;">private</span> Cursor mCursor;</pre>
  </div>
</div>

Como decíamos al principio, la actividad NotesList hereda de ListActivity, lo que le permite mostrar datos en una lista. Para ello creamos un adaptador [ListAdapter](http://code.google.com/android/reference/android/widget/ListAdapter.html), como se muestra en las líneas 16-19. La clase [SimpleCursorAdaptor](http://code.google.com/android/reference/android/widget/SimpleCursorAdapter.html) es un creador genérico de adaptadores, al que indicamos el _layout_ que vamos a usar (en nuestro caso [R.layout.noteslist_item](http://code.google.com/android/samples/NotePad/res/layout/noteslist_item.html)), el cursor que hemos definido, los nombres de las columnas a mostrar (en este caso sólo el título), y los _ids_ de los controles (tienen que ser del tipo TextView) que van a mostrar cada columna. ´

Finalmente el método setListAdapter asigna el ListAdapter a nuestra actividad para mostrar los datos.

Nos queda por ver el método setupListStripes:

<div>
  <div style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;padding:0;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">void</span> setupListStripes() {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   2:</span>     Drawable[] lineBackgrounds = <span style="color:#0000ff;">new</span> Drawable[2];</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   3:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   4:</span>     lineBackgrounds[0] =</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   5:</span>         getResources().getDrawable(R.drawable.even_stripe);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   6:</span>     lineBackgrounds[1] =</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   7:</span>         getResources().getDrawable(R.drawable.odd_stripe);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   8:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   9:</span>     View view = getViewInflate().inflate(</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  10:</span>             android.R.layout.simple_list_item_1, <span style="color:#0000ff;">null</span>, <span style="color:#0000ff;">null</span>);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  11:</span>     TextView v = (TextView)view.findViewById(android.R.id.text1);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  12:</span>     v.setText(<span style="color:#006080;">"X"</span>);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  13:</span>     v.measure(</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  14:</span>         View.MeasureSpec.makeMeasureSpec(View.MeasureSpec.EXACTLY, 100),</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  15:</span>         View.MeasureSpec.makeMeasureSpec(View.MeasureSpec.UNSPECIFIED, 0)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  16:</span>         );</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  17:</span>     <span style="color:#0000ff;">int</span> height = v.getMeasuredHeight();</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:#f4f4f4;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  18:</span>     getListView().setStripes(lineBackgrounds, height);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;line-height:12pt;font-family:consolas, 'Courier New', courier, monospace;background-color:white;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  19:</span> }</pre>
  </div>
</div>

<div>
  Este método es el encargado de dibujar líneas de colores distintos para el fondo de la ventana. Para ello definimos dos objetos <a href="http://code.google.com/android/reference/android/graphics/drawable/Drawable.html">Drawable</a>, que no es más que una clase genérica para objetos dibujables, y a cada uno le asignamos un color (los colores se definen en el archivo <a href="http://code.google.com/android/reference/android/graphics/drawable/Drawable.html">colors.xml</a>).
</div>

<div>
  Las líneas 10 y 11 instancian una vista estándar para mostrar elementos de una lista, y la 12 obtiene el objeto TextView correspondiente al control que previamente hemos visto que mostrará la columna título de las notas.
</div>

<div>
  Las líneas 12-16 hacen lo siguiente: escriben una &#8216;X&#8217; en el control, luego le piden al control que decida las medidas necesarias para mostrar la información, definiendo un ancho máximo y dejando libertad al alto, para que ocupe lo que necesite. Luego obtenemos ese alto, que será el necesario para que el control muestre letras mayúsculas.
</div>

<div>
  La línea 18 llama al método setStripes de la vista asociada a nuestra actividad, que se encarga de establecer un fondo con líneas alternas de los colores definidos al principio y la altura obtenida.
</div>

<div>
  En la próxima entrada hablaremos del menú y de como interactuar con las notas mostradas.
</div>

**Entradas anteriores:**

[Programando en Android &#8211; NotePad (I)](http://javiercancela.com/2008/05/26/programando-en-android-notepad-i/)
  
[Programando en Android &#8211; Conceptos iniciales (II)](http://javiercancela.com/2008/05/19/programando-en-android-conceptos-iniciales-ii/)
  
[Programando en Android &#8211; Conceptos iniciales (I)](http://javiercancela.com/2008/05/12/programando-en-android-conceptos-iniciales-i/)
  
[Programando en Android &#8211; Prólogo](http://javiercancela.com/2008/05/06/programando-en-android-prologo/)