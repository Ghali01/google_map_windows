part of WindowsMap;

abstract class _BasePoly extends _DrawElement<LatLngCallBack> {
  bool _editable, _geodesic;
  Color _strokeColor;
  double _strokeOpacity, _strokeWeight;

  _BasePoly({
    bool clickable = true,
    bool editable = false,
    bool geodesic = false,
    Color strokeColor = Colors.blueAccent,
    double strokeOpacity = 1,
    double strokeWeight = 1,
    bool visible = true,
    int zIndex = 1,
  })  : _editable = editable,
        _geodesic = geodesic,
        _strokeColor = strokeColor,
        _strokeOpacity = strokeOpacity,
        _strokeWeight = strokeWeight,
        super(visible,clickable, zIndex);
  Map _toMap()=>{
    'id':id,
    'clickable':_clickable,
    'editable':_editable,
    'geodesic':_geodesic,
    'strokeColor':strokeColor._rgba,
    'strokeOpacity':_strokeOpacity,
    'strokeWeight':_strokeWeight,
    'visible':_visible,
    'zIndex':_zIndex,
  };

  List<Map<String,double>> _pathToMap(List<LatLng> path){
    List<Map<String,double>> list=[];
    for (final point in path){
      list.add(point.toMap());
    }
    return list;
  }
  bool get editable=>_editable;
  set editable(bool value){
    _editable=value;
    _sendData('setPloyEditable', {'editable':value});
  }
  bool get geodesic=>_geodesic;
  set geodesic(bool value){
    _geodesic=value;
    _sendData('setPloyGeodesic', {'geodesic':value});
  }
  Color get strokeColor=>_strokeColor;
  set strokeColor(Color value){
    _strokeColor=value;
    _sendData('setPolyStrokeColor', {'strokeColor':strokeColor._rgba});
  }
  double get strokeOpacity=>_strokeOpacity;
  set strokeOpacity(double value){
    _strokeOpacity=value;
    _sendData('setPolyStrokeOpacity',{'strokeOpacity':_strokeOpacity});
  }
  double get strokeWeight=>_strokeWeight;
  set strokeWeight(double value){
    _strokeWeight=value;
    _sendData('setPolyStrokeWeight',{'strokeWeight':_strokeWeight});
  }
  void _startListenOnEvents(){
    _messagesReceiver.where((msg) => msg['eventType'].startsWith(runtimeType.toString().toLowerCase())&&msg['data'].containsKey('id')&&msg['data']['id']==id).listen((data) {
      // print(data['eventType'].toString().replaceFirst(runtimeType.toString().toLowerCase(),''));
      switch (data['eventType'].toString().replaceFirst(runtimeType.toString().toLowerCase(),'')) {
        case 'Click':
          if(_onClick!=null){_onClick!(LatLng.fromMap(data['data']['latlng']));}
          break;
        case 'DoubleClick':
          if(_onDoubleClick!=null){_onDoubleClick!(LatLng.fromMap(data['data']['latlng']));}
          break;
        case 'RightClick':
          if(_onRightClick!=null){_onRightClick!(LatLng.fromMap(data['data']['latlng']));}
          break;
        case 'MouseMove':
          if(_onMouseMove!=null){_onMouseMove!(LatLng.fromMap(data['data']['latlng']));}

          break;
        case 'MouseDown':
          if(_onMouseDown!=null){_onMouseDown!(LatLng.fromMap(data['data']['latlng']));}

          break;
        case 'MouseUp':
          if(_onMouseUp!=null){_onMouseUp!(LatLng.fromMap(data['data']['latlng']));}
          break;

      }
    });
  }


}
extension _2rgba on Color{
 String get _rgba=>'rgba($red,$green,$blue,$opacity)';
}