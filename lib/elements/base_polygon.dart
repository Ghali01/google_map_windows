part of WindowsMap;
// enum StrokePosition{
//   CENTER,
//   INSIDE,
//   OUTSIED
// }
abstract class _BasePolygon extends _BasePoly{
  Color _fillColor;
  double _fillOpacity;
  // StrokePosition _strokePosition;
  _BasePolygon({
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
  }):_fillColor=fillColor,_fillOpacity=fillOpacity,/*_strokePosition=strokePosition,*/super(clickable: clickable,editable: editable,geodesic: geodesic,strokeColor: strokeColor,strokeOpacity: strokeOpacity,strokeWeight: strokeWeight,visible: visible,zIndex: zIndex);
  @override
  Map _toMap()=>{
    'fillColor':_fillColor._rgba,
    'fillOpacity':_fillOpacity,
    'type':runtimeType.toString().toLowerCase(),

    // 'strokePosition':_strokePosition.name
  }..addAll(super._toMap());
  Color get fillColor=>_fillColor;
  set fillColor(Color value){
    _fillColor =value;
    _sendData('setPolygonFillColor',{'fillColor':value._rgba});
  }
  double get fillOpacity=>_fillOpacity;
  set fillOpacity(double value){
    _fillOpacity=value;
    _sendData('setPolygonFillOpacity',{'fillOpacity':value});
  }
  // Future<Map> _listenToValue(String event) async{
  //   await for (Map data in _messagesReceiver.where((msg) => msg['data'].containsKey('id')&&msg['data']['id']==id&&msg['data']['event']==event )){
  //     return data;
  //   }
  //   return {};
  //
  // }

}