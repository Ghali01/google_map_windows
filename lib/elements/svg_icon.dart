part of WindowsMap;


class MapSvgIcon extends _BaseIcon {
  final String path;
  final Color fillColor, strokeColor;
  final double fillOpacity, rotation, scale, strokeOpacity, strokeWeight;

  MapSvgIcon({
    required this.path,
    Point? anchor,
    Point? labelOrigin,
    this.fillColor = Colors.black,
    this.fillOpacity = 1,
    this.strokeColor = Colors.black,
    this.strokeOpacity = 1,
    this.strokeWeight = 1,
    this.scale = 1,
    this.rotation = 0,
  }) : super(anchor, labelOrigin);

  @override
  Map _toMap() => {
        'path': path,
        'anchor': anchor,
        'labelOrigin': labelOrigin,
        'fillColor': fillColor._rgba,
        'fillOpacity': fillOpacity,
        'strokeColor': strokeColor._rgba,
        'strokeOpacity': strokeOpacity,
        'strokeWeight': strokeWeight,
        'scale': scale,
        'rotation': rotation,
      }..removeWhere((key, value) => value==null);


}
