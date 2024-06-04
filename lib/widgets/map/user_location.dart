import 'package:arcade/view_model/user_location_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class UserLocation extends StatelessWidget {
  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    UserLocationVM vm = Provider.of<UserLocationVM>(context);

    return StreamBuilder<Position>(
      stream: vm.getLocationStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MarkerLayer(
            markers: [
              Marker(
                width: 100.0,
                height: 80.0,
                point: vm.locationDataToLatLng(snapshot.data!),
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
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
              ),
            ),
            child: const Text(
              "Obtentendo localização...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }
      },
    );
  }
}
