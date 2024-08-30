import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minimal_social_app/components/my_drawer.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  final Set<Marker> _deviceMarkers = {}; // Track device markers

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(7.9044655, -1.0304069),
    zoom: 11.5,
  );

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(''),
      ),
      drawer: const MyDrawer(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) {
              _googleMapController = controller;
              _fetchDeviceLocations(); // Fetch device locations
            },
            markers: _deviceMarkers,
            onLongPress: _addMarker,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) {
    // Implement as needed
  }

  void _fetchDeviceLocations() async {
    FirebaseFirestore.instance.collection('devices').snapshots().listen((snapshot) {
      final newMarkers = <Marker>{};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final LatLng position = LatLng(data['latitude'], data['longitude']);

        newMarkers.add(
          Marker(
            markerId: MarkerId(doc.id),
            infoWindow: InfoWindow(
              title: data['deviceName'],
              snippet: '${data['deviceType']} - ${data['deviceID']}',
            ),
            position: position,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      }

      setState(() {
        _deviceMarkers.clear();
        _deviceMarkers.addAll(newMarkers);
      });
    });
  }
}
