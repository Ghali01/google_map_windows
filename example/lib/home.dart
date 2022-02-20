import 'package:flutter/material.dart';
import 'package:google_map_windows/google_map_windows.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WindowsMapController mapController;
  int zoom = 12;

  //31.776187750566574, 35.23573728711054
  final mkaaLocation = LatLng(lat: 21.422817474739336, lng: 39.826170262307336),
      al_madinaLocation =
          LatLng(lat: 24.46752900640867, lng: 39.61106867194075),
      al_QudsLocation = LatLng(lat: 31.776187750566574, lng: 35.23573728711054);
  TextEditingController latController = TextEditingController(),
      lngController = TextEditingController();
  TextEditingController westController = TextEditingController(),
      eastController = TextEditingController(),
      southController = TextEditingController(),
      northController = TextEditingController();
 void btnClicked() async {
  }

  @override
  void initState() {
    mapController = WindowsMapController();
    mapController.initMap();
    mapController.onZoomChanged = (zoomValue) {
      setState(() => zoom = zoomValue);
    };
    mapController.onCenterChanged = (LatLng center) {
      latController.text = center.lat.toString();
      lngController.text = center.lng.toString();
    };
    mapController.onBoundsChanged = (LatLngBounds bounds) {
      westController.text = bounds.west.toString();
      eastController.text = bounds.east.toString();
      southController.text = bounds.south.toString();
      northController.text = bounds.north.toString();
    };

    super.initState();

  }

  void zoomIn() async {
    mapController.setZoom(this.zoom + 1);
    int zoom = await mapController.getZoom();
    setState(() => this.zoom = zoom);
  }

  void zoomOut() async {
    mapController.setZoom(this.zoom - 1);
    int zoom = await mapController.getZoom();
    setState(() => this.zoom = zoom);
  }

  void setCenter(LatLng center) => mapController.setCenter(center);

  void panTo() => mapController.panTo(LatLng(
      lat: double.parse(latController.text),
      lng: double.parse(lngController.text)));

  void setBounds() => mapController.fitBounds(LatLngBounds(
      west: double.parse(westController.text),
      east: double.parse(eastController.text),
      south: double.parse(southController.text),
      north: double.parse(northController.text)));

  void panToBounds() => mapController.panToBounds(LatLngBounds(
      west: double.parse(westController.text),
      east: double.parse(eastController.text),
      south: double.parse(southController.text),
      north: double.parse(northController.text)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Column(
            children: [
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
              ElevatedButton(
                  onPressed: btnClicked, child: const Text('Click me')),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.blueAccent))),
                  child: const Text(
                    "Zoom",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: zoomIn, icon: const Icon(Icons.add)),
                    Text(
                      zoom.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    IconButton(
                        onPressed: zoomOut, icon: const Icon(Icons.remove))
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: Colors.blueAccent))),
                  child: const Text(
                    "Center",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () => setCenter(mkaaLocation),
                          child: const Text('Makka')),
                      ElevatedButton(
                          onPressed: () => setCenter(al_madinaLocation),
                          child: const Text('al-Middina')),
                      ElevatedButton(
                          onPressed: () => setCenter(al_QudsLocation),
                          child: const Text('al-Quds')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        'lat',
                        style: TextStyle(fontSize: 25),
                      ),
                      Expanded(
                        child: TextField(
                          controller: latController,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        'lng',
                        style: TextStyle(fontSize: 25),
                      ),
                      Expanded(
                        child: TextField(
                          controller: lngController,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => setCenter(LatLng(
                            lat: double.parse(latController.text),
                            lng: double.parse(lngController.text))),
                        child: const Text("Go"),
                      ),
                      ElevatedButton(
                        onPressed: panTo,
                        child: const Text("Pan To"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: Colors.blueAccent))),
                  child: const Text(
                    "Bounds",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        'north',
                        style: TextStyle(fontSize: 25),
                      ),
                      Expanded(
                        child: TextField(
                          controller: northController,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        'south',
                        style: TextStyle(fontSize: 25),
                      ),
                      Expanded(
                        child: TextField(
                          controller: southController,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        'west',
                        style: TextStyle(fontSize: 25),
                      ),
                      Expanded(
                        child: TextField(
                          controller: westController,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        'east',
                        style: TextStyle(fontSize: 25),
                      ),
                      Expanded(
                        child: TextField(
                          controller: eastController,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: setBounds,
                        child: const Text('Set Bounds'),
                      ),
                      ElevatedButton(
                        onPressed: panToBounds,
                        child: const Text('Pan Bounds'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
