import 'package:flutter/material.dart';
import 'package:mylibrary/screens/book_screen.dart';
import 'package:mylibrary/screens/books_screen.dart';
import 'package:mylibrary/screens/categories_screen.dart';
import 'package:mylibrary/screens/editprofile_screen.dart';
import 'package:mylibrary/screens/favorites_screen.dart';
import 'package:mylibrary/screens/friends_screen.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/loading_screen.dart';
import 'package:mylibrary/screens/login_screen.dart';
import 'package:mylibrary/screens/profile_screen.dart';
import 'package:mylibrary/screens/reading_screen.dart';
import 'package:mylibrary/screens/readlater_screen.dart';
import 'package:mylibrary/screens/registration_screen.dart';
import 'package:mylibrary/screens/reviews_screen.dart';
import 'package:mylibrary/screens/users_screen.dart';
import 'package:mylibrary/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        BooksScreen.id: (context) => BooksScreen(),
        BookScreen.id: (context) => BookScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        CategoriesScreen.id: (context) => CategoriesScreen(),
        ReviewsScreen.id: (context) => ReviewsScreen(),
        FavoritesScreen.id: (context) => FavoritesScreen(),
        ReadLaterScreen.id: (context) => ReadLaterScreen(),
        ReadingScreen.id: (context) => ReadingScreen(),
        FriendsScreen.id: (context) => FriendsScreen(),
        UsersScreen.id: (context) => UsersScreen(),
      },
    );
  }
}
