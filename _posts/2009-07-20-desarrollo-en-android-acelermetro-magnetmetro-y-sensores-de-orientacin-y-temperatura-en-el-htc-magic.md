---
id: 401
title: 'Desarrollo en Android: acelerómetro, magnetómetro y sensores de orientación y temperatura en el HTC Magic'
date: 2009-07-20T06:00:00+00:00
author: javiercancela
layout: post
guid: http://javiercancela.wordpress.com/?p=401
categories:
  - android
image: /images/obsolete.jpg
---
Android permite acceder a los sensores internos del dispositivo a través de las clases <span>Sensor</span>, <span>SensorEvent</span> y <span>SensorManager</span>, y de la interfaz <span>SensorEventListener</span>, del paquete <span>android.hardware</span>.

La clase <span>Sensor </span>acepta ocho tipos de sensores, como se puede ver en la [referencia](http://developer.android.com/reference/android/hardware/Sensor.html). Los sensores disponibles varían en función del aparato utilizado.

**Listar los sensores del dispositivo**

Para ver de qué sensores dispone nuestro dispositivo usamos la clase <span>SensorManager</span>:

<div class="csharpcode">
  <div id="codeSnippetWrapper">
    <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;">
      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   1:</span> <span style="color:#008000;">// Solicitamos al sistema el servicio que gestiona los sensores</span></pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   2:</span> SensorManager mSensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);</pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   3:</span> <span style="color:#008000;">// Peimos la lista con todos los sensores disponibles</span></pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   4:</span> List&lt;Sensor&gt; listSensors = mSensorManager.getSensorList(Sensor.TYPE_ALL);</pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   5:</span> <span style="color:#008000;">// Iteramos y mostramos</span></pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   6:</span> <span style="color:#0000ff;">for</span>(Sensor sensor:listSensors)</pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   7:</span> {</pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   8:</span>     Log.i(<span style="color:#006080;">"SENSOR"</span>, sensor.getName());</pre>
      
      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   9:</span> }</pre>
    </div>
  </div>
</div>

La nueva versión de la SDK marca como obsoleto (_deprecated_) el método <span>getSensors</span> de la clase <span>SensorManager</span><span>, </span>así como la <span>interfaz SensorListener. Aunque los métodos antiguos son necesarios para versiones anteriores de la SDK, los ejemplos de este artículos se basan en la última versión. </span>

<span><strong>Los sensores del HTC Magic</strong></span>

Esta es una lista de los valores devueltos por el código anterior ejecutándose en el HTC Magic:

  * AK8976A 3-axis Accelerometer
  * AK8976A 3-axis Magnetic field sensor
  * AK8976A Orientation sensor
  * AK8976A Temperature sensor

El [AK8976A](http://www.asahi-kasei.co.jp/asahi/en/news/2005/e060322.html) (arriba a la izquierda en [esta figura](http://i.cmpnet.com/eetimes/news/online/2008/10/igoogle_2.jpg), que muestra el hardware del HTC Dream) es una combinación de acelerómetro de tres ejes y magnetómetro de tres ejes. Combinando la lectura de los campos gravitatorio y magnético terrestres proporciona también información de orientación. Incluye además un sensor interno de temperatura, útil para comprobar si el móvil se está calentado demasiado.

**Acceso a los datos del sensor**

Para tener acceso a los datos del sensor debemos indicárselo al <span>SensorManager </span>con el método <span>registerListener</span>:

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> MiActividad <span style="color:#0000ff;">extends</span> Activity {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   2:</span>     MiVista mVista; <span style="color:#008000;">// Clase que implemente SensorEventListener</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   3:</span>     <span style="color:#008000;">// ...</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   4:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   5:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   6:</span>     @Override</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   7:</span>    <span style="color:#0000ff;">protected</span> <span style="color:#0000ff;">void</span> onCreate(Bundle savedInstanceState) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   8:</span>         <span style="color:#0000ff;">super</span>.onCreate(savedInstanceState);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   9:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  10:</span>         <span style="color:#008000;">// En esta clase recibiré los eventos y usaré el resultado para lo que quiera</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  11:</span>         mVista = <span style="color:#0000ff;">new</span> MiVista(<span style="color:#0000ff;">this</span>);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  12:</span>         SensorManager mSensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  13:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  14:</span>         <span style="color:#008000;">// Cada sensor se registra por separado</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  15:</span>         List&lt;Sensor&gt; listSensors = mSensorManager.getSensorList(Sensor.TYPE_MAGNETIC_FIELD);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  16:</span>         Sensor orientationSensor = listSensors.get(0);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  17:</span>         mSensorManager.registerListener(mTop, orientationSensor, SensorManager.SENSOR_DELAY_UI);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  18:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  19:</span>         listSensors = mSensorManager.getSensorList(Sensor.TYPE_ACCELEROMETER);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  20:</span>         Sensor acelerometerSensor = listSensors.get(0);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  21:</span>         mSensorManager.registerListener(mTop, acelerometerSensor, SensorManager.SENSOR_DELAY_UI);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  22:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  23:</span>         listSensors = mSensorManager.getSensorList(Sensor.TYPE_MAGNETIC_FIELD);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  24:</span>         Sensor magneticSensor = listSensors.get(0);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  25:</span>         mSensorManager.registerListener(mTop, magneticSensor, SensorManager.SENSOR_DELAY_UI);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  26:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  27:</span>         listSensors = mSensorManager.getSensorList(Sensor.TYPE_TEMPERATURE);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  28:</span>         Sensor temperatureSensor = listSensors.get(0);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  29:</span>         mSensorManager.registerListener(mTop, temperatureSensor, SensorManager.SENSOR_DELAY_UI);</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  30:</span>         ...</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  31:</span>     }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  32:</span>     ...</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  33:</span> }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  34:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  35:</span> <span style="color:#0000ff;">class</span> MiVista <span style="color:#0000ff;">extends</span> View <span style="color:#0000ff;">implements</span> SensorEventListener {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  36:</span> ...</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  37:</span> }</pre>
  </div>
</div>

<div>
</div>

Es necesario registrar cada tipo de sensor por separado para poder obtener información de todos ellos. El método registerListener toma como primer parámetro la instancia de la clase que implementa el _SensorEventListener_, y que veremos a continuación. El tercer parámetro acepta cuatro posibles valores, que indican al sistema con qué frecuencia nos gustaría recibir actualizaciones del sensor. Esta indicación sirve para que el sistema estime cuánta atención necesitan los sensores, pero no garantiza una frecuencia concreta.

**Obtención de datos**

Para recibir los datos tenemos que implementar dos métodos de SensorEventListener:

<div id="codeSnippetWrapper">
  <div id="codeSnippet" style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   1:</span> <span style="color:#0000ff;">class</span> MiVista <span style="color:#0000ff;">extends</span> View <span style="color:#0000ff;">implements</span> SensorEventListener {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   2:</span>     <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span>   mOrientationValues[] = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">float</span>[3];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   3:</span>     <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span>   mAccelerometerValues[] = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">float</span>[3];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   4:</span>     <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span>   mMagneticValues[] = <span style="color:#0000ff;">new</span> <span style="color:#0000ff;">float</span>[3];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   5:</span>     <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">float</span>   mTemperatureValues;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   6:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   7:</span>     <span style="color:#008000;">/*</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   8:</span> <span style="color:#008000;">    * El resto del código de la clase para mostrar los datos</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">   9:</span> <span style="color:#008000;">    */</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  10:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  11:</span>     <span style="color:#008000;">// En este ejemplo no necesitamos enterarnos de las variaciones de </span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  12:</span>     <span style="color:#008000;">// precisión del sensor</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  13:</span>     @Override</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  14:</span>     <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> onAccuracyChanged(Sensor sensor, <span style="color:#0000ff;">int</span> accuracy) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  15:</span>         <span style="color:#008000;">// TODO Auto-generated method stub</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  16:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  17:</span>     }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  18:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  19:</span>     @Override</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  20:</span>     <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">void</span> onSensorChanged(SensorEvent event) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  21:</span>         <span style="color:#008000;">// Cada sensor puede provocar que un thread pase por aquí, así </span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  22:</span>         <span style="color:#008000;">// que sincronizamos el acceso</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  23:</span>         <span style="color:#0000ff;">synchronized</span> (<span style="color:#0000ff;">this</span>) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  24:</span>             <span style="color:#0000ff;">switch</span>(event.sensor.getType()) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  25:</span>             <span style="color:#0000ff;">case</span> Sensor.TYPE_ORIENTATION:</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  26:</span>                 <span style="color:#0000ff;">for</span> (<span style="color:#0000ff;">int</span> i=0 ; i&lt;3 ; i++) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  27:</span>                     mOrientationValues[i] = event.values[i];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  28:</span>                 }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  29:</span>                 <span style="color:#0000ff;">break</span>;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  30:</span>             <span style="color:#0000ff;">case</span> Sensor.TYPE_ACCELEROMETER:</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  31:</span>                 <span style="color:#0000ff;">for</span> (<span style="color:#0000ff;">int</span> i=0 ; i&lt;3 ; i++) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  32:</span>                     mAccelerometerValues[i] = event.values[i];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  33:</span>                 }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  34:</span>                 <span style="color:#0000ff;">break</span>;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  35:</span>             <span style="color:#0000ff;">case</span> Sensor.TYPE_MAGNETIC_FIELD:</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  36:</span>                 <span style="color:#0000ff;">for</span> (<span style="color:#0000ff;">int</span> i=0 ; i&lt;3 ; i++) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  37:</span>                     mMagneticValues[i] = event.values[i];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  38:</span>                 }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  39:</span>                 <span style="color:#0000ff;">break</span>;</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  40:</span>             <span style="color:#0000ff;">default</span>:</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  41:</span>                 <span style="color:#0000ff;">for</span> (<span style="color:#0000ff;">int</span> i=0 ; i&lt;event.values.length ; i++) {</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  42:</span>                     mTemperatureValues = event.values[i];</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  43:</span>                 }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  44:</span>             }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  45:</span></pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  46:</span>             invalidate();</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  47:</span>         }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  48:</span>     }</pre>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;">  49:</span> }</pre>
  </div>
</div>

Cuando el evento se dispara en el método onSensorChanged comprobamos qué sensor lo ha causado y leemos los datos. Los posibles valores devueltos se indican en la [documentación de la clase SensorEvent](http://developer.android.com/reference/android/hardware/SensorEvent.html).

La clase SensorManager tiene además tres métodos (getInclination, getOrientation y getRotationMatrix), usados para calcular transformaciones de coordenadas. De ellos hablaremos en un próximo artículo.