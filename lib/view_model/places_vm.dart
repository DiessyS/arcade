import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/event_model.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service/map_service.dart';
import 'package:arcade/service/models/event_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:arcade/widgets/place_form.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oktoast/oktoast.dart';

class PlacesVM extends ChangeNotifier {
  addPlace(LatLng latlng, BuildContext context, {required bool isTemp}) {
    if (!_verifyLimit(latlng)) {
      showToast('Não é possivel adicionar um ponto aqui', position: ToastPosition.bottom);
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PlaceForm(
          latlng: latlng,
          isTemp: isTemp,
          callback: (place) => {
            service<EventService>().add(place),
            notifyListeners(),
          },
        );
      },
    );
  }

  addPlaceByLocation(BuildContext context, {required bool isTemp}) async {
    Position location = await service<LocationService>().determinePosition();
    addPlace(LatLng(location.latitude, location.longitude), context, isTemp: isTemp);
  }

  bool _verifyLimit(LatLng latlng) {
    return service<MapService>().isLatLngInsideLimit(latlng);
  }

  List<EventModel> getPlaces() {
    List<EventModel> places = service<EventService>().getAll();
    return places;
  }

  List<EventModel> getNonTempPlaces() {
    List<EventModel> places = service<EventService>().getAll();
    return places.where((element) => element.type != EventType.temp).toList();
  }

  bool noPlaces() {
    return service<EventService>().getAll().isEmpty;
  }
}
