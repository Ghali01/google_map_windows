# google_map_windows

a plugin for google map on windows OS

## Before the  installing
this plugin depends on Javascript google map api and [webview_windows](https://pub.dev/packages/webview_windows)
which depends on [Microsoft Edge WebView2](https://docs.microsoft.com/en-us/microsoft-edge/webview2/)
we recommend to read the install requirements of [webview_windows](https://pub.dev/packages/webview_windows#development-platform-requirements)
### porblem you may face with webview_windows and nuget
some times the source of nuget maybe uncorret you set it from cmd by following next command 
**be sure you add nuget to system varibles**
```
$ nuget source Update -Name nuget.org -Source https://api.nuget.org/v3/index.json
```
## get the api key (optinal)
as we said this plugin built on google map javascript api
so you can use javascript apikey by follwing [this guide](https://developers.google.com/maps/documentation/javascript/get-api-key)

#how to use
you can add the map to your widget tree by follwing code


###1- crate map controller 

```
    WindowsMapController mapController = WindowsMapController();
    mapController.initMap();
```


###2- set your api key (optinal)

``` 
    mapController.apiKey = YOUR_API_KEY';
```


###3- add to widget tree

```
    SizedBox(
        width: 900,
        height: 500,
        child: WindowsMap(
          controller: mapController,
          zoom: zoom,
          center:
          LatLng(lat: 33.43446356719302, lng: 36.25603641463645),

        ),
  ),
```