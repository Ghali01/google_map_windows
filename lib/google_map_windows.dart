library WindowsMap;

import 'dart:convert';
import 'dart:typed_data';
import 'dart:collection' ;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_windows/web_middleware/init.dart';
import 'package:webview_windows/webview_windows.dart';
import 'dart:math' show Random,max,min;

part 'controller.dart';
part 'elements/lat_lng.dart';
part 'elements/lat_lng_bounds.dart';
part 'elements/draw_elelment.dart';
part 'elements/marker.dart';
part 'elements/marker_label.dart';
part 'elements/draw_geo.dart';
part 'elements/base_icon.dart';
part 'elements/image_icon.dart';
part 'elements/svg_icon.dart';
part 'elements/base_poly.dart';
part 'elements/polyline.dart';
part 'elements/base_polygon.dart';
part 'elements/polygon.dart';
part 'elements/rectanlge.dart';
part 'elements/criclcle.dart';
class WindowsMap extends StatefulWidget {
  final WindowsMapController _mapController;
  int zoom, minZoom, maxZoom;
  LatLng center;
  bool doubleClickZoom;

  WindowsMap(
      {Key? key,
      required WindowsMapController controller,
      this.zoom = 8,
      required this.center,
      this.doubleClickZoom = true,
      this.maxZoom = 30,
      this.minZoom = 4})
      : _mapController = controller,
        assert(minZoom < maxZoom, "minZoom gte maxZoom"),
        super(key: key);

  @override
  _WindowsMapState createState() => _WindowsMapState();
}

class _WindowsMapState extends State<WindowsMap> {
  late WebviewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget._mapController._webviewController;
    // widget._mapController._setWebViewController(_controller);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    await _controller.initialize();
    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);

    await _controller
        .loadStringContent(await HTMLFile.load(widget._mapController.apiKey, {
      'zoom': widget.zoom,
      'center': widget.center.toJson(),
      'disabledoublecliczoom': !widget.doubleClickZoom,
      'minzoom': widget.minZoom,
      'maxzoom': widget.maxZoom,
    }));
    if (!mounted) return;
    setState(() {});
  }
  int _dy=0;
  void _zooming(event) async{
    if(event is PointerScrollEvent) {
        _dy+=event.scrollDelta.dy.toInt();
        if(_dy>=32){
          _dy=0;
          widget._mapController.setZoom(await widget._mapController.getZoom()-1);
        }
        else if(_dy<=-32){
          _dy=0;
          widget._mapController.setZoom(await widget._mapController.getZoom()+1);

        }
        Future.delayed(const Duration(milliseconds: 500),()=>_dy=0);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _zooming,
      child: Webview(_controller),
    );
  }
}
