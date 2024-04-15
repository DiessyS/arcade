import 'package:arcade/models/multi_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Limit extends StatelessWidget {
  Limit({super.key, required this.limit});

  MultiEventModel limit;

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(
      polygons: [
        Polygon(
          points: limit.asLatLngList(),
          color: Colors.red.withOpacity(0.1),
          isFilled: true,
          isDotted: true,
          borderColor: Colors.red,
          borderStrokeWidth: 3.0,
        ),
      ],
    );
  }
}
