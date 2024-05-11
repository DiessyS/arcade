import 'package:arcade/view_model/event_map_vm.dart';
import 'package:arcade/view_model/limit_vm.dart';
import 'package:arcade/view_model/places_vm.dart';
import 'package:arcade/widgets/map/compass.dart';
import 'package:arcade/widgets/map/limit.dart';
import 'package:arcade/widgets/map/places.dart';
import 'package:arcade/widgets/map/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class EventMap extends StatelessWidget {
  EventMap({super.key}) {
    mapController = MapController();
  }

  late MapController mapController;

  @override
  Widget build(BuildContext context) {
    final LimitVM limitVM = Provider.of<LimitVM>(context);
    final PlacesVM placesVM = Provider.of<PlacesVM>(context);
    final EventMapVM vm = Provider.of<EventMapVM>(context);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: vm.getInitialLocation(),
            initialZoom: 17.2,
            minZoom: 16.0,
            maxZoom: 22.0,
            onTap: (pos, latlng) {
              if (limitVM.insertingLimit) {
                limitVM.insertLimit(latlng);
              }
            },
            onLongPress: (pos, latlng) {
              final offset = pos.global;
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy,
                  MediaQuery.of(context).size.width - offset.dx,
                  MediaQuery.of(context).size.height - offset.dy,
                ),
                items: [
                  PopupMenuItem(
                    child: const Text('Criar lugar'),
                    onTap: () async {
                      placesVM.addPlace(latlng, context, isTemp: false);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Criar lugar temporario'),
                    onTap: () async {
                      placesVM.addPlace(latlng, context, isTemp: true);
                    },
                  ),
                  PopupMenuItem(
                    enabled: true,
                    onTap: () async {
                      limitVM.insertLimit(latlng);
                    },
                    child: const Text('Criar limite'),
                  ),
                ],
              );
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            const Limit(),
            const Places(),
            const UserLocation(),
            const Compass(),
          ],
        ),
      ],
    );
  }
}
