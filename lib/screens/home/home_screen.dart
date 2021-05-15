import 'package:cookbook_app/models/nav_bar_item.dart';
import 'package:cookbook_app/pages/edit_profile.dart';
import 'package:cookbook_app/pages/settings.dart';
import 'package:cookbook_app/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatelessWidget {
  List<NavBarItem> navBarItems = [
    NavBarItem(
      label: 'Recipes',
      unselectedIcon: Icons.restaurant_menu_rounded,
      selectedIcon: Icons.restaurant_menu_rounded,
    ),
    NavBarItem(
      label: 'Favourites',
      unselectedIcon: Icons.favorite_border,
      selectedIcon: Icons.favorite,
    ),
    NavBarItem(
      label: 'Profile',
      unselectedIcon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 90,
        iconTheme: IconThemeData(color: Colors.green[500]),
        title: Text(
          'BROWSE',
          style: TextStyle(
            color: Colors.green[600],
            letterSpacing: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      drawerScrimColor: Colors.green.withOpacity(0.3),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 0:
            case 1:
            case 2:
          }
        },
        items: navBarItems
            .map(
              (navItem) => BottomNavigationBarItem(
                icon: Icon(navItem.unselectedIcon),
                activeIcon: Icon(navItem.selectedIcon),
                label: navItem.label,
              ),
            )
            .toList(),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              Container(
                width: SizeConfigs.horizontalFractions * 100,
                height: SizeConfigs.verticalFractions * 16,
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(color: Colors.green[200]),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white38,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Lomash Dubey\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                              ),
                              children: [
                                TextSpan(
                                  text: 'kanhadubey2@gmail.com',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w300,
                                    fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 150),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onPressed: () => SettingsPage().launch(context),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () => EditProfilePage().launch(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(),
    ));
  }
}
