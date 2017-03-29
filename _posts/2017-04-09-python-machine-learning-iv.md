---
title: Machine Learning con Python - Tema 2 - Gradiente descendente estocástico
date: 2017-04-09 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
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

Es decir, para cada época tenemos que ralizar un millón de veces:

* el cálculo de la función de costros
* el cálculo de la resta con la clase real
* la multiplicación del resultado por la entrada de la muestra

y después sumar el millón de resultados.


El gradiente descendente estocástico utiliza otra aproximación. En vez de recalcular los pesos usando todas las muestras, utilizamos sólo la muestra de la entrada para el cálculo:
$$
\Delta \mathbf{w} = \eta \big(y^{(i)} - \phi(z)_{A}^{(i)}\big) x^{(i)}
$$

Este cambio tiene dos consecuencias fundamentales Por un lado, los pesos se actualizan con más frecuencia, así que la convergencia suele ser más rápida. Por otro lado, usar una sola muestra da menos precisión a la actualización, así que se introduce más ruido en los pesos. Esto no es necesariamente malo, ya que facilita salir de mínimos locales que no se corresponden con la minimización de nuestra función de costos. Otra ventaja de este algoritmo es que resulta adecuado para el aprendizaje _on line_, es decir, aquel en el que el modelo tiene que adaptarse rápidamente a cambios en los datos.

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