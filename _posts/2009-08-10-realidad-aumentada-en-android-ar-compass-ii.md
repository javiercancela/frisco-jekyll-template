---
id: 463
title: 'Realidad aumentada en Android: AR Compass – II'
date: 2009-08-10T07:00:48+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=463
categories:
  - android
image: /images/obsolete.jpg
---
Una vez [obtenida la imagen de la cámara]({% post_url 2009-08-04-realidad-aumentada-en-android-ar-compass-i %}) pasamos a la brújula. Necesitaremos dos cosas: obtener los datos de orientación y dibujarlos en el lugar adecuado. Empezaremos inicializando los sensores y los datos iniciales de la brújula.

**Empezando con OpenGL**

Como dijimos en [la entrada anterior]({% post_url 2009-08-04-realidad-aumentada-en-android-ar-compass-i %}) vamos a usar OpenGL para dibujar la brújula. Una advertencia: antes de realizar esta serie de entradas no sabía nada de OpenGL, así que es probable es que el código que incluyo no sea muy ortodoxo, incluso puede que contenga errores. Aún así funciona correctamente en el HTC Magic.

Para aprender algo de OpenGL utilicé el libro _“The [OpenGL Programming Guide 5th Edition. The Official Guide to Learning OpenGL Version 2.1](http://www.glprogramming.com/red/)”_, también conocido como el _OpenGL Red Book_. Por supuesto hay gran cantidad de tutoriales de OpenGL por internet. Los [ejemplos de Android sobre OpenGL|ES](http://developer.android.com/guide/samples/ApiDemos/src/com/example/android/apis/graphics/index.html) permiten hacerse una idea de cómo usar OpenGL en Android. Algunas de las clases que aparecen en esta entrada están basadas en esos ejemplos.

Lo primero que necesitamos para trabajar con OpenGL es una superficie sobre la que pintar. La SDK incluye una diseñada para OpenGL: [GLSurfaceView](http://developer.android.com/reference/android/opengl/GLSurfaceView.html), un tipo especial de SurfaceView cuya principal característica es que ejecuta el código de renderizado en un thread aparte (llamado GLThread). Para ello, a la vista GLSurfaceView se le asigna un renderizador, que es una clase que hereda de [GLSurfaceView.Renderer](http://developer.android.com/reference/android/opengl/GLSurfaceView.Renderer.html):

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">class</span> CompassRenderer <span style="color:#0000ff;">implements</span> GLSurfaceView.Renderer, SensorEventListener {</pre>
  </div>
</div>

En nuestro caso, dado que esta clase va a renderizar la brújula en base a los datos de los sensores, haremos que implemente también SensorEventListener (como veíamos en [esta entrada]({% post_url 2009-07-20-desarrollo-en-android-acelermetro-magnetmetro-y-sensores-de-orientacin-y-temperatura-en-el-htc-magic %})), para tener los datos en la misma clase.

Pero primero tenemos que decirle a nuestra actividad que use esta vista además de la vista de la cámara:

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> ARCompass <span style="color:#0000ff;">extends</span> Activity {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   2:</span>     <span style="color:#0000ff;">private</span> SensorManager mSensorManager;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   3:</span>     <span style="color:#0000ff;">private</span> CameraView mCameraView;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   4:</span>     <span style="color:#0000ff;">private</span> GLSurfaceView mGLSurfaceView;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   5:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   6:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   7:</span>     <span style="color:#008000;">/** Called when the activity is first created. */</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   8:</span>     @Override</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   9:</span>     <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> onCreate(Bundle savedInstanceState) {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  10:</span>         <span style="color:#0000ff;">super</span>.onCreate(savedInstanceState);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  11:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  12:</span>         <span style="color:#008000;">// Hide the window title.</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  13:</span>         requestWindowFeature(Window.FEATURE_NO_TITLE);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  14:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  15:</span>         mGLSurfaceView = <span style="color:#0000ff;">new</span> GLSurfaceView(<span style="color:#0000ff;">this</span>);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  16:</span>         mGLSurfaceView.setEGLConfigChooser(8, 8, 8, 8, 16, 0);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  17:</span>         CompassRenderer compassRenderer = <span style="color:#0000ff;">new</span> CompassRenderer(true);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  18:</span>         mGLSurfaceView.setRenderer(compassRenderer);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  19:</span>         mGLSurfaceView.getHolder().setFormat(PixelFormat.TRANSLUCENT);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  20:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  21:</span>         setContentView(mGLSurfaceView);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  22:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  23:</span>         mCameraView = <span style="color:#0000ff;">new</span> CameraView(<span style="color:#0000ff;">this</span>);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  24:</span>         addContentView(mCameraView, <span style="color:#0000ff;">new</span> LayoutParams(LayoutParams.WRAP_CONTENT,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">                                                         LayoutParams.WRAP_CONTENT));</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  25:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  26:</span>         mSensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  27:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  28:</span>         List&lt;Sensor&gt; listSensors = mSensorManager.getSensorList(Sensor.TYPE_ACCELEROMETER);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  29:</span>         <span style="color:#0000ff;">if</span> (listSensors.size() &gt; 0)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  30:</span>         {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  31:</span>             mSensorManager.registerListener(compassRenderer, listSensors.get(0),</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">                                                   SensorManager.SENSOR_DELAY_UI);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  32:</span>         }</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  33:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  34:</span>         listSensors = mSensorManager.getSensorList(Sensor.TYPE_MAGNETIC_FIELD);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  35:</span>         <span style="color:#0000ff;">if</span> (listSensors.size() &gt; 0)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  36:</span>         {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  37:</span>             mSensorManager.registerListener(compassRenderer, listSensors.get(0),</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">                                                                   SensorManager.SENSOR_DELAY_UI);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  38:</span>         }</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  39:</span>     }</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  40:</span>  ...</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  41:</span> }</pre>
  </div>
</div>

En las líneas 15-19 creamos la superficie OpenGL, establecemos los componentes de color RGB a 8 bits con profundidad de buffer a 60 bits, creamos nuestra clase CompassRenderer (que veremos después), le decimos a la superficie que vamos a renderizar en la clase CompassRenderer y finalmente establecemos en la superficie un formato de pixel que soporte varios de canal alfa. Este último paso es necesario para que la superficie sea transparente y poder ver lo que hay debajo, que será la imagen de la cámara.

En las líneas 21-24 asociamos la vista OpenGL a la actividad, creamos la vista de la cámara y la añadimos. La vista de la cámara queda así detrás de la vista OpenGL, visible porque esta última tiene una superficie transparente.

El resto del código registra los _Listeners_ del acelerómetro y del sensor de campo magnético.

**La clase Compass**

La clase Compass le indica al renderizador las características del objeto a renderizar. Contiene un método draw que será llamado por el renderizador cada vez que quiera dibujar un frame:

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">class</span> Compass</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   2:</span> {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   3:</span>     <span style="color:#0000ff;">private</span> FloatBuffer   mVertexBuffer;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   4:</span>     <span style="color:#0000ff;">private</span> IntBuffer   mColorBuffer;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   5:</span>     <span style="color:#0000ff;">private</span> ByteBuffer  mIndexBuffer;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   6:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   7:</span>     <span style="color:#0000ff;">public</span> Compass()</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   8:</span>     {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   9:</span>          ...</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  10:</span>     }</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  11:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  12:</span>     <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> draw(GL10 gl)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  13:</span>     {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  14:</span>         gl.glVertexPointer(3, GL10.GL_FLOAT, 0, mVertexBuffer);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  15:</span>         gl.glColorPointer(4, GL10.GL_FIXED, 0, mColorBuffer);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  16:</span>         gl.glDrawElements(GL10.GL_LINES, 32 + 6 + 10 + 8 + 8, GL10.GL_UNSIGNED_BYTE,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">                                mIndexBuffer);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  17:</span>     }</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  18:</span> }</pre>
  </div>
</div>

La clase contiene tres buffers: uno con los vértices de cada primitiva a dibujar (en nuestro caso las primitivas son líneas), otro con los colores, y el último con el orden en el que se van a aplicar cada uno de los vértices. Los buffers se asignan en el constructor, como veremos después, y contienen una descripción de la posición y el color del modelo. En nuestro caso el modelo es una serie de líneas verticales y cuatro letras que se distribuyen en una circunferencia en el plano XY alrededor del punto (0, 0, 0).

La línea 14 define el array de vértices a partir de nuestro buffer. Son vértices de tres coordenadas, de tipo float, sin _stride_ (desplazamiento entre vértices consecutivos, usado para empaquetar información de cada vértice, ver [este artículo](http://web.me.com/smaurice/AppleCoder/iPhone_OpenGL/Entries/2009/4/20_OpenGL_ES_08_-_The_Final_Primitives__Points_and_Lines_in_a_Stride.html) para más información). La línea 15 define el array de colores. Y la línea 16 renderiza las primitivas: indicamos el tipo de primitivas (en este caso líneas) y el número de elementos a renderizar (en este caso vértices, 32 de la brújula, 6, 10, 8 y 8 para cada letra).

Veamos ahora el constructor:

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> Compass()</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   2:</span>  {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   3:</span>      <span style="color:#0000ff;">int</span> one = 0x10000;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   4:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   5:</span>      <span style="color:#0000ff;">int</span> colorLines[] = {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   6:</span>              0,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   7:</span>              0,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   8:</span>        };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">   9:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  10:</span>      <span style="color:#0000ff;">int</span> colorLetters[] = {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  11:</span>              <span style="color:#008000;">//North</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  12:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  13:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  14:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  15:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  16:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  17:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  18:</span>              <span style="color:#008000;">// South</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  19:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  20:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  21:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  22:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  23:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  24:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  25:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  26:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  27:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  28:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  29:</span>              <span style="color:#008000;">// East</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  30:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  31:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  32:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  33:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  34:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  35:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  36:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  37:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  38:</span>              <span style="color:#008000;">// West</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  39:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  40:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  41:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  42:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  43:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  44:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  45:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  46:</span>              one,  one,    0,  one,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  47:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  48:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  49:</span>      <span style="color:#008000;">// Buffers to be passed to gl*Pointer() functions</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  50:</span>      <span style="color:#008000;">// must be direct, i.e., they must be placed on the</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  51:</span>      <span style="color:#008000;">// native heap where the garbage collector cannot</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  52:</span>      <span style="color:#008000;">// move them.</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  53:</span>      <span style="color:#008000;">//</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  54:</span>      <span style="color:#008000;">// Buffers with multi-byte datatypes (e.g., short, int, float)</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  55:</span>      <span style="color:#008000;">// must have their byte order set to native order</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  56:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  57:</span>      <span style="color:#008000;">// (( vertices_per_compass_line * coords_per_vertex * lines_number) </span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  58:</span>      <span style="color:#008000;">// + north_vertices * coords_per_vertex + south_vertices * coords_per_vertex </span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  59:</span>      <span style="color:#008000;">// + east_vertices * coords_per_vertex + west_vertices * coords_per_vertex) </span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  60:</span>      <span style="color:#008000;">// * bytes_per_float</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  61:</span>      ByteBuffer vbb = ByteBuffer.allocateDirect(((2 * 3 * 16) + (6 * 3) + (10 * 3) +</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">                                                       (8 * 3) + (8 * 3)) * 4);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  62:</span>      vbb.order(ByteOrder.nativeOrder());</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  63:</span>      mVertexBuffer = vbb.asFloatBuffer();</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  64:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  65:</span>      <span style="color:#008000;">// ((total_compass_vertices * coords_per_color) + </span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  66:</span>      <span style="color:#008000;">// (north_vertices * coords_per_color)  + (south_vertices * coords_per_color))</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  67:</span>      <span style="color:#008000;">// * bytes_per_int</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  68:</span>      ByteBuffer cbb = ByteBuffer.allocateDirect(((32 * 4) + (6 * 4) + (10 * 4) +</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;">                                                        (8 * 4) + (8 * 4)) * 4);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  69:</span>      cbb.order(ByteOrder.nativeOrder());</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  70:</span>      mColorBuffer = cbb.asIntBuffer();</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  71:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  72:</span>      mIndexBuffer = ByteBuffer.allocateDirect(32 + 6 + 10 + 8 + 8);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  73:</span>      <span style="color:#0000ff;">float</span> x;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  74:</span>      <span style="color:#0000ff;">float</span> y;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  75:</span>      <span style="color:#0000ff;">float</span> z;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  76:</span>      <span style="color:#0000ff;">for</span> (<span style="color:#0000ff;">int</span> i = 0; i &lt; 16; i++)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  77:</span>      {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  78:</span>          <span style="color:#0000ff;">if</span> (i % 2 == 0)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  79:</span>              <span style="color:#0000ff;">if</span> (i % 4 == 0)</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  80:</span>                  z = 6.0f;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  81:</span>              <span style="color:#0000ff;">else</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  82:</span>                  z = 4.0f;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  83:</span>          <span style="color:#0000ff;">else</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  84:</span>              z = 2.0f;</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  85:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  86:</span>          x = (<span style="color:#0000ff;">float</span>)(Math.sin(((<span style="color:#0000ff;">double</span>)i / 16) * 2 * Math.PI) * 32);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  87:</span>          y = (<span style="color:#0000ff;">float</span>)(Math.cos(((<span style="color:#0000ff;">double</span>)i / 16) * 2 * Math.PI) * 32);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  88:</span>          mVertexBuffer.put(x);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  89:</span>          mVertexBuffer.put(y);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  90:</span>          mVertexBuffer.put(-z);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  91:</span>          mIndexBuffer.put((<span style="color:#0000ff;">byte</span>)(2 * i));</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  92:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  93:</span>          mVertexBuffer.put(x);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  94:</span>          mVertexBuffer.put(y);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  95:</span>          mVertexBuffer.put(z);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  96:</span>          mIndexBuffer.put((<span style="color:#0000ff;">byte</span>)(2 * i + 1));</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  97:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  98:</span>          mColorBuffer.put(colorLines);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;">  99:</span>      }</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 100:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 101:</span>      <span style="color:#0000ff;">float</span> north[] = {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 102:</span>          -2.0f, 32.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 103:</span>          -2.0f, 32.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 104:</span>          -2.0f, 32.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 105:</span>          2.0f, 32.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 106:</span>          2.0f, 32.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 107:</span>          2.0f, 32.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 108:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 109:</span>      mVertexBuffer.put(north);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 110:</span>      <span style="color:#0000ff;">byte</span> indices[] = {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 111:</span>              32, 33, 34, 35, 36, 37,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 112:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 113:</span>      mIndexBuffer.put(indices);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 114:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 115:</span>      <span style="color:#0000ff;">float</span> south[] = {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 116:</span>              2.0f, -32.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 117:</span>              -2.0f, -32.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 118:</span>              -2.0f, -32.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 119:</span>              -2.0f, -32.0f, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 120:</span>              -2.0f, -32.0f, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 121:</span>              2.0f, -32.0f, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 122:</span>              2.0f, -32.0f, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 123:</span>              2.0f, -32.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 124:</span>              2.0f, -32.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 125:</span>              -2.0f, -32.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 126:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 127:</span>      mVertexBuffer.put(south);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 128:</span>      indices = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">byte</span>[]{</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 129:</span>              38, 39, 40, 41, 42, 43, 44, 45, 46, 47,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 130:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 131:</span>      mIndexBuffer.put(indices);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 132:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 133:</span>      <span style="color:#0000ff;">float</span> east[] = {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 134:</span>              32.0f, -2.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 135:</span>              32.0f, 2.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 136:</span>              32.0f, -2.0f, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 137:</span>              32.0f, 2.0f, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 138:</span>              32.0f, -2.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 139:</span>              32.0f, 2.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 140:</span>              32.0f, 2.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 141:</span>              32.0f, 2.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 142:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 143:</span>      mVertexBuffer.put(east);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 144:</span>      indices = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">byte</span>[]{</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 145:</span>              48, 49, 50, 51, 52, 53, 54, 55,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 146:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 147:</span>      mIndexBuffer.put(indices);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 148:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 149:</span>      <span style="color:#0000ff;">float</span> west[] = {</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 150:</span>              -32.0f, 2.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 151:</span>              -32.0f, 1.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 152:</span>              -32.0f, 1.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 153:</span>              -32.0f, 0, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 154:</span>              -32.0f, 0, 9.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 155:</span>              -32.0f, -1.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 156:</span>              -32.0f, -1.0f, 7.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 157:</span>              -32.0f, -2.0f, 11.0f,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 158:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 159:</span>      mVertexBuffer.put(west);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 160:</span>      indices = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">byte</span>[]{</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 161:</span>              56, 57, 58, 59, 60, 61, 62, 63,</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 162:</span>      };</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 163:</span>      mIndexBuffer.put(indices);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 164:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 165:</span>      mColorBuffer.put(colorLetters);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 166:</span></pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 167:</span>      mColorBuffer.position(0);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 168:</span>      mVertexBuffer.position(0);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 169:</span>      mIndexBuffer.position(0);</pre>
    
    <pre style="font-size:8pt;overflow:visible;width:100%;color:black;direction:ltr;line-height:12pt;"><span style="color:#606060;"> 170:</span>  }</pre>
  </div>
</div>

Esta parte contiene código aparentemente ilógico, como arrays cuyos valores se asignan a mano en vez de en bucle. La idea es que se vea con más claridad de dónde sale cada cosa y para qué se usa.

La variable colorLines contiene los colores de los dos vértices de una línea (en este caso verde, para una explicación del color ver [esta sección del libro rojo](http://www.glprogramming.com/red/chapter04.html#name2)). Como vamos a crear cada línea en un bucle usaremos siempre ese array. La variable colorLetters contiene el color (amarillo) de cada vértice de cada línea de cada letra. Vamos a asignar los vértices de las letras una a una, así que esta variable contiene un color por vértice.

Después creamos los buffers, teniendo cuidado a la hora de dar el tamaño correcto en bytes de cada array.

En las líneas 76-99 vemos el bucle que crea cada línea de la brújula. Imaginamos un círculo de radio 32 en el plano XY. Las líneas (un total de 16) serán verticales a ese plano, con longitudes de 12 para las correspondientes a N, S, E y O, 8 para las que indiquen NO, NE, SE y SO, y 4 para las demás. La coordenada z se asigna al principio. Después se calculan x e y en función del seno y el coseno del ángulo (dividimos 2*PI en 16 porciones y vamos haciendo las cuentas).  En las líneas 88-96 asignan cada vértice, donde se puede ver que para cada línea de la brújula solo varía la coordenada z.

La variable mIndexBuffer contiene un array de bytes que le indacarán al renderizador en qué orden se deben procesar los vértices (en este array se puede indicar, por ejemplo, que se repitan vértices ya utilizados). El bucle acaba añadiendo los datos de color para cada vértice.

El resto del constructor es más de lo mismo, pero para las letras. Se dibujan las letras N, S, W, E con líneas, de una forma muy simple, y además utilizando como primitivas líneas sueltas, en vez de líneas continuas (se podía haber usado la primitiva GL\_LINE\_STRIP para no repetir los vértices que son comunes a más de una línea).

En la siguiente y última entrada, veremos cómo mostrar todo esto en pantalla.