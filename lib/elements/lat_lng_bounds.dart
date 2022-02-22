part of WindowsMap;


class LatLngBounds{
  late double west,east,south,north;
  LatLngBounds({
   required this.west,
   required this.east,
   required this.south,
   required this.north,
});
  /// Build a object from Map.
  ///
  /// example on the Map:
  /// ```
  /// {
  //     'west':0.0,
  //     'east':0.0,
  //     'north':0.0,
  //     'south':0.0
  //   }
  /// ```
  LatLngBounds.fromMap(Map data){
    east=data['east'];
    west=data['west'];
    south=data['south'];
    north=data['north'];
  }

  /// Build a object from json String.
  ///
  /// example on the json:
  /// ```
  /// {
  //     "west":0.0,
  //     ""east":0.0,
  //     "north":0.0,
  //     "south":0.0
  //   }
  /// ```
  LatLngBounds.fromJson(String json){
    Map data=jsonDecode(json);
    east=data['east'];
    west=data['west'];
    south=data['south'];
    north=data['north'];
  }
  /// Convert the object to Map.
  Map<String,double> toMap()=>{
    'west':west,
    'east':east,
    'north':north,
    'south':south
  };
  /// Convert the object to json.
  String toJson()=>jsonEncode(toMap());
  @override
  String toString() =>toJson();

  @override
  bool operator ==(Object other) {
    if (other is LatLngBounds){
      return other.south==south&&other.north==north&&other.west==west&&other.east==east;
    }
    return false;

  }
  /// return true if the given [point] was inside the bounds.
  bool contains(LatLng point) {
    bool h,v;
    if (east>west){
      h=point.lng >= west &&
          point.lng <= east;
    }else{
      h=(point.lng >= west && point.lng<=180)||
          (point.lng <= east&&point.lng>=-180);
    }
     v=point.lat <= north &&
          point.lat >= south;

    return h&&v;
         }
  /// return the center of this bounds.
  LatLng getCenter()=>LatLng(lat: south+ (north-south)/2, lng: west+ (east-west)/2);
  /// return the (north,east) as [LatLng].
  LatLng getNorthEast()=>LatLng(lat: north, lng: east);
  /// return the (north,west) as [LatLng].
  LatLng getNorthWest()=>LatLng(lat: north, lng: west);
  /// return the (south,east) as [LatLng].

  LatLng getSouthWest()=>LatLng(lat: south, lng: west);
  /// return the (south,west) as [LatLng].

  LatLng getSouthEast()=>LatLng(lat: south, lng: east);
  /// Check if the given [bounds] intersect with this bounds in one point or more.
  bool intersects(LatLngBounds bounds){
      return contains(bounds.getNorthEast())||contains(bounds.getNorthWest())||contains(bounds.getSouthEast())||contains(bounds.getSouthWest());

  }
  /// return a new object from the union of this bounds and the given [bounds].
  LatLngBounds union(LatLngBounds other)=>LatLngBounds(west: min<double> (other.west,west), east: max<double>(other.east, east), south: min<double>(other.south,south), north: max<double>(other.north,north));
  /// expend this bounds in order to containe the given [point]
  void extend(LatLng point){
    if(!contains(point)){
      if(west>point.lng){west=point.lng;}
      if(east<point.lng){east=point.lng;}
      if(south>point.lat){south=point.lat;}
      if(north<point.lat){north=point.lat;}
    }
  }
}