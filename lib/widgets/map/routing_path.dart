import 'package:arcade/view_model/map/path_vm.dart';
import 'package:arcade/widgets/confirmation_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class RoutingNodes extends StatelessWidget {
  const RoutingNodes({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PathVM>(context);

    return FutureBuilder(
      future: vm.getPaths(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(
              child: SizedBox(),
            );
          }

          return Stack(
            children: [
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: vm.polylineBuffer,
                    color: Colors.orange,
                    strokeWidth: 5.0,
                  ),
                ],
              ),
              PolylineLayer(
                polylines: snapshot.data!
                    .map(
                      (e) => Polyline(
                        points: [
                          e.begin.marker.toLatLng(),
                          e.end.marker.toLatLng(),
                        ],
                        color: e.begin.eventType.color!,
                        strokeWidth: 5.0,
                      ),
                    )
                    .toList(),
              ),
              MarkerLayer(
                markers: snapshot.data!
                    .map(
                      (e) => Marker(
                        width: 32,
                        height: 32,
                        point: e.end.asLatLng(),
                        child: Stack(
                          children: [
                            IconButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.white.withOpacity(0.5),
                                ),
                                side: WidgetStateProperty.all(
                                  const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                              ),
                              onPressed: () {
                                if (vm.insertingPath) {
                                  if (e.begin.asLatLng() == e.end.asLatLng()) {
                                    vm.resetInsertion();
                                    showToast(
                                      "Não é possivel ligar o caminho a si mesmo",
                                      position: ToastPosition.bottom,
                                    );
                                    return;
                                  }
                                  vm.insertPathNodeWithReference(e.end.asLatLng());
                                  return;
                                }
                                vm.startInsertionByReference(e.end.asLatLng());
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              Visibility(
                visible: vm.isUnsaved,
                child: ConfirmationOverlay(
                  message: 'Para adicionar o limite continue tocando nos pontos envolta da area que deseja limitar.',
                  onConfirm: () async {
                    await vm.saveLimit();
                  },
                  confirmText: 'Finalizar',
                  onCancel: () {
                    vm.cancelInsertion();
                  },
                  cancelText: 'Cancelar',
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: SizedBox(
              child: Text(
                'Erro ao carregar caminhos',
              ),
            ),
          );
        }
      },
    );
  }
}
