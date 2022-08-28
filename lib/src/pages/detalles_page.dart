import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/peliculas_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DetallesPage extends StatelessWidget {
  const DetallesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _posterTitulo(context, pelicula),
                _description(pelicula),
                _crearCasting(pelicula),
              ]
            ),
          ),
        ],
      )
    );
  }
  
  Widget _appBar(Pelicula pelicula) {
    return SliverAppBar(
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: const TextStyle(color: Colors.white),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: const AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
          )
      ),
    );
  }
  
  _posterTitulo(context, Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child:Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage( pelicula.getPosterImg() ),
                height: 150,
              ),
          
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title, style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    const Icon( Icons.star),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1),
                  ],
                )
              ],
            )
          ),
        ],
      )
    );
  }
  
  _description(Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
  
  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView( snapshot.data! );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  
  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1, 
        ),
        itemCount: actores.length,
        itemBuilder: (context, i){
          return _actoresTarjeta( actores[i] );
        },
      ),
    );
  }

  Widget _actoresTarjeta(Actor actor) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            image: NetworkImage(actor.getFoto()),
            placeholder: const AssetImage('assets/no-image.jpg'),
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}