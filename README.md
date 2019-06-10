# The Movie DB Client!

El código esta basado en el enunciado y trata de cubrir la mayoría de los puntos. Es una aplicación simple la cual consume una API REST del sitio themoviedb. 

La aplicación esta estructurada de una manera clara, agregando grupos para cada una de las capas y archivos comunes. 

## Organizacion de la App

Los grupos principales son:

* **Assets**: contiene recursos que son utilizados en la app como imágenes, JSON para test, etc.

* **Commons**: Solamente posee enumeraciones y la clase AppDelegate.

* **Helpers**: Varias clases cuyo objetivo es simplificar el desarrollo, centralizando el código que se usa varias veces en la app.

* **Model**: Archivos base de modelo, me hubiera gustado poder dedicarle mas tiempo para tener archivos planos de solo atributos para enviar a la vista.

* **Services**: Estan contenidos los servicios de Networking y Base de Datos

Finalmente existe otros grupos que contienen las clases relacionada a cada feature en la app. Estos son:

* **Main View**: tab bar que contiene un tab para peliculas y uno para series. Desarrollado con MVP

* **MoviesMainList**: es la lista principal de peliculas las cuales pueden ser filtradas por categorias Top Rated, Popular, Upcoming, On the Air. Las categorias depende de si se visualiza movie o tv. Para el desarrollo de esta pantalla se utilizo VIPER, con algunas limitaciones por convivir con otros protocolos los cuales utilice para agilizar el desarrollo.

* **MovieDetail**: Muestra el detalle de una pelicula/serie permitiendo ver los trailers si ellos se encuentran disponibles.

* **Movie Search**: Un buscador el cual permite buscar peliculas o series por una cadena determinada. El mismo busca entre peliculas almacenadas en cache si la app no tiene internet.



Al navegar el código se notará que hay varios patrones de arquitectura utilizados, la idea era demostrar como funciona cada uno, pero en otros casos por necesidad de avanzar con la app, priorice el resultado visutal y de UX antes que el de arquitectura. Como todo diseño de una aplicación siempre es devatible y mejorable, se trato de demostrar y utilizar la mayor cantidad de herramientas posibles, pero no siempre se puede demostrar todo :).




## Installation

La app utiliza Cocoapods, por los que es necesario instarlo antes de correrla. Luego simplemente ejecutar:

```bash
pod install
```

## Third Party libraries

* [Alamofire](https://github.com/Alamofire/Alamofire)
* [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
* [MXSegmentedControl](https://github.com/maxep/MXSegmentedControl)
* [YoutubeDirectLinkExtractor](https://github.com/devandsev/YoutubeDirectLinkExtractor)
* [TTGSnackbar](https://github.com/zekunyan/TTGSnackbar)


## Demo
![](movie.GIF)
