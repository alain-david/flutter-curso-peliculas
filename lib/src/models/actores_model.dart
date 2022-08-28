class Casting {
  
  List<Actor> actores = [];

  Casting();

  Casting.fromJsonList( List<dynamic> jsonList ){
    
    for (var item in jsonList) {
      final pelicula = Actor.fromJson(item);
      actores.add(pelicula);      
    }
  }

}

class Actor {
  late bool adult;
  late int gender;
  late int id;
  late String knownForDepartament;
  late String name;
  late String originalName;
  late double popularity;
  late String profilePath;
  late int castId;
  late String character;
  late String creditId;
  late int order;

  Actor(){
    adult;
    gender;
    id;
    knownForDepartament;
    name;
    originalName;
    popularity;
    profilePath;
    castId;
    character;
    creditId;
    order;
  }

  Actor.fromJson( Map<String, dynamic> json){
    adult               = json['adult'];
    if( json['profile_path'] == null) {
      profilePath       = '';
    }else{
      profilePath       = json['profile_path'];
    }
    gender              = json['gender'];
    id                  = json['id'];
    knownForDepartament = json['known_for_department'];
    name                = json['name'];
    originalName        = json['original_name'];
    popularity          = json['popularity'];
    if( json['profile_path'] == null) {
      profilePath       = '';
    }else{
      profilePath       = json['profile_path'];
    }
    castId              = json['cast_id'];
    character           = json['character'];
    creditId            = json['credit_id'];
    order               = json['order'];
  }

  getFoto(){
    // ignore: unnecessary_null_comparison
    if ( profilePath == '' ) {
      return 'https://www.seekpng.com/png/full/428-4287240_no-avatar-user-circle-icon-png.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}