import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view/home/perfil_page.dart';
import 'package:arcade/view_model/bottom_navigation_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigationVM vm = Provider.of<BottomNavigationVM>(context);

    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      color: ThemeTokens.backgroundColor,
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              height: 84,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buttonOnBottomNavigation(
                    0,
                    Icons.person_outline,
                    vm,
                    callback: () {
                      openPerfilPage(context);
                    },
                  ),
                  _buttonOnBottomNavigation(
                    1,
                    Icons.home_outlined,
                    vm,
                    callback: () {
                      Navigator.of(context).pushNamed('/home_page');
                    },
                  ),
                  _buttonOnBottomNavigation(
                    2,
                    Icons.list_alt_outlined,
                    vm,
                    callback: () {
                      Navigator.of(context).pushNamed('/list_page');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  openPerfilPage(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const PerfilPage(),
      ),
    );
  }

  _buttonOnBottomNavigation(
    int index,
    IconData icon,
    BottomNavigationVM vm, {
    required VoidCallback? callback,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextButton(
          onPressed: () async {
            if (callback != null) {
              callback.call();
            }
            vm.setIndex(index);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(vm.getColorByActivity(index)),
            fixedSize: MaterialStateProperty.all(const Size(64, 84)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
