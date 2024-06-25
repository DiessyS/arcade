import 'package:arcade/enum/home_page_modes.dart';
import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view/home/perfil_page.dart';
import 'package:arcade/view_model/bottom_navigation_vm.dart';
import 'package:arcade/view_model/home_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  VoidCallback? viewChangeClick;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationVM vm = Provider.of<BottomNavigationVM>(context);
    HomePageVM homePageVM = Provider.of<HomePageVM>(context);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
      value: vm.lastNavigationPositionValue,
    );

    if (vm.canHideButton()) {
      _controller.animateTo(0);
      vm.lastNavigationPositionValue = 0;
    } else if (vm.canShowButton()) {
      _controller.reset();
      _controller.animateTo(1, duration: const Duration(milliseconds: 500));
      vm.lastNavigationPositionValue = 1;
    }

    return Container(
      color: ThemeTokens.backgroundColor,
      height: 104,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
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
                  _buttonOnBottomNavigation(
                    0,
                    Icons.person_outline,
                    vm,
                    callback: () {
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
          FadeTransition(
            opacity: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOutCubic,
            ),
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOutCubic,
              ),
              axis: Axis.horizontal,
              child: Stack(
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
                      decoration: const BoxDecoration(
                        color: ThemeTokens.backgroundColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                        child: FilledButton(
                          onPressed: () {
                            homePageVM.changeModeTo(HomePageModes.cameraARCore);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
                            splashFactory: InkSparkle.splashFactory,
                            elevation: MaterialStateProperty.all(2),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.sync_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    );
  }
}
