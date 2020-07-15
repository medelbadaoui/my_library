import 'package:flutter/material.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

import '../constants.dart';
import 'books_screen.dart';

class CategoriesScreen extends StatefulWidget {
  static const id = 'categories_screen';
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  LibraryModel libraryModel = LibraryModel();
  String key = '';
  var keys = [];
  var values = [];
  bool isLoading;

  Future getindexofkey() async {
    var tab = await libraryModel.getCategories('');

    int indexCat = tab.keys.toList().indexOf(BooksScreen.pagecategorie);

    return indexCat;
  }

  void initkeysvalues(String key) async {
    setState(() {
      isLoading = true;
    });
    var tab = await libraryModel.getCategories(key);
    setState(() {
      keys = tab.keys.toList();
      values = tab.values.toList();
      isLoading = false;
    });
  }

  void setkeysvalues(String key) async {
    var tab = await libraryModel.getCategories(key);
    setState(() {
      keys = tab.keys.toList();
      values = tab.values.toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initkeysvalues(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        username: HomeScreen.username,
        profilepicture: HomeScreen.profilepic,
        selecteditem: 'Home',
      ),
      resizeToAvoidBottomPadding: false,
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Color(0xFF2F4F3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Image.asset(
                        'images/back.png',
                        width: 50,
                        height: 90,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: const Offset(0, 0),
                            blurRadius: 0.1,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              width: 300,
                              child: TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    //Do something with the user input.

                                    setState(() {
                                      setkeysvalues(value);
                                      key = value;
                                    });
                                  },
                                  decoration: kSearchFieldDecoration.copyWith(
                                      hintText: 'Search')),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                            future: libraryModel.getCategories(key),
                            builder: (context, snapshot) {
                              Map data = snapshot.data;
                              if (snapshot.hasError)
                                return CircularProgressIndicator();
                              if (snapshot.hasData) {
                                return Expanded(
                                  flex: 6,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          BooksScreen.pagecategorie =
                                              keys[index];

                                          var tmp = await getindexofkey();

                                          setState(() {
                                            BooksScreen.pagecategorie =
                                                keys[index];
                                            BooksScreen.categorieindex = tmp;
                                          });

                                          Navigator.pushNamed(
                                              context, BooksScreen.id);
                                        },
                                        child: Card(
                                          child: ListTile(
                                            title: Text('${keys[index]}'),
                                            trailing:
                                                Text('${values[index]} Books'),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: data.length,
                                  ),
                                );
                              }
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Text("No results for " + ' $key ');
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
