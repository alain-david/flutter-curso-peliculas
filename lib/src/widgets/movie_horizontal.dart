import 'package:flutter/material.dart';

import 'package:peliculas/src/models/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal({Key? key, required this.peliculas, required this.siguientePagina}) : super(key: key);

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
    // keepPage: false,
  );

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener( ( () {
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent-200){
          siguientePagina();
        }
      })
    );

    return SizedBox(
      height: screenSize.height * 0.2,
      child: PageView.builder(
        // reverse: true,
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: ( context, i) => _tarjeta(context, peliculas[i] ),
      ),
    );
  }

  Widget _tarjeta (context, pelicula){
    pelicula.uniqueId = '${ pelicula.id }-horizontal';
    final tarjeta = Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg()),
                placeholder: const AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
          ),
          const SizedBox(height: 5.0,),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  return GestureDetector(
    child: tarjeta,
    onTap: (){
      Navigator.pushNamed(context, 'detalles', arguments: pelicula);
    },
    );
  }
}