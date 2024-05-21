import 'package:arcade/enum/multi_event_type.dart';
import 'package:arcade/models/multi_event_model.dart';
import 'package:arcade/repository/multi_event_repository.dart';
import 'package:arcade/service/models/generic_model_service.dart';

class MultiEventService extends GenericModelService<MultiEventModel> {
  MultiEventService() {
    repository = MultiEventRepository();
  }

  MultiEventModel getByType(MultiEventType type) {
    List<MultiEventModel> all = getAll();
    return all.firstWhere((element) => element.type == type, orElse: () => MultiEventModel());
  }
}
