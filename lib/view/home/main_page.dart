import 'package:arcade/view/home/event_map.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xFF070F2B),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: EventMap(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Para onde você quer ir?',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
