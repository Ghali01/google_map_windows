part of WindowsMap;
/// a class represent an icon useing image file.
class MapImageIcon extends _BaseIcon {
  final String _url;
  ///The position of the image within a sprite, if any.
  ///By default, the origin is located at the top left corner of the image (0, 0).
  final Point? origin;
  ///The display size of the sprite or image. When using sprites, you must specify the sprite size.
  ///If the size is not provided, it will be set when the image loads.
  final Size? size;
  ///The size of the entire image after scaling,
  ///if any. Use this property to stretch/shrink an image or a sprite.
  final Size? scaledSize;
  /// icon from the internet
  /// load the image from the given [url]
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

  /// return an icon from the assets.
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
