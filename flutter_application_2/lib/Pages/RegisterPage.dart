import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();


  bool _firstNameError = false;
  bool _lastNameError = false;
  bool _emailError = false;
  bool _passwordError = false;
  bool _phoneNumberError = false;

  String _passwordErrorMessage = '';
  String _phoneNumberErrorMessage = '';
  String _emailErrorMessage = '';

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isTeacher = false;

Future<void> _register() async {
  final firstName = _firstNameController.text.trim();
  final lastName = _lastNameController.text.trim();
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();
  final phoneNumber = _phoneNumberController.text.trim();

  if (firstName.isEmpty ||
      lastName.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      phoneNumber.isEmpty) {
    // Show error message for empty fields
    setState(() {
      _firstNameError = firstName.isEmpty;
      _lastNameError = lastName.isEmpty;
      _emailError = email.isEmpty;
      _passwordError = password.isEmpty;
      _phoneNumberError = phoneNumber.isEmpty;
    });
    return;
  }

  // Show a loading indicator
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent user from dismissing the dialog
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    // Check if the user with the same email exists
    final emailExists = await _checkUserExists(email);
    if (emailExists) {
      // Hide the loading indicator
      Navigator.pop(context);

      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A user with the same email already exists.'),
        ),
      );
      return;
    }

    // Check if the user with the same phone number exists
    final phoneNumberExists = await _checkUserExists(phoneNumber);
    if (phoneNumberExists) {
      // Hide the loading indicator
      Navigator.pop(context);

      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A user with the same phone number already exists.'),
        ),
      );
      return;
    }

    // Create a new user
    final authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

        // Store whether the user is a teacher or not in Firestore
    await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
      'isTeacher': isTeacher,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    });

    // Successfully registered, show a SnackBar and navigate to the Login page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration successful!'),
      ),
    );


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  } catch (e) {
    // Hide the loading indicator
    Navigator.pop(context);

    // Handle Firebase authentication errors here
    if (e is FirebaseAuthException) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          _emailError = true;
        });
      } else {
        print(e.message);
      }
    }
  }
}

Future<bool> _checkUserExists(String field) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: field)
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print(e.toString());
    return false;
  }
}



  double _firstNameOpacity = 0.0;
  double _lastNameOpacity = 0.0;
  double _emailOpacity = 0.0;
  double _passwordOpacity = 0.0;
  double _phoneNumberOpacity = 0.0;
  double _registerButtonOpacity = 0.0;
  double _iconButtonOpacity = 0.0;
  double _registerTextOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Delayed animations to create the slide-in and fade-in effect
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _firstNameOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _lastNameOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 1100), () {
      setState(() {
        _emailOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 1400), () {
      setState(() {
        _passwordOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 1700), () {
      setState(() {
        _phoneNumberOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 2300), () {
      setState(() {
        _registerButtonOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 2600), () {
      setState(() {
        _registerTextOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _iconButtonOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    AnimatedOpacity(
                      opacity: _iconButtonOpacity,
                      duration: Duration(milliseconds: 500),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0.0, 0.2),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: ModalRoute.of(context)!.animation!,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    AnimatedOpacity(
                      opacity: _registerTextOpacity,
                      duration: Duration(milliseconds: 500),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0.0, 0.2),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: ModalRoute.of(context)!.animation!,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                AnimatedOpacity(
                  opacity: _firstNameOpacity,
                  duration: Duration(milliseconds: 500),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _firstNameError ? Colors.red : Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: _firstNameError ? 'First Name cannot be empty' : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedOpacity(
                  opacity: _lastNameOpacity,
                  duration: Duration(milliseconds: 500),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _lastNameError ? Colors.red : Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: _lastNameError ? 'Last Name cannot be empty' : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedOpacity(
                  opacity: _emailOpacity,
                  duration: Duration(milliseconds: 500),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _emailError ? Colors.red : Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: _emailError ? 'Email cannot be empty' : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedOpacity(
                  alwaysIncludeSemantics: true,
                  opacity: _passwordOpacity,
                  duration: Duration(milliseconds: 500),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _passwordError ? Colors.red : Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: _passwordError ? 'Password cannot be empty' : null,
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedOpacity(
                  opacity: _phoneNumberOpacity,
                  duration: Duration(milliseconds: 500),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _phoneNumberError ? Colors.red : Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: _phoneNumberError ? 'Phone Number cannot be empty' : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),


 Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isTeacher ? Colors.blue[300] : Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1.2,
        ),
      ),
      child: MaterialButton(
        highlightColor: Colors.blue,
        splashColor: Colors.transparent,
        enableFeedback: !isTeacher, // Enable only if it's not already selected
        onPressed: () {
          setState(() {
            // Select teacher
            isTeacher = true;
          });
        },
        child: Row(
          children: [
            Icon(
              Icons.co_present_outlined,
              color: Colors.blue,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              'Teacher',
              style: TextStyle(
                color: isTeacher ? Colors.white : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ),
    AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: !isTeacher ? Colors.blue : Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1.2,
        ),
      ),
      child: MaterialButton(
        highlightColor: Colors.blue,
        splashColor: Colors.transparent,
        enableFeedback: isTeacher, // Enable only if it's not already selected
        onPressed: () {
          setState(() {
            isTeacher = false;
          });
        },
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.blue,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              'Student',
              style: TextStyle(
                color: !isTeacher ? Colors.white : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03,
                ),
                AnimatedOpacity(
                  opacity: _registerButtonOpacity,
                  duration: Duration(milliseconds: 500),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                      child: MaterialButton(
                        onPressed: _register,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
