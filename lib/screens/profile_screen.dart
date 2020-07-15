import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylibrary/components/app_drawer.dart';
import 'package:mylibrary/components/categorie_listtile.dart';
import 'package:mylibrary/screens/book_screen.dart';
import 'package:mylibrary/screens/editprofile_screen.dart';
import 'package:mylibrary/screens/home_screen.dart';
import 'package:mylibrary/screens/reviews_screen.dart';
import 'package:mylibrary/services/librarydata.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile_screen';
  static var friendInfos;
  static String userid = 'f5851828-c1f1-4ff2-8e58-144448fa9969';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showActivity = false;
  bool isCurrentUser;
  bool isLoading;
  bool isMyFriend;

  LibraryModel libraryModel = LibraryModel();
  Future checkfriendship() async {
    bool result = false;
    var data = await libraryModel.getFriends(HomeScreen.userid, '');

    for (int i = 0; i < data['docs'].length; i++) {
      if (data['docs'][i]['_id'] == ProfileScreen.userid) {
        setState(() {
          result = true;
        });
      }
    }
    return result;
  }

  _showMaterialDialog(String id, String name) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(),
              title: new Text("Unfollow"),
              content: new Text("Do you want to Unfollow \n" + name + " ?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Stop Following'),
                  onPressed: () async {
                    await libraryModel.addFriend(id);
                    setState(() {
                      isMyFriend = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  void initData() async {
    setState(() {
      isLoading = true;
    });
    ProfileScreen.friendInfos =
        await libraryModel.getUser(ProfileScreen.userid);
    var res = await checkfriendship();

    setState(() {
      isCurrentUser =
          (HomeScreen.userInfos['_id'] == ProfileScreen.friendInfos['_id']);
      isMyFriend = res;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        username: HomeScreen.username,
        profilepicture: HomeScreen.profilepic,
        selecteditem: 'Profile',
      ),
      body: (isLoading)
          ? (Center(
              child: CircularProgressIndicator(),
            ))
          : Stack(
              children: <Widget>[
                Container(
                  color: Color(0xFFF2F4F3),
                  alignment: Alignment.topCenter,
                  padding:
                      new EdgeInsets.only(top: 150, right: 10.0, left: 10.0),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'images/cancel.png',
                      width: 50,
                      height: 90,
                    ),
                  ),
                ),
                Container(
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
                  margin: EdgeInsets.only(top: 170, right: 10.0, left: 10),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        child: Text(
                          '@' + ProfileScreen.friendInfos['login']['username'],
                          style: GoogleFonts.redHatDisplay(
                              textStyle: TextStyle(fontSize: 20)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (isCurrentUser)
                          ? Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, EditProfileScreen.id);
                                },
                                child: Container(
                                  color: Colors.blue,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Edit profile',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.only(
                                      top: 2, left: 10, right: 10, bottom: 2),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () async {
                                  if (isMyFriend) {
                                    _showMaterialDialog(
                                        ProfileScreen.friendInfos['_id'],
                                        ProfileScreen.friendInfos['name']
                                                ['first'] +
                                            ' ' +
                                            ProfileScreen.friendInfos['name']
                                                ['last']);
                                  } else {
                                    await libraryModel.addFriend(
                                        ProfileScreen.friendInfos['_id']);
                                    setState(() {
                                      isMyFriend = true;
                                    });
                                  }
                                },
                                child: Container(
                                  color:
                                      (isMyFriend) ? Colors.green : Colors.blue,
                                  child: Text(
                                    (isMyFriend) ? 'Stop Following' : 'Follow',
                                    style: GoogleFonts.pacifico(
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                  padding: EdgeInsets.only(
                                      top: 2, left: 10, right: 10, bottom: 2),
                                ),
                              ),
                            ),
                      Container(
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: CategorieListTile(
                                    name: 'About',
                                    selected: !showActivity,
                                    onClick: () {
                                      setState(() {
                                        showActivity = false;
                                      });
                                    })),
                            Expanded(
                              child: CategorieListTile(
                                name: "Activity",
                                selected: showActivity,
                                onClick: () {
                                  setState(() {
                                    showActivity = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      (!showActivity)
                          ? Expanded(
                              child: ListView(
                                children: <Widget>[
                                  InfoItem(
                                    data: ProfileScreen.friendInfos['name']
                                            ['first'] +
                                        ' ' +
                                        ProfileScreen.friendInfos['name']
                                            ['last'],
                                    icon: Icons.person,
                                  ),
                                  (isCurrentUser)
                                      ? InfoItem(
                                          data: ProfileScreen
                                              .friendInfos['email'],
                                          icon: Icons.alternate_email,
                                        )
                                      : SizedBox(
                                          height: 0.1,
                                        ),
                                  InfoItem(
                                    data:
                                        (ProfileScreen.friendInfos['gender'] ==
                                                'M')
                                            ? 'Male'
                                            : 'Female',
                                    icon:
                                        (ProfileScreen.friendInfos['gender'] ==
                                                'M')
                                            ? FontAwesomeIcons.mars
                                            : FontAwesomeIcons.venus,
                                  ),
                                  InfoItem(
                                    data: ProfileScreen.friendInfos['mobile'],
                                    icon: Icons.phone_iphone,
                                  ),
                                  InfoItem(
                                    data: ProfileScreen.friendInfos['dob']
                                                ['age']
                                            .toString() +
                                        ' years old',
                                    icon: Icons.timelapse,
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount:
                                    ProfileScreen.friendInfos['rating'].length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        BookScreen.bookid =
                                            ProfileScreen.friendInfos['rating']
                                                [index]['idBook'];
                                      });
                                      Navigator.pushNamed(
                                          context, ReviewsScreen.id);
                                    },
                                    child: ListTile(
                                      title: generatestars(
                                          ProfileScreen.friendInfos['rating']
                                              [index]['rate']),
                                      trailing: Image.network(
                                        ProfileScreen.friendInfos['rating']
                                            [index]['image'],
                                        width: 45,
                                        fit: BoxFit.fill,
                                      ),
                                      subtitle: Text(
                                          ProfileScreen.friendInfos['rating']
                                              [index]['title']),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(140)),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            ProfileScreen.friendInfos['picture']['large']),
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
                    height: 170,
                    width: 160,
                  ),
                ),
              ],
            ),
    );
  }
}

class InfoItem extends StatelessWidget {
  InfoItem({this.data, this.icon});

  final String data;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.blue,
      ),
      title: Text(
        data,
        style: GoogleFonts.openSans(),
      ),
    );
  }
}

Widget generatestars(int number) {
  int tmp = 5 - number;
  return Container(
    child: Row(
      children: <Widget>[
        for (int i = 0; i < number; i++)
          Icon(
            Icons.star,
            size: 20,
            color: Colors.yellow,
          ),
        for (int j = 0; j < tmp; j++)
          Icon(
            Icons.star_border,
            size: 20,
            color: Colors.yellow,
          ),
      ],
    ),
  );
}
