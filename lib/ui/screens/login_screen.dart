import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_roomate/data/db/remote/response.dart';
import 'package:project_roomate/data/provider/user_provider.dart';
import 'package:project_roomate/ui/screens/top_navigation_screen.dart';
import 'package:project_roomate/ui/widgets/bordered_text_field.dart';
import 'package:project_roomate/ui/widgets/custom_modal_progress_hud.dart';
import 'package:project_roomate/ui/widgets/rounded_button.dart';
import 'package:project_roomate/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';




class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
   String? errorMessage = '';
   bool islogin = true;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _inputEmail = '';
  String _inputPassword = '';
  bool _isLoading = false;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of(context, listen: false);
  }

  void loginPressed() async {
    setState(() {
      _isLoading = true;
    });
    await _userProvider
        .loginUser(_inputEmail, _inputPassword, _scaffoldKey)
        .then((response) {
      if (response is Success<UserCredential>) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(TopNavigationScreen.id, (route) => false);
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: CustomModalProgressHUD(
          inAsyncCall: _isLoading,
          key: _scaffoldKey,
          offset: Offset.fromDirection(1.0),

          child: Padding(
            padding: kDefaultPadding,
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to your account',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: 40),
                  BorderedTextField(
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => _inputEmail = value,
                  ),
                  SizedBox(height: 5),
                  BorderedTextField(
                    labelText: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => _inputPassword = value,
                  ),
                  Expanded(child: Container()),
                  RoundedButton(text: 'LOGIN', onPressed: () => loginPressed())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
