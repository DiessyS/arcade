import 'package:arcade/enum/multi_event_type.dart';
import 'package:arcade/models/marker_model.dart';
import 'package:arcade/models/multi_event_model.dart';
import 'package:arcade/service/models/multi_event_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class LimitVM extends ChangeNotifier {
  late bool insertingLimit;
  late MultiEventModel limitBuffer;

  LimitVM() {
    insertingLimit = false;
    limitBuffer = MultiEventModel();
  }

  insertLimit(LatLng latlng) {
    insertingLimit = true;
    limitBuffer.markers.add(MarkerModel()..fromLatLng(latlng));
    notifyListeners();
  }

  saveLimit() {
    MultiEventModel limit = MultiEventModel()
      ..type = MultiEventType.limit
      ..markers = limitBuffer.markers;
    service<MultiEventService>().add(limit);
    insertingLimit = false;
    limitBuffer = MultiEventModel();
    notifyListeners();
  }

  resetLimit() {
    insertingLimit = false;
    limitBuffer = MultiEventModel();
    notifyListeners();
  }

  List<LatLng> getLimit() {
    if (insertingLimit) {
      return limitBuffer.asLatLngList();
    }
    MultiEventModel limit = service<MultiEventService>().getByType(MultiEventType.limit);
    return limit.asLatLngList();
  }
}
