import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/event.dart';
import 'package:arcade/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class PlaceForm extends StatelessWidget {
  PlaceForm({super.key, required this.latlng, required this.isTemp, required this.callback});

  final void Function(Event) callback;

  LatLng latlng;
  bool isTemp;

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Título',
            ),
            onChanged: (value) {
              title = value;
            },
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(16),
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Descrição',
            ),
            onChanged: (value) {
              description = value;
            },
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.red.withOpacity(0.8)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.black54),
                ),
                onPressed: () {
                  Event place = Event();
                  place.name = title;
                  place.description = description;
                  place.marker.fromLatLng(latlng);
                  place.eventType = isTemp ? EventType.temp : EventType.place;

                  callback(place);

                  Navigator.of(context).pop();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
