import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/event_map_vm.dart';
import 'package:arcade/view_model/map/limit_vm.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/view_model/map/path_vm.dart';
import 'package:arcade/widgets/event_form.dart';
import 'package:arcade/widgets/map/compass.dart';
import 'package:arcade/widgets/map/limit.dart';
import 'package:arcade/widgets/map/places.dart';
import 'package:arcade/widgets/map/routing_path.dart';
import 'package:arcade/widgets/map/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class EventMap extends StatelessWidget {
  EventMap({super.key}) {
    mapController = MapController();
  }

  late final MapController mapController;

  @override
  Widget build(BuildContext context) {
    final LimitVM limitVM = Provider.of<LimitVM>(context);
    final PathVM pathVM = Provider.of<PathVM>(context);
    final AuthVM authVM = Provider.of<AuthVM>(context);
    final EventMapVM vm = Provider.of<EventMapVM>(context);
    final CompassVM compassVM = Provider.of<CompassVM>(context);

    return FlutterMap(
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
          if (pathVM.insertingPath) {
            if (pathVM.isPathEmpty()) {
              pathVM.insertPathNode(latlng);
            } else {
              pathVM.insertPathNodeWithReference(latlng);
            }
          }
        },
        onLongPress: (pos, latlng) {
          if (!authVM.isAuthenticated()) {
            return;
          }

          final offset = pos.global;
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              offset.dx,
              offset.dy,
              MediaQuery.of(context).size.width - offset.dx,
              MediaQuery.of(context).size.height - offset.dy,
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            items: [
              PopupMenuItem(
                enabled: authVM.isUserManager(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: EventForm(
                        latlng: latlng,
                        isTemp: false,
                        onEventCreated: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Criar lugar',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              PopupMenuItem(
                child: const Text(
                  'Criar lugar temporario',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: EventForm(
                        latlng: latlng,
                        isTemp: true,
                        onEventCreated: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                enabled: authVM.isUserManager(),
                onTap: () async {
                  limitVM.insertLimit(latlng);
                },
                child: const Text(
                  'Criar limite',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              PopupMenuItem(
                enabled: authVM.isUserManager() && pathVM.isPathEmpty(),
                onTap: () async {
                  pathVM.insertPathNode(latlng);
                },
                child: const Text(
                  'Criar caminho',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          );
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.arcade',
        ),
        const Limit(),
        const Places(),
        const UserLocation(),
        authVM.isUserManager() ? const RoutingNodes() : SizedBox.fromSize(),
        const Compass(),
        PolylineLayer(
          polylines: [
            Polyline(
              points: compassVM.findResults,
              color: Colors.red,
              strokeWidth: 5.0,
            ),
          ],
        ),
      ],
    );
  }
}
