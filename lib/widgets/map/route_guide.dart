import 'package:arcade/view_model/compass_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class RouteGuide extends StatelessWidget {
  const RouteGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final CompassVM compassVM = Provider.of<CompassVM>(context);

    if (!compassVM.isTracking()) {
      return SizedBox.fromSize(size: const Size(0, 0));
    }

    return PolylineLayer(
      polylines: [
        Polyline(
          points: compassVM.findResults,
          color: Colors.blue,
          strokeCap: StrokeCap.round,
          strokeWidth: 4.0,
        ),
      ],
    );
  }
}
