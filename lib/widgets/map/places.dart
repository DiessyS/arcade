import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/view_model/map/event_vm.dart';
import 'package:arcade/widgets/event_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class Places extends StatelessWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context) {
    AuthVM loginVM = Provider.of<AuthVM>(context);
    CompassVM compassVM = Provider.of<CompassVM>(context);
    EventVM eventVM = Provider.of<EventVM>(context);

    return FutureBuilder(
      future: eventVM.getPlaceAndTempEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(
              child: SizedBox(),
            );
          }
          return MarkerLayer(
            markers: snapshot.data!
                .map(
                  (e) => Marker(
                    width: 100.0,
                    height: 80.0,
                    point: e.marker.toLatLng(),
                    child: GestureDetector(
                      onTapDown: (details) {
                        if (!loginVM.isAuthenticated()) {
                          return;
                        }
                        final offset = details.globalPosition;
                        showMenu(
                          context: context,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          position: RelativeRect.fromLTRB(
                            offset.dx,
                            offset.dy,
                            MediaQuery.of(context).size.width - offset.dx,
                            MediaQuery.of(context).size.height - offset.dy,
                          ),
                          items: [
                            PopupMenuItem(
                              enabled: loginVM.isUserManager(),
                              child: const Text(
                                'Remover',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              onTap: () async {
                                eventVM.deleteEvent(e.id);
                              },
                            ),
                            PopupMenuItem(
                              child: const Text(
                                'Ir para',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              onTap: () {
                                compassVM.startTracking(e);
                              },
                            ),
                            PopupMenuItem(
                              enabled: loginVM.isUserManager(),
                              child: const Text(
                                'Informações',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              onTap: () async {
                                showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom,
                                    ),
                                    child: EventInfo(
                                      event: e,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            e.name,
                            style: TextStyle(
                              color: e.eventType.color,
                            ),
                          ),
                          Icon(
                            Icons.place,
                            size: 25.0,
                            color: e.eventType.color,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }
        return const Center(
          child: Text("Erro ao carregar lugares"),
        );
      },
    );
  }
}
