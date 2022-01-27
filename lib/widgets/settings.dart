import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 50,
            color: Theme.of(context).accentColor,
          ),
        ),
        SizedBox(height: 20),
        SwitchListTile(
          value: true,
          title: Text(
            'Sound effects',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onChanged: (bool value) {},
        ),
        SwitchListTile(
          value: true,
          title: Text(
            'Background music',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onChanged: (bool value) {},
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
