import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    if (map['routes'] == null || (map['routes'] as List).isEmpty) {
      throw ArgumentError('Routes data is empty or not in the expected format');
    }

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng((northeast['lat'] as num).toDouble(), (northeast['lng'] as num).toDouble()),
      southwest: LatLng((southwest['lat'] as num).toDouble(), (southwest['lng'] as num).toDouble()),
    );

    // Distance & durations
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      if (leg.containsKey('distance') && leg['distance'].containsKey('text')) {
        distance = leg['distance']['text'];
      }
      if (leg.containsKey('duration') && leg['duration'].containsKey('text')) {
        duration = leg['duration']['text'];
      }
    }

    // Polyline points
    List<PointLatLng> polylinePoints = [];
    if (data.containsKey('overview_polyline') && data['overview_polyline'] != null && data['overview_polyline'].containsKey('points')) {
      polylinePoints = PolylinePoints().decodePolyline(data['overview_polyline']['points']);
    }

    // Return Directions
    return Directions(
      bounds: bounds,
      polylinePoints: polylinePoints,
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
