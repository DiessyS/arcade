import 'package:arcade/models/user.dart';
import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/view_model/perfil_vm.dart';
import 'package:arcade/widgets/floating_map_menu.dart';
import 'package:arcade/widgets/glossy_container.dart';
import 'package:arcade/widgets/perfil/login.dart';
import 'package:arcade/widgets/perfil/perfil.dart';
import 'package:arcade/widgets/window_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/event_map.dart';
import 'list/event_list.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({super.key});

  final bool invertImage = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    AuthVM loginVM = Provider.of<AuthVM>(context);
    PerfilVM vm = Provider.of<PerfilVM>(context);
    User user = loginVM.getUser()!;

    return WindowArea(
      child: GlossyContainer(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 124,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ThemeTokens.backgroundColor.withOpacity(0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          "${user.identifier} - ${user.manager ? 'Gerenciador' : 'Usuário'}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: ThemeTokens.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          await loginVM.logout(context);
                        },
                        child: const Icon(Icons.logout),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox.fromSize(size: const Size(0, 16)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Minhas marcações",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CupertinoSlidingSegmentedControl<int>(
                      groupValue: selectedIndex,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      thumbColor: Colors.white,
                      children: {
                        0: SizedBox(
                          height: 42,
                          width: 180,
                          child: Center(
                            child: Text(
                              "Todas marcações",
                              style: TextStyle(
                                color: selectedIndex == 0 ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        1: SizedBox(
                          height: 42,
                          width: 180,
                          child: Center(
                            child: Text(
                              "Minhas marcações",
                              style: TextStyle(
                                color: selectedIndex == 1 ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      },
                      onValueChanged: (i) {
                        selectedIndex = i!;
                        vm.changeView(i == 0);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ThemeTokens.backgroundColor,
                          width: 1,
                        ),
                      ),
                      child: EventList(showAllEvents: true, user: user),
                    ),
                  ),
                ],
              ),
            ),
            // SingleChildScrollView(
            //   child: const EventList(),
            // ),
          ],
        ),
      ),
    );
  }
}
