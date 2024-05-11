import 'package:arcade/view_model/compass_vm.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Compass extends StatelessWidget {
  const Compass({super.key});

  @override
  Widget build(BuildContext context) {
    CompassVM vm = Provider.of<CompassVM>(context);

    if (!vm.isTracking()) {
      return SizedBox.fromSize(size: const Size(0, 0));
    }

    return StreamBuilder<Position>(
      stream: vm.location,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double distance = vm.getDistance(snapshot.data!);
          if (vm.isTrackingCloseEnough(distance) || vm.isTrackingFinished) {
            vm.stopTrackingDelayed();
            return _infoBox(_trackingFinished(vm.targetName));
          } else {
            return _infoBox(_compass(snapshot.data!, distance, vm));
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget _infoBox(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF070F2B).withOpacity(1),
        ),
        height: 96,
        child: widget,
      ),
    );
  }

  Widget _compass(Position position, double distance, CompassVM vm) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(vm.getDirection(position)),
            child: const Icon(
              Icons.arrow_upward,
              size: 64,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Indo até ${vm.targetName}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${distance.toStringAsFixed(2)} metros',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _trackingFinished(targetName) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            Icons.check,
            size: 64,
            color: Colors.white,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              targetName ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Você chegou ao destino',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
