---
id: 441
title: 'Realidad aumentada en Android: AR Compass – I'
date: 2009-08-04T07:00:54+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=441
permalink: /index.php/2009/08/04/realidad-aumentada-en-android-ar-compass-i/
categories:
  - android
image: /images/obsolete.jpg
---
Decíamos en el [anterior artículo](http://javiercancela.com/2009/08/03/realidad-aumentada-en-android-introduccion/) que la realidad aumentada combina datos generados por ordenador con imágenes del entorno obtenidas en tiempo real. La parte complicada es la superposición de los datos sobre la imagen en la posición correcta. Así que vamos a comenzar con una aplicación de realidad _levemente_ aumentada: una brújula virtual.

**AR Compass<img style="display:inline;margin-left:0;margin-right:0;border-width:0;" title="Mi pantalla apunta al noroeste" src="http://localhost/wp-content/uploads/2009/08/compass2.png" border="0" alt="Mi pantalla apunta al noroeste" width="252" height="172" align="right" />**

AR Compass (brújula de realidad aumentada, en inglés queda más _cool_) es una aplicación para Android que muestra una brújula superpuesta a la imagen capturada por la cámara. La brújula consiste en una serie de líneas verticales con el norte, el sur, el este y el oeste marcados.

La aplicación usa OpenGL para mostrar los puntos cardinales sobre la imagen de la cámara. A partir de los datos del acelerómetro y del magnetómetro obtenemos la matriz de rotación que nos permite mostrar la dirección correcta en la pantalla.

**La imagen de la cámara**

Es código para mostrar la imagen de la cámara es bastante simple, y se puede sacar del ejemplo [CameraPreview](http://developer.android.com/guide/samples/ApiDemos/src/com/example/android/apis/graphics/CameraPreview.html):

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> CameraPreview <span style="color:#0000ff;">extends</span> Activity {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   2:</span>     <span style="color:#0000ff;">private</span> Preview mPreview;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   3:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   4:</span>     @Override</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   5:</span>     <span style="color:#0000ff;">protected</span> <span style="color:#0000ff;">void</span> onCreate(Bundle savedInstanceState) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   6:</span>         <span style="color:#0000ff;">super</span>.onCreate(savedInstanceState);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   7:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   8:</span>         <span style="color:#008000;">// Hide the window title.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   9:</span>         requestWindowFeature(Window.FEATURE_NO_TITLE);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  10:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  11:</span>         <span style="color:#008000;">// Create our Preview view and set it as the content of our activity.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  12:</span>         mPreview = <span style="color:#0000ff;">new</span> Preview(<span style="color:#0000ff;">this</span>);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  13:</span>         setContentView(mPreview);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  14:</span>     }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  15:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  16:</span> }</pre>
  </div>
</div>



En la línea 9 indicamos que no queremos que la ventana tenga titulo. Después simplemente instanciamos la vista y se la asignamos a la actividad. La vista es la clase Preview, que hereda de [SurfaceView](http://developer.android.com/guide/samples/ApiDemos/src/com/example/android/apis/graphics/CameraPreview.html). SurfaceView es un tipo de vista que se caracteriza por contener una superficie (un objeto [Surface](http://developer.android.com/reference/android/view/Surface.html)) sobre la que dibujar.

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">class</span> Preview <span style="color:#0000ff;">extends</span> SurfaceView <span style="color:#0000ff;">implements</span> SurfaceHolder.Callback {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   2:</span>     SurfaceHolder mHolder;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   3:</span>     Camera mCamera;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   4:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   5:</span>     Preview(Context context) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   6:</span>         <span style="color:#0000ff;">super</span>(context);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   7:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   8:</span>         <span style="color:#008000;">// Install a SurfaceHolder.Callback so we get notified when the</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   9:</span>         <span style="color:#008000;">// underlying surface is created and destroyed.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  10:</span>         mHolder = getHolder();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  11:</span>         mHolder.addCallback(<span style="color:#0000ff;">this</span>);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  12:</span>         mHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  13:</span>     }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  14:</span> ...</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  15:</span> }</pre>
  </div>
</div>



Además de heredar de SurfaceView, la clase Preview implementa la interfaz [SurfaceHolder.Callback](http://developer.android.com/reference/android/view/SurfaceHolder.Callback.html). La clase [SurfaceHolder](http://developer.android.com/reference/android/view/SurfaceHolder.html) es el contendor que nos da acceso a la superficie, la cual no se suele usar directamente. A través de los métodos de esta interfaz nos enteraremos de cuando se crea, destruye o cambia de tamaño la superficie.

Las líneas 10 y 11 sirven para indicarle al SurfaceHolder que notifique los cambios de la superficie a nuestra instancia. La línea 12 especifica el tipo de superficie a usar, en este caso una que no posee sus propios buffers. No tengo muy claro qué significa esto, pero imagino que el resto de los tipos de superficie tendrán uno o dos buffers para renderizar la imagen, mientras que este tipo necesita que le propercionen los buffers con la imagen a buscar. En cualquier caso es el único tipo con el que funciona la cámara.

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> surfaceCreated(SurfaceHolder holder) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   2:</span>     <span style="color:#008000;">// The Surface has been created, acquire the camera and tell it where</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   3:</span>     <span style="color:#008000;">// to draw.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   4:</span>     mCamera = Camera.open();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   5:</span>     <span style="color:#0000ff;">try</span> {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   6:</span>        mCamera.setPreviewDisplay(holder);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   7:</span>     } <span style="color:#0000ff;">catch</span> (IOException exception) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">   8:</span>         mCamera.release();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">   9:</span>         mCamera = null;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  10:</span>         <span style="color:#008000;">// TODO: add more exception handling logic here</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  11:</span>     }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  12:</span> }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  13:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  14:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> surfaceDestroyed(SurfaceHolder holder) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  15:</span>     <span style="color:#008000;">// Surface will be destroyed when we return, so stop the preview.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  16:</span>     <span style="color:#008000;">// Because the CameraDevice object is not a shared resource, it's very</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  17:</span>     <span style="color:#008000;">// important to release it when the activity is paused.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  18:</span>     mCamera.stopPreview();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  19:</span>     mCamera.release();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  20:</span>     mCamera = null;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  21:</span> }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  22:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  23:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> surfaceChanged(SurfaceHolder holder, <span style="color:#0000ff;">int</span> format, <span style="color:#0000ff;">int</span> w, <span style="color:#0000ff;">int</span> h) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  24:</span>     <span style="color:#008000;">// Now that the size is known, set up the camera parameters and begin</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  25:</span>     <span style="color:#008000;">// the preview.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  26:</span>     Camera.Parameters parameters = mCamera.getParameters();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  27:</span>     parameters.setPreviewSize(w, h);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  28:</span>     mCamera.setParameters(parameters);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#606060;">  29:</span>     mCamera.startPreview();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span style="color:#606060;">  30:</span> }</pre>
  </div>
</div>



En estos tres métodos se notifican los eventos relacionados con la superficie donde mostramos la imagen de la cámara. El primero de ellos es surfaceCreated. El bucle de nuestra aplicación recibe un mensaje indicándole que la superficie ha sido creada, e invoca este método pasándole el SurfaceHolder de la misma. En la línea 4 &#8220;abrimos&#8221; la cámara  y en la 6 le decimos que muestre la imagen de previsualización usando la superficie asociada al _holder_. Si hay algún problema liberamos la cámara.

Cuando la superficie se destruye (por ejemplo, porque se va a iniciar otra actividad) detenemos la previsualización y liberamos la cámara. El ejemplo de la SDK no incluye la llamada a release(), lo que provoca excepciones _Out of memory_ cuando la ventana se destruye y posteriormente se quiere volver a usar la cámara.

El método surfaceChanged se invoca si la superficie cambia de tamaño (si la pantalla gira, por ejemplo). En nuestro ejemplo no se usará, porque vamos a fijar la ventana de la actividad a formato _landscape_.

Para usar la cámara necesitaremos los permisos adecuados, en este caso _<uses-permission android:name=&#8221;android.permission.CAMERA&#8221; />_. Precisamente [la última revisión de la SDK](http://developer.android.com/sdk/RELEASENOTES.html#1.5_r3 "Android 1.5 SDK, Release 3") corrige un error por el cual no se forzaba correctamente este permiso.

En la próxima entrada comenzaremos a usar OpenGL para añadir la brújula sobre la cámara.