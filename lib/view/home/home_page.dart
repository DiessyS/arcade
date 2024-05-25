import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:arcade/enum/home_page_modes.dart';
import 'package:arcade/models/event.dart';
import 'package:arcade/view/home/home/event_camera.dart';
import 'package:arcade/view/home/home/event_map.dart';
import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/home_page_vm.dart';
import 'package:arcade/view_model/places_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageVM vm = Provider.of<HomePageVM>(context);
    PlacesVM placesVM = Provider.of<PlacesVM>(context);
    CompassVM compassVM = Provider.of<CompassVM>(context);

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
                  HomePageModes.cameraARCore => EventCamera(),
                },
              ),
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
                      SizedBox(
                        height: 68,
                        width: 68,
                        child: FilledButton(
                          onPressed: () async {
                            await placesVM.addPlaceByLocation(context, isTemp: true);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
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
                      FutureBuilder(
                        future: placesVM.getNonTempPlaces(),
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
