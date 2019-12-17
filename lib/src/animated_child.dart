import 'package:flutter/material.dart';

class AnimatedChild extends AnimatedWidget {
  final int index;
  final Color backgroundColor;
  final double elevation;
  final Widget child;

  final bool visible;
  final VoidCallback onTap;
  final VoidCallback toggleChildren;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subTitleColor;

  AnimatedChild({
    Key key,
    Animation<double> animation,
    this.index,
    this.backgroundColor,
    this.elevation = 6.0,
    this.child,
    this.title,
    this.subtitle,
    this.visible = false,
    this.onTap,
    this.toggleChildren,
    this.titleColor,
    this.subTitleColor
  }) : super(key: key, listenable: animation);

  void _performAction() {
    if (onTap != null) onTap();
    toggleChildren();
  }

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    final Widget buttonChild = animation.value > 50.0
        ? Container(
          width: animation.value,
          height: animation.value,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: child ?? Container(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: (titleColor == null) ? Colors.black : titleColor, fontSize: 16.0),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: (subTitleColor == null) ? Colors.black : subTitleColor, fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
        : Container(
            width: 0.0,
            height: 0.0,
          );

    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 80.0,
      padding: EdgeInsets.only(bottom: 72 - animation.value),
      child: GestureDetector(
        onTap: _performAction,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          //width: animation.value,
          color: backgroundColor,
          child: buttonChild,
        ),
      ),
    );
  }
}
