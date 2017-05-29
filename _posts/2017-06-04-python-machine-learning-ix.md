---
title: PML T3 - 
date: 2017-06-04 03:00:00 +0200
description: Python Machine Learning - Tema 3 - Notas sobre el libro de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

Para utilizar el mismo planteamiento que en otros algoritmos, convirtamos esta función en una función de costos. La función $$l(\mathbf{w})$$ es tal que al maximizarla maximizamos la probabilidad de que cada muestra pertenezca a la clase predicha, ya que es el logaritmo de la función que calcula dicha probabilidad. Si la cambiamos de signo, optimizaremos esta probabilidad calculando su mínimo, con lo nuestra función de coste puede ser la negativa de $$l(\mathbf{w})$$:

$$
J(\mathbf{w}) = \sum_{i=1}^{n} \Bigg[- y^{(i)} \log \bigg(\phi \big( z^{(i)} \big) \bigg) - \bigg(1 - y^{(i)} \bigg) \log \bigg( 1 - \phi \big( z^{(i)} \big) \bigg)  \Bigg]
$$

Con esta introducción ya tenemos lo suficiente para ver cómo utilizar este algoritmo con _scikit-learn_.

### Entrenamiento en Python

Como se menciona en el libro, bastaría con sustituir la función de costos usada en ADALINE por la que hemos obtenido para que nos sirviese el ejemplo de código del tema 2. Pero la estrategia correcta es, por supuesto, dejar esta tarea a _scikit-learn_, cuya implementación síempre será más óptima y libre de errores que la nuestra.

<pre class="line-numbers">
  <code class="language-python">
	from sklearn.linear_model import LogisticRegression

	lr = LogisticRegression(C=1000.0, random_state=0)
	lr.fit(X_train_std, y_train)

	plot_decision_regions(X_combined_std, y_combined,
	                      classifier=lr, test_idx=range(105, 150))
	plt.xlabel('petal length [standardized]')
	plt.ylabel('petal width [standardized]')
	plt.legend(loc='upper left')
	plt.tight_layout()
	plt.show()  
  </code>
 </pre>