class Peliculas {
  
  List<Pelicula> listaPeliculas = [];

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList ){
    
    for (var item in jsonList) {
      final pelicula = Pelicula.fromJson(item);
      listaPeliculas.add(pelicula);      
    }
  }

}

class Pelicula {
  late int voteCount;
  late int id;
  late String uniqueId;
  late bool video;
  late double voteAverage;
  late String title;
  late double popularity;
  late String posterPath;
  late String originalLanguage;
  late String originalTitle;
  late List<int> genreIds;
  late String backdropPath;
  late bool adult;
  late String overview;
  late String releaseDate;

  Pelicula(){
    voteCount;
    id;
    video;
    voteAverage;
    title;
    popularity;
    posterPath;
    originalLanguage;
    originalTitle;
    genreIds;
    backdropPath;
    adult;
    overview;
    releaseDate;
  }

  Pelicula.fromJson( Map<String, dynamic> json){
    if( json['poster_path'] == null) {
      posterPath     = '';
    }else{
      posterPath     = json['poster_path'];
    }
    adult            = json['adult'];
    overview         = json['overview'];
    if( json['release_date'] == null) {
      releaseDate    = '';
    }else{
      releaseDate    = json['release_date'];
    }
    genreIds         = json['genre_ids'].cast<int>();
    id               = json['id'];
    originalTitle    = json['original_title'];
    originalLanguage = json['original_language'];
    title            = json['title'];
    if( json['backdrop_path'] == null) {
      backdropPath   = '';
    }else{
      backdropPath   = json['backdrop_path'];
    }
    popularity       = json['popularity'] / 1;
    voteCount        = json['vote_count'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
  }

  Map<String, dynamic> toJson() => {
    "vote_count"       : voteCount,
    "id"                : id,
    "video"             : video,
    "vote_average"      : voteAverage,
    "title"             : title,
    "popularity"        : popularity,
    "poster_path"       : posterPath,
    "original_language" : originalLanguage,
    "original_title"    : originalTitle,
    "genre_ids"         : genreIds,
    "backdrop_path"     : backdropPath,
    "adult"             : adult,
    "overview"          : overview,
    "release_date"      : releaseDate,
  };

  getPosterImg(){
    // ignore: unnecessary_null_comparison
    if ( posterPath == '' ) {
      return 'https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg(){
    // ignore: unnecessary_null_comparison
    if ( posterPath == '' ) {
      return 'https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }

}