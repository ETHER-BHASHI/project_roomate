import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void>signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('HELLO USER');
  }

  Widget _userUid() {
    return  Text(user?.email?? 'user email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: signOut,
        child: const Text('sign out'),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
