part of WindowsMap;

abstract class _BaseIcon{
  ///The position at which to anchor an image in correspondence to the location of the marker on the map.
  /// By default, the anchor is located along the center point of the bottom of the image.
  final Point? anchor;
  ///The origin of the label relative to the top-left corner of the icon image, if a label is supplied by the marker.
  ///By default, the origin is located in the center point of the image.
  final Point? labelOrigin;

  const _BaseIcon(this.anchor,this.labelOrigin);
  Map _toMap();

}