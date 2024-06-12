import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  // const CastingCards({super.key});

  final Movie movie;

  const CastingCards( this.movie );



  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movie.id), 
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if(!snapshot.hasData){
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

      final List<Cast> cast = snapshot.data!;

      // final Cast actor;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 30),
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: ( _ , int index ) => _CastCard(actor: cast[index],)
          ),
        );
      },
    );

    // return Container(
    //   width: double.infinity,
    //   margin: EdgeInsets.only(bottom: 30),
    //   height: 180,
    //   // color: Colors.red,
    //   child: ListView.builder(
    //     itemCount: 10,
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: ( _ , int index ) => _CastCard()
    //   ),
    // );
  }
}

class _CastCard extends StatelessWidget {
  // const _CastCard({super.key});

  final Cast actor;

  const _CastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect( // imagen con bordes redondeados
            borderRadius:BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width:100,
              fit: BoxFit.cover,
            
            ),
          ),
          SizedBox(height: 5,),
          Expanded(
            child: Text(
              actor.name,
              maxLines: 2,
              overflow:TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            
            ),
          )
        ],
      ),
    );
  }
}