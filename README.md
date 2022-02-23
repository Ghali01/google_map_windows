# google_map_windows

a plugin for google map on windows OS

## Before the  installing

this plugin depends on Javascript google map api and [webview_windows](https://pub.dev/packages/webview_windows)
which depends on [Microsoft Edge WebView2](https://docs.microsoft.com/en-us/microsoft-edge/webview2/)
we recommend to read the install requirements of [webview_windows](https://pub.dev/packages/webview_windows#development-platform-requirements)

### porblem you may face with webview_windows and nuget

some times the source of nuget maybe uncorret you set it from cmd by following next command **be sure you add nuget to system varibles**

```bash
nuget source Update -Name nuget.org -Source https://api.nuget.org/v3/index.json
```

## get the api key (optinal in development mode)

as we said this plugin built on google map javascript api
so you can use javascript api key by follwing [this guide](https://developers.google.com/maps/documentation/javascript/get-api-key)

## how to use

you can add the map to your widget tree by follwing code.

### 1- crate map controller

``` dart
    WindowsMapController mapController = WindowsMapController();
    mapController.initMap();
```

### 2- set your api key (optinal)

``` dart
    mapController.apiKey = YOUR_API_KEY';
```

### 3- add to widget tree

```dart
    SizedBox(
        width: 900,
        height: 500,
        child: WindowsMap(
          controller: mapController,
          zoom: zoom,
          center:
          LatLng(lat: 33.43446356719302, lng: 36.25603641463645),

        ),
  ),main.html

```

### 3- add draw element

you can add [Markes](https://pub.dev/documentation/google_map_windows/latest/WindowsMap/Marker-class.html), [Polylnes](https://pub.dev/documentation/google_map_windows/latest/WindowsMap/Polyline-class.html) and [Polygons](https://pub.dev/documentation/google_map_windows/latest/WindowsMap/Polygon-class.html) by the map controller.

#### markers

adding a Marker

``` dart
  al_QudsLocation = LatLng(lat: 31.776187750566574, lng: 35.23573728711054);
  Marker marker = Marker(position: al_QudsLocation, title: 'msjd al-aqsa almubark');
  mapController.addMarker(marker);
```

removing a marker

```dart
  mapController.removeMarker(marker);
```

#### polylines

adding a polyline

```dart
  Polyline polyline = Polyline(path: [al_madinaLocation, mkaaLocation]);
  mapController.addPolyline(polyline);
```

removing a polyline

```dart
  mapController.removePolyline(polyline);
```

#### polygons

adding a ploygon

```dart
 List<LatLng> alAqsaPP = [
    LatLng.fromMap({"lat": 31.77956412562312, "lng": 35.23701938301966}),
    LatLng.fromMap({"lat": 31.779276833355343, "lng": 35.23453029305384}),
    LatLng.fromMap({"lat": 31.77573126753284, "lng": 35.234828062147656}),
    LatLng.fromMap({"lat": 31.7762192265448, "lng": 35.23731178769545})
  ];
  Polygon polygon = Polygon(
    paths: [
      alAqsaPP,
    ],
    fillColor: Colors.blue.shade400,
    strokeColor: Colors.red.shade200,
    fillOpacity: .4,
  );
  mapController.addPolygon(polygon);

```

removeing a ploygon

```dart
  mapController.removePolygon(polygon);
```

### 4- events system

you can add a new event listenr with following syntex

for map

```dart
  mapController.event=function;
```

for draw elements

```dart
  element.event=function;
```

examples:

```dart
  mapController.onMapInitialed = () {};
  marker.onClick = (point) {};
```

**_for more [docs](https://pub.dev/documentation/google_map_windows/latest/), [github](https://github.com/Ghali01/google_map_windows)_**
