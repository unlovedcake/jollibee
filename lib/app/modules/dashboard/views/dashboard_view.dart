import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  final _dashBoardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Nav with GetX'),
      // ),
      // body: Obx(() => AnimatedSwitcher(
      //       duration: Duration(milliseconds: 1000),
      //       child: IndexedStack(
      //         index: _dashBoardController.selectedIndex.value,
      //         children: _dashBoardController.screens,
      //       ),
      //       transitionBuilder: (Widget child, Animation<double> animation) {
      //         // return FadeTransition(
      //         //   opacity: animation,
      //         //   child: child,
      //         // );
      //         return SlideTransition(
      //           position: Tween<Offset>(
      //             begin: Offset(1, 0),
      //             end: Offset.zero,
      //           ).animate(animation),
      //           child: child,
      //         );
      //       },
      //     )),
      body: Obx(
        () => IndexStackWithFadeAnimation(
          index: _dashBoardController.selectedIndex.value,
          children: _dashBoardController.screens,
        ),
        // AnimatedSwitcher(
        //   duration: Duration(milliseconds: 300),
        //   child: _dashBoardController
        //       .screens[_dashBoardController.selectedIndex.value],
        //   transitionBuilder: (child, animation) {
        //     return SlideTransition(
        //       position: Tween<Offset>(
        //         begin: Offset(1.0, 0.0),
        //         end: Offset(0.0, 0.0),
        //       ).animate(animation),
        //       child: child,
        //     );
        //   },
        // ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white.withOpacity(0.5),
          items: _dashBoardController.bottomNavBarItems,
          currentIndex: _dashBoardController.selectedIndex.value,
          selectedItemColor: Colors.blue,
          // onTap: (index) {
          //   // Slide left animation
          //   if (index > _dashBoardController.selectedIndex.value) {
          //     Get.to(() => _dashBoardController.screens[index],
          //         transition: Transition.leftToRight);
          //   } else {
          //     Get.to(() => _dashBoardController.screens[index],
          //         transition: Transition.rightToLeft);
          //   }
          //   _dashBoardController.selectedIndex.value = index;
          // },
          onTap: _dashBoardController.changeTabIndex,
        ),
      ),
    );
  }
}

class IndexStackWithFadeAnimation extends StatefulWidget {
  const IndexStackWithFadeAnimation({
    Key? key,
    required this.index,
    required this.children,
  }) : super(key: key);

  final int index;
  final List<Widget> children;

  @override
  State<IndexStackWithFadeAnimation> createState() =>
      _IndexStackWithFadeAnimationState();
}

class _IndexStackWithFadeAnimationState
    extends State<IndexStackWithFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(IndexStackWithFadeAnimation oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset(0.0, 0.0),
      ).animate(_controller),
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
    // FadeTransition(
    //   opacity: _controller,
    //   child: IndexedStack(
    //     index: widget.index,
    //     children: widget.children,
    //   ),
    // );
  }
}
