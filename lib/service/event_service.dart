import 'package:arcade/service/generic/generic_service.dart';
import 'package:arcade_repository/arcade_repository.dart';

class EventService extends GenericService<Event> {
  EventService() : super(urlSubPath: 'event');
}
