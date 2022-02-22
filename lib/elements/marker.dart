part of WindowsMap;

enum MarkerAnimation{
  BOUNCE,
  DROP
}

class Marker extends _DrawElement<LatLngCallBack>{
  late LatLng _position;
  late double _opacity;
  late String _title;
  ///how the marker will display on the map.
  final MarkerAnimation animation;
  MarkerLabel? _label;
  _BaseIcon? _icon;

  Marker({
    required LatLng position,
    double opacity=1,
    String title='',
    this.animation=MarkerAnimation.BOUNCE,
    bool visible=true,
    int zIndex=0,
    MarkerLabel? label,
    bool clickable=true,
    _BaseIcon? icon
    }):_position=position,_opacity=opacity,_title=title,_label=label,_icon=icon,super(visible,clickable,zIndex);
  Map _toMap()=>{
    'position':_position.toMap(),
    'id':id,
    'opacity':_opacity,
    'title':_title,
    'animation':animation.name,
    'visible':_visible,
    'zIndex':_zIndex,
    'clickable':_clickable,
    'label':_label!=null? _label!._toMap():null,
    'icon':_icon!=null? _icon!._toMap():null
  }..removeWhere((key, value) => value==null);
  LatLng get  position=>_position;
  set position(LatLng value){
    _position=value;
    _sendData('setMarkerPosition', {'latLng':value.toMap()});
  }
  /// the opacity of the marker.
  double get opacity=>_opacity;
  set opacity(double value){
    _opacity=value;
    _sendData('setMarkerOpacity', {'opacity':value});
  }
  /// Rollover text. If provided, an accessibility text (e.g. for use with screen readers)
  /// will be added to the marker with the provided value.
  String get title=>_title;
  set title(String value){
    _title=value;
    _sendData('setMarkerTitle', {'title':value});
  }
  /// the label of the marker.
  MarkerLabel? get label=>_label;
  set label(MarkerLabel? value){
    _label=value;
    _sendData('setMarkerLabel', {'label':value!=null?value._toMap():null});
  }
  /// the icon will  display on the marker postion
  _BaseIcon? get icon =>_icon;
  set icon (_BaseIcon? value){
    _icon=value;
    _sendData('setMarkerIcon', {"icon":value != null ?value._toMap(): null});
  }
  void _startListenOnEvents(){
    _messagesReceiver.where((msg) => msg['eventType'].startsWith('marker')&&msg['data'].containsKey('id')&&msg['data']['id']==id).listen((data) {
      switch (data['eventType']) {
        case 'markerClick':
          if(_onClick!=null){_onClick!(LatLng.fromMap(data['data']['latlng']));}
          break;
        case 'markerDoubleClick':
          if(_onDoubleClick!=null){_onDoubleClick!(LatLng.fromMap(data['data']['latlng']));}
          break;
        case 'markerRightClick':
          if(_onRightClick!=null){_onRightClick!(LatLng.fromMap(data['data']['latlng']));}
          break;
        case 'markerMouseMove':
          if(_onMouseMove!=null){_onMouseMove!(LatLng.fromMap(data['data']['latlng']));}

          break;
        case 'markerMouseDown':
          if(_onMouseDown!=null){_onMouseDown!(LatLng.fromMap(data['data']['latlng']));}

          break;
        case 'markerMouseUp':
          if(_onMouseUp!=null){_onMouseUp!(LatLng.fromMap(data['data']['latlng']));}
          break;

      }
    });
  }


}