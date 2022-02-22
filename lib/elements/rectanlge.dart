part of WindowsMap;
/// a rectangle draws on the map as [Polygon]
class MapRectanlge extends _BasePolygon{
  LatLngBounds _bounds;
  LatLngBoundsCallBack? _onBoundsChanged;
  MapRectanlge({
    required LatLngBounds bounds,
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
  }):_bounds=bounds,super(clickable: clickable,editable: editable,geodesic: geodesic,fillColor: fillColor,fillOpacity: fillOpacity,strokeColor: strokeColor,strokeOpacity: strokeOpacity,strokeWeight: strokeWeight,visible: visible,zIndex: zIndex);
  @override
  Map _toMap()=>{
    'bounds':_bounds.toMap(),
  }..addAll(super._toMap());
  LatLngBounds get bound=>_bounds;
  /// the bounds of the rectangle.
  set bounds(LatLngBounds bounds){
    _bounds=bounds;
    _sendData('setRectangleBounds', {'bounds':bounds.toMap()});
  }
  /// an event runs on the user edit the rectangle.
  set onBoundsChanged(LatLngBoundsCallBack fun)=>_onBoundsChanged=fun;
  @override
  void _startListenOnEvents(){
    super._startListenOnEvents();
    _messagesReceiver.where((msg) => msg['eventType'].startsWith(runtimeType.toString().toLowerCase())&&msg['data'].containsKey('id')&&msg['data']['id']==id).listen((data) {

      switch (data['eventType'].toString().replaceFirst(runtimeType.toString().toLowerCase(),'')) {
        case 'BoundsChanged':
          _bounds=LatLngBounds.fromMap(data['data']['bounds']);
          if(_onBoundsChanged!=null){_onBoundsChanged!(_bounds);}
          break;


      }
    });
  }

}
