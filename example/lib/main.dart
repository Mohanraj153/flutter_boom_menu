import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_boom_menu/flutter_boom_menu.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), title: 'Boom Menu Example'));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  ScrollController scrollController;
  bool scrollVisible = true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection == ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      scrollVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  BoomMenu buildBoomMenu() {
    return BoomMenu(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      //child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      scrollVisible: scrollVisible,
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      children: [
        MenuItem(
//          child: Icon(Icons.accessibility, color: Colors.black, size: 40,),
          child: Image.asset('assets/logout_icon.png', color: Colors.grey[850]),
          title: "Logout",
          titleColor: Colors.grey[850],
          subtitle: "Lorem ipsum dolor sit amet, consectetur",
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.grey[50],
          onTap: () => print('THIRD CHILD'),
        ),
        MenuItem(
          child: Image.asset('assets/schemes_icon.png', color: Colors.white),
          title: "List",
          titleColor: Colors.white,
          subtitle: "Lorem ipsum dolor sit amet, consectetur",
          subTitleColor: Colors.white,
          backgroundColor: Colors.pinkAccent,
          onTap: () => print('FOURTH CHILD'),
        ),
        MenuItem(
          child: Image.asset('assets/customers_icon.png', color: Colors.grey[850]),
          title: "Team",
          titleColor: Colors.grey[850],
          subtitle: "Lorem ipsum dolor sit amet, consectetur",
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.grey[50],
          onTap: () => print('THIRD CHILD'),
        ),
        MenuItem(
          child: Image.asset('assets/profile_icon.png', color: Colors.white),
          title: "Profile",
          titleColor: Colors.white,
          subtitle: "Lorem ipsum dolor sit amet, consectetur",
          subTitleColor: Colors.white,
          backgroundColor: Colors.blue,
          onTap: () => print('FOURTH CHILD'),
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Boom Menu Example')),
      body: buildBody(),
      floatingActionButton: buildBoomMenu(),
    );
  }
}
