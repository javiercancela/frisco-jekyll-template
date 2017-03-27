---
title: Machine Learning con Python - Tema 2 - Adaline
date: 2017-04-02 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

El perceptrón visto en el post anterior es una red neuronal de una sola capa. Otro ejemplo de este tipo de redes es la llamada **neurona lineal adaptativa**, en inglés _ADAptative LIneal NEuron_, o [_ADALINE_](https://es.wikipedia.org/wiki/Adaline). Nos dice el libro que la importancia de este algoritmo se debe a que muestra con claridad la definición y minimización de las funciones de costos (_cost functions_). 

## Función de costos
**Función de costos** es un término que procede de la economía, y hace referencia a la función que expresa los costes de producción en términos de la cantidad conocida. En el campo de las redes neuronales la función de costos devuelve un número que determina indica lo bien que el algoritmo genera las salidas correctas para las muestras de entrenamiento. Este número es mejor cuanto más bajo, por eso se busca minimizar el valor de la función. Esta minimización de la función de costos supone la base de técnicas de clasificación más avanzadas.

La diferencia básica entre Adaline y el perceptrón está en la función de activación, que pasa de ser una función escalón a ser una función lineal.


<div style="text-align:center">
    <figure>
        <a href="https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/images/02_09.png"><img alt="Actualizamos los pesos con una función lineal de la entrada" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_09.png" /></a>
        <figcaption>Actualizamos los pesos con una función lineal de la entrada</figcaption>
    </figure>
</div>

En concreto, la función lineal de activación de Adaline es la función identidad $$\phi(z) = z$$, con lo que $$\phi(\mathbf{w}^T\bf x) = \mathbf{w}^T\bf x$$. Como vemos en la gráfica superior, se sigue usando un cuantizador para clasificar la muestra, aunque no se use ya para corregir los pesos.

## Minimización de funciones de costos

Como vimos en el caso del perceptrón, la actualización de pesos se realiza calculando $$w_j := w_j + \eta(y^{(i)} - \hat y^{(i)})x_j^{(i)}$$. Para el perceptrón tanto $$y^{(i)}$$ como $$\hat y^{(i)}$$ son etiquetas de clases con solo dos posibles valores. En el caso de Adaline se usan valores continuos.

La idea de la función de costos es definir una función que se pueda optimizar durante el proceso de aprendizaje. Para ello utilizamos la suma de los errores al cuadrado (_Sum of Squared Errors_, o _SSE_, también llamado en inglés [_Residual Sum of Squareds_](https://en.wikipedia.org/wiki/Residual_sum_of_squares)):

$$
J({\mathbf{w}}) = \frac{1}{2} \sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big)^2,
$$

donde $$\frac{1}{2}$$ se incluye para simplificar cálculos posteriores. Como buscamos el $$\mathbf{w}$$ que minimiza el valor de esa función, multiplicarla por una constante no afecta al resultado. Como siempre, $$y^{(i)}$$ es el resultado esperado para la muestra $$i$$. $$\phi(z)_{A}^{(i)}$$ es la salida de la función de activación ($$A$$) para la muestra $$i$$. 

Esta función es diferenciable y convexa, lo que nos permite calcular un mínimo. Como nuestra función de costos sólo depende de los pesos $$\mathbf{w}$$, minimizarla nos dará el peso que tenga una menor diferencia entre la salida esperada y la obtenida ($$y^{(i)} - \phi(z)_{A}^{(i)}$$). Para ello se usa un algoritmo llamado [gradiente descendente](http://alejandrosanchezyali.blogspot.co.uk/2016/01/algoritmo-del-gradiente-descendente-y.html). Para ello vamos a ir modificar el peso $$\mathbf{w}$$ en incrementos $$\Delta \mathbf{w}$$: 

$$
\mathbf{w} := \mathbf{w} + \Delta \mathbf{w}.
$$

Para calcular $$\Delta \mathbf{w}$$ vamos a necesitar conocer el gradiente de nuestra función de costos: $$\nabla J(\mathbf{w})$$. [Gradiente](https://es.wikipedia.org/wiki/Gradiente) es un término matemático que hace referencia al vector que indica la dirección en la que un campo varía con más rapidez. Desde un punto de vista geométrico, el gradiente de una curva es su derivada, o el vector que apunta en la dirección en la que el incremento de la misma es máximo. 

<div style="text-align:center">
    <figure>
        <a href="https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/images/02_10.png"><img alt="Usamos el gradiente en cada punto para calcular los decrementos que nos lleven al mínimo" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_10.png" /></a>
        <figcaption>Usamos el gradiente en cada punto para calcular los decrementos que nos lleven al mínimo</figcaption>
    </figure>
</div>

Nosotros vamos a usar el gradiente para buscar el mínimo de $$J(\mathbf{w})$$, así que en vez de sumarlo lo restaremos (de ahí lo de gradiente descendente). Además usaremos nuestra tasa de aprendizaje para modular esta iteración:

$$
\Delta \mathbf{w} = - \eta \nabla J(\mathbf{w}).
$$

Dado que 

$$
J({\mathbf{w}}) = \frac{1}{2} \sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big)^2,
$$

tendremos que cada uno de los pesos se actualizará con este incremento:

$$
\Delta w_{j} := \eta \sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big) x_{j}^{(i)}.
$$

Para una explicación del cálculo de este gradiente podemos leer [este artículo del propio Sebastian Raschka](http://rasbt.github.io/mlxtend/user_guide/general_concepts/linear-gradient-derivative/).

## Adaline en Python

Como en la entrada anterior, el código está [sacado de GitHub](https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/ch02.ipynb). 

La implementación de Adaline es muy similar a la del Perceptrón. La única diferencia está en el método `fit`, donde los pesos se actualizan con el gradiente descendente


<pre class="line-numbers">
  <code class="language-python">
	class AdalineGD(object):
	    def __init__(self, eta=0.01, n_iter=50):
	        self.eta = eta
	        self.n_iter = n_iter

	    def fit(self, X, y):
	        self.w_ = np.zeros(1 + X.shape[1])
	        self.cost_ = []

	        for i in range(self.n_iter):
	            output = self.activation(X)
	            errors = (y - output)
	            self.w_[1:] += self.eta * X.T.dot(errors)
	            self.w_[0] += self.eta * errors.sum()
	            cost = (errors**2).sum() / 2.0
	            self.cost_.append(cost)
	        return self

	    def net_input(self, X):
	        return np.dot(X, self.w_[1:]) + self.w_[0]

	    def activation(self, X):
	        return self.net_input(X)

	    def predict(self, X):
	        return np.where(self.activation(X) >= 0.0, 1, -1)
  </code>
</pre>

Recordemos cómo funciona el método `fit`. Se le pasan dos parámetros: una matriz $$\bf X$$, que contiene una fila por cada muestra y una columna por cada característica, y que constituye nuestro conjunto de datos de entrenamiento; y un array $$\bf y$$, que contiene el resultado objetivo para cada muestra. 

Lo primero que hace el método `fit` es inicializar los pesos y los costos:

```python
self.w_ = np.zeros(1 + X.shape[1])
self.cost_ = []
```
Después iteramos el proceso tantas veces como épocas se hayan definido. La entrada neta (la función `net_input`) es el producto escalar de los atributos de las muestras y sus pesos. Para la salida utilizamos una función `activation` que es igual a la entrada neta. La existencia de este método se justifica para hacer el código más general, y poder reutilizarlo con otros algoritmos. En nuestro caso, esta función es la función identidad, por lo que podríamos haber usado directamente `net_input`. El error será la difencia entre la salida esperada, `y`, y la real, `output`.


```python
output = self.activation(X)
errors = (y - output)
```

Si recordamos las entradas anteriores, la salida esperada `y` es un array con las clases reales de 100 muestras, las 50 primeras con valor -1 (Iris-setosa), y las 50 siguientes con valor 1 (Iris-versicolor). El valor de output es la salida de la función identidad, pero en este caso vamos a considerar todas las muestras a la vez, con lo que tendremos un array de 100 elementos en vez de un escalar. El método `net_input` calcula el producto escalar de la matriz de muestras `X` por el array de pesos `w_`. 


```python
def net_input(self, X):
    return np.dot(X, self.w_[1:]) + self.w_[0]

```

El resultado es un array de errores `errors` de 100 elementos, uno para cada muestra. Con ellos se actualizan los pesos:


```python
self.w_[1:] += self.eta * X.T.dot(errors)
self.w_[0] += self.eta * errors.sum()
```

En la primera línea se aplica un incremento `self.eta * X.T.dot(errors)` al array de pesos $$\mathbf{w}$$, salvo al elemento $$w_0$$ (peso asociado a una entrada ficticia $$x_0 = 1$$ para simplificar los cálculos). Recordando la fórmula de incremento de pesos vista más arriba:

$$
\Delta w_{j} := \eta \sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big) x_{j}^{(i)},
$$

tenemos que los elementos $$error^{(i)}$$ del array `errors` se corresponden con $$error^{(i)} = y^{(i)} - \phi(z)_{A}^{(i)}$$. Por lo tanto, el producto escalar entre la traspuesta de la matriz de atributos de cada muestra `X` y el array de errores `errors` (`X.T.dot(errors)`) se corresonden con el sumatorio $$\sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big) x_{j}^{(i)}$$.

Para el caso del elemento $$w_0$$, al ser el valor de los atributos de esa muestra ficticia igual a uno, basta con sumar los errores para obtener el incremento de peso (también podríamos haber añadido una fila con valores unitarios a la matriz `X`).

Aunque el algoritmo no usa la función de costos directanemte, ya que el ajuste de pesos se realiza mediante el gradiente descendente que acabamos de aplicar, y que se explica más arriba, vamos a almacenar también el valor de la función para dibujar después su evolución. 

Recordemos la funcón de costos: $$J({\mathbf{w}}) = \frac{1}{2} \sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big)^2$$. El programa almacena un arrary `errors = (y - output)` que se corresponde con $$y^{(i)} - \phi(z)_{A}^{(i)}$$, así que para calcular en valor de la función sólo tenemos que sumar el cuadrado de los valores del array y dividir entre dos. Esto nos dará el valor calculado por la función de costos para los pesos actuales. Como estamos iterando mediante el gradiente descendente vamos a almacenar los resultados de la función obtenidos para cada conjunto de pesos:

```python
cost = (errors**2).sum() / 2.0
self.cost_.append(cost)
```

Una vez definida la clase, el libro pasa a utilizarla con dos tasas de aprendizaje distintas. Esta tasa va a determinar la convergencia del algoritmo, y encontrar el valor que nos de la mejor convergencia posible requiere muchas pruebas. Vamos a probar con $$\eta = 0.1$$ y $$\eta = 0.0001$$:

```python
fig, ax = plt.subplots(nrows=1, ncols=2, figsize=(8, 4))

ada1 = AdalineGD(n_iter=10, eta=0.01).fit(X, y)
ax[0].plot(range(1, len(ada1.cost_) + 1), np.log10(ada1.cost_), marker='o')
ax[0].set_xlabel('Epochs')
ax[0].set_ylabel('log(Sum-squared-error)')
ax[0].set_title('Adaline - Learning rate 0.01')

ada2 = AdalineGD(n_iter=10, eta=0.0001).fit(X, y)
ax[1].plot(range(1, len(ada2.cost_) + 1), ada2.cost_, marker='o')
ax[1].set_xlabel('Epochs')
ax[1].set_ylabel('Sum-squared-error')
ax[1].set_title('Adaline - Learning rate 0.0001')

plt.tight_layout()
plt.show()
```

Pintamos una gráfica con cada tasa, representado la evolución del valor de la función de costos para cada iteración (época). Para la tasa de 0.1 representamos en realidad el logaritmo del valor, ya que el valor real diverge exponencialmente. En cambio, podemos ver como la tasa de 0.0001 converge, pero lentamente.

<div style="text-align:center">
    <figure>
        <a href="https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/images/02_11.png"><img alt="Una tasa de aprendizaje muy alta provoca que el algoritmo no converja, una tasa muy baja provoca que converja lentamente" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_11.png" /></a>
        <figcaption>Una tasa de aprendizaje muy alta provoca que el algoritmo no converja, una tasa muy baja provoca que converja lentamente</figcaption>
    </figure>
</div>

Llevado al ejemplo visual del gradiente descendente, podemos ver como la tasa de aprendizaje influye en la longitud del "paso" que se da hacia el mínimo. Si este paso es muy grande el algoritmo "se sale":

<div style="text-align:center">
    <figure>
        <a href="https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/images/02_12.png"><img alt="Visualización gráfica de los pasos dados con el algoritmo" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_12.png" /></a>
        <figcaption>Visualización gráfica de los pasos dados con el algoritmo</figcaption>
    </figure>
</div>

El libro acaba esta parte con una referencia al escalado de características que se verá en el tema 3, y que nosotros dejaremos hasta entonces.

En la próxima entrada veremos cómo modificar este algoritmo para adaptarlo a grandes grupos de datos.

