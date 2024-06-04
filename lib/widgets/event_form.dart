import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/marker.dart';
import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view_model/map/event_vm.dart';
import 'package:arcade/view_model/map/limit_vm.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {
  const EventForm(
      {super.key, required this.latlng, required this.isTemp, required this.onEventCreated});

  final LatLng latlng;
  final bool isTemp;
  final VoidCallback onEventCreated;

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  checkBoundaries(context) {
    LimitVM limitVM = Provider.of<LimitVM>(context);
    limitVM.isInsideLimit(widget.latlng).then((value) {
      if (!value) {
        showToast('Não é possivel adicionar um ponto aqui', position: ToastPosition.bottom);
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    EventVM eventVM = Provider.of<EventVM>(context);

    checkBoundaries(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Criar lugar ${widget.isTemp ? "temporario" : ""}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  //close
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox.fromSize(size: const Size(0, 32)),
              TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Titulo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um titulo';
                    }
                    return null;
                  }),
              SizedBox.fromSize(size: const Size(0, 16)),
              TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  }),
              SizedBox.fromSize(size: const Size(0, 16)),
              FilledButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  try {
                    await eventVM.addEvent(
                      titleController.text,
                      descriptionController.text,
                      widget.isTemp ? EventType.temp : EventType.place,
                      Marker.fromLatLng(widget.latlng),
                    );
                  } catch (e) {
                    showToast(e.toString(), position: ToastPosition.bottom);
                    return;
                  }

                  widget.onEventCreated();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ThemeTokens.backgroundColor),
                  fixedSize: MaterialStateProperty.all(
                    const Size(
                      double.infinity,
                      48,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child: const Text('Criar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
