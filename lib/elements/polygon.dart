part of WindowsMap;

class Polygon extends _BasePolygon{
  List<List<LatLng>> _paths;
  Polygon({
    required List<List<LatLng>> paths,
    Color fillColor=Colors.greenAccent,
    double fillOpacity=1,
    // StrokePosition strokePosition=StrokePosition.CENTER,
    bool clickable = true,
    bool editable = false,
    bool geodesic = false,
    Color strokeColor = Colors.blueAccent,
    double strokeOpacity = 1,
    double strokeWeight = 1,
    bool visible = true,
    int zIndex = 1,
  }):_paths=paths,super(clickable: clickable,editable: editable,geodesic: geodesic,fillColor: fillColor,fillOpacity: fillOpacity,strokeColor: strokeColor,strokeOpacity: strokeOpacity,strokeWeight: strokeWeight,visible: visible,zIndex: zIndex);
  @override
  Map _toMap()=>{
    'paths':_pathsToMap(),
  }..addAll(super._toMap());

  List<List<Map<String,double>>> _pathsToMap(){
    List<List<Map<String,double>>> list=[];
    for (final path in _paths){
      list.add(_pathToMap(path));
    }
    return list;
  }
  void _sendSetPathSignal()=>_sendData('setPolygonPaths',{'paths':_pathsToMap()});

  UnmodifiableListView<LatLng> get firstPath=>UnmodifiableListView(_paths.first);
  set firstPath(List<LatLng> path)=>setPath(0, path);
  UnmodifiableListView<LatLng>? getPath(int index)=>_paths.length>index?UnmodifiableListView(_paths[index]):null;
  void setPath(int index,List<LatLng> path){
    _paths[index]=path;
    _sendSetPathSignal();
  }

  List<List<LatLng>> get paths=>_paths;
  set paths(List<List<LatLng>> value){
    paths=value;
    _sendSetPathSignal();
  }
  void addPointToPath(int index,LatLng point){
    if(_paths.length>index) {
      _paths[index].add(point);
    }else{
      _paths[index]=[point];
    }
    _sendSetPathSignal();
  }
}