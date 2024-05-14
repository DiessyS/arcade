import 'package:arcade/service/generic/generic_service.dart';
import 'package:arcade_repository/arcade_repository.dart';

class MarkerService extends GenericService<Marker> {
  MarkerService() : super(urlSubPath: 'marker');
}
