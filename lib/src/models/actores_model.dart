class Cast {

  List<Actor> items = new List();
  Cast();
  Cast.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final actor = new Actor.fromJsonMap(item);
      items.add( actor );
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic>json ){
    print(json);
    castId = json['castId'];
    character = json['character'];
    creditId = json['creditId'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath= json['profile_path'];
  }
  getActorImg(){
    // print('https://image.tmdb.org/t/p/w500/$profilePath');
    if(profilePath == null){
      return 'https://www.landfood.ubc.ca/files/2018/03/Profile_avatar_placeholder_large.png';
    }else{
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

