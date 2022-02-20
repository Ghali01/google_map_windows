part of WindowsMap;

class MapCircle extends _BasePolygon{
  LatLng _center;
  double _radius;
  LatLngCallBack? _onCenterChanged;
  CallBackValue? _onRadiusChanged;

  MapCircle({
    required LatLng center,
    required double radius,
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
  }):_center=center,_radius=radius,super(clickable: clickable,editable: editable,geodesic: geodesic,fillColor: fillColor,fillOpacity: fillOpacity,strokeColor: strokeColor,strokeOpacity: strokeOpacity,strokeWeight: strokeWeight,visible: visible,zIndex: zIndex);
  @override
  Map _toMap()=>{
    'center':_center.toMap(),
    'radius':_radius,
  }..addAll(super._toMap());
  LatLng get center=>_center;
  set center(LatLng value){
    _center=value;
    _sendData('setCircleCenter', {'center':value.toMap()});
  }
  double get radius=>_radius;
  set radius(double value){
    _radius=value;
    _sendData('setCircleRadius',{'radius':value});
  }
  set onCenterChanged(LatLngCallBack fun)=>_onCenterChanged=fun;
  set onRadiusChanged(CallBackValue fun)=>_onRadiusChanged=fun;
  @override
  void _startListenOnEvents(){
    super._startListenOnEvents();
    _messagesReceiver.where((msg) => msg['eventType'].startsWith(runtimeType.toString().toLowerCase())&&msg['data'].containsKey('id')&&msg['data']['id']==id).listen((data) {
      switch (data['eventType'].toString().replaceFirst(
          runtimeType.toString().toLowerCase(), '')) {
        case 'CenterChanged':
          _center=LatLng.fromMap(data['data']['center']);
          if (_onCenterChanged != null) {
            _onCenterChanged!(_center);
          }
          break;
          case 'RadiusChanged':
            _radius=data['data']['radius'];
          if (_onRadiusChanged != null) {
            _onRadiusChanged!(_radius);
          }
          break;
      }
    });
  }
}