import 'package:arcade/models/multi_event_model.dart';
import 'package:arcade/repository/multi_event_repository.dart';
import 'package:arcade/service/models/generic_model_service.dart';

class MultiEventService extends GenericModelService<MultiEventModel> {
  MultiEventService() {
    repository = MultiEventRepository();
  }
}
