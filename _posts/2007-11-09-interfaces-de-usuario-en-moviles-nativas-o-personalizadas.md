---
id: 125
title: 'Interfaces de usuario en móviles: ¿nativas o personalizadas?'
date: 2007-11-09T13:55:31+00:00
author: javiercancela
layout: post
guid: 'http://javiercancela.com/2007/11/09/interfaces-de-usuario-en-moviles-%c2%bfnativas-o-personalizadas/'
categories:
  - otros
image: /images/obsolete.jpg
---
Una reflexión rápida provocada por el post [Native or Custom UI?](http://mobilephonedevelopment.com/archives/475 "Native or Custom UI?") (¿Interfaz de usuario nativa o personalizada?) en el blog [Mobile Phone Development](http://www.mobilephonedevelopment.com/ "Mobile Phone Development"). En él se comparan las interfaces de usuario de [ProfiMail](http://www.lonelycatgames.com/?app=profimail "ProfiMail") y de las versiones nativa y Java del [cliente de GMail para móviles](http://gmail.com/app "Google Mobile"). Nokia tiene una extensa [especificación](http://www.forum.nokia.com/info/sw.nokia.com/id/04c58d5a-84c3-42db-83d5-486c1cf3e6b3/S60_UI_Style_Guide_v1_3_en.pdf.html "S60 UI Style Guide v1.3") sobre cómo las aplicaciones deben respetar la interfaz de usuario propia de S60, y Simon Judge, el autor del artículo, proporciona varios motivos por los que los autores de software pueden querer utilizar su propia interfaz de usuario.

Aunque las razones que da me parecen válidas, esta situación me recuerda hasta cierto punto lo que ocurría con la programación en Windows durante la segunda mitad de los 90. La API de Windows proporcionaba una interfaz de usuario que, aunque no especialmente bonita ni visualmente configurable, proporcionaba toda la funcionalidad que un programador podía razonablemente esperar. Muchas aplicaciones incorporaban su propia interfaz de usuario, generalmente por motivos estéticos (ya que habitualmente no presentaban mejoras de usabilidad), lo cual incrementaba el coste del desarrollo e introducía nuevas posibilidades incorporar bugs y problemas de seguridad en el producto. Hay un [artículo de Joel Spolsky](http://www.joelonsoftware.com/uibook/chapters/fog0000000061.html "Consistency and Other Hobgoblins") de hace unos años que habla de este asunto.

Aunque no creo que la situación con las interfaces de los móviles sea la misma, sí hay que tener en cuenta que mantener una interfaz de usuario consistente no es la única ventaja de seguir las recomendaciones de UI de cada plataforma. Según aumenta la potencia de los móviles también lo hace la complejidad de su software, por lo que hay que evaluar con mucho cuidado si lo que nos aporte la nueva UI nos va a compensar el esfuerzo.