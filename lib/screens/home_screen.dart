import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  // const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true); // Del arbol de widgets, obtiene la instancia de MoviesProvider y la coloca aqui
    print(moviesProvider.onDisplayMovies); // No es un metodo, es la propiedad onDisplayMovies (List<Movie> onDisplayMovies)
                                                              // Cuando se manda a llamar el NotifierListener verifica si el widget tiene alguna dependencia y lo redibuja, por defecto esta en true
    // return Container(
    //   child: Text('Home screeen'),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
            icon: const Icon(Icons.search_rounded),
          )
        ],
      ),
      body: SingleChildScrollView( // Permite hacer scrolly se puede mostrar toda la informacion que se necesite
        child: Column(
        children: [
          //Tarjetas principales
          // const CardSwiper( movies: moviesProvider.onDisplayMovies ),
          CardSwiper(movies: moviesProvider.onDisplayMovies,), // Para enviar parametros por nombre, se deben especificar como required en el constructor
          // Slider de peliculas
          MovieSlider(
            movies: moviesProvider.popularMovies,
            title: 'Populares',
            onNextPage: () => moviesProvider.getPopularMovies(),
          ),
          // MovieSlider(movies: moviesProvider.popularMovies, title: 'De la semana', onNextPage: ,),
          // MovieSlider(movies: moviesProvider.popularMovies, onNextPage: ,),

          // MovieSlider(),

          // MovieSlider(),

          // MovieSlider(),

          // MovieSlider(),

          // MovieSlider()

          // Listado de peliculas
        ],
      ),
      )
    );
  }
}