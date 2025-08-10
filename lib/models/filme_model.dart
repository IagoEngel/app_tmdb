import 'package:app_tmdb/models/membro_elenco_model.dart';

class FilmeModel {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final num popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final num voteAverage;
  final int voteCount;
  List<MembroElencoModel> cast;
  List<MembroElencoModel> crew;

  FilmeModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'] ?? false,
        backdropPath = json['backdrop_path'] ?? '',
        genreIds = List.from(json['genre_ids'] ?? []),
        id = json['id'] ?? 0,
        originalLanguage = json['original_language'] ?? '',
        originalTitle = json['original_title'] ?? '',
        overview = json['overview'] ?? '',
        popularity = json['popularity'] ?? 0,
        posterPath = json['poster_path'] ?? '',
        releaseDate = json['release_date'] ?? '',
        title = json['title'] ?? '',
        video = json['video'] ?? false,
        voteAverage = json['vote_average'] ?? 0,
        voteCount = json['vote_count'] ?? 0,
        cast = List.from(json['cast'] ?? []),
        crew = List.from(json['crew'] ?? []);
}
