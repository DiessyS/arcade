import 'package:arcade/models/event_model.dart';
import 'package:arcade/models/marker_model.dart';
import 'package:arcade/models/multi_event_model.dart';
import 'package:arcade/service/map_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:latlong2/latlong.dart';

extension on double {
  double get bounded {
    if (this > 180) {
      return this - 360;
    }
    return this;
  }
}

class EventMap extends StatefulWidget {
  EventMap({super.key});

  LatLng mainInitialLocation = const LatLng(-25.051366806523237, -50.13217808780914);

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  MapController mapController = MapController();

  List<EventModel> places = [
    EventModel()
      ..title = 'Sala c'
      ..marker.fromLatLng(LatLng(-25.050006806523237, -50.13303808780914)),
  ];

  List<EventModel> tempPlaces = [];

  MultiEventModel limit = MultiEventModel();
  List<MultiEventModel> roads = [];

  bool insertingLimit = false;
  bool insertingRoad = false;

  insertPlace(LatLng latlng, String title, String description, context) {
    EventModel event = EventModel();
    event.title = title;
    event.description = description;
    event.marker.fromLatLng(latlng);

    places.add(event);
  }

  insertTempPlace(LatLng latlng, String title, String description, context) {
    EventModel event = EventModel();
    event.title = title;
    event.description = description;
    event.marker.fromLatLng(latlng);

    tempPlaces.add(event);
  }

  insertLimit(LatLng latlng) {
    insertingLimit = true;
    insertingRoad = false;
    limit.markers.add(MarkerModel()..fromLatLng(latlng));
  }

  getUserLocation() {
    return LatLng(-25.051366806523237, -50.13217808780914);
  }

  getDirection() {
    LatLng user = getUserLocation();
    LatLng target = places.first.asLatLng();

    return service<MapService>().calculateBearing(user.latitude, user.longitude, target.latitude, target.longitude);
  }

  getDistance() {
    LatLng user = getUserLocation();
    LatLng target = places.first.asLatLng();

    var distance =
        FlutterMapMath().distanceBetween(user.latitude, user.longitude, target.latitude, target.longitude, 'meters');

    return distance;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: widget.mainInitialLocation,
            initialZoom: 17.2,
            minZoom: 16.0,
            maxZoom: 22.0,
            onTap: (pos, latlng) {
              if (insertingLimit) {
                setState(() {
                  insertLimit(latlng);
                });
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
                      EventModel event = EventModel();
                      event.marker.fromLatLng(latlng);

                      if (limit.asLatLngList().isNotEmpty && !service<MapService>().isEventInsideLimit(event, limit)) {
                        showToast('O lugar não está dentro do limite.');
                        return;
                      }

                      setState(() {
                        showEventFormModal(latlng, false);
                      });
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Criar lugar temporario'),
                    onTap: () async {
                      EventModel event = EventModel();
                      event.marker.fromLatLng(latlng);

                      if (limit.asLatLngList().isNotEmpty && !service<MapService>().isEventInsideLimit(event, limit)) {
                        showToast('O lugar não está dentro do limite.');
                        return;
                      }

                      setState(() {
                        showEventFormModal(latlng, true);
                      });
                    },
                  ),
                  PopupMenuItem(
                    onTap: () async {
                      setState(() {});
                    },
                    child: const Text('Criar caminhos'),
                  ),
                  PopupMenuItem(
                    enabled: limit.markers.isEmpty,
                    onTap: () async {
                      setState(() {
                        insertLimit(latlng);
                      });
                    },
                    child: const Text('Criar limite'),
                  ),
                  PopupMenuItem(
                    enabled: limit.markers.isNotEmpty,
                    onTap: () async {
                      setState(() {
                        insertingLimit = false;
                        limit = MultiEventModel();
                      });
                    },
                    child: const Text('Remover limite'),
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
            // ----------------- //
            //    Area limit     //
            // ----------------- //
            PolygonLayer(
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
            ),
            // ----------------- //
            //      Places       //
            // ----------------- //
            MarkerLayer(
              markers: places
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
                                onTap: () async {
                                  setState(() {});
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Delete'),
                                onTap: () async {
                                  setState(() {});
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
                                color: Colors.green,
                              ),
                            ),
                            Icon(
                              Icons.place,
                              size: 25.0,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            // ----------------- //
            //       Temp        //
            // ----------------- //
            MarkerLayer(
              markers: tempPlaces
                  .map(
                    (e) => Marker(
                      width: 100.0,
                      height: 80.0,
                      point: e.marker.toLatLng(),
                      child: GestureDetector(
                        child: Column(
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            Icon(
                              Icons.add_location,
                              size: 25.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            // ----------------- //
            //   User Location   //
            // ----------------- //
            MarkerLayer(
              markers: [
                Marker(
                  width: 100.0,
                  height: 80.0,
                  point: getUserLocation(),
                  child: const Column(
                    children: [
                      Text(
                        'Você',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Icon(
                        Icons.location_on,
                        size: 25.0,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 124,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(getDirection() / 360),
                        child: Icon(
                          Icons.arrow_upward,
                          size: 92,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${getDistance().toStringAsFixed(2)}m',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        insertingLimit ? getMultiEventInsertingBanner() : Container(),
      ],
    );
  }

  /*
    String title = '';
  EventType type = EventType.place;
  MarkerModel marker = MarkerModel();
   */
  showEventFormModal(LatLng latlng, bool isTemp) {
    String title = '';
    String description = '';

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Título',
                ),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(16),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Descrição',
                ),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(16),
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
                    child: Text('Cancelar'),
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
                      setState(() {
                        if (isTemp)
                          insertTempPlace(latlng, title, description, context);
                        else
                          insertPlace(latlng, title, description, context);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    print(msg);
  }

  getMultiEventInsertingBanner() {
    String message = '';

    if (insertingLimit) {
      message = 'Continue tocando nos pontos envolta da area que deseja limitar.';
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(8),
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
                  setState(
                    () {
                      insertingLimit = false;
                      limit = MultiEventModel();
                    },
                  );
                },
                child: Text('Cancelar'),
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
                  setState(
                    () {
                      insertingLimit = false;
                    },
                  );
                },
                child: Text('Finalizar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
