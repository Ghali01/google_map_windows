part of WindowsMap;

class Polyline extends _BasePoly{
  List<LatLng> _path;
  Polyline({
    required List<LatLng> path,
    bool clickable = true,
    bool editable = false,
    bool geodesic = false,
    Color strokeColor = Colors.blueAccent,
    double strokeOpacity = 1,
    double strokeWeight = 1,
    bool visible = true,
    int zIndex = 1,
  }):_path=path,super(clickable: clickable,editable: editable,geodesic: geodesic,strokeColor: strokeColor,strokeOpacity: strokeOpacity,strokeWeight: strokeWeight,visible: visible,zIndex: zIndex);
  @override
  Map _toMap()=>{
    'path':_pathToMap(_path),

  }..addAll(super._toMap());
  /// the path of the polyline.
  UnmodifiableListView<LatLng> get path=>UnmodifiableListView(_path);
  set path(List<LatLng> value){
    _path=value;
    _sendData('setPolylinePath',{'path':_pathToMap(value)});
  }
  /// adding new point to the polyline.
  void addPointToPath(LatLng point){
    _path.add(point);
    _sendData('setPolylinePath',{'path':_pathToMap(_path)});

  }

}