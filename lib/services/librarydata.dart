import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mylibrary/screens/book_screen.dart';
import 'package:mylibrary/screens/friends_screen.dart';
import 'package:mylibrary/screens/home_screen.dart';

import 'networking.dart';
import 'package:mylibrary/constants.dart';

class LibraryModel {
  Future temp;

  Future<dynamic> loginUser(String username, String password) async {
    NetworkHelper networkHelper = NetworkHelper(url: '$localhost' + 'login');
    final jsonStr = jsonEncode({"username": username, "password": password});
    return await networkHelper.postData(jsonStr);
  }

  Future<dynamic> getBook(String id) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$localhost' + 'book/' + '$id');
    return await networkHelper.getData();
  }

  Future<dynamic> getBooks(String key, String page, String size) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$localhost' +
            'book?cle=' +
            ((key == null) ? '' : key) +
            '&page=' +
            page +
            '&size=' +
            size);
    return await networkHelper.getData();
  }
  Future<dynamic> getUsers(String key) async {
    NetworkHelper networkHelper =
    NetworkHelper(url: '$localhost' + 'reader?cle=' + key);
    return await networkHelper.getData();
  }

  Future<dynamic> getUser(String id) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$localhost' + 'reader/' + '$id');
    return await networkHelper.getData();
  }

  Future<dynamic> editUser(String id, var editable) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$localhost' + 'reader/' + '$id');
    final jsonStr = jsonEncode(editable);
    return await networkHelper.putData(jsonStr);
  }

  Future<dynamic> getCategories(String key) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$localhost' + 'book/categories?cle=' + key);
    return await networkHelper.getData();
  }

  Future<dynamic> getBooksByCategorie(String cat, String key) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$localhost' +
            'book/categories/' +
            cat +
            '?cle=' +
            ((key == null) ? '' : key));
    return await networkHelper.getData();
  }

  Future<dynamic> getUserBooks(String type, String userId, String key) async {
    //type : favorite,encours,lireplustard
    NetworkHelper networkHelper = NetworkHelper(
        url: '$localhost' + 'book/' + type + '?id=' + userId + '&cle=' + key);
    return await networkHelper.getData();
  }

  Future<dynamic> addUserBook(String type, String idBook) async {
    //type : favorite,encours,lireplustard
    NetworkHelper networkHelper =
        NetworkHelper(url: '$localhost' + 'reader/' + type);
    final jsonStr = jsonEncode({
      "user": {"_id": HomeScreen.userid},
      "id": idBook
    });
    return await networkHelper.postData(jsonStr);
  }

  Future<dynamic> getFriends(String userId, String key) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$localhost' + 'reader/getfriend?id=' + userId + '&cle=' + key);
    return await networkHelper.getData();
  }

  Future<dynamic> addFriend(String idfriend) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$localhost' + 'reader/addfriend');
    final jsonStr = jsonEncode({
      "user": {"_id": HomeScreen.userid},
      "id": idfriend
    });
    return await networkHelper.putData(jsonStr);
  }

  Future<dynamic> addReview(String comment, int rate) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$localhost' + 'book/rate');
    final jsonStr = jsonEncode({
      "idBook": BookScreen.bookid,
      "comment": comment,
      "rate": rate,
      "id": HomeScreen.userid
    });
    return await networkHelper.putData(jsonStr);
  }
}
