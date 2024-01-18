import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class CardSwiper extends StatelessWidget {
  // const CardSwiper({super.key});

  final List<Movie> movies;

  const CardSwiper({super.key, required this.movies}); // De esta forma se envian parametros posicionales

  
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    var loading = Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        )
    );

    if(movies.isEmpty){
      return loading;
    }

    // if(this.movies.length == 0) {
    //   return Container(
    //     width: double.infinity,
    //     height: size.height * 0.5,
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        // color: Colors.indigo.shade200
      ),
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.45,
        itemBuilder: ( _, int index ) {

          final movie = movies[index];
          movie.heroId = 'swiper-${movie.id}';
          // print(movie.fullPosterImg);

          return GestureDetector(
            // onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!, // el tag puede ser cualquier cosa pero tiene que ser unico, se le pone el signo porque esta declarado como opcional pero con el signo se le dice a dart que siempre tendra un valor
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage( // animacion para mostrar la imagen
                  placeholder:AssetImage('assets/no-image.jpg'),
                  // image: NetworkImage('https://via.placeholder.com/300x400'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }, // item builder es una funcion que se va a disparar para construir un nuevo widget
      ),
    );
  }
}