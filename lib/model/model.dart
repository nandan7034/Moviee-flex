class Movie {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.softcore,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int? id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final bool? softcore;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"] == null
          ? []
          : List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      title: json['title'] ?? json['name'] ?? '',
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: (json["popularity"] as num?)?.toDouble(),
      posterPath: json["poster_path"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      softcore: json["softcore"],
      video: json["video"],
      voteAverage: (json["vote_average"] as num?)?.toDouble(),
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds,
    "id": id,
    "title": title,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date":
        "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
    "softcore": softcore,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class MoviePop {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MoviePop({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MoviePop.fromJson(Map<String, dynamic> json) {
    return MoviePop(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      originalLanguage: json['original_language'],
      genreIds: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'])
          : [],
      popularity: (json['popularity'] as num?)?.toDouble(),
      releaseDate: json['release_date'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
    );
  }
}
