import 'package:flutter/cupertino.dart';

class NavBarItem {
  const NavBarItem({
    @required this.label,
    @required this.unselectedIcon,
    @required this.selectedIcon,
  });

  final String label;
  final IconData unselectedIcon;
  final IconData selectedIcon;
}
