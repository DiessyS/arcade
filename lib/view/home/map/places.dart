import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Places extends StatelessWidget {
  Places({super.key, required this.points, required this.tempPoints});

  List<EventModel> points;
  List<EventModel> tempPoints;

  @override
  Widget build(BuildContext context) {
    List<EventModel> allPoints = [...points, ...tempPoints];
    return MarkerLayer(
      markers: allPoints
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
                        child: const Text('Rename'),
                        onTap: () async {},
                      ),
                      PopupMenuItem(
                        child: const Text('Delete'),
                        onTap: () async {},
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
