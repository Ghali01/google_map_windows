# Google  Maps for Flutter Windows OS

[![pub package](https://img.shields.io/pub/v/google_map_windows.svg)](https://pub.dev/packages/google_map_windows)

A flutter plugin that provides [Google Maps](https://developers.google.com/maps/) widget for Windows OS app.

## Usage

To use this plugin, add `google_maps_windows` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Before the installing

This plugin depends on Javascript google map api and [webview_windows](https://pub.dev/packages/webview_windows)
which depends on [Microsoft Edge WebView2](https://docs.microsoft.com/en-us/microsoft-edge/webview2/)
we recommend to read the install requirements of [webview_windows](https://pub.dev/packages/webview_windows#development-platform-requirements)

### Problem you may face with webview_windows and nuget

Sometimes the source of nuget maybe incorrect, you can set it from cmd by following this command. **Ensure you have added nuget to system varibles**

```bash
nuget source Update -Name nuget.org -Source https://api.nuget.org/v3/index.json
```

## Get the api key (optional in development mode)

As it was earlier stated, this plugin is built on google map javascript api
so you can use javascript api key by follwing [this guide](https://developers.google.com/maps/documentation/javascript/get-api-key)

## How to use

Add a `WindowsMap` widget to your widget tree.

The map view can be controlled with the `WindowsMapController` that is passed to
the `WindowsMap`'s `onMapInitialed` callback.

### 1- create map controller

``` dart
    WindowsMapController mapController = WindowsMapController();
    mapController.initMap();
```

### 2- set your api key (optional in development mode)

``` dart
    mapController.apiKey = 'YOUR_API_KEY';
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
  )

```

### 4- add draw element

You can add [Markers](https://pub.dev/documentation/google_map_windows/latest/WindowsMap/Marker-class.html), [Polylines](https://pub.dev/documentation/google_map_windows/latest/WindowsMap/Polyline-class.html) and [Polygons](https://pub.dev/documentation/google_map_windows/latest/WindowsMap/Polygon-class.html) by the map controller.

#### Markers

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

#### Polylines

adding a polyline

```dart
  Polyline polyline = Polyline(path: [al_madinaLocation, mkaaLocation]);
  mapController.addPolyline(polyline);
```

removing a polyline

```dart
  mapController.removePolyline(polyline);
```

#### Polygons

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

### 5- Events system

You can add a new event listener with following syntax

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
