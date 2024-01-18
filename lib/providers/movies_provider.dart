import 'dart:async';

import 'package:flutter/material.dart';

// import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';



class MoviesProvider extends ChangeNotifier{

  final String _apiKey = 'f3749e879eff9557cfa5d1b66d469752';
  final String _baseUrl = 'api.themoviedb.org';
  final String _languaje = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = []; // se crea la lista del tipo del que se esta mapeando, (en este caso es movie), para guardar la data

  Map<int, List<Cast>> moviesCast = {}; // Mapa para guardar el id de la pelicula y el valor va a ser una lista de tipo Cast
  
  int _popularPage = 0; // se crea variable para que cada vez que el endpoint se llame, el contador de la pagina incremente

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500), // Cuanto tiempo se quiere esperar para emitir un valor
    // onValue: 
  );

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  MoviesProvider(){
    // print('MoviesProvider inicializado');
    // this.getOnDisplayMovies();
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1] ) async { // Page es opcional y si no tiene valor, su valor por defecto es 1, edpoint es obligatorio
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key'   : _apiKey,
      'languaje'  : _languaje,
      'page'      : '$page'
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners(); // le notifica a los widgets que se redibujen cuando existe un cambio en la data

    // onDisplayMovies = [...nowPlayingResponse.results]; // Desestructuracion -> se puede realizar de esta forma para realizar una paginacion
    // print(response.body);
    // print(nowPlayingResponse.results[1].title);
  }

  getPopularMovies() async {
    _popularPage++; // Se incrementa en 1 el contador de la pagina
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData); // variable para identificar y guardar los datos del http response
    popularMovies = [ ...popularMovies,/* operador spread */ ...popularResponse.results ]; // se desestructura porque eventualmente el numero de paginas va a cambiar
    // print('popularMovies[0]: ${popularMovies[0]}');
    notifyListeners(); // le notifica a los widgets que se redibujen cuando existe un cambio en la data
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {  // EL ASYNC CONVIERTE CUALCUQIER RETORNO EN UN FUTURE QUE RESUELVE ESTE moviesCast[movieId]! VALOR
    //Todo: revisar el mapa
   // Revisa si el mapa de moviesCast ya tiene valores, si los contiene retorna los mismos valores y si no, realiza la peticion HTTP
   if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!; // Sin el ! podria no existir pero con el signo, indicamos que siempre va a existir

    print('pidiendo info al servidor - Cast');
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key'   : _apiKey,
      'languaje'  : _languaje,
      'query'     : query
   });
   final response = await http.get(url);
   final searchResponse = SearchResponse.fromJson(response.body);
   return searchResponse.results; // esto si es un future
  }

  void getSuggestionsByQuery( String searchTerm){
    debouncer.value = '';
    debouncer.onValue = ( value ) async { // es async porque aqui es donde eventualmente se mandara a llamar el searchMovies
      // print('tenemos valor a buscar: $value');
      final results = await this.searchMovies(value);
      this._suggestionStreamController.add( results );
    };
      final timer = Timer.periodic(Duration(milliseconds: 300), (_) { 
        debouncer.value = searchTerm;
      });
      Future.delayed(Duration(milliseconds: 301)).then(( _ ) => timer.cancel());
  }

  // getOnDisplayMovies() async {
  //   var url = Uri.https(_baseUrl, '3/movie/now_playing', {
  //     'api_key'   : _apiKey,
  //     'languaje'  : _languaje,
  //     'page'      : '1'
  //   });
  //   // Await the http get response, then decode the json-formatted response.
  //   final response = await http.get(url);
  //   final Map<String,dynamic> decodedData = json.decode(response.body);
  //   // print(response.body);
  //   print(decodedData['results']);
  // }
}