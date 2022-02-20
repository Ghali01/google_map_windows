part of WindowsMap;


class LatLngBounds{
  late double west,east,south,north;
  LatLngBounds({
   required this.west,
   required this.east,
   required this.south,
   required this.north,
});
  LatLngBounds.fromMap(Map data){
    east=data['east'];
    west=data['west'];
    south=data['south'];
    north=data['north'];
  }
  LatLngBounds.fromJson(String json){
    Map data=jsonDecode(json);
    east=data['east'];
    west=data['west'];
    south=data['south'];
    north=data['north'];
  }
  Map<String,double> toMap()=>{
    'west':west,
    'east':east,
    'north':north,
    'south':south
  };
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

  LatLng getCenter()=>LatLng(lat: south+ (north-south)/2, lng: west+ (east-west)/2);
  LatLng getNorthEast()=>LatLng(lat: north, lng: east);
  LatLng getNorthWest()=>LatLng(lat: north, lng: west);
  LatLng getSouthWest()=>LatLng(lat: south, lng: west);
  LatLng getSouthEast()=>LatLng(lat: south, lng: east);
  bool intersects(LatLngBounds bounds){
      return contains(bounds.getNorthEast())||contains(bounds.getNorthWest())||contains(bounds.getSouthEast())||contains(bounds.getSouthWest());

  }
  LatLngBounds union(LatLngBounds other)=>LatLngBounds(west: min<double> (other.west,west), east: max<double>(other.east, east), south: min<double>(other.south,south), north: max<double>(other.north,north));
  void extend(LatLng point){
    if(!contains(point)){
      if(west>point.lng){west=point.lng;}
      if(east<point.lng){east=point.lng;}
      if(south>point.lat){south=point.lat;}
      if(north<point.lat){north=point.lat;}
    }
  }
}