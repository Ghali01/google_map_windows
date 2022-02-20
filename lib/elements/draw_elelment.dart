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
  get isAdded=>_id!=null;
  late bool _visible ,_clickable;

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
  int? get id=>_id;


  int get  zIndex=>_zIndex;

  set zIndex(int value){
    _zIndex=value;
    _sendData('setDrawElementZIndex',{'zIndex':value});
  }

  bool get visible=>_visible;
  set visible(bool value){
    _visible=value;
    _sendData('setDrawElementVisible',{'visible':value});
  }
  bool get clickable=>_clickable;
  set clickable(bool value){
    _clickable=value;
    _sendData('setDrawElementClickable', {'clickable':value});
  }


  set onMouseUp(MET value)=>_onMouseUp = value;


  set onMouseMove(MET value) =>_onMouseMove = value;

  set onMouseDown(MET value) =>_onMouseDown = value;


  set onRightClick(MET value)=>_onRightClick = value;


  set onDoubleClick(MET value)=> _onDoubleClick = value;


  set onClick(MET value)=>_onClick = value;
}