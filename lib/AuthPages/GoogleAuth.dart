import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class GoogleAuth extends StatefulWidget {
  const GoogleAuth({Key? key}) : super(key: key);

  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  GoogleSignInAccount? user;
  bool _isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Vx.white),
            borderRadius: BorderRadius.circular(40)),
        child: _isUserLoggedIn != false
            ? _buildProfile(user)
            : _buildSignInPage());
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.signOut().then((value) {
      setState(() {
        _isUserLoggedIn = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _handleSignIn() async {
    try {
      _googleSignIn.signIn().then((value) {
        setState(() {
          _isUserLoggedIn = true;
          user = value;
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Widget _buildSignInPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FadeInImage.assetNetwork(
          imageScale: 5,
          placeholder: "Google",
          image:
              'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png',
        ),
        VxCapsule(
          child:
              "Sign In".text.fontFamily('rubik').minFontSize(14).makeCentered(),
          height: 48,
          backgroundColor: Vx.red300,
        ).centered().p24().onTap(() {
          _handleSignIn();
        }),
      ],
    );
  }

  Widget _buildProfile(GoogleSignInAccount? user) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      FadeInImage.assetNetwork(
              imageScale: 0.55,
              placeholder: "Profile Pic",
              image: user!.photoUrl.toString())
          .cornerRadius(28),
      Column(
        children: [
          user.displayName!.text.white
              .fontFamily('Rubik')
              .minFontSize(24)
              .makeCentered(),
          user.email.text.warmGray100
              .fontFamily('Rubik')
              .minFontSize(16)
              .makeCentered()
              .p16(),
        ],
      ),
      VxCapsule(
        child:
            "Sign Out".text.fontFamily('rubik').minFontSize(14).makeCentered(),
        height: 48,
        backgroundColor: Vx.red300,
      ).p24().onTap(() {
        _handleSignOut();
      })
    ]);
  }
}
