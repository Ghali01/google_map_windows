part of WindowsMap;

class MapImageIcon extends _BaseIcon {
  final String _url;
  final Point? origin;
  final Size? size, scaledSize;

  MapImageIcon.fromUrl(
      {required String url,
      Point? anchor,
      Point? labelOrigin,
      this.origin,
      this.size,
      this.scaledSize})
      : _url = url,
        super(anchor, labelOrigin);
  @override
  Map _toMap() => {
        'url': _url,
        'anchor': anchor != null ? anchor!._toMap() : null,
        'labelOrigin': labelOrigin != null ? labelOrigin!._toMap() : null,
        'origin': origin != null ? origin!._toMap() : null,
        'size': size != null ? size!._toMap() : null,
        'scaledSize': scaledSize != null ? scaledSize!._toMap() : null,
      }..removeWhere((key, value) => value == null);
  static Future<MapImageIcon> iconFromAssets(
      {required String path,
      Point? anchor,
      Point? labelOrigin,
      Point? origin,
      Size? size,
      Size? scaledSize}) async{
    final String format=path.split('.').last;
    final file=await rootBundle.load(path);
    var b64=base64Encode(Uint8ClampedList.view(file.buffer));
    b64='data:image/$format;base64,$b64';
    return MapImageIcon.fromUrl(
      url: b64,
      anchor: anchor,
      labelOrigin: labelOrigin,
      origin: origin,
      size: size,
      scaledSize: scaledSize,

    );
  }
}
