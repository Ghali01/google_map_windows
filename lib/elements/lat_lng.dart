part of WindowsMap;

/// a Class represent a point on the map by its coordinates (latitude,longitude)
class LatLng {
  ///latitude of the point.
  late final double lat;

  ///longitude of the point.
  late final double lng;
  LatLng({required this.lat, required this.lng});

  /// Build a LatLng object from json String
  ///
  /// example on the json:
  /// ```
  /// {"lat":0.0,"lng":0.0}
  /// ```
  LatLng.fromJson(String json) {
    final data = jsonDecode(json);
    lat = data['lat'];
    lng = data['lng'];
  }

  /// Build a LatLng object from Map
  ///
  /// example on the Map:
  /// ```
  /// {"lat":0.0,"lng":0.0}
  /// ```
  LatLng.fromMap(Map<String, dynamic> data) {
    lat = data['lat']!.toDouble();
    lng = data['lng']!.toDouble();
  }

  /// Convert the LatLng obejct to Map.
  Map<String, double> toMap() => {'lat': lat, 'lng': lng};

  /// Convert the LatLng obejct to json String.
  String toJson() => jsonEncode(toMap());
  @override
  String toString() {
    return toJson();
  }

  @override
  bool operator ==(Object other) {
    if (other is LatLng) {
      return other.lat == lat && other.lng == lng;
    }
    return false;
  }

  @override
  int get hashCode => lng.hashCode + lat.hashCode;
}
