part of WindowsMap;

class MapElementNotAddedException implements Exception{
  _DrawElement element;

  MapElementNotAddedException(this.element);

  @override
  String toString() {
    return '${element.runtimeType} not added yet';
  }
}

abstract class _DrawElement<MET>{
  int? _id;
  late final void Function(String,Map) _messagesSender;
  late final Stream<Map<dynamic,dynamic>> _messagesReceiver;
  /// Check if the element added to the map.
  get isAdded=>_id!=null;
  late bool _visible;
  late bool _clickable;

  late int _zIndex;
  MET? _onClick,_onDoubleClick,_onRightClick,_onMouseMove,_onMouseUp,_onMouseDown;
  _DrawElement(bool visible,bool clickable,int zIndex):_visible=visible,_clickable=clickable,_zIndex=zIndex;
  void _sendData(String event,Map data){
    data['id']=id;
    data['type']=runtimeType.toString().toLowerCase();
    if(_askForAdding()) {
      _messagesSender(event, data);
    }
  }
  bool _askForAdding(){
    if(isAdded){return true;}
    else{return false;}
  }
  /// the id of the element.
  int? get id=>_id;

  ///All elements are displayed on the map in order of their zIndex,
  /// with higher values displaying in front of markers with lower values.
  /// By default, elements are displayed according to their vertical position on screen,
  /// with lower elements appearing in front of markers further up the screen.
  int get  zIndex=>_zIndex;

  set zIndex(int value){
    _zIndex=value;
    _sendData('setDrawElementZIndex',{'zIndex':value});
  }

  /// the visibility of the element
  bool get visible=>_visible;
  set visible(bool value){
    _visible=value;
    _sendData('setDrawElementVisible',{'visible':value});
  }
  /// if true the element will be clickable and listen to mouse event.
  /// Default true.

  bool get clickable=>_clickable;
  set clickable(bool value){
    _clickable=value;
    _sendData('setDrawElementClickable', {'clickable':value});
  }

  /// an event runs on the mouse button up on the element.

  set onMouseUp(MET value)=>_onMouseUp = value;

  /// an event runs on the mouse move on the element.

  set onMouseMove(MET value) =>_onMouseMove = value;

  /// an event runs on the mouse button down on the element.

  set onMouseDown(MET value) =>_onMouseDown = value;

  /// an event runs on the user click the right mouse button on the element

  set onRightClick(MET value)=>_onRightClick = value;

  /// an event runs on the user double click the left mouse button on the element

  set onDoubleClick(MET value)=> _onDoubleClick = value;

  /// an event runs on the user click the left mouse button on the element

  set onClick(MET value)=>_onClick = value;
}