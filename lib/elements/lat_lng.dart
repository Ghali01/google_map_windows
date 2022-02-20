part of WindowsMap;

class LatLng{
  late final double lat,lng;
  LatLng({required this.lat,required this.lng});
  LatLng.fromJson(String json){
    final data=jsonDecode(json);
    lat=data['lat'];
    lng =data['lng'];
  }
  LatLng.fromMap(Map<String,dynamic> data){
    lat=data['lat']!.toDouble();
    lng =data['lng']!.toDouble();
  }
  Map<String,double> toMap()=>{'lat':lat,'lng':lng};
  String toJson()=>jsonEncode(toMap());
  @override
  String toString() {
    return toJson();
  }
  @override
  bool operator ==(Object other) {
    if (other is LatLng){
      return other.lat==lat&&other.lng==lng;
    }
    return false;
  }

  @override
  int get hashCode => lng.hashCode+lat.hashCode;

}