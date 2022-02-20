part of WindowsMap;

abstract class _BaseIcon{
  final Point? anchor,labelOrigin;

  const _BaseIcon(this.anchor,this.labelOrigin);
  Map _toMap();

}