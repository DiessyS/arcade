import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/event_model.dart';
import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/places_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class Places extends StatelessWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context) {
    PlacesVM vm = Provider.of<PlacesVM>(context);
    CompassVM compassVM = Provider.of<CompassVM>(context);

    return MarkerLayer(
      markers: vm
          .getPlaces()
          .map(
            (e) => Marker(
              width: 100.0,
              height: 80.0,
              point: e.marker.toLatLng(),
              child: GestureDetector(
                onTapDown: (details) {
                  final offset = details.globalPosition;
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
                        child: const Text('Renomear'),
                        onTap: () async {},
                      ),
                      PopupMenuItem(
                        child: const Text('Remover'),
                        onTap: () async {},
                      ),
                      PopupMenuItem(
                        child: const Text('Ir para'),
                        onTap: () {
                          compassVM.startTracking(e);
                        },
                      ),
                    ],
                  );
                },
                child: Column(
                  children: [
                    Text(
                      e.title,
                      style: TextStyle(
                        color: _getColorByType(e),
                      ),
                    ),
                    Icon(
                      Icons.place,
                      size: 25.0,
                      color: _getColorByType(e),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  _getColorByType(EventModel e) {
    switch (e.type) {
      case EventType.place:
        return Colors.green;
      case EventType.temp:
        return Colors.blue;
    }
  }
}
