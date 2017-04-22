---
id: 472
title: 'Realidad aumentada en Android: AR Compass – III'
date: 2009-08-17T07:00:49+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=472
permalink: /index.php/2009/08/17/realidad-aumentada-en-android-ar-compass-iii/
categories:
  - android
image: /images/obsolete.jpg
---
La entrada anterior se centró la clase Compass, que describe la brújula. También presentaba la clase CompassRenderer, que es la encargada de dibujarla en su sitio. Vamos a ver esta clase con más detalle.

**La clase CompassRenderer**

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum1" style="color:#606060;">   1:</span> <span style="color:#0000ff;">class</span> CompassRenderer <span style="color:#0000ff;">implements</span> GLSurfaceView.Renderer, SensorEventListener {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum2" style="color:#606060;">   2:</span>         <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span>   mAccelerometerValues[] = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">float</span>[3];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum3" style="color:#606060;">   3:</span>         <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span>   mMagneticValues[] = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">float</span>[3];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum4" style="color:#606060;">   4:</span>         <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span> rotationMatrix[] = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">float</span>[16];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum5" style="color:#606060;">   5:</span>         <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span> remappedRotationMatrix[] = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">float</span>[16];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum6" style="color:#606060;">   6:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum7" style="color:#606060;">   7:</span>         <span style="color:#0000ff;">private</span> Compass mCompass;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum8" style="color:#606060;">   8:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum9" style="color:#606060;">   9:</span>     <span style="color:#0000ff;">public</span> CompassRenderer() {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum10" style="color:#606060;">  10:</span>         mCompass = <span style="color:#0000ff;">new</span> Compass();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum11" style="color:#606060;">  11:</span>     }</pre>
  </div>
</div>

La clase CompassRenderer cumple dos funciones: capturar la información de los sensores y renderizar la brújula con esa información.

**Implementación de la interfaz SensorEventListener**

Como hemos visto en otras entradas, el método onSensorChanged es invocado cada vez que hay nueva información disponible de alguno de los sensores a los que nos hemos subscrito:

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum1" style="color:#606060;">   1:</span> @Override</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum2" style="color:#606060;">   2:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> onSensorChanged(SensorEvent event) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum3" style="color:#606060;">   3:</span>        <span style="color:#0000ff;">synchronized</span> (<span style="color:#0000ff;">this</span>) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum4" style="color:#606060;">   4:</span>             <span style="color:#0000ff;">switch</span>(event.sensor.getType()) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum5" style="color:#606060;">   5:</span>             <span style="color:#0000ff;">case</span> Sensor.TYPE_ACCELEROMETER:</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum6" style="color:#606060;">   6:</span>                 mAccelerometerValues = event.values.clone();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum7" style="color:#606060;">   7:</span>                 <span style="color:#0000ff;">break</span>;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum8" style="color:#606060;">   8:</span>             <span style="color:#0000ff;">case</span> Sensor.TYPE_MAGNETIC_FIELD:</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum9" style="color:#606060;">   9:</span>                 mMagneticValues = event.values.clone();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum10" style="color:#606060;">  10:</span>                 <span style="color:#0000ff;">break</span>;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum11" style="color:#606060;">  11:</span>             <span style="color:#0000ff;">default</span>:</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum12" style="color:#606060;">  12:</span>                 <span style="color:#0000ff;">break</span>;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum13" style="color:#606060;">  13:</span>             }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum14" style="color:#606060;">  14:</span>        }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum15" style="color:#606060;">  15:</span> }</pre>
  </div>
</div>

Para obtener la matriz de rotación (como veremos después) sólo necesitamos el acelerómetro y el sensor de campo magnético.

Un punto a tener en cuenta en este caso es la sincronización. Al código de la clase CompassRenderer van a acceder dos threads: el principal y thread de OpenGL. Las llamadas a los métodos de los sensores vendrán del primero, mientras que las llamadas a los métodos de renderización vendrán del segundo. Esto quiere decir que las variables miembro mAccelerometerValues y mMagneticValues serán asignadas en un thread y leídas en el otro, por lo que usamos un lock para evitar que se lean mientras se están asignando.

**Creación de la superficie OpenGL**

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum1" style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> onSurfaceCreated(GL10 gl, EGLConfig config) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum2" style="color:#606060;">   2:</span>     <span style="color:#008000;">/*</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum3" style="color:#606060;">   3:</span> <span style="color:#008000;">     * By default, OpenGL enables features that improve quality</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum4" style="color:#606060;">   4:</span> <span style="color:#008000;">     * but reduce performance. One might want to tweak that</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum5" style="color:#606060;">   5:</span> <span style="color:#008000;">     * especially on software renderer.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum6" style="color:#606060;">   6:</span> <span style="color:#008000;">     */</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum7" style="color:#606060;">   7:</span>     gl.glDisable(GL10.GL_DITHER);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum8" style="color:#606060;">   8:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum9" style="color:#606060;">   9:</span>     <span style="color:#008000;">/*</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum10" style="color:#606060;">  10:</span> <span style="color:#008000;">     * Some one-time OpenGL initialization can be made here</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum11" style="color:#606060;">  11:</span> <span style="color:#008000;">     * probably based on features of this particular context</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum12" style="color:#606060;">  12:</span> <span style="color:#008000;">     */</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum13" style="color:#606060;">  13:</span>      gl.glHint(GL10.GL_PERSPECTIVE_CORRECTION_HINT,</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum14" style="color:#606060;">  14:</span>              GL10.GL_FASTEST);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum15" style="color:#606060;">  15:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum16" style="color:#606060;">  16:</span>      gl.glClearColor(0,0,0,0);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum17" style="color:#606060;">  17:</span> }</pre>
  </div>
</div>

Cuando el GLThread crea la superficie ejecuta el método onSurfaceCreated. Las líneas 7 y 13 son optimizaciones que le indican a OpenGL que optimice el rendimiento sobre la calidad de la imagen. La línea 16 establece los valores que se utilizarán para limpiar el buffer de color.

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum1" style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> onSurfaceChanged(GL10 gl, <span style="color:#0000ff;">int</span> width, <span style="color:#0000ff;">int</span> height) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum2" style="color:#606060;">   2:</span>      gl.glViewport(0, 0, width, height);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum3" style="color:#606060;">   3:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum4" style="color:#606060;">   4:</span>      <span style="color:#008000;">/*</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum5" style="color:#606060;">   5:</span> <span style="color:#008000;">      * Set our projection matrix. This doesn't have to be done</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum6" style="color:#606060;">   6:</span> <span style="color:#008000;">      * each time we draw, but usually a new projection needs to</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum7" style="color:#606060;">   7:</span> <span style="color:#008000;">      * be set when the viewport is resized.</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum8" style="color:#606060;">   8:</span> <span style="color:#008000;">      */</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum9" style="color:#606060;">   9:</span>      <span style="color:#0000ff;">float</span> ratio = (<span style="color:#0000ff;">float</span>) width / height;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum10" style="color:#606060;">  10:</span>      gl.glMatrixMode(GL10.GL_PROJECTION);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum11" style="color:#606060;">  11:</span>      gl.glLoadIdentity();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum12" style="color:#606060;">  12:</span>      gl.glFrustumf(-ratio, ratio, -1, 1, 1, 100);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum13" style="color:#606060;">  13:</span> }</pre>
  </div>
</div>

El método onSurfaceChanged después de creada la superficie, y adicionalmente cada vez que esta cambia de tamaño. En la línea 2 establecemos el _viewport_. Básicamente le decimos a sistema que utilice todo el alto y ancho de la pantalla para pintar el modelo. Las líneas 9-12 inicializan la matriz de proyección y establece la región  que se va a visualizar (ver por ejemplo [este tutorial](http://usuarios.lycos.es/andromeda_studios/paginas/tutoriales/aptutgl01.htm#Proyeccion)).

**Dibujo de la brújula**

Cada cuadro correspondiente a la animación de la brújula se dibuja en el método onDrawFrame:

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum1" style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> onDrawFrame(GL10 gl) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum2" style="color:#606060;">   2:</span>     <span style="color:#008000;">// Get rotation matrix from the sensor</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum3" style="color:#606060;">   3:</span>     SensorManager.getRotationMatrix(rotationMatrix, null, mAccelerometerValues,</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;">                                          mMagneticValues);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum4" style="color:#606060;">   4:</span>     <span style="color:#008000;">// As the documentation says, we are using the device as a compass in landscape </span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span style="color:#008000;">          // mode</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum5" style="color:#606060;">   5:</span>     SensorManager.remapCoordinateSystem(rotationMatrix, SensorManager.AXIS_Y,</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;">                                              SensorManager.AXIS_MINUS_X,</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;">                                              remappedRotationMatrix);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum6" style="color:#606060;">   6:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum7" style="color:#606060;">   7:</span>     <span style="color:#008000;">// Clear color buffer</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum8" style="color:#606060;">   8:</span>     gl.glClear(GL10.GL_COLOR_BUFFER_BIT);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum9" style="color:#606060;">   9:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum10" style="color:#606060;">  10:</span>     <span style="color:#008000;">// Load remapped matrix</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum11" style="color:#606060;">  11:</span>     gl.glMatrixMode(GL10.GL_MODELVIEW);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum12" style="color:#606060;">  12:</span>     gl.glLoadIdentity();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum13" style="color:#606060;">  13:</span>     gl.glLoadMatrixf(remappedRotationMatrix, 0);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum14" style="color:#606060;">  14:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum15" style="color:#606060;">  15:</span>     gl.glEnableClientState(GL10.GL_VERTEX_ARRAY);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum16" style="color:#606060;">  16:</span>     gl.glEnableClientState(GL10.GL_COLOR_ARRAY);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum17" style="color:#606060;">  17:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;"><span id="lnum18" style="color:#606060;">  18:</span>     mCompass.draw(gl);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;"><span id="lnum19" style="color:#606060;">  19:</span> }</pre>
  </div>
</div>

En la línea 3 obtenemos la matriz de rotación a partir de los sensores. Como vamos a ver la imagen en formato horizontal giramos los ejes en la línea 5. Las líneas 11-13 cargan la matriz. Después habilitamos los arrays de vértices y colores en el cliente que como vimos usa la clase Compass, y finalmente llamamos al método de dibujo de la brújula (visto en la entrada anterior).

El código completo del proyecto está disponible aquí: [ARCompass](http://code.google.com/p/ipoki/source/browse/#svn/trunk/ipoki/Android/ARCompass).