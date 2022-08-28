import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/cards_swiper.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Peliculas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){
              showSearch( 
                context: context,
                delegate: DataSearch(),
                // query: ''
              );
            }
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _swiperTarjetas(),
          _footer(context),
        ],
      ),
    );
  }

  Widget _swiperTarjetas(){
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: ((context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data!);
        } else {
          return const SizedBox(
            height: 400.0,
            child: Center(child: CircularProgressIndicator()));
        }
      })
    );
  }

  Widget _footer(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('   Populares', style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: ((context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data!, siguientePagina: peliculasProvider.getPopulares,);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
          ),
        ]
      ),
    );
  }
}