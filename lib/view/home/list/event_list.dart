import 'package:arcade/view_model/list/list_events_vm.dart';
import 'package:arcade/view_model/map/event_vm.dart';
import 'package:arcade/widgets/event_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    EventVM eventVM = Provider.of<EventVM>(context);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Pesquisar",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: eventVM.getPlaceAndTempEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Nenhum evento encontrado"),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            print("Event tapped");
                          },
                          onTapDown: (details) {
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                details.globalPosition.dx,
                                details.globalPosition.dy,
                                details.globalPosition.dx,
                                details.globalPosition.dy,
                              ),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              items: [
                                PopupMenuItem(
                                  enabled: true,
                                  child: const Text(
                                    'Remover',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () async {
                                    await eventVM.deleteEvent(e.id);
                                  },
                                ),
                                PopupMenuItem(
                                  enabled: true,
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
                          enableFeedback: true,
                          splashFactory: InkRipple.splashFactory,
                          splashColor: Colors.black.withOpacity(0.03),
                          overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.03)),
                          child: ListTile(
                            title: Text("${e.name} (${e.eventType.label})"),
                            subtitle: Text(
                              "Longitude: ${e.asLatLng().longitude.toStringAsFixed(4)} \nLatitude: ${e.asLatLng().latitude.toStringAsFixed(4)}",
                            ),
                            trailing: Text("${e.createdAt?.toIso8601String().split('T').first}"),
                          ),
                        ),
                      )
                      .toList(),
                );
              } else {
                return const Center(
                  child: Text("Erro ao carregar usuários"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
