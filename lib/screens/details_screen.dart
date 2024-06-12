import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  // const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: cambiar por una instancia de movie
    // final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie; // Como el argumento es un objeto, se necesita especificar como va a ser tratado, en este caso como una pelicula
    // print(movie.title);
    // print(movie.fullbackDropPath);
    // print(movie.voteAverage);
    // print(movie.overview);
    

    return Scaffold(
      // appBar: AppBar(

      // ),
      body: CustomScrollView(
        slivers: [
          // _CustomAppBar(title: movie.title, backDropPath: movie.fullbackDropPath),
          _CustomAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),
              _Overview(movie),
              _Overview(movie),
              _Overview(movie),
              CastingCards(movie)

            ])
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      pinned: true, //nunca desaparece
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          child: FadeIn(
            delay: const Duration(milliseconds: 300),
            child: Text(
            movie.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white
            ),
            ),
          ),
        ),
        background: Hero(
          tag: movie.heroIdBanner!,
          child: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            // image: NetworkImage('https://via.placeholder.com/500x300'),
            image: NetworkImage(movie.fullbackDropPath),
            fadeInDuration: const Duration(milliseconds: 150),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  // final String title;
  // final String backDropPath;
  // final String originalTitle;
  // final double movieAverage;
  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
            Hero(
              tag: movie.heroId!, // Tiene que llevarlo en el lugar que se va a usar para animarse y en el lugar que va a ser animado
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  height: 150,
                  // width: 110,
                ),
              ),
            ),

          const SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FadeIn(
                  delay: const Duration(milliseconds: 200),
                  child: Text(movie.title, style: textTheme.headlineMedium, overflow: TextOverflow.ellipsis, maxLines: 2),
                ),
                FadeIn(
                  delay: const Duration(milliseconds: 400),
                  child: Text(movie.originalTitle, style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2),
                ),
                // Text(title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
                FadeIn(
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    children: [
                      const Icon( Icons.star_border_outlined, size: 15, color: Colors.grey,),
                      const SizedBox(width: 5,),
                      Text(movie.voteAverage.toString(), style: textTheme.titleMedium,)
                    ],
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return  Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.labelSmall,
    ),
    );
  }
}














