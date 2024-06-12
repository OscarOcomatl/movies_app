import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {
  // const MovieSlider({super.key});

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  MovieSlider({required this.movies, this.title, required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        // print('obtener siguiente pagina');
        widget.onNextPage(); // Ejecuta la funcion que recibe por parametro
      }
      // print(scrollController.position.pixels);
      // print(scrollController.position.maxScrollExtent);

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // this.title != null ? Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text(this.title.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),) : Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text('Recomendadas para ti', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
          if(widget.title != null)
            Padding
            (padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(widget.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),


          //TODO: Si viene el titulo, mostrar, si no, no se debe mostrar
          // Padding
          // (padding: EdgeInsets.symmetric(horizontal: 20),
          // child: Text('Populares', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          // ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _, int index) { 
                // final movie = widget.movies[index];
                return _MoviePoster( widget.movies[ index ], '${widget.title}-$index-${widget.movies[index].id}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  // const _MoviePoster({super.key});

  final Movie movie;
  final String heroId;

  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    // movie.heroId =  heroId;
    // print('title: ${movie.title}, original title: ${movie.originalTitle}');
    return Container(
      width: 130,
      height: 200,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            // onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-insance'),
            onTap: () => Navigator.pushNamed(context,'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!, // el signo es porque se sabe que siempre va a llegar
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit:BoxFit.cover
                ),
              ),
            ),
          ),
          const SizedBox(height: 4,),
          Expanded( // Antes del expanded daba el error de <A RenderFlex overflowed by 7.0 pixels on the bottom.>
            child: Text(movie.originalTitle,
              overflow: TextOverflow.visible,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }
}




