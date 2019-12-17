# Flutter Boom Menu

## Usage

The BoomMenu widget is built to be placed in the `Scaffold.floatingActionButton` argument, replacing the `FloatingActionButton` widget.
It's not possible to set its position with the `Scaffold.floatingActionButtonLocation` argument, but it's possible to set right/bottom margin with the `marginRight` and `marginBottom` arguments (default to 16) to place the button anywhere in the screen.
Using the `Scaffold.bottomNavigationBar` the floating button will be always placed above the bar, so the `BottomAppBar.hasNotch` should be always `false`.

**Title**

Every child button can have a `Icon`,`Title`, `SubTitle` which can be customized providing by yourself. If the `Title` parameter is not provided the title will be not rendered.

The package will handle the animation by itself.

![alt text](https://github.com/ralphnoel13/flutter_boom_menu/blob/master/screenshot/ezgif.com-video-to-gif.gif)

**Example Usage ( complete with all params ):**

```dart
Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: BoomMenu(
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
          child: Icon(Icons.accessibility, color: Colors.black),
          title: "Profiles",
          titleColor: Colors.white,
          subtitle: "You Can View the Noel Profile",
          subTitleColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          onTap: () => print('FIRST CHILD'),
        ),
        MenuItem(
          child: Icon(Icons.brush, color: Colors.black),
          title: "Profiles",
          titleColor: Colors.white,
          subtitle: "You Can View the Noel Profile",
          subTitleColor: Colors.white,
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
        ),
        MenuItem(
          child: Icon(Icons.keyboard_voice, color: Colors.black),
          title: "Profile",
          titleColor: Colors.white,
          subtitle: "You Can View the Noel Profile",
          subTitleColor: Colors.white,
          backgroundColor: Colors.blue,
          onTap: () => print('THIRD CHILD'),
        ),
        MenuItem(
          child: Icon(Icons.ac_unit, color: Colors.black),
          title: "Profiles",
          titleColor: Colors.white,
          subtitle: "You Can View the Noel Profile",
          subTitleColor: Colors.white,
          backgroundColor: Colors.blue,
          onTap: () => print('FOURTH CHILD'),
        )
      ],
    ),
    );
}
```
## Issues & Feedback

Please file an [issue](https://github.com/ralphnoel13/flutter_boom_menu/issues) to send feedback or report a bug. Thank you!

## Contributing

Every pull request is welcome.