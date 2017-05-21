---
title: PML T1 - Aprendizaje máquina
date: 2017-03-12 03:00:00 +0200
description: Python Machine Learning - Tema 1 - Notas sobre el libro de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

El foco de estas entradas se pondrá en el [código Python publicado en GitHub](https://github.com/rasbt/python-machine-learning-book), pero el primer tema no incluye código, tan sólo presenta una serie de conceptos que resumo en esta entrada.

## Tipos de _machine learning_

Existen tres estrategias distintas de aprendizaje automático: supervisado, no supervisado y reforzado

### Supervisado

En el aprendizaje supervisado se entrena el modelo con datos para los que ya se conoce el resultado correcto. En función del tipo de resultado que esperemos obtener, podemos encontrarnos con que los datos de entrenamiento llevan asociada una etiqueta que indica a qué categoría pertenece, o un valor numérico. En el primer caso hablamos de **clasificación**, y en el segundo de **regresión**.

Un ejemplo de problema de clasificación es el mencionado en la entrada anterior: la clasificación de spam. Al modelo se le presenta con una serie de correos que ya han sido identificados con una etiqueta 'spam' o 'no spam'. El modelo utiliza esos correos para calibrar ciertos valores internos, de forma que pueda identificar correctamente futuros correos sin intervención humana.

En los problemas de regresión el valor esperado pertenece a un rango continuo. Un ejemplo, [sacado de este post (en inglés)](http://setosa.io/ev/ordinary-least-squares-regression/), sería un modelo para predecir la altura de una persona a partir del tamaño de su mano. Para ello entrenaríamos el modelo con una muestra aleatoria de personas, para las cuales tendríamos tanto el tamaño de su mano como su altura real. El resultado sería una ecuación del tipo $$y = A + Bx$$
donde _x_ sería el tamaño de la mano, _A_ y _B_ valores definidos tras el proceso de aprendizaje, e _y_ la altura predicha para el valor x.

<div style="text-align:center">
    <figure>
        <img alt="Ejemplo de regresión lineal" src ="/images/pml/1_regression.png" />
        <figcaption>Ejemplo de regresión lineal</figcaption>
    </figure>
</div>

### Reforzado

El aprendizaje reforzado entrena un modelo para que consiga un objetivo. Para ello se alimenta el modelo con el resultado de una función que evalúa cómo de cerca estamos del objetivo. Se establece un ciclo en el que el modelo genera una salida, la función evalúa cómo de satisfactoria ha sido esta salida, y la evaluación se utiliza para ajustar el modelo.

<div style="text-align:center">
    <figure>
        <img alt="El modelo ('Agent') cambia el estado a través de una acción. Este cambio nos acerca más o menos al objetivo. Realimentamos el modelo con una recompensa, así como con la acción que generó dicha recompensa" src ="/images/pml/1_refuerzo.png" />
        <figcaption>El modelo ('Agent') cambia el estado a través de una acción. Este cambio nos acerca más o menos al objetivo. Realimentamos el modelo con una recompensa, así como con la acción que generó dicha recompensa</figcaption>
    </figure>
</div>

Los ejemplos habituales de aplicación de esta técnica son los juegos: ajedrez, tres en raya, juegos de cartas... En ellos el programa va aprendiendo según juega partidas y comprueba qué acciones llevan a la victoria. 

### No supervisado

En algunas ocasiones nos encontramos con datos de los que no sabemos qué información extraer. Para estos casos se usan técnicas de aprendizaje no supervisado, en las que se analiza la estructura de los datos para intentar extraer información útil. El libro menciona dos aproximaciones a esta técnica: **agrupación (_clustering_)** y **reducción de dimensionalidad**.

En la agrupación se buscan elementos que, según algún criterio, son algo similares entre sí y algo distintos a los demás. Por ejemplo, si tenemos un conjunto de animales con gatos, caballos, palomas y águilas, y proporcionamos al modelo sus tamaños y el número de patas de cada animal, el aprendizaje no supervisado le permitiría identificar correctamente cuatro tipos de animales: grande con dos patas (águila), grande con cuatro patas (caballo), pequeño con dos patas (paloma) y pequeño con cuatro patas (gato).  

<div style="text-align:center">
    <figure>
        <img alt="Un ejemplo un poco más real de clustering" src ="https://docs.microsoft.com/en-us/azure/machine-learning/media/machine-learning-algorithm-choice/image9.png" />
        <figcaption>Un ejemplo un poco más real de clustering</figcaption>
    </figure>
</div>


En cuanto a la reducción de dimensionalidad, consiste en reducir los datos de forma que se retenga la información relevante. La idea es disminuir tanto el espacio ocupado por los datos como el tiempo necesario para ejecutar los algoritmos. Usando un ejemplo sacado de [esta respuesta de stackoverflow](http://stackoverflow.com/a/1994481), supongamos un conjunto de datos en el que 1000 personas indican si les gusta o no cada una de 100 películas seleccionadas. Podríamos almacenar esta información en 1000 vectores de 100 elementos cada uno, donde cada elemento fuese un 1 o un 0 según la película hubiese gustado o no. Una forma de reducir la dimensionalidad del conjunto de datos sería asignar a cada película uno de cinco géneros (comedia, terror, ... los que fuesen más representativos), y usar los datos originales para construir un nuevo vector de cinco elementos para cada persona, donde se indicase si el género es no de su agrado. Pasaríamos así de 100.000 a 5.000 elementos. Como contrapartida, perderíamos información (a una persona le pueden gustar un par de películas de un género que no le gusta).

<div style="text-align:center">
    <figure>
        <img alt="El ejemplo del libro reduce una muestra de datos en 3 dimensionaes a otra equivalente en 2 dimensiones" src ="/images/pml/1_compression.png" />
        <figcaption>El ejemplo del libro reduce una muestra de datos en 3 dimensiones a otra equivalente en 2 dimensiones</figcaption>
    </figure>
</div>

## Terminología y notación

Como es de esperar en cualquier disciplina técnica que se precie, el _machine learning_ incluye un montón de terminología propia que es preciso conocer. El siguiente punto del tema 1 presenta algunos de estos términos.

En aprendizaje automático existe un conjunto de datos muy conocido que se usa en todos los cursos para principiantes, algo así como el "Hola Mundo" de los conjuntos de datos. Se llama [conjunto de datos Iris](https://es.wikipedia.org/wiki/Iris_flor_conjunto_de_datos), e incluye datos de 50 ejemplares de cada una de las 3 especies de la flor Iris. Para cada ejemplar se da el largo y ancho del pétalo y el sépalo, así como la especie a la que pertenece (_setosa_, _versicolor_ o _virginica_).

<div style="text-align:center">
    <figure>
        <img alt="Algunos datos de Iris y una ilustración de la flor" src ="/images/pml/1_iris.png" />
        <figcaption>Algunos datos de Iris y una ilustración de la flor</figcaption>
    </figure>
</div>

Como se puede apreciar en la imagen superior, cada fila de datos es una *muestra*, *instancia* u *observación*. Para cada una de estas muestras se proporciona una serie de datos, a los que nos solemos referir como *características*, aunque también *atributos*, *medidas* o *dimensiones*. Finalmente, la especie de la flor sería la *etiqueta* u *objetivo*. La consistencia en la terminología no es un fuerte del _machine learning_.

En este punto el libro también nos habla de notación algebraica. El trabajo con matrices es fundamental en el _machine learning_, así que este el autor nos cuenta qué notación utiliza para representar matices, vectores y elementos dentro de los mismos. 

Por ejemplo, el conjunto de datos Iris se puede representar como una matriz de 150 filas (una por muestra) y 4 columnas (una por característica):

\begin{bmatrix}
x_1^{(1)} & x_2^{(1)} & x_3^{(1)} & x_4^{(1)} \cr
x_1^{(2)} & x_2^{(2)} & x_3^{(2)} & x_4^{(2)} \cr
\vdots & \vdots & \vdots & \vdots \cr
x_1^{(150)} & x_2^{(150)} & x_3^{(150)} & x_4^{(150)} \cr
\end{bmatrix}

En general, un elemento $$x_n^{(m)}$$ se refiere al elemento de la fila m y la columna n de una matriz. Usaremos negritas en minúsculas para los vectores ($$\bf x \in \mathbb R^{nx1}$$), y negritas en mayúsculas para las matrices ($$\bf X \in \mathbb R^{nxm}$$).

## Otros aspectos importantes del aprendizaje automático

Además del algoritmo de aprendizaje, el libro nos habla en este tema de otros aspectos importantes del _machine learning_

### Preprocesado

El preprocesado es la fase inicial del proceso de aprendizaje. Consiste en disponer los datos existentes en un formato adecuado para su procesamiento: se normalizan valores, se pasan textos a números, se separan datos de entrenamiento y datos de prueba,...

<div style="text-align:center">
    <figure>
        <img alt="Ejemplo de flujo de modelado predictivo" src ="/images/pml/1_flujo.png" />
        <figcaption>Ejemplo de flujo de modelado predictivo</figcaption>
    </figure>
</div>

### Entrenamiento y selección del proceso predictivo

La otra tarea fundamental a realizar al empezar es la correcta selección del algoritmo a utilizar. Queremos obtener el modelo que presente un mejor rendimiento, pero para ello necesitamos definir una métrica que mida este rendimiento. La más común es la proporción de muestras correctamente clasificadas.

### Evaluación de modelos y predcción de instancias de datos no vistas

El modelo se entrena con los datos de entrenamiento, y se evalúa con la parte del conjunto de datos reservada para ello. En función de la tasa de error encontrada en la evaluación decidiremos si el modelo es válido. 

## Python

El tema finaliza hablando de Python y de cómo instalarlo. Python es uno de los lenguajes más populares en el mundo del _machine learning_, en parte por su versatilidad, en parte por la gran cantidad de librerías especialidadas de las que dispone. Especialmente relevantes para el aprendizaje máquina son [NumPy](http://www.numpy.org/) y [SciPy](https://www.scipy.org/).

La opción más cómoda para instalar Python con todo lo necesario para este libro es descargar [Anaconda](https://docs.continuum.io/anaconda/install#), un gestor de instalaciones de Python.

El libro no habla del entorno de desarrollo, pero yo uso desde hace unos meses el [Visual Studio Code](https://code.visualstudio.com/). Con la [extensión de Python](https://marketplace.visualstudio.com/items?itemName=donjayamanne.python) proporcionando autocompletado, [_linting_](https://es.wikipedia.org/wiki/Lint), formateado de código y depuración, el Visual Studio Code supera al resto de entornos Python disponibles de forma gratuita.

## Conclusión

El tema 1 nos familiariza con los conceptos más básicos del aprendizaje máquina. En el tema 2 empezaremos ya a ver código para avanzar en la materia.