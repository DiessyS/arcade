import 'package:arcade/view_model/map/path_line_vm.dart';
import 'package:arcade/widgets/confirmation_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class PathLine extends StatelessWidget {
  const PathLine({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PathLineVM>(context);

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

          if (!vm.insertingPath) {
            return const SizedBox();
          }

          return Stack(
            children: [
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
                        child: IconButton(
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
                            if (e.begin.asLatLng().toSexagesimal() == e.end.asLatLng().toSexagesimal()) {
                              showToast(
                                "Não é possivel ligar o caminho a si mesmo",
                                position: ToastPosition.bottom,
                              );
                              return;
                            }
                            vm.insertPathNode(e.end.asLatLng());
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              Visibility(
                visible: vm.insertingPath,
                child: ConfirmationOverlay(
                  message: vm.paths.isEmpty && vm.pathBuffer.isEmpty
                      ? 'Toque no inicio da rota e logo em seguida no ponto final'
                      : 'Para adicionar uma rota conecte os pontos criados',
                  onConfirm: () async {
                    await vm.saveLimit();

                    showToast(
                      "Caminho salvo com sucesso",
                      position: ToastPosition.bottom,
                    );
                  },
                  confirmText: 'Finalizar',
                  onCancel: () {
                    vm.cancelPathInsertion();
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
