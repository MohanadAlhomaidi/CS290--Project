import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/HomePage.dart';
import 'package:flutter_application_2/Pages/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _emailError = false;
  bool _passwordError = false;

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show error message and change border color to red
      setState(() {
        _emailError = email.isEmpty;
        _passwordError = password.isEmpty;
      });
      return;
    }

    try {
      // Perform Firebase login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      SnackBar snackBar = SnackBar(
        content: Text('Logged in successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Successfully logged in, navigate to the home page
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          // Replace 'HomePage()' with your actual home page widget
          return HomePage();
        },
      ));
    } catch (e) {
      // Handle Firebase authentication errors here
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          // Show error message and change border color to red
          setState(() {
            _emailError = true;
            _passwordError = true;
          });
          SnackBar snackBar = SnackBar(
            content: Text('Invalid email or password'),
          );
        } else {
          // Handle other Firebase authentication errors
          print(e.message);
        }
      }
    }
  }

  double _emailOpacity = 0.0;
  double _passwordOpacity = 0.0;
  double _loginButtonOpacity = 0.0;
  double _forgotPasswordOpacity = 0.0;
  double _additionalButtonsOpacity = 0.0;
  double _iconButtonOpacity = 0.0;
  double _loginTextOpacity = 0.0;
  double _isInstructorOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Delayed animations to create the slide-in and fade-in effect
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _emailOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        _passwordOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 700), () {
      setState(() {
        _loginButtonOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _forgotPasswordOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        _additionalButtonsOpacity = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _iconButtonOpacity = 1.0;
        _loginTextOpacity = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 1100), () {
      setState(() {
        _isInstructorOpacity = 1.0;
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
              top: MediaQuery.of(context).size.height * 0.13,
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
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    AnimatedOpacity(
                      opacity: _loginTextOpacity,
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
                            'Login',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
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
                          borderSide: BorderSide(
                              color: _emailError ? Colors.red : Colors.blue),
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
                          borderSide: BorderSide(
                              color: _passwordError ? Colors.red : Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText:
                            _passwordError ? 'Password cannot be empty' : null,
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedOpacity(
                  opacity: _loginButtonOpacity,
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
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          _login(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _forgotPasswordOpacity,
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
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password?'),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedOpacity(
                  opacity: _additionalButtonsOpacity,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterPage();
                              }));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        
                                SizedBox(height: 16.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              
              ],
          

      ),
    );
  }
}
