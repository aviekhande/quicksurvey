import 'package:geolocator/geolocator.dart';

/// Wraps Geolocator to safely fetch the device's current GPS position.
class LocationService {
  /// Returns the current [Position] or null if permission is denied / unavailable.
  static Future<Position?> getCurrentPosition() async {
    try {
      // Check if location services are enabled on device
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      // Request permission if not yet granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      // Fetch the position with a 5-second timeout to avoid UI freezing
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,       
         timeLimit: const Duration(seconds: 5)
      );
    } catch (_) {
      return null; // Graceful degradation – submission still saves without coords
    }
  }
}
