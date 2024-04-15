import 'package:arcade/service/location_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class UserLocation extends StatelessWidget {
  UserLocation({super.key});

  Stream<Position> location = const Stream.empty();

  @override
  Widget build(BuildContext context) {
    service<LocationService>().capture();
    location = service<LocationService>().positionStream;

    return StreamBuilder<Position>(
      stream: location,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MarkerLayer(
            markers: [
              Marker(
                width: 100.0,
                height: 80.0,
                point: positionToLatLng(snapshot.data!),
                child: const Column(
                  children: [
                    Text(
                      'Você',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    Icon(
                      Icons.location_on,
                      size: 25.0,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }

  positionToLatLng(Position position) {
    return LatLng(position.latitude, position.longitude);
  }

  getUserLocation() {
    return LatLng(-25.051366806523237, -50.13217808780914);
  }
}
