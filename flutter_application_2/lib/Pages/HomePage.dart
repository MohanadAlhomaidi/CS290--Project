import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/Pages/LoginPage.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:auto_animated/auto_animated.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  // Define other light mode theme properties
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isDarkMode = false;
  TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0;
  bool? _IsTeacher;
  CollectionReference collection =
      FirebaseFirestore.instance.collection('https://console.firebase.google.com/u/0/project/projectsecourse34/database/projectsecourse34-default-rtdb/data/~2F');

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void fetchUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          _IsTeacher = userData.get('isTeacher');
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  Future<void> _logout() async {
    try {
      // Sign out the user
      auth.signOut();

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            LoginPage(), // Replace with your login page widget
      ));
    } catch (e) {
      // Handle any errors that occur during logout
      print('Error during logout: $e');
    }
  }

  Widget CourseContainer(
    String courseName,
    String description,
    String instructor,
    String imageUrl,
    String videoUrl,
    bool isFavorite,
    int rating,
  ) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  instructor,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer CustomDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.60,
      surfaceTintColor: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Contact us'),
            onTap: () {},
          ),

          if (_IsTeacher == true)
            ListTile(
              title: Text('Create Course'),
              onTap: () {
               setState(() {
                  collection.add(
                  {
                    'VidCom': 'Flutter is a cross-platform app development framework',
                    'VidTit': 'Flutter',
                    'VidDesc':
                        'Flutter is a cross-platform app development framework',
                    'VidImg':'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freecodecamp.org%2Fnews%2Fflutter-course%2F&psig=AOvVaw0QZ2Z2Q4Z3Z2Z2Z2Z2Z2Z2&ust=1634178979124000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJjQ4ZqH0_MCFQAAAAAdAAAAABAD',
                    'VidUrl': 'https://www.youtube.com/watch?v=Ib2FlirtcmE',
                  },
                );
               });
              },
            ),
          if (_IsTeacher == true)
            ListTile(
              title: Text('Create Quiz'),
              onTap: () {},
            ),
          if (_IsTeacher == true)
            ListTile(
              title: Text('Create Article'),
              onTap: () {},
            ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              toggleTheme(value);
            },
          ),
          MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            enableFeedback: false,
            onPressed: () {
              try {
                _logout();
              } catch (e) {
                print(e);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ],
            ),
            textColor: Colors.black,
          ),
          // Add more items as needed
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        enableFeedback: false,
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Icon(Icons.menu),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: AnimSearchBar(
                          closeSearchOnSuffixTap: true,
                          width: MediaQuery.of(context).size.width * 0.78,
                          boxShadow: false,
                          textController: _searchController,
                          helpText: "Search",
                          onSuffixTap: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          suffixIcon: Icon(Icons.clear),
                          // Your code to change the state of the widget
                          onSubmitted: (String) {
                            // Your code to change the state of the widget
                            print("Submitted");
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? Color.fromARGB(255, 226, 94, 94)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: selectedIndex == 0
                                  ? Colors.red
                                  : Colors.black,
                              width: 1,
                            ),
                          ),
                          child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            enableFeedback: false,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Text("Courses"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? Color.fromARGB(255, 226, 94, 94)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: selectedIndex == 1
                                  ? Colors.red
                                  : Colors.black,
                              width: 1,
                            ),
                          ),
                          child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            enableFeedback: false,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: Text("Quizzes"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: selectedIndex == 2
                                ? Color.fromARGB(255, 226, 94, 94)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: selectedIndex == 2
                                  ? Color.fromARGB(255, 238, 158, 152)
                                  : Colors.black,
                              width: 1,
                            ),
                          ),
                          child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            enableFeedback: false,
                            onPressed: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                            },
                            child: Text("Articles"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (selectedIndex == 0)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                if (selectedIndex == 0)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                        Container(
                          color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Container(
                          color: Colors.red,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ],
                    ),
                  ),
                if (selectedIndex == 1)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                if (selectedIndex == 1)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          color: Colors.green,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Container(
                          color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Container(
                          color: Colors.red,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        drawer: CustomDrawer(),
      ),
    );
  }
}
