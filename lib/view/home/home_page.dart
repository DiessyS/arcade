import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:arcade/enum/home_page_modes.dart';
import 'package:arcade/models/event.dart';
import 'package:arcade/view/home/home/event_map.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/home_page_vm.dart';
import 'package:arcade/view_model/map/event_vm.dart';
import 'package:arcade/view_model/user_location_vm.dart';
import 'package:arcade/widgets/event_form.dart';
import 'package:arcade/widgets/map/map_legend.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthVM authVM = Provider.of<AuthVM>(context);
    HomePageVM vm = Provider.of<HomePageVM>(context);
    CompassVM compassVM = Provider.of<CompassVM>(context);
    EventVM eventVM = Provider.of<EventVM>(context);
    UserLocationVM userLocationVM = Provider.of<UserLocationVM>(context);

    return SafeArea(
      child: Container(
        color: const Color(0xFF070F2B),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: switch (vm.mode) {
                  HomePageModes.rasterMap => EventMap(),
                  HomePageModes.cameraARCore => Text(''),
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: (MediaQuery.of(context).viewInsets.bottom / 2) + 16,
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Row(
                        children: [
                          if (authVM.isAuthenticated()) ...[
                            SizedBox(
                              height: 68,
                              width: 68,
                              child: FilledButton(
                                onPressed: () async {
                                  LatLng latlng = await userLocationVM.getUserLocation();

                                  showModalBottomSheet(
                                    context: context,
                                    useSafeArea: true,
                                    isScrollControlled: true,
                                    builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: EventForm(
                                        latlng: latlng,
                                        isTemp: true,
                                        onEventCreated: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                                  splashFactory: InkSparkle.splashFactory,
                                  elevation: MaterialStateProperty.all(2),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox.fromSize(
                              size: const Size(16, 0),
                            ),
                          ],
                          FutureBuilder(
                            future: eventVM.getPlacesEvents(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.data == null) {
                                  return const Center(
                                    child: Text("Nenhum lugar encontrado"),
                                  );
                                }
                                return getPlaceSearch(snapshot.data, compassVM.startTracking);
                              }
                              return const SizedBox(width: 1, height: 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const MapLegend(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPlaceSearch(List<Event>? places, startTracking) {
    if (places == null || places.isEmpty) {
      return const SizedBox(width: 1, height: 1);
    } else {
      return Expanded(
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: CustomDropdown<Event>.search(
            decoration: const CustomDropdownDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
                height: 2.5,
              ),
              listItemStyle: TextStyle(
                color: Colors.black,
                height: 2.5,
              ),
              headerStyle: TextStyle(
                color: Colors.black,
                height: 2.5,
              ),
            ),
            hintText: 'Para onde você quer ir?',
            searchHintText: 'Pesquisar',
            items: places,
            onChanged: (Event? value) {
              if (value != null) {
                startTracking(value);
              }
            },
          ),
        ),
      );
    }
  }
}
