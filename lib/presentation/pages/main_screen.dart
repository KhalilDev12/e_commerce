import 'package:e_commerce/presentation/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends StatefulWidget {
  final int index;

  MainScreen({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller = PersistentTabController();

  // List of Screens
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      WishlistScreen(),
      CartScreen(),
      UserScreen(),
    ];
  }

// List of Bottom NavigationBar Items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _buildBottomNavBarItem(icon: Icons.home_outlined, title: "Home"),
      _buildBottomNavBarItem(icon: Icons.favorite_outline, title: "Wishlist"),
      _buildBottomNavBarItem(icon: Icons.shopping_cart_outlined, title: "Cart"),
      _buildBottomNavBarItem(icon: Icons.person_outline, title: "Profile"),
    ];
  }

  PersistentBottomNavBarItem _buildBottomNavBarItem(
      {required IconData icon, required String title}) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: title,
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.jumpToTab(widget.index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      hideNavigationBarWhenKeyboardShows: false,
      resizeToAvoidBottomInset: true,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style3,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
