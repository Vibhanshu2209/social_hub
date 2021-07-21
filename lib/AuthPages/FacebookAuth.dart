import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthent extends StatefulWidget {
  const FacebookAuthent({Key? key}) : super(key: key);

  @override
  _FacebookAuthState createState() => _FacebookAuthState();
}

bool _isUserLoggedIn = false;
Map _userObj = {};

class _FacebookAuthState extends State<FacebookAuthent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Vx.white),
            borderRadius: BorderRadius.circular(40)),
        child: _isUserLoggedIn ? _buildProfile() : _buildSignInPage());
  }

  Widget _buildProfile() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      FadeInImage.assetNetwork(
              imageScale: 1.1,
              placeholder: "Profile Pic",
              image: _userObj["picture"]["data"]["url"])
          .cornerRadius(28),
      Column(
        children: [
          _userObj["name"]
              .toString()
              .text
              .white
              .fontFamily('Rubik')
              .minFontSize(24)
              .makeCentered(),
          _userObj["email"] == null
              ? "No connected email"
                  .text
                  .blueGray700
                  .fontFamily('Rubik')
                  .minFontSize(16)
                  .makeCentered()
              : _userObj["email"]
                  .toString()
                  .text
                  .warmGray100
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
        backgroundColor: Vx.blue400,
      ).p24().onTap(() {
        _handleSignOut();
      })
    ]);
  }

  Widget _buildSignInPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FadeInImage.assetNetwork(
          imageScale: 5,
          placeholder: "Facebook",
          image:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fclassicrock995.com%2Fwp-content%2Fuploads%2F2020%2F11%2FFacebook-logo.png&f=1&nofb=1',
        ),
        VxCapsule(
          child:
              "Sign In".text.fontFamily('rubik').minFontSize(14).makeCentered(),
          height: 48,
          backgroundColor: Vx.blue600,
        ).centered().p24().onTap(() {
          _handleSignIn();
        }),
      ],
    );
  }

  Future<void> _handleSignIn() async {
    FacebookAuth.instance.login(permissions: ["public_profile"]).then((value) =>
        FacebookAuth.instance.getUserData().then((data) => setState(() {
              _isUserLoggedIn = true;
              _userObj = data;
            })));
  }

  Future<void> _handleSignOut() async {
    setState(() {
      _isUserLoggedIn = false;
      FacebookAuth.instance.logOut();
    });
  }
}
