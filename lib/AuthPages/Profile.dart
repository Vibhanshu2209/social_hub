import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Vx.white),
            borderRadius: BorderRadius.circular(40)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                // alignment: Alignment.topCenter,
                image: AssetImage('assets/Rectangle 1.png'),
              ),
              "My Resume".text.fontFamily("Rubik").warmGray200.makeCentered(),
              VxCapsule(
                child: "View LinkedIn Profile"
                    .text
                    .fontFamily('rubik')
                    .minFontSize(14)
                    .makeCentered(),
                height: 48,
                backgroundColor: Vx.blueGray600,
              ).centered().p24().onTap(() {
                _launchURL();
              }),
            ],
          ),
        ));
  }

  final _url = "https://www.linkedin.com/in/vibhanshu-chawla";

  Future<void> _launchURL() async => await url.canLaunch(_url)
      ? await url.launch(_url)
      : throw 'Could not launch $_url';
}
