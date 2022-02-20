part of WindowsMap;

class Point{
  final int x,y;
  Point(this.x,this.y);
  Map _toMap()=>{'x':x,'y':y};
}

extension _SizeToMap on Size{
  Map _toMap()=>{'width':width,'height':height};
}
