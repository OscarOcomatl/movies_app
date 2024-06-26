
import 'dart:convert';

class Movie {
    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath;
    String? releaseDate; // antes de String era DateTime
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    // String? heroId; // opcional porque se va a construir en el momento que se esta construyendo ese widget

    get fullPosterImg { // getter mthod
      // return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
      // return 'https://image.tmdb.org/t/p/w500${posterPath}';
      if(posterPath != null){
        return 'https://image.tmdb.org/t/p/w500$posterPath';
      }
      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    get fullbackDropPath { // getter mthod
      // return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
      // return 'https://image.tmdb.org/t/p/w500${posterPath}';
      if(backdropPath != null){
        return 'https://image.tmdb.org/t/p/w500$backdropPath';
      }
      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    Movie({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    get heroId{
      return '$id-tarjeta';
    }

    get heroIdBanner {
      return '$id-banner';
    }

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult             : json["adult"],
        backdropPath      : json["backdrop_path"],
        genreIds          : List<int>.from(json["genre_ids"].map((x) => x)),
        id                : json["id"],
        originalLanguage  : json["original_language"],
        originalTitle     : json["original_title"],
        overview          : json["overview"],
        popularity        : json["popularity"]?.toDouble(),
        posterPath        : json["poster_path"],
        releaseDate       : json["release_date"],
        title             : json["title"],
        video             : json["video"],
        voteAverage       : json["vote_average"]?.toDouble(),
        voteCount         : json["vote_count"],
    );

    // Map<String, dynamic> toMap() => {
    //     "adult": adult,
    //     "backdrop_path": backdropPath,
    //     "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    //     "id": id,
    //     "original_language": originalLanguageValues.reverse[originalLanguage],
    //     "original_title": originalTitle,
    //     "overview": overview,
    //     "popularity": popularity,
    //     "poster_path": posterPath,
    //     "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    //     "title": title,
    //     "video": video,
    //     "vote_average": voteAverage,
    //     "vote_count": voteCount,
    // };
}

// enum OriginalLanguage {
//     EN,
//     ES,
//     JA,
//     TL
// }

// final originalLanguageValues = EnumValues({
//     "en": OriginalLanguage.EN,
//     "es": OriginalLanguage.ES,
//     "ja": OriginalLanguage.JA,
//     "tl": OriginalLanguage.TL
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }
