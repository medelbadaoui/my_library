import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/components/menu_item.dart';
import 'package:mylibrary/screens/favorites_screen.dart';
import 'package:mylibrary/screens/friends_screen.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/profile_screen.dart';
import 'package:mylibrary/screens/reading_screen.dart';
import 'package:mylibrary/screens/readlater_screen.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({this.username, this.profilepicture, this.selecteditem});
  final String username;
  final String profilepicture;
  final String selecteditem;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          border: Border.all(
            color: Colors.white,
          ),
          color: Color(0xFFF2F4F3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(0, 0),
              blurRadius: 0.1,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(140)),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(profilepicture),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: const Offset(0, 0),
                              blurRadius: 1.1,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        height: 120,
                        width: 120,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        username,
                        style: GoogleFonts.redHatDisplay(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView(
                          children: <Widget>[
                            MenuItem(
                              title: 'Home',
                              icon: Icons.home,
                              selected: (selecteditem == 'Home') ? true : false,
                              onClick: () {
                                Navigator.pushNamed(context, HomeScreen.id);
                              },
                            ),
                            MenuItem(
                              title: 'Profile',
                              icon: Icons.person,
                              selected:
                                  (selecteditem == 'Profile') ? true : false,
                              onClick: () {
                                ProfileScreen.userid = HomeScreen.userid;
                                Navigator.pushNamed(context, ProfileScreen.id);
                              },
                            ),
                            MenuItem(
                                title: 'Reading',
                                icon: Icons.library_books,
                                selected:
                                    (selecteditem == 'Reading') ? true : false,
                                onClick: () {
                                  Navigator.pushNamed(
                                      context, ReadingScreen.id);
                                }),
                            MenuItem(
                                title: 'Read later',
                                icon: Icons.bookmark,
                                selected: (selecteditem == 'Read later')
                                    ? true
                                    : false,
                                onClick: () {
                                  Navigator.pushNamed(
                                      context, ReadLaterScreen.id);
                                }),
                            MenuItem(
                              title: 'Favorites',
                              icon: Icons.star,
                              selected:
                                  (selecteditem == 'Favorites') ? true : false,
                              onClick: () {
                                Navigator.pushNamed(
                                    context, FavoritesScreen.id);
                              },
                            ),
                            MenuItem(
                                title: 'Friends',
                                icon: Icons.people,
                                selected:
                                    (selecteditem == 'Friends') ? true : false,
                                onClick: () {
                                  Navigator.pushNamed(
                                      context, FriendsScreen.id);
                                }),
                            SizedBox(
                              height: 50,
                            ),
                            MenuItem(
                              title: 'Settings',
                              icon: Icons.settings,
                              selected:
                                  (selecteditem == 'Settings') ? true : false,
                            ),
                            MenuItem(
                              title: 'Log out',
                              icon: Icons.exit_to_app,
                              selected: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
