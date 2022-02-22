part of WindowsMap;
typedef CallBackValue=void Function(dynamic);
typedef LatLngCallBack=void Function(LatLng);
typedef LatLngBoundsCallBack=void Function(LatLngBounds);
typedef VoidCallBack= void Function();

///  this Class used to control in the map by:
///  adding an event listener, set api key,get or set center and zoom...,adding or remove markers,polyline,polygons
class WindowsMapController {
  /// the javascript api key
  String? apiKey;
  // windows webview controller
  final WebviewController _webviewController = WebviewController();
  static const _EVENT_TYPE = 'eventType';
  // stream that reccives message from webview
  late final Stream<Map<dynamic,dynamic>> _webMessages;
  // event runs on zoom changed
  CallBackValue? _onZoomChanged;
  LatLngCallBack? _onCenterChanged,_onClick,_onDoubleClick,_onRightClick,_onMouseMove,_onMouseUp,_onMouseDown;
  VoidCallBack? _onMapInitialed,_onIdle;
  LatLngBoundsCallBack? _onBoundsChanged;
  Map<int,Marker> _markers={};
  Map<int,Polyline> _polylines={};
  Map<int,_BasePolygon> _polygons={};

  WindowsMapController() {
    _webMessages = _webviewController.webMessage.asBroadcastStream();
    _webMessages.listen((data) {
      //listen to events
      switch (data[_EVENT_TYPE]) {
        case 'log':
          {
            // print(data['data']['value']);
          }
          break;
        case 'zoomChanged':
              if (_onZoomChanged!=null){_onZoomChanged!(data['data']['zoom']);}
          break;
        case 'centerChanged':
              if (_onCenterChanged!=null){_onCenterChanged!(LatLng.fromMap(data['data']['latLng']));}
          break;
        case 'mapInitialed':
            if(_onMapInitialed!=null){_onMapInitialed!();}
          break;
        case 'boundsChanged':
            if(_onBoundsChanged!=null){_onBoundsChanged!(LatLngBounds.fromMap(data['data']));}
          break;
        case 'click':
            if(_onClick!=null){_onClick!(LatLng.fromMap(data['data']));}
          break;
        case 'doubleClick':
          if(_onDoubleClick!=null){_onDoubleClick!(LatLng.fromMap(data['data']));}
          break;
        case 'rightClick':
          if(_onRightClick!=null){_onRightClick!(LatLng.fromMap(data['data']));}
          break;
          case 'mouseMove':
            if(_onMouseMove!=null){_onMouseMove!(LatLng.fromMap(data['data']));}

            break;
          case 'mouseDown':
            if(_onMouseDown!=null){_onMouseDown!(LatLng.fromMap(data['data']));}

            break;
          case 'mouseUp':
            if(_onMouseUp!=null){_onMouseUp!(LatLng.fromMap(data['data']));}
            break;
          case 'idle':
              if(_onIdle!=null){_onIdle!();}
            break;
      }
    });
  }
  // sending a massges to js
  void _sendData(String event,[Map data = const {}]){
    _webviewController.postWebMessage(jsonEncode({_EVENT_TYPE:event,'data':data}));
  }
  //this future wait a value from js
  Future<Map> _listenToValue(String event) async {
    await for (final msg in _webMessages) {
      if (msg[_EVENT_TYPE] == event) {
        return msg;
      }
    }
    return {};
  }
  /// create the Map usually call it in initState
  /// affter finshing the setup of the map
  void initMap() async {
    if (_webviewController.value.isInitialized) {
      _sendData('initMap');
   } else {
      await _webviewController.loadingState.first;
      _sendData('initMap');
    }
  }
  /// return the current zoom of the map
  Future<int> getZoom() async {
    _sendData('getZoom');
    Map msg = await _listenToValue('sendZoom');
    return msg['data']['zoom'];
  }
  /// set the zoom of the map
  void setZoom(int zoom) {
    _sendData('setZoom',{'zoom':zoom});
  }
  /// a event runs on the zoom is changed
  set onZoomChanged(CallBackValue fun)=>_onZoomChanged=fun;

  /// return the current Center of the map
  Future<LatLng> getCenter()async{
    _sendData('getCenter');
    Map data=await _listenToValue('sendCenter');
    return LatLng.fromMap(data['data']);
  }

  /// set the center of the map
  void setCenter(LatLng latLng){
    _sendData('setCenter',latLng.toMap());
  }
  /// an event runs on the center is changed
  set onCenterChanged(LatLngCallBack fun)=>_onCenterChanged=fun;

  /// an event runs on the map is created
  ///
  /// here you can start adding draw elements
  /// [Polygon],[Marker],[Polyline],[MapCircle],[MapRectanlge]
  set onMapInitialed(VoidCallBack fun)=>_onMapInitialed=fun;

  /// return the current bounds of the map
  Future<LatLngBounds> getBounds() async{
    _sendData('getBounds');
    Map data=await _listenToValue('sendBounds');
    return LatLngBounds.fromMap(data['data']);
  }

  /// set the bounds of the map
  void fitBounds(LatLngBounds bounds){
    _sendData('fitBounds',bounds.toMap());
  }

  /// an event runs on the bounds is changed
  set onBoundsChanged(LatLngBoundsCallBack fun)=>_onBoundsChanged=fun;
  ///Changes the center of the map by the given distance in pixels.
  ///If the distance is less than both the width and height of the map, the transition will be smoothly animated.
  ///Note that the map coordinate system increases from west to east (for [x] values) and north to south (for [y] values).
  void panBy(double x,double y)=>_sendData('panBy',{'x':x,'y':y});

  ///Changes the center of the map to the given [LatLng].
  ///If the change is less than both the width and height of the map,
  ///the transition will be smoothly animated.
  void panTo(LatLng point)=>_sendData('panTo',point.toMap());
  ///Pans the map by the minimum amount necessary to contain the given [LatLngBounds]
  void panToBounds(LatLngBounds bounds)=>_sendData('panToBounds',bounds.toMap());

  /// an event runs on the map be idle(loading)
  set onIdle(VoidCallBack value) =>_onIdle = value;

  /// an event runs on the muose up
  set onMouseUp(LatLngCallBack value)=>_onMouseUp = value;

  /// an event runs on the muose is moveing on the map
  set onMouseMove(LatLngCallBack value) =>_onMouseMove = value;

  /// an event runs on the muose down
  set onMouseDown(LatLngCallBack value) =>_onMouseDown = value;

  /// an event runs on the muose right button clicked
  set onRightClick(LatLngCallBack value)=>_onRightClick = value;

  /// an event runs on the muose left button double clicked
  set onDoubleClick(LatLngCallBack value)=> _onDoubleClick = value;

  /// an event runs on the muose left button clicked
  set onClick(LatLngCallBack value)=>_onClick = value;

  /// Adding a new marker to the map.
  void addMarker(Marker marker){
    marker._messagesSender=_sendData;
    marker._messagesReceiver=_webMessages;
    marker._startListenOnEvents();
    _markers._addWithRandom(marker);
    _sendData('addMarker',marker._toMap());
  }
  /// Remove a marker from the map.
  void removeMarker(Marker marker){
    if(_markers.containsKey(marker.id)) {
      _markers.remove(marker.id);

      _sendData('removeMarker', {'id': marker.id});
      marker._id=null;
    }
  }
  /// Remove a [Marker] from the map by its id.
  void removeMarkerById(int? id){
    if(_markers.containsKey(id)){

      final Marker marker=_markers.remove(id)!;
      _sendData('removeMarker', {'id':id});
      marker._id=null;
    }
  }
  /// Adding a new polyline to the map.
  void addPolyline(Polyline polyline){
    polyline._messagesSender=_sendData;
    polyline._messagesReceiver=_webMessages;
    polyline._startListenOnEvents();
   _polylines._addWithRandom(polyline);
   _sendData('addPolyline',polyline._toMap());
  }
  /// Remove a plyline from the map.
  void removePolyline(Polyline polyline){
    if(_polylines.containsKey(polyline.id)){
      _polylines.remove(polyline.id);
      _sendData('removePolyLine',{'id':polyline.id});
      polyline._id=null;
    }
  }
  /// Remove a [Polyline] from the map by its id.
  void removePolylineById(int? id){
    if(_polylines.containsKey(id)){
      final Polyline polyline= _polylines.remove(id)!;
      _sendData('removePolyLine',{'id':polyline.id});
      polyline._id=null;

    }
  }
  /// Adding a polygon to the map that can any of [Polygon],[MapRectanlge],[MapCircle]
  void addPolygon(_BasePolygon polygon){
    polygon._messagesSender=_sendData;
    polygon._messagesReceiver=_webMessages;
    polygon._startListenOnEvents();
    _polygons._addWithRandom(polygon);
    _sendData('addPolygon',polygon._toMap());

  }
  /// remove a polygon from the map that can any of [Polygon],[MapRectanlge],[MapCircle]
  void removePolygon(_BasePolygon polygon){
    if(_polygons.containsKey(polygon.id)){
      _polygons.remove(polygon.id);
      _sendData('removePolygon',{'id':polygon.id});
      polygon._id=null;
    }
  }
  /// remove a polygon from the map that can any of [Polygon],[MapRectanlge],[MapCircle] by its id

  void removePolygonById(int id){
    if(_polygons.containsKey(id)){
      _BasePolygon polygon= _polygons.remove(id)!;
      _sendData('removePolygon',{'id':polygon.id});
      polygon._id=null;
    }
  }
}
extension _AddUniqeKey on Map{
  int _addWithRandom(_DrawElement value){
    Random random =Random();
    int key=random.nextInt(1000000);
    while(keys.contains(key)){key=random.nextInt(1000000);}
    value._id=key;
    this[key]=value;
    return key;
  }

}