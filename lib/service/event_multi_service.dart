import 'package:arcade/service/generic/generic_service.dart';
import 'package:arcade_repository/arcade_repository.dart';

class EventMultiService extends GenericService<EventMultiMarker> {
  EventMultiService() : super(urlSubPath: 'event_multi');
}
