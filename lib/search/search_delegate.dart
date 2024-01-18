import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate { // Para que en el homescreen funcione, debe heredar de esta manera
 
 @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Search movie'; // cambiar el texto del input de busqueda
 
 @override
  List<Widget>? buildActions(BuildContext context) {
    // // TODO: implement buildActions
    // throw UnimplementedError();
    return [
      // Text('Build actions')
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '', // limpia el query de busqueda
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // // TODO: implement buildLeading
    // throw UnimplementedError();
    // return Text('Build leading');
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        // este metodo ya viene en el delegate
        close(context, null);//el result es lo que se quiere regresar en el momento que se manda a llamar showSearch
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // // TODO: implement buildResults
    // throw UnimplementedError();
    return Text('Build results');
    // return ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // // TODO: implement buildSuggestions
    // throw UnimplementedError();
    // return Text('Build Suggestions: $query');
    if( query.isEmpty){
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery( query ); // se va a mandar a llamar cada vez que se toca una tecla


    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot) { // Cuando tenga data va a ser una lista de peliculas
        if(!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
        );
      },
    );
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
      ),
    );
  }

}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  // final String? heroId;
  const _MovieItem( {required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        // print(movie.title);
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}

// DOCUMENTADO PORQUE FUE MODIFICADO
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // // TODO: implement buildSuggestions
  //   // throw UnimplementedError();
  //   // return Text('Build Suggestions: $query');
  //   if( query.isEmpty){
  //     return _emptyContainer();
  //   }

  //   final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);


  //   return FutureBuilder(
  //     future: moviesProvider.searchMovies(query),
  //     builder: ( _ , AsyncSnapshot<List<Movie>> snapshot) { // Cuando tenga data va a ser una lista de peliculas
  //       if(!snapshot.hasData) return _emptyContainer();
  //       final movies = snapshot.data!;
  //       return ListView.builder(
  //         itemCount: movies.length,
  //         itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
  //       );
  //     },
  //   );
  // }

