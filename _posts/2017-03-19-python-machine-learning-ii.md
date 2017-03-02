---
title: Machine Learning con Python - Tema 2 - El perceptrón
date: 2017-03-19 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
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

## Perceptrón

El [perceptrón](https://es.wikipedia.org/wiki/Perceptr%C3%B3n) es un algoritmo de aprendizaje supervisado para realizar tareas de clasificación binaria, es decir, para determinar si una muestra pertenece o no a una clase.

<div style="background-color: #EEEEEE; padding: 1em">
El libro asume cierta familiaridad trabajando con vectores y matrices. Para refrescar conceptos recomiendo revisar los <a href="https://es.wikipedia.org/wiki/%C3%81lgebra_lineal#Enlaces_externos">enlaces externos referenciados en la página de la Wikipedia dedicada al Álgebra Lineal</a>.
</div>

<div style="text-align:center">
    <figure>
        <a href="https://commons.wikimedia.org/wiki/File:Perceptr%C3%B3n_5_unidades.svg#/media/File:Perceptr%C3%B3n_5_unidades.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Perceptr%C3%B3n_5_unidades.svg/1200px-Perceptr%C3%B3n_5_unidades.svg.png" alt="Perceptrón 5 unidades.svg"></a>
        <figcaption>
            De <a href="//commons.wikimedia.org/w/index.php?title=User:Alejandro.cartas&amp;action=edit&amp;redlink=1" class="new" title="User:Alejandro.cartas (page does not exist)">Alejandro Cartas</a> - <span class="int-own-work" lang="es">Trabajo propio</span>, <a href="http://creativecommons.org/licenses/by-sa/4.0" title="Creative Commons Attribution-Share Alike 4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=41534843">Enlace</a>
        </figcaption>
    </figure>
</div>

Como podemos ver en la figura anterior, la señal de entrada está compuesta por un array $\bf x$ al que se aplica una serie de pesos definidos por un array $\bf w$. Es decir, cada elemento $x_i$ se multiplica por $w_i$, y se suma el resultado de cada uno de estos productos. De una manera más formal, definimos
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
$$

Y la entrada resultante $z$ será la suma de cada entrada ponderada:
$$
z = \sum{w_ix_i} = w_1x_1 + \cdots + w_mx_m
$$

Ya tenemos la entrada $z$ a la función de activación $\phi(z)$. Para nuestro caso vamos a usar como función de activación la [función escalón](https://es.wikipedia.org/wiki/Funci%C3%B3n_escal%C3%B3n_de_Heaviside). Esta función se define de la siguiente forma:
$$
\phi(z) = \begin{cases}
\text{1 si } z \ge \theta \cr
\text{-1 en otro caso}
\end{cases}
$$

Ese valor $\theta$ es el umbral que tiene que superar $z$ para disparar la señal. Para simplificar los cálculos, definimos un peso 0 con $w_0 = -\theta$ y $x_0 = 1$, de esta forma podemos escribir:
$$
z = w_0x_0 + w_1x_1 + \cdots + w_mx_m
$$

y 

$$
\phi(z) = \begin{cases}
\text{1 si } z \ge 0 \cr
\text{-1 en otro caso}
\end{cases}
$$

El valor de $z$ se puede escribir también como $z = \mathbf{w}^T\bf x$. El superíndice T indica que la matriz (en este caso un array, que tratamos como una matriz de 1 columna y n filas) está traspuesta, o lo que es lo mismo, se han convertidos sus columnas en filas. Por lo tanto:

$$
\mathbf{w}^T\bf x = \begin{bmatrix} w_0 & w_1 & \cdots & w_m \end{bmatrix} \begin{bmatrix}
x_1 \cr
\vdots \cr
x_m \cr
\end{bmatrix}
$$

Esto nos permite usar la operación de producto escalar entre matrices. En una operación entre matrices, si la primera tiene dimensiones $n \times m$, la segunda debe tener $m \times p$, dando como resultado una matriz $n \times p$. En nuestro caso, la dimensiones serían $1 \times n$ y $n \times 1$, dando como resultado una matriz $1 \times 1$, es decir, un escalar. Por ello esta operación es realmente un producto escalar entre vectores, cuyo resultado es la ya conocida expresión
$$
z = w_0x_0 + w_1x_1 + \cdots + w_mx_m
$$

## Entrenando el modelo

Recapitulando, lo que pretendemos es ir modificando los valores de los pesos ($\mathbf{w}$) de forma que las salidas del preceptrón se vayan acercando a los valores esperados. Para ello se inicializan los pesos a cero, o a un valor muy pequeño, se obtiene la salida, y se actualizan los pesos.

¿Cómo se actualizan los pesos? Pues sumándoles una cantidad (positiva o negativa) que depende de la entrada, de la diferencia entre la salida real y la salida esperada, y de la tasa de aprendizaje ($\eta$), que es una constante que vale entre 0 y 1:
$$
\Delta w_j = \eta(y^{(i)} - \hat y^{(i)})x_j^{(i)}
$$

En esta fórmula, a demás de la ya mencionada tasa de aprendizaje $\eta$, $y^{(i)}$ es la clase a la que pertenece la muestra (i), $\hat y^{(i)}$ es la clase predicha por el perceptrón, y $x_j^{(i)}$ es la entrada de la característica j para la muestra (i). Todo esto se multiplica para calcular la variación en la característica j: $\Delta w_j$. Para la siguiente muestra, se recalcularán los pesos:
$$
w_j := w_j + \Delta w_j
$$

### Condiciones de convergencia

Este proceso iterativo puede converger o no. Para que el perceptrón clasifique correctamente las muestras , el valor de $w_j$ debe ir acercándose cada vez más a un valor final, o lo que es lo mismo, $\Delta w_j$ debe ser cada vez más pequeño. 

Para que se de esta situación deben cumplirse dos requisitos: 

* La tasa de aprendizaje debe ser suficientemente pequeña. En general, cuanto más grande sea $\eta$ más rápido será el aprendizaje, pero pasado cierto valor el proceso de aprendizaje nunca convergerá

* Las dos clases deben ser linealmente separables. Es decir, si representamos los elementos de ambas clases en un diagrama de 2 dimensiones (suponeniendo que las muestras tienen dos características), debe existir una línea que separe a todos los de una clase a un lado, y a todos los de la otra clase al otro lado.

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

Una vez instanciado el perceptrón llamaremos al método `fit` para entrenar nuestro modelo. Se le pasan dos parámetros: una matriz $\bf X$, que contiene una fila por cada muestra y una columna por cada característica, y que constituye nuestro conjunto de datos de entrenamiento, y un array $\bf y$, que contiene el resultado objetivo para cada muestra. 

Lo primero que hace el método `fit` es inicializar los pesos y los errores:
```python
  self.w_ = np.zeros(1 + X.shape[1])
  self.errors_ = []
```

Los pesos se inicializan a un array con el mismo número de elementos que muestras tiene la matriz $\bf X$ más uno. 

A continuación comienza un precose que se ejecutará `n_iter` veces. En el se itera sobre los datos proporcionados mediante esta instrucción:
```python
   for xi, target in zip(X, y)
```
