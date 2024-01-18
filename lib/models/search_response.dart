import 'dart:convert';

import 'package:peliculas/models/models.dart';

class SearchResponse {
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    SearchResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))), // Se cambia el result por el tipo Movie
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
    // Map<String, dynamic> toMap() => {
    //     "page": page,
    //     "results": List<dynamic>.from(results.map((x) => x.toMap())),
    //     "total_pages": totalPages,
    //     "total_results": totalResults,
    // };
}
