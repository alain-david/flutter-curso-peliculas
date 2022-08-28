import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  final peliculasProvider = PeliculasProvider();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Acciones del AppBar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Leading del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados de la busqueda
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias de busqueda
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (context, AsyncSnapshot<List<Pelicula>> snapshot){
          if (snapshot.hasData) {

            final peliculas = snapshot.data!;

            return ListView(
              children: peliculas.map(( pelicula ) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalles', arguments: pelicula);
                  },
                );
              }).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      );
  }

}