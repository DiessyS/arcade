import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/event_map_vm.dart';
import 'package:arcade/view_model/map/limit_vm.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/view_model/map/path_line_vm.dart';
import 'package:arcade/widgets/bottom_modal.dart';
import 'package:arcade/widgets/event_form.dart';
import 'package:arcade/widgets/map/compass.dart';
import 'package:arcade/widgets/map/limit.dart';
import 'package:arcade/widgets/map/places.dart';
import 'package:arcade/widgets/map/route_guide.dart';
import 'package:arcade/widgets/map/path_line.dart';
import 'package:arcade/widgets/map/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class EventMap extends StatelessWidget {
  EventMap({super.key});

  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final LimitVM limitVM = Provider.of<LimitVM>(context);
    final PathLineVM pathVM = Provider.of<PathLineVM>(context);
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
            if (pathVM.begin != null) {
              pathVM.insertPathNode(latlng);
              return;
            }

            if (pathVM.pathBuffer.isEmpty) {
              pathVM.insertPathNode(latlng);
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
                  BottomModal.show(
                    context,
                    "Criar lugar",
                    EventForm(
                      latlng: latlng,
                      isTemp: false,
                      onEventCreated: () {
                        Navigator.of(context).pop();
                      },
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
                  BottomModal.show(
                    context,
                    "Criar lugar temporario",
                    EventForm(
                      latlng: latlng,
                      isTemp: true,
                      onEventCreated: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
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
        ..._getOverlays(authVM, compassVM),
      ],
    );
  }

  List<Widget> _getOverlays(AuthVM authVM, CompassVM compassVM) {
    final List<Widget> overlays = [
      const Limit(),
      const Places(),
      const UserLocation(),
      const PathLine(),
      const Compass(),
    ];

    if (authVM.isUserManager()) {
      overlays.add(const PathLine());
    }

    overlays.add(const RouteGuide());

    return overlays;
  }
}
