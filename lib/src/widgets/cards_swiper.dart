import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key, required this.peliculas}) : super(key: key);

  final List<Pelicula> peliculas;

  @override
  Widget build(BuildContext context) {

    final screnSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: screnSize.width * 0.7,
          itemHeight: screnSize.height * 0.5,
          // autoplay: true,
          itemBuilder: (context, index) {
            peliculas[index].uniqueId = '${ peliculas[index].id }-Swiper';
            return Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: (() => Navigator.pushNamed(context, 'detalles', arguments: peliculas[index])),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ); 
          },
          itemCount: peliculas.length,
        ),
    );
  }
}