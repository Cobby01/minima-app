import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minimal_social_app/components/my_drawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

@override
_HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(7.9044655,-1.0304069);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        // title: const Text("Home"),
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // go to users page button
          IconButton(onPressed: () => Navigator.pushNamed(context, '/users_page'),
           icon: const Icon(Icons.person)),
        ], 
      ),
            drawer: MyDrawer(),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
