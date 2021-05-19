import 'package:cookbook_app/constants.dart';
import 'package:cookbook_app/models/nav_bar_item.dart';
import 'package:cookbook_app/pages/add_dish.dart';
import 'package:cookbook_app/pages/edit_profile.dart';
import 'package:cookbook_app/screens/auth/auth_one.dart';
import 'package:cookbook_app/screens/favs/favs.dart';
import 'package:cookbook_app/screens/profile/profile.dart';
import 'package:cookbook_app/screens/recipes/recipes.dart';
import 'package:cookbook_app/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:cookbook_app/utils.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<NavBarItem> navBarItems = [
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

  PageController _pageController = PageController();

  int _navIndex = 0;

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
            Utils().getPageTitle(_navIndex),
            style: TextStyle(
              color: Colors.green[600],
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        drawerScrimColor: Colors.green[600].withOpacity(0.7),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            switch (index) {
              case 0:
                _pageController.animateToPage(0, duration: Duration(milliseconds: 1000), curve: Curves.easeInSine);
                setState(() {
                  _navIndex = 0;
                });
                break;
              case 1:
                _pageController.animateToPage(1, duration: Duration(milliseconds: 1000), curve: Curves.easeInSine);
                setState(() {
                  _navIndex = 1;
                });
                break;
              case 2:
                _pageController.animateToPage(2, duration: Duration(milliseconds: 1000), curve: Curves.easeInSine);
                setState(() {
                  _navIndex = 2;
                });
                break;
              default:
                break;
            }
          },
          currentIndex: _navIndex,
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
                            FutureBuilder<SharedPreferences>(
                              future: SharedPreferences.getInstance(),
                              builder: (cx, prefs) {
                                return Container(
                                  padding: EdgeInsets.all(2.5),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 15,
                                        color: Colors.green[600],
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: prefs.data.getString('pfpUrl').isEmptyOrNull
                                        ? Icon(
                                            Icons.person,
                                            size: 40,
                                            color: Colors.green[300],
                                          )
                                        : Container(),
                                    backgroundImage: prefs.data.getString('pfpUrl').isEmptyOrNull
                                        ? null
                                        : NetworkImage(prefs.data.getString('pfpUrl')),
                                    backgroundColor: Colors.white38,
                                  ),
                                );
                              },
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
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  SharedPreferences _prefs = await SharedPreferences.getInstance();
                                  _prefs.clear();
                                  AuthOne().launch(context);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () => EditProfilePage(
                                  Constants.editTitleForProfilePage,
                                ).launch(
                                  context,
                                ),
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
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add a dish'),
          icon: Icon(Icons.add),
          onPressed: () => AddDish().launch(context),
        ),
        body: PageView(
          controller: _pageController,
          children: [
          Recipes(),
            Favourites(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
