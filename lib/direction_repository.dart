import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minimal_social_app/env.dart';
import 'package:minimal_social_app/models/directions_model.dart';

class DirectionRepository {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': googleAPIKey,
      },
    );

    // Debug: Print the response data
    print('Response data: ${response.data}');

    // Check if response is successful
    if (response.statusCode == 200 && response.data['routes'] != null) {
      return Directions.fromMap(response.data);
    } else {
      print('Failed to fetch directions or routes data is null');
    }
    return null;
  }
}
