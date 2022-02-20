part of WindowsMap;
typedef CallBackValue=void Function(dynamic);
typedef LatLngCallBack=void Function(LatLng);
typedef LatLngBoundsCallBack=void Function(LatLngBounds);
typedef VoidCallBack= void Function();
class WindowsMapController {
  String? apiKey;
  final WebviewController _webviewController = WebviewController();
  static const _EVENT_TYPE = 'eventType';
  late final Stream<Map<dynamic,dynamic>> _webMessages;
  CallBackValue? _onZoomChanged;
  LatLngCallBack? _onCenterChanged,_onClick,_onDoubleClick,_onRightClick,_onMouseMove,_onMouseUp,_onMouseDown;
  VoidCallBack? _onMapInitialed,_onIdle;
  LatLngBoundsCallBack? _onBoundsChanged;
  Map<int,Marker> _markers={};
  Map<int,Polyline> _polylines={};
  Map<int,_BasePolygon> _polygons={};
  // void _setWebViewController(WebviewController controller)=>_webviewController=controller;
  WindowsMapController() {
    _webMessages = _webviewController.webMessage.asBroadcastStream();
    _webMessages.listen((data) {
      // const EVENT_TYPE='eventType';
      // print(data);
      switch (data[_EVENT_TYPE]) {
        case 'log':
          {
            print(data['data']['value']);
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
  void _sendData(String event,[Map data = const {}]){
    _webviewController.postWebMessage(jsonEncode({_EVENT_TYPE:event,'data':data}));
  }
  Future<Map> _listenToValue(String event) async {
    await for (final msg in _webMessages) {
      if (msg[_EVENT_TYPE] == event) {
        return msg;
      }
    }
    return {};
  }

  void initMap() async {
    if (_webviewController.value.isInitialized) {
      _sendData('initMap');
   } else {
      await _webviewController.loadingState.first;
      _sendData('initMap');
      // await for (LoadingState e in _webviewController.loadingState) {
      // _sendData('initMap');
      //   break;
      // }
    }
  }

  Future<int> getZoom() async {
    _sendData('getZoom');
    Map msg = await _listenToValue('sendZoom');
    return msg['data']['zoom'];
  }

  void setZoom(int zoom) {
    _sendData('setZoom',{'zoom':zoom});
  }
  set onZoomChanged(CallBackValue fun)=>_onZoomChanged=fun;

  Future<LatLng> getCenter()async{
    _sendData('getCenter');
    Map data=await _listenToValue('sendCenter');
    return LatLng.fromMap(data['data']);
  }

  void setCenter(LatLng latLng){
    _sendData('setCenter',latLng.toMap());
  }
  set onCenterChanged(LatLngCallBack fun)=>_onCenterChanged=fun;
  set onMapInitialed(VoidCallBack fun)=>_onMapInitialed=fun;

  Future<LatLngBounds> getBounds() async{
    _sendData('getBounds');
    Map data=await _listenToValue('sendBounds');
    return LatLngBounds.fromMap(data['data']);
  }
  void fitBounds(LatLngBounds bounds){
    _sendData('fitBounds',bounds.toMap());
  }
  set onBoundsChanged(LatLngBoundsCallBack fun)=>_onBoundsChanged=fun;

  void panBy(double x,double y)=>_sendData('panBy',{'x':x,'y':y});
  void panTo(LatLng point)=>_sendData('panTo',point.toMap());
  void panToBounds(LatLngBounds bounds)=>_sendData('panToBounds',bounds.toMap());

  set onIdle(VoidCallBack value) =>_onIdle = value;


  set onMouseUp(LatLngCallBack value)=>_onMouseUp = value;


  set onMouseMove(LatLngCallBack value) =>_onMouseMove = value;

  set onMouseDown(LatLngCallBack value) =>_onMouseDown = value;


  set onRightClick(LatLngCallBack value)=>_onRightClick = value;


  set onDoubleClick(LatLngCallBack value)=> _onDoubleClick = value;


  set onClick(LatLngCallBack value)=>_onClick = value;

  void addMarker(Marker marker){
    marker._messagesSender=_sendData;
    marker._messagesReceiver=_webMessages;
    marker._startListenOnEvents();
    _markers._addWithRandom(marker);
    _sendData('addMarker',marker._toMap());
  }
  void removeMarker(Marker marker){
    if(_markers.containsKey(marker.id)) {
      _markers.remove(marker.id);

      _sendData('removeMarker', {'id': marker.id});
      marker._id=null;
    }
  }
  void removeMarkerById(int? id){
    if(_markers.containsKey(id)){

      final Marker marker=_markers.remove(id)!;
      _sendData('removeMarker', {'id':id});
      marker._id=null;
    }
  }
  void addPolyline(Polyline polyline){
    polyline._messagesSender=_sendData;
    polyline._messagesReceiver=_webMessages;
    polyline._startListenOnEvents();
   _polylines._addWithRandom(polyline);
   _sendData('addPolyline',polyline._toMap());
  }
  void removePolyline(Polyline polyline){
    if(_polylines.containsKey(polyline.id)){
      _polylines.remove(polyline.id);
      _sendData('removePolyLine',{'id':polyline.id});
      polyline._id=null;
    }
  }

  void removePolylineById(int? id){
    if(_polylines.containsKey(id)){
      final Polyline polyline= _polylines.remove(id)!;
      _sendData('removePolyLine',{'id':polyline.id});
      polyline._id=null;

    }
  }
  void addPolygon(_BasePolygon polygon){
    polygon._messagesSender=_sendData;
    polygon._messagesReceiver=_webMessages;
    polygon._startListenOnEvents();
    _polygons._addWithRandom(polygon);
    _sendData('addPolygon',polygon._toMap());

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