---
title: PML T2 - El perceptrón
date: 2017-03-19 03:00:00 +0200
description: Python Machine Learning - Tema 2 - Notas sobre el libro de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

Empezamos con los algoritmos. Vamos a implementar un perceptrón en Python, y entrenarlo para que sepa clasificar las diferentes especies de flores en Iris. El libro comienza mostrando el [modelo de neurona de McCulloch-Pitts](https://es.wikipedia.org/wiki/Neurona_de_McCulloch-Pitts):

<div style="text-align:center">
    <figure>
        <img alt="En este modelo se emite una señal de salida si el resultado de aplicar una función a la suma de las entradas supera cierto umbral" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_01.png" />
        <figcaption>En este modelo se emite una señal de salida si el resultado de aplicar una función a la suma de las entradas supera cierto umbral</figcaption>
    </figure>
</div>

Tomando este modelo como base, Frank Rosenblatt diseñó un dispositivo electrónico con capacidad para aprender. El algoritmo usado por ese dispositivo se conoce como Perceptrón.

## Perceptrón

El [perceptrón](https://es.wikipedia.org/wiki/Perceptr%C3%B3n) es un algoritmo de aprendizaje supervisado para realizar tareas de clasificación binaria, es decir, para determinar si una muestra pertenece o no a una clase.

<div style="background-color: #EEEEEE; padding: 1em">
El libro asume cierta familiaridad trabajando con vectores y matrices. Para refrescar conceptos recomiendo revisar los <a href="https://es.wikipedia.org/wiki/%C3%81lgebra_lineal#Enlaces_externos">enlaces externos referenciados en la página de la Wikipedia dedicada al Álgebra Lineal</a>. También tiene buena pinta [el curso de la Khan Academy](https://es.khanacademy.org/math/linear-algebra). <br/>
En inglés hay varios libros gratuitos disponibles, como [este](https://www.math.ucdavis.edu/~linear/linear-guest.pdf) y [este](http://www.cs.cmu.edu/~zkolter/course/linalg/linalg_notes.pdf).
</div>

<div style="text-align:center">
    <figure>
        <a href="https://commons.wikimedia.org/wiki/File:Perceptr%C3%B3n_5_unidades.svg#/media/File:Perceptr%C3%B3n_5_unidades.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Perceptr%C3%B3n_5_unidades.svg/1200px-Perceptr%C3%B3n_5_unidades.svg.png" alt="Perceptrón 5 unidades.svg"></a>
        <figcaption>
            De <a href="//commons.wikimedia.org/w/index.php?title=User:Alejandro.cartas&amp;action=edit&amp;redlink=1" class="new" title="User:Alejandro.cartas (page does not exist)">Alejandro Cartas</a> - <span class="int-own-work" lang="es">Trabajo propio</span>, <a href="http://creativecommons.org/licenses/by-sa/4.0" title="Creative Commons Attribution-Share Alike 4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=41534843">Enlace</a>
        </figcaption>
    </figure>
</div>

Como podemos ver en la figura anterior, la señal de entrada está compuesta por un array $$\bf x$$ al que se aplica una serie de pesos definidos por un array $$\bf w$$. Es decir, cada elemento $$x_i$$ se multiplica por $$w_i$$, y se suma el resultado de cada uno de estos productos. De una manera más formal, definimos

$$
x = \begin{bmatrix}
x_1 \cr
\vdots \cr
x_m \cr
\end{bmatrix}, w = \begin{bmatrix}
w_1 \cr
\vdots \cr
w_m \cr
\end{bmatrix}
\tag{2.1}
$$

Y la entrada resultante $$z$$ será la suma de cada entrada ponderada:

$$
z = \sum{w_ix_i} = w_1x_1 + \cdots + w_mx_m
\tag{2.2}
$$

Ya tenemos la entrada $$z$$ a la función de activación $$\phi(z)$$. Para nuestro caso vamos a usar como función de activación la [función escalón](https://es.wikipedia.org/wiki/Funci%C3%B3n_escal%C3%B3n_de_Heaviside). Esta función se define de la siguiente forma:

$$
\phi(z) = \begin{cases}
\text{1 si } z \ge \theta \cr
\text{-1 en otro caso}
\end{cases}
\tag{2.3}
$$

Ese valor $$\theta$$ es el umbral que tiene que superar $$z$$ para disparar la señal. Para simplificar los cálculos, definimos un peso 0 con $$w_0 = -\theta$$ y $$x_0 = 1$$, de esta forma podemos escribir:

$$
z = w_0x_0 + w_1x_1 + \cdots + w_mx_m
\tag{2.4}
\label{2.4}
$$

y 

$$
\phi(z) = \begin{cases}
\text{1 si } z \ge 0 \cr
\text{-1 en otro caso}
\end{cases}
\tag{2.5}
\label{2.5}
$$

El valor de $$z$$ se puede escribir también como $$z = \mathbf{w}^T\bf x$$. El superíndice T indica que la matriz (en este caso un array, que tratamos como una matriz de 1 columna y n filas) está traspuesta, o lo que es lo mismo, se han convertidos sus columnas en filas. Por lo tanto:

$$
\mathbf{w}^T\bf x = \begin{bmatrix} w_0 & w_1 & \cdots & w_m \end{bmatrix} \begin{bmatrix}
x_1 \cr
\vdots \cr
x_m \cr
\end{bmatrix}

\tag{2.6}
$$

Esto nos permite usar la operación de producto escalar entre matrices. En una operación entre matrices, si la primera tiene dimensiones $$n \times m$$, la segunda debe tener $$m \times p$$, dando como resultado una matriz $$n \times p$$. En nuestro caso, la dimensiones serían $$1 \times n$$ y $$n \times 1$$, dando como resultado una matriz $$1 \times 1$$, es decir, un escalar. Por ello esta operación es realmente un producto escalar entre vectores, cuyo resultado es la ya conocida expresión \eqref{2.4}

## Entrenando el modelo

Pretendemos modificar los valores de los pesos ($$\mathbf{w}$$) de forma que las salidas del preceptrón se vayan acercando a los valores esperados. Para ello se inicializan los pesos a cero, o a un valor muy pequeño, se obtiene la salida, y se actualizan los pesos.

¿Cómo se actualizan los pesos? Sumándoles una cantidad (positiva o negativa) que depende de la entrada, de la diferencia entre la salida real y la salida esperada, y de la tasa de aprendizaje ($$\eta$$), que es una constante que vale entre 0 y 1:

$$
\Delta w_j = \eta(y^{(i)} - \hat y^{(i)})x_j^{(i)}
\tag{2.7}
$$

En esta fórmula $$y^{(i)}$$ es la clase a la que pertenece la muestra (i), $$\hat y^{(i)}$$ es la clase predicha por el perceptrón, y $$x_j^{(i)}$$ es la entrada de la característica j para la muestra (i). Todo esto se multiplica para calcular la variación en la característica j: $$\Delta w_j$$. Con cada muestra se recalculan los pesos:

$$
w_j := w_j + \Delta w_j
\tag{2.8}
$$

### Condiciones de convergencia

Este proceso iterativo puede converger o no. Para que el perceptrón clasifique correctamente las muestras , el valor de $$w_j$$ debe ir acercándose cada vez más a un valor final, o lo que es lo mismo, $$\Delta w_j$$ debe tender a cero. 

Para que se de esta situación deben cumplirse dos requisitos. En primer lugar, la tasa de aprendizaje debe ser suficientemente pequeña. En general, cuanto más grande sea $$\eta$$ más rápido será el aprendizaje, pero pasado cierto valor el proceso de aprendizaje nunca convergerá. En segundo lugar, las dos clases deben ser linealmente separables. Es decir, si representamos los elementos de ambas clases en un diagrama de 2 dimensiones (suponeniendo que las muestras tienen dos características), debe existir una línea que separe a todos los de una clase a un lado, y a todos los de la otra clase al otro lado.

<div style="text-align:center">
    <figure>
        <img alt="Ejemplos con muestras de dos clases. Sólo el primero es linearmente separable." src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_03.png" />
        <figcaption>Ejemplos con muestras de dos clases. Sólo el primero es linearmente separable.</figcaption>
    </figure>
</div>

## Perceptrón en Python

El código del capítulo 2 (y de los demás capítulos) está, como comentamos, [subido a GitHub](https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/ch02.ipynb) en formato [Jupyter](http://jupyter.org/). Jupyter (originalmente iPython) es una aplicación web que permite crear y compartir documentos que contengan código, gráficas, animaciones... de un forma muy sencilla. Jupyter viene incluido en Anaconda, que es el entorno Python que recomendamos en [una entrada anterior]({{ site.baseurl }}{% link _posts/2017-03-12-python-machine-learning-i.md %}). También se puede ver el código completo de cada capítulo como archivo Python [aquí](https://github.com/rasbt/python-machine-learning-book/tree/master/code/optional-py-scripts).

El código comienza declarando una clase `Perceptron` en la que se definen en constructor y tres métodos:
<pre class="line-numbers">
  <code class="language-python">
    import numpy as np

    class Perceptron(object):
      def __init__(self, eta=0.01, n_iter=10):
        self.eta = eta
        self.n_iter = n_iter

      def fit(self, X, y):
        self.w_ = np.zeros(1 + X.shape[1])
        self.errors_ = []

        for _ in range(self.n_iter):
          errors = 0
          for xi, target in zip(X, y):
            update = self.eta * (target - self.predict(xi))
            self.w_[1:] += update * xi
            self.w_[0] += update
            errors += int(update != 0.0)
          self.errors_.append(errors)
        return self

      def net_input(self, X):
        return np.dot(X, self.w_[1:]) + self.w_[0]

      def predict(self, X):
        return np.where(self.net_input(X) >= 0.0, 1, -1)
  </code>
</pre>

Inicializamos el perceptrón con dos parámetros: `eta`, que es la tasa de aprendizaje, y `n_iter`, que es el número de veces que vamos a recorrer el conjunto de datos de entrenamiento. A cada una de estas veces se les llama "épocas".

Una vez instanciado el perceptrón llamaremos al método `fit` para entrenar nuestro modelo. Se le pasan dos parámetros: una matriz $$\bf X$$, que contiene una fila por cada muestra y una columna por cada característica, y que constituye nuestro conjunto de datos de entrenamiento; y un array $$\bf y$$, que contiene el resultado objetivo para cada muestra. 

Lo primero que hace el método `fit` es inicializar los pesos y los errores:
```python
  self.w_ = np.zeros(1 + X.shape[1])
  self.errors_ = []
```

Los pesos se inicializan a un array con el mismo número de elementos que muestras tiene la matriz $$\bf X$$ más uno. Ese más uno es debido a que vamos a almacenar también el parámetro $$w_0$$ corresondiente al umbral $$\theta$$ que pasamos a la izquiera en la equación \eqref{2.4}. Como estamos inicializando todo a cero consideramos el umbral inicial de activación como cero.

A continuación comienza un precose que se ejecutará `n_iter` veces. En el se itera sobre los datos proporcionados mediante esta instrucción:
```python
   for xi, target in zip(X, y)
```

Lo que va a hacer la instrucción `zip` es devolver un elemento por cada lista que se le pase de parámetro. Así, si $$\bf X$$ es una matriz de 100 filas (muestras) y 2 columnas (características), e $$\bf y$$ es un array de 100 elementos (las clases reales de cada muestra), la instrucción anterior iterará para cada muestra almacenando en `xi` las características y en `target` su clase real.

Con esos datos vamos a calcular los nuevos pesos. La fórmula era la siguiente:

$$
\Delta w_j = \eta(y^{(i)} - \hat y^{(i)})x_j^{(i)}
w_j := w_j + \Delta w_j
$$

En nuestro caso hacemos esto:

```python
    update = self.eta * (target - self.predict(xi))
    self.w_[1:] += update * xi
    self.w_[0] += update
    errors += int(update != 0.0)
```

Calculamos primero el factor $$\eta(y^{(i)} - \hat y^{(i)})$$, y después lo multiplicamos por $$\bf{x^{(i)}}$$ para sumárselo al array de pesos, salvo el peso 0. Al ser tanto 'self.w_[1:]' como 'xi' arrays con un elemento por cada característica, estamos aplicando la corrección a todos los pesos. En el peso $$w_0$$ no multiplicamos por $$\bf{x_0^{(i)}}$$, ya que este por definición vale uno. Finalmente acumulamos el error de cada muestra, y al final de cada época lo añadimos a un array. Esto nos permitirá ver la evolución del error por épocas.

Veamos ahora cómo calcular el término $$\hat y^{(i)}$$, que en código se obtiene llamando a `self.predict(xi)`

```python
  def net_input(self, xi):
    return np.dot(xi, self.w_[1:]) + self.w_[0]

  def predict(self, xi):
    return np.where(self.net_input(xi) >= 0.0, 1, -1)
```

Lo primero que hace `predict` con `xi` es usarlo para invocar `net_input`. En esta función usamos `np.dot` para realizar un producto escalar entre `xi` y `self.w_[1:]`. Es decir, suponiendo una muestra con dos características, y por tanto dos entradas y dos pesos, `np.dot(xi, self.w_[1:])` equivale a $$w_1x_1 + w_2x_2$$. A esto le sumamos $$w_0$$ (ya que $$x_0$$ es igual a uno), y tenemnos que `net_input` devuelve el valor $$z$$, tal como se define en \eqref{2.4}. La última parte, `np.where(self.net_input(xi) >= 0.0, 1, -1)` devuelve 1 si $$z$$ es mayor o igual que 0, y -1 en otro caso. En resumen, el método `predict` es la función $$\phi(z)$$ (\eqref{2.5}). 

### Perceptrón con el conjunto de datos Iris

Toda la lógica del perceptrón está implementada en la clase anterior. Vamos a utilizarla con el conjunto de datos Iris ya mencionado anteriormente. El ejemplo del libro utilizan la librería `pandas`, especializada en análisis de datos y estructuras, para cargar los datos de Iris. Estos datos se almacenan en un tipo de datos de la librería llamado [DataFrame](http://pandas.pydata.org/pandas-docs/stable/dsintro.html#dataframe):

```python
import pandas as pd
df = pd.read_csv('https://archive.ics.uci.edu/ml/'
                 'machine-learning-databases/iris/iris.data', header=None)
print(df.tail())                
```

El archivo de datos lo estamos descargando de internet, pero también está disponible en el código de ejemplo para usar en local.

El código de ejemplo imprime las últimas líneas de la estructura de datos cargada:

||  0| 1| 2| 3| 4|
|---|---|---|---|---|---|
|**145**|6.7|3.0|5.2|2.3|Iris-virginica|
|**146**|6.3|2.5|5.0|1.9|Iris-virginica|
|**147**|6.5|3.0|5.2|2.0|Iris-virginica|
|**148**|6.2|3.4|5.4|2.3|Iris-virginica|
|**149**|5.9|3.0|5.1|1.8|Iris-virginica|

A continuación preprocesamos los datos, para dejarlos en el formato adecuado para trabajar con ellos. Usaremos las librerías `numpy`, para tratar los datos, y `matplotlib`, para dibujarlos en una gráfica

```python
import numpy as np
import matplotlib.pyplot as plt

y = df.iloc[0:100, 4].values
```

En primer lugar hemos seleccionado los 100 primeros registros del DataFrame, pero cogiendo sólo la quinta columna (la 4 por comenzar el índice en 0). Esto nos devuelve un array con 100 valores, cada uno de los cuales es el nombre de la especie. Es decir, cogemos las etiquetas de la clase de cada muestra.

En el conjunto de datos Iris los datos están ordenados de tal forma que los 50 primeros son Iris-setosa, y los 50 siguientes Iris-versicolor. De esta forma limitarnos a los 100 primeros registros nos permite realizar una clasificación binaria. 

```python
y = np.where(y == 'Iris-setosa', -1, 1)
```

El siguiente paso consiste en sustituir las etiquetas de texto por valores numéricos. El valor objetivo pasará a ser -1 para las Iris-setosa y 1 para las Iris-versicolor. Almacenamos los datos en un array $$\bf y$$ de 100 elementos.

```python
X = df.iloc[0:100, [0, 2]].values
```

De las cuatro características posibles nos vamos a quedar con dos: la longitud del sépalo y la longitud del pétalo. Esto nos permitirá dibujar los datos en una gráfica de dos dimensiones. Al igual que hicimos con el valor objetivo, cogemos los cien primeros valores del conjunto de datos, quedándonos con la primera y la tercera columna. Esto nos devuelve una matriz $$\bf X \in \mathbb R^{100x2}$$.

```python
plt.scatter(X[:50, 0], X[:50, 1],
            color='red', marker='o', label='setosa')
plt.scatter(X[50:100, 0], X[50:100, 1],
            color='blue', marker='x', label='versicolor')

plt.xlabel('sepal length [cm]')
plt.ylabel('petal length [cm]')
plt.legend(loc='upper left')

plt.tight_layout()
plt.show()
```

Dibujamos los datos almacenados. Marcamos con una 'o' roja las Iris-setosa (las 50 primeras), y con una 'x' azul las Iris-versicolor. El resultado es este:

<div style="text-align:center">
    <figure>
        <img alt="Datos de entrenamiento" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_06.png" />
        <figcaption>Datos de entrenamiento</figcaption>
    </figure>
</div>

Con los datos listos podemos realizar el entrenamiento.

```python
ppn = Perceptron(eta=0.1, n_iter=10)
ppn.fit(X, y)
```

Instanciamos el perceptrón con un $$\eta = 0.1$$ y 10 épocas. Para entrenar  basta con llamar al método `fit` pasando $$\bf X$$  e $$\bf y$$ como parámetros.

```python
plt.plot(range(1, len(ppn.errors_) + 1), ppn.errors_, marker='o')
plt.xlabel('Epochs')
plt.ylabel('Number of updates')

plt.tight_layout()
# plt.savefig('./perceptron_1.png', dpi=300)
plt.show()
```

Una vez entrenado el modelo, pintamos en un gráfico los errores encontrados en cada generación. En  el eje X pintamos las épocas (la longitud del array de errores), y en el Y mostramos el número de errores. 

<div style="text-align:center">
    <figure>
        <img alt="Errores por época" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_07.png" />
        <figcaption>Errores por época</figcaption>
    </figure>
</div>

A partir de la 6ª época el modelo ya no comete errores. Ahora vamos a dibujar los datos de entrenamiento, pero marcando las zonas que el modelo ya entrenado considera como de una clase u otra.

```python
from matplotlib.colors import ListedColormap

def plot_decision_regions(X, y, classifier, resolution=0.02):
    markers = ('s', 'x', 'o', '^', 'v')
    colors = ('red', 'blue', 'lightgreen', 'gray', 'cyan')
    cmap = ListedColormap(colors[:len(np.unique(y))])
```

Definimos una nueva función que nos permita dibujar en distintos colores las zonas que serían de Iris-setosa e Iris-versicolor si una muestra tuviese unas características que estuviesen en ese punto.

```python
def plot_decision_regions(X, y, classifier, resolution=0.02):
    # ... Continuación
    x1_min, x1_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    x2_min, x2_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx1, xx2 = np.meshgrid(np.arange(x1_min, x1_max, resolution),
                           np.arange(x2_min, x2_max, resolution))
    Z = classifier.predict(np.array([xx1.ravel(), xx2.ravel()]).T)
    Z = Z.reshape(xx1.shape)
    plt.contourf(xx1, xx2, Z, alpha=0.4, cmap=cmap)
    plt.xlim(xx1.min(), xx1.max())
    plt.ylim(xx2.min(), xx2.max())

    # plot class samples
    for idx, cl in enumerate(np.unique(y)):
        plt.scatter(x=X[y == cl, 0], y=X[y == cl, 1],
                    alpha=0.8, c=cmap(idx),
                    marker=markers[idx], label=cl)
```
Definimos los valores mínimo y máximo del sépalo (`x1_min` y `x1_max`) y del pétalo (`x2_min` y `x2_max`), restando uno al mínimo y sumándolo al máximo para tener un rango con margen. La función [`np.arange`](https://docs.scipy.org/doc/numpy/reference/generated/numpy.arange.html) devuelve una lista de valores que van del primer parámetro al segundo en intervalos marcados por el tercer parámetro. Las dos llamadas a `np.arange` devolverán un array de valores separados por 0.02. En el primer caso van del 3.30 al 7.98, en el segundo del 0 al 6.08.  Con ambos arrays construimos una matriz que pasamos al predictor, el cual nos devolverá el valor predicho para todos los puntos del plano definido.

<div style="text-align:center">
    <figure>
        <img alt="Regiones predichas para cada clase" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_08.png" />
        <figcaption>Regiones predichas para cada clase</figcaption>
    </figure>
</div>