import 'package:anydrawer/anydrawer.dart';
import 'package:arcade/widgets/perfil_drawer.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Color(0xFF070F2B),
        height: 124,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                  ),
                ),
                height: 84,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          /*showDrawer(
                            context,
                            builder: (context) {
                              return const PerfilDrawer();
                            },
                            config: const DrawerConfig(
                              side: DrawerSide.left,
                              closeOnClickOutside: true,
                              closeOnEscapeKey: true,
                              closeOnResume: true,
                              // (Android only)
                              closeOnBackButton: false,
                              // (Requires a route navigator)
                              backdropOpacity: 0.5,
                              borderRadius: 24,
                            ),
                            onOpen: () {
                              // Optional callback when the drawer is opened
                            },
                            onClose: () {
                              // Optional callback when the drawer is closed
                            },
                          );
                        },

                           */
                        },
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          fixedSize: MaterialStateProperty.all(Size(64, 84)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          fixedSize: MaterialStateProperty.all(Size(64, 84)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.list_alt_outlined,
                          color: Colors.black,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          fixedSize: MaterialStateProperty.all(Size(64, 84)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 64,
                  width: 112,
                  color: Colors.white,
                ),
                Center(
                  child: Container(
                    width: 112,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Color(0xFF070F2B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(
                          Icons.photo_camera_outlined,
                          size: 32,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
