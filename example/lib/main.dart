import 'package:example/utils/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_navigator/flutter_navigator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:maplibre_gl/maplibre_gl.dart';

final json = {
  "type": "FeatureCollection",
  "bbox": [90.363557, 23.755817, 90.385784, 23.837539],
  "features": [
    {
      "bbox": [90.363557, 23.755817, 90.385784, 23.837539],
      "type": "Feature",
      "properties": {
        "segments": [
          {
            "distance": 10668.4,
            "duration": 890.4,
            "steps": [
              {
                "distance": 26.2,
                "duration": 6.3,
                "type": 11,
                "instruction": "Head east on Road 7",
                "name": "Road 7",
                "way_points": [0, 1]
              },
              {
                "distance": 109.6,
                "duration": 26.3,
                "type": 0,
                "instruction": "Turn left onto Avenue 6",
                "name": "Avenue 6",
                "way_points": [1, 3]
              },
              {
                "distance": 784.4,
                "duration": 62.4,
                "type": 0,
                "instruction": "Turn left onto Link Road 9",
                "name": "Link Road 9",
                "way_points": [3, 14]
              },
              {
                "distance": 868.4,
                "duration": 56.8,
                "type": 7,
                "instruction": "Enter the roundabout and take the 1st exit",
                "name": "-",
                "exit_number": 1,
                "way_points": [14, 24]
              },
              {
                "distance": 2529.2,
                "duration": 193.9,
                "type": 7,
                "instruction":
                    "Enter the roundabout and take the 2nd exit onto বেগম রোকেয়া সরণী",
                "name": "বেগম রোকেয়া সরণী",
                "exit_number": 2,
                "way_points": [24, 75]
              },
              {
                "distance": 4910.4,
                "duration": 353.2,
                "type": 7,
                "instruction":
                    "Enter the roundabout and take the 2nd exit onto বেগম রোকেয়া সরণী",
                "name": "বেগম রোকেয়া সরণী",
                "exit_number": 2,
                "way_points": [75, 131]
              },
              {
                "distance": 746.8,
                "duration": 59.7,
                "type": 6,
                "instruction": "Continue straight onto বেগম রোকেয়া সরণী",
                "name": "বেগম রোকেয়া সরণী",
                "way_points": [131, 142]
              },
              {
                "distance": 31.4,
                "duration": 1.8,
                "type": 7,
                "instruction":
                    "Enter the roundabout and take the 1st exit onto খামার বাড়ি সড়ক",
                "name": "খামার বাড়ি সড়ক",
                "exit_number": 1,
                "way_points": [142, 144]
              },
              {
                "distance": 80.8,
                "duration": 3.4,
                "type": 3,
                "instruction": "Turn sharp right",
                "name": "-",
                "way_points": [144, 145]
              },
              {
                "distance": 50.8,
                "duration": 2.2,
                "type": 3,
                "instruction": "Turn sharp right onto ইন্দিরা রোড",
                "name": "ইন্দিরা রোড",
                "way_points": [145, 147]
              },
              {
                "distance": 69.6,
                "duration": 13.9,
                "type": 7,
                "instruction":
                    "Enter the roundabout and take the 1st exit onto রাজা বাজার- ইন্দিরা রোড",
                "name": "রাজা বাজার- ইন্দিরা রোড",
                "exit_number": 1,
                "way_points": [147, 150]
              },
              {
                "distance": 98.7,
                "duration": 23.7,
                "type": 0,
                "instruction": "Turn left onto রাজা বাজার- ইন্দিরা রোড",
                "name": "রাজা বাজার- ইন্দিরা রোড",
                "way_points": [150, 151]
              },
              {
                "distance": 240.9,
                "duration": 57.8,
                "type": 1,
                "instruction": "Turn right onto রাজা বাজার- ইন্দিরা রোড",
                "name": "রাজা বাজার- ইন্দিরা রোড",
                "way_points": [151, 156]
              },
              {
                "distance": 121.4,
                "duration": 29.1,
                "type": 0,
                "instruction": "Turn left",
                "name": "-",
                "way_points": [156, 158]
              },
              {
                "distance": 0.0,
                "duration": 0.0,
                "type": 10,
                "instruction": "Arrive at your destination, on the right",
                "name": "-",
                "way_points": [158, 158]
              }
            ]
          }
        ],
        "summary": {"distance": 10668.4, "duration": 890.4},
        "way_points": [0, 158]
      },
      "geometry": {
        "coordinates": [
          [90.371111, 23.836542],
          [90.371367, 23.836558],
          [90.37134, 23.837031],
          [90.371267, 23.837539],
          [90.37034, 23.837498],
          [90.370234, 23.837474],
          [90.369335, 23.837415],
          [90.36926, 23.837422],
          [90.369087, 23.837441],
          [90.367255, 23.837347],
          [90.366327, 23.837312],
          [90.365999, 23.837294],
          [90.364844, 23.837271],
          [90.364605, 23.837218],
          [90.363576, 23.837163],
          [90.363557, 23.837152],
          [90.363635, 23.836704],
          [90.363701, 23.836223],
          [90.363743, 23.835838],
          [90.363794, 23.835263],
          [90.363821, 23.83486],
          [90.363818, 23.833483],
          [90.363833, 23.831771],
          [90.363877, 23.831038],
          [90.363913, 23.829378],
          [90.363945, 23.829368],
          [90.363974, 23.829326],
          [90.363973, 23.829308],
          [90.363958, 23.829279],
          [90.364067, 23.829273],
          [90.364129, 23.828674],
          [90.364195, 23.828313],
          [90.364243, 23.827785],
          [90.364303, 23.827304],
          [90.364337, 23.826725],
          [90.364352, 23.826186],
          [90.364357, 23.82567],
          [90.364364, 23.825184],
          [90.36438, 23.824647],
          [90.364421, 23.823834],
          [90.364517, 23.822645],
          [90.364589, 23.822111],
          [90.364711, 23.821575],
          [90.364805, 23.821058],
          [90.364863, 23.820856],
          [90.365017, 23.820322],
          [90.36504, 23.820239],
          [90.36513, 23.819954],
          [90.365244, 23.819537],
          [90.365378, 23.819057],
          [90.365524, 23.818512],
          [90.365665, 23.817997],
          [90.365813, 23.817455],
          [90.365949, 23.816961],
          [90.366091, 23.81644],
          [90.366235, 23.815913],
          [90.366375, 23.815389],
          [90.366513, 23.814891],
          [90.366641, 23.814394],
          [90.366815, 23.813741],
          [90.366952, 23.813229],
          [90.367057, 23.812957],
          [90.3672, 23.81246],
          [90.367186, 23.812354],
          [90.367299, 23.811933],
          [90.367436, 23.811418],
          [90.367564, 23.81094],
          [90.367653, 23.810605],
          [90.367676, 23.810519],
          [90.367699, 23.810436],
          [90.367706, 23.810411],
          [90.367846, 23.809936],
          [90.367989, 23.809408],
          [90.368148, 23.808864],
          [90.368275, 23.808365],
          [90.368607, 23.807238],
          [90.368704, 23.807213],
          [90.36874, 23.807181],
          [90.368763, 23.807143],
          [90.368768, 23.807058],
          [90.368704, 23.806972],
          [90.368788, 23.80669],
          [90.369029, 23.806111],
          [90.369178, 23.805809],
          [90.369272, 23.805576],
          [90.369687, 23.804713],
          [90.369825, 23.804434],
          [90.370172, 23.803682],
          [90.370354, 23.803234],
          [90.370403, 23.803135],
          [90.370644, 23.80259],
          [90.370965, 23.801879],
          [90.37114, 23.801503],
          [90.371387, 23.800915],
          [90.371557, 23.800509],
          [90.371794, 23.799919],
          [90.372467, 23.798352],
          [90.373003, 23.797064],
          [90.373388, 23.796124],
          [90.373692, 23.795402],
          [90.37405, 23.794575],
          [90.374335, 23.793884],
          [90.374556, 23.793382],
          [90.374578, 23.793324],
          [90.374794, 23.792795],
          [90.374903, 23.792546],
          [90.375306, 23.791602],
          [90.375775, 23.790484],
          [90.375882, 23.790223],
          [90.376171, 23.789608],
          [90.376403, 23.789055],
          [90.376451, 23.788948],
          [90.376499, 23.788853],
          [90.378195, 23.784873],
          [90.378609, 23.783759],
          [90.379221, 23.781862],
          [90.379252, 23.781756],
          [90.379369, 23.781363],
          [90.379631, 23.780472],
          [90.380039, 23.77902],
          [90.38058, 23.777268],
          [90.380695, 23.77693],
          [90.380742, 23.776775],
          [90.381215, 23.775239],
          [90.381772, 23.77332],
          [90.382076, 23.7723],
          [90.382518, 23.770705],
          [90.382542, 23.770613],
          [90.382793, 23.769533],
          [90.382896, 23.768775],
          [90.383186, 23.767001],
          [90.383385, 23.765441],
          [90.383407, 23.7652],
          [90.383413, 23.764981],
          [90.383425, 23.764711],
          [90.383442, 23.764456],
          [90.383466, 23.763617],
          [90.383542, 23.762473],
          [90.383629, 23.761216],
          [90.383708, 23.759942],
          [90.38376, 23.75917],
          [90.383798, 23.75897],
          [90.383843, 23.758742],
          [90.383925, 23.758711],
          [90.384103, 23.75883],
          [90.384122, 23.758104],
          [90.383714, 23.758264],
          [90.383663, 23.758283],
          [90.383582, 23.758341],
          [90.38354, 23.758404],
          [90.383508, 23.757947],
          [90.384477, 23.75797],
          [90.384472, 23.757035],
          [90.384445, 23.756963],
          [90.384531, 23.75627],
          [90.384563, 23.756087],
          [90.384603, 23.755817],
          [90.385613, 23.755913],
          [90.385784, 23.755955]
        ],
        "type": "LineString"
      }
    }
  ],
  "metadata": {
    "attribution":
        "openrouteservice.org, OpenStreetMap contributors, tmc - BASt",
    "service": "routing",
    "timestamp": 1730739485985,
    "query": {
      "coordinates": [
        [90.3711, 23.8367],
        [90.3858, 23.7559]
      ],
      "profile": "driving-car",
      "format": "json"
    },
    "engine": {
      "version": "8.0.0",
      "build_date": "2024-03-21T13:55:54Z",
      "graph_date": "2024-10-30T16:44:05Z"
    }
  }
};
final data = OpenrouteserviceResponse.fromJson(json);

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? currentLocation;

  Future<void> fetchDirections() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentLocation = await Geolocator.getCurrentPosition();
    setState(() {});
  }

  @override
  void initState() {
    fetchDirections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: currentLocation != null
          ? MapScreen(
              currentLocation: currentLocation!,
            )
          : SizedBox(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.currentLocation});

  final Position currentLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapLibreMapController? controller;
  OpenrouteserviceResponse? data;
  Line? line;

  _getData(LatLng toLocation) async {
    final currentLocation = await Geolocator.getLastKnownPosition();
    final url = Uri.parse(
        '${dotenv.env['ROUTE_SERVER_HOST']}/ors/v2/directions/driving-car?start=${currentLocation!.longitude}%2C${currentLocation.latitude}&end=${toLocation.longitude}%2C${toLocation.latitude}');

    try {
      // Send the GET request
      final response = await http.get(url);

      // Check for a successful response
      if (response.statusCode == 200) {
        // Parse the JSON response
        data = OpenrouteserviceResponse.fromJson(jsonDecode(response.body));
        setState(() {});
      } else {
        print('Failed to load directions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: data == null ? null : FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FlutterNavigator(
                directionRouteResponse: data!,
              ),
            ),
          );
        },
        child: Icon(Icons.directions),
      ),
      body: MapLibreMap(
        styleString:
            'https://api.maptiler.com/maps/basic-v2/style.json?key=${dotenv.env['MAP_KEY']}',
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.currentLocation.latitude,
            widget.currentLocation.longitude,
          ),
          zoom: 15.0,
        ),
        onMapCreated: (c) {
          controller = c;
        },
        onStyleLoadedCallback: () async {
          final ByteData bytes =
              await rootBundle.load('assets/location-marker.png');
          final Uint8List list = bytes.buffer.asUint8List();
          controller?.addImage("marker_image", list);
        },
        myLocationEnabled: true,
        onMapClick: (point, coordinates) async {
          MarkerManager.instance.addMarker(
            location: coordinates,
            mapController: controller!,
          );
          await _getData(coordinates);
          print(data?.features.first.geometry.coordinates
              .map<LatLng>(
                (point) => LatLng(
                  point[1],
                  point[0],
                ),
              )
              .toList());
          if (line != null) {
            controller?.removeLine(line!);
          }

          line = await controller!.addLine(
            LineOptions(
              geometry: data?.features.first.geometry.coordinates
                  .map<LatLng>(
                    (point) => LatLng(
                      point[1],
                      point[0],
                    ),
                  )
                  .toList(),
              lineColor: '#0000FF',
              lineJoin: 'round',
              lineWidth: 6,
            ),
          );
        },
      ),
    );
  }
}
