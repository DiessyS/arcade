import 'package:arcade/enum/event_type.dart';
import 'package:flutter/material.dart';

class MapLegend extends StatelessWidget {
  const MapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    var colorsAndLabels = EventType.values
        .where(
          (element) => element.color != null,
        )
        .toList();

    return Container(
      height: 32,
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: colorsAndLabels.map((e) {
          return Row(
            children: [
              Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: e.color,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                e.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
