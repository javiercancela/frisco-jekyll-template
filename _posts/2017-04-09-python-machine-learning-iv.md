---
title: PML T2 - Gradiente descendente estocástico
date: 2017-04-09 03:00:00 +0200
description: Python Machine Learning - Tema 2 - Notas sobre el libro de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

El siguiente punto del libro nos habla de cómo modificar este algoritmo para adaptarlo a conjuntos con millones de datos. El punto clave está en que la forma del algoritmo que hemos analizado reevalúa todo el conjunto de datos cada vez que se realiza una iteración o época. Si tenemos 1 millón de muestras, por cada época vamos a tener que calcular:
$$
\Delta \mathbf{w} = \eta \sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big) x^{(i)}
$$

Es decir, para cada época tenemos que realizar un millón de veces:

* el cálculo de la función de costos
* el cálculo de la resta con la clase real
* la multiplicación del resultado por la entrada de la muestra

y después sumar el millón de resultados.

### Optimizando el proceso

El gradiente descendente estocástico utiliza otra aproximación. En vez de recalcular los pesos usando todas las muestras, utilizamos sólo la muestra de la entrada para el cálculo:
$$
\Delta \mathbf{w} = \eta \big(y^{(i)} - \phi(z)_{A}^{(i)}\big) x^{(i)}
$$

Este cambio tiene dos consecuencias fundamentales Por un lado, los pesos se actualizan con más frecuencia, así que la convergencia suele ser más rápida. Por otro lado, usar una sola muestra da menos precisión a la actualización, así que se introduce más ruido en los pesos. Esto no es necesariamente malo, ya que facilita salir de mínimos locales que no se corresponden con la minimización de nuestra función de costos. Otra ventaja de este algoritmo es que resulta adecuado para el aprendizaje _on line_, es decir, aquel en el que el modelo tiene que adaptarse rápidamente a cambios en los datos.

Una variante mencionada en el libro pero no implementada en el código consiste en sustituir una tasa de aprendizaje fija $$\eta$$ por una que disminuya con el tiempo:

$$
\frac{c_1}{[\textit {número de iteraciones}] + c_2}
$$

### Código Python

Vamos a adaptar la clase Adaline anterior a este nuevo algoritmo:

<pre class="line-numbers">
  <code class="language-python">
  from numpy.random import seed

  class AdalineSGD(object):
      def __init__(self, eta=0.01, n_iter=10, shuffle=True, random_state=None):
          self.eta = eta
          self.n_iter = n_iter
          self.w_initialized = False
          self.shuffle = shuffle
          if random_state:
              seed(random_state)
          
      def fit(self, X, y):
          self._initialize_weights(X.shape[1])
          self.cost_ = []
          for i in range(self.n_iter):
              if self.shuffle:
                  X, y = self._shuffle(X, y)
              cost = []
              for xi, target in zip(X, y):
                  cost.append(self._update_weights(xi, target))
              avg_cost = sum(cost) / len(y)
              self.cost_.append(avg_cost)
          return self

      def partial_fit(self, X, y):
          if not self.w_initialized:
              self._initialize_weights(X.shape[1])
          if y.ravel().shape[0] > 1:
              for xi, target in zip(X, y):
                  self._update_weights(xi, target)
          else:
              self._update_weights(X, y)
          return self

      def _shuffle(self, X, y):
          r = np.random.permutation(len(y))
          return X[r], y[r]
      
      def _initialize_weights(self, m):
          self.w_ = np.zeros(1 + m)
          self.w_initialized = True
          
      def _update_weights(self, xi, target):
          output = self.net_input(xi)
          error = (target - output)
          self.w_[1:] += self.eta * xi.dot(error)
          self.w_[0] += self.eta * error
          cost = 0.5 * error**2
          return cost
      
      def net_input(self, X):
          return np.dot(X, self.w_[1:]) + self.w_[0]

      def activation(self, X):
          return self.net_input(X)

      def predict(self, X):
          return np.where(self.activation(X) >= 0.0, 1, -1)
  </code>
</pre>

En primer lugar, hemos añadido un método `_shuffle` para mezclar los datos de la entrada antes de cada iteración. El propósito de este paso es evitar ciclos al minimizar la función de costos, ya que este algoritmo es sensible a este problema.

```python
def _shuffle(self, X, y):
    r = np.random.permutation(len(y))
    return X[r], y[r]
```

El constructor incluye parámetros para indicar si queremos mezclar al azar los datos de entrada y para inicializar una semilla para esta mezcla. 

El método `fit` es el que se encarga del entrenamiento. Invocamos primero al método que inicializa los pesos a cero. Este método existe para marcar los pesos como inicializados, información que necesitamos para el método de entrenamiento parcial `parcial_fit`.


Dentro del método `fit` el código que se itera en cada época comienza comprobando si hay que barajar los datos de entrada, e inicializa el costo que evaluará la función de costos:


```python
if self.shuffle:
    X, y = self._shuffle(X, y)
cost = []
```

A continuación iteramos los datos. La variable `X` es una matriz que contiene una fila por cada muestra, y una columna por cada característica. La variable `y` es un array que contiene un elemento, la clase real, para cada muestra de `X`. El método `zip` nos devolverá un elemento de cada variable (_zip_ en inglés significa, entre otras cosas, cremallera), por lo que en cada iteración del `for` en `xi` y en `target` se almacenarán las características y la clase real de cada muestra.

```python
for xi, target in zip(X, y):
    cost.append(self._update_weights(xi, target))

```

Para cada muestra, actualizamos los pesos en el método `_update_weights`:

```python
def _update_weights(self, xi, target):
    output = self.net_input(xi)
    error = (target - output)
    self.w_[1:] += self.eta * xi.dot(error)
    self.w_[0] += self.eta * error
    cost = 0.5 * error**2
    return cost

```

Para la salida real seguimos utilizando la función identidad, con lo que la `output` es igual a la entrada. La diferencia en este nuevo algoritmo está en cómo ajustamos los pesos. El array de pesos se ajusta con el producto del error con la muestra procesada, no con toda la matriz de entradas. Lógicamente, el costo calculado se obtendrá del error de esta muestra al cuadrado. El costo lo añadimos al array de costos para representarlo posteriormente.


```python
avg_cost = sum(cost) / len(y)
self.cost_.append(avg_cost)
```

Para finalizar el método `fit` calculamos la media de los costos de cada muestra, y la añadimos al array de costos.

### Resultados

Ahora toca usar esta clase. La instanciamos y entrenamos el modelo (el libro usa, en este ejemplo y en el de la entrada anterior, un conjunto de datos escalado para mejorar el rendimiento, y que nosotros revisaremos en el tema 3):


```python
ada = AdalineSGD(n_iter=15, eta=0.01, random_state=1)
ada.fit(X, y)
```

Pintamos los resultados, primero mostrando la clasificación de las muestras y después el costo por época.

```python
plot_decision_regions(X, y, classifier=ada)
plt.title('Adaline - Gradiente descendiente estocástico')
plt.xlabel('longitud sépalo')
plt.ylabel('longitud pétalo')
plt.legend(loc='upper left')

plt.tight_layout()
plt.show()
plt.plot(range(1, len(ada.cost_) + 1), ada.cost_, marker='o')
plt.xlabel('Épocas')
plt.ylabel('Costo medio')

plt.tight_layout()
plt.show()
```
Los datos obtenidos son estos (los resultados son distintos a los obtenidos en el libro, ya que nosotros no hemos estandarizado los valores de las muestras):

<div style="text-align:center">
    <figure>
        <img alt="Arriba, nuestros resultados. Abajo, los resultados del libro con los valores estandarizados" src ="/images/pml/2_adaline.png" />
        <a href="https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/images/02_14.png"><img alt="Arriba, nuestros resultados. Abajo, los resultados del libro con los valores estandarizados" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_14.png" /></a>
        <figcaption>Arriba, nuestros resultados. Abajo, los resultados del libro con los valores estandarizados</figcaption>
    </figure>
</div>

Nuestra convergencia es mucha más rápida, pero también muy variable, ya que a partir de la sexta época el costo empieza a oscilar.