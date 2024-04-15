import 'package:arcade/models/event_model.dart';
import 'package:arcade/repository/event_repository.dart';
import 'package:arcade/service/models/generic_model_service.dart';

class EventService extends GenericModelService<EventModel> {
  EventService() {
    repository = EventRepository();
  }
}
