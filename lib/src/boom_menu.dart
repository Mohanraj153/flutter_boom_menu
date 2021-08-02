import 'package:flutter/material.dart';

import 'animated_child.dart';
import 'animated_floating_button.dart';
import 'background_overlay.dart';
import 'boom_menu_item.dart';

/// Builds the Speed Dial
class BoomMenu extends StatefulWidget {
  /// Children buttons, from the lowest to the highest.
  final List<MenuItem> children;

  /// Used to get the button hidden on scroll. See examples for more info.
  final bool scrollVisible;

  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final ShapeBorder fabMenuBorder;
  final Alignment fabAlignment;

  final double marginLeft;
  final double marginRight;
  final double marginBottom;

  final double fabPaddingLeft;
  final double fabPaddingRight;
  final double fabPaddingTop;

  /// The color of the background overlay.
  final Color overlayColor;

  /// The opacity of the background overlay when the dial is open.
  final double overlayOpacity;

  /// The animated icon to show as the main button child. If this is provided the [child] is ignored.
  final AnimatedIconData animatedIcon;

  /// The theme for the animated icon.
  final IconThemeData animatedIconTheme;

  /// The child of the main button, ignored if [animatedIcon] is non [null].
  final Widget child;

  /// Executed when the dial is opened.
  final VoidCallback onOpen;

  /// Executed when the dial is closed.
  final VoidCallback onClose;

  /// Executed when the dial is pressed. If given, the dial only opens on long press!
  final VoidCallback onPress;

  /// If true user is forced to close dial manually by tapping main button. WARNING: If true, overlay is not rendered.
  final bool overlayVisible;

  /// The speed of the animation
  final int animationSpeed;

  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subTitleColor;

  BoomMenu({
    this.children = const [],
    this.scrollVisible = true,
    this.title,
    this.subtitle,
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.overlayOpacity = 0.8,
    this.overlayColor = Colors.white,
    this.animatedIcon,
    this.animatedIconTheme,
    this.child,
    this.marginBottom = 0,
    this.marginLeft = 16,
    this.marginRight = 0,
    this.onOpen,
    this.onClose,
    this.overlayVisible = false,
    this.fabMenuBorder = const CircleBorder(),
    this.fabAlignment = Alignment.centerRight,
    this.fabPaddingRight = 0,
    this.fabPaddingLeft = 0,
    this.fabPaddingTop = 0,
    this.onPress,
    this.animationSpeed = 150
  });

  @override
  _BoomMenuState createState() => _BoomMenuState();
}

class _BoomMenuState extends State<BoomMenu> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _calculateMainControllerDuration(),
      vsync: this,
    );
  }

  Duration _calculateMainControllerDuration() =>
      Duration(milliseconds: widget.animationSpeed + widget.children.length * (widget.animationSpeed / 5).round());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performAnimation() {
    if (!mounted) return;
    if (_open) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(BoomMenu oldWidget) {
    if (oldWidget.children.length != widget.children.length) {
      _controller.duration = _calculateMainControllerDuration();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _toggleChildren() {
    var newValue = !_open;
    setState(() {
      _open = newValue;
    });
    if (newValue && widget.onOpen != null) widget.onOpen();
    _performAnimation();
    if (!newValue && widget.onClose != null) widget.onClose();
  }

  List<Widget> _getChildrenList() {
    final singleChildrenTween = 1.0 / widget.children.length;

    return widget.children
        .map((MenuItem child) {
          int index = widget.children.indexOf(child);

          var childAnimation = Tween(begin: 0.0, end: 62.0).animate(
            CurvedAnimation(
              parent: this._controller,
              curve: Interval(0, singleChildrenTween * (index + 1),
              ),
            ),
          );

          return AnimatedChild(
            animation: childAnimation,
            index: index,
            visible: _open,
            backgroundColor: child.backgroundColor,
            elevation: child.elevation,
            child: child.child,
            title: child.title,
            subtitle: child.subtitle,
            titleColor: child.titleColor,
            subTitleColor : child.subTitleColor,
            onTap: child.onTap,
            toggleChildren: () {
              if (!widget.overlayVisible) _toggleChildren();
            }
          );
        })
        .toList()
        .reversed
        .toList();
  }

  Widget _renderOverlay() {
    return Positioned(
      right: -16.0,
      bottom: -16.0,
      top: _open ? 0.0 : null,
      left: _open ? 0.0 : null,
      child: GestureDetector(
        onTap: _toggleChildren,
        child: BackgroundOverlay(
          animation: _controller,
          color: widget.overlayColor,
          opacity: widget.overlayOpacity,
        ),
      ),
    );
  }

  Widget _renderButton() {
    var child = widget.animatedIcon != null
        ? AnimatedIcon(
            icon: widget.animatedIcon,
            progress: _controller,
            color: widget.animatedIconTheme?.color,
            size: widget.animatedIconTheme?.size,
          )
        : widget.child;

    var fabChildren = _getChildrenList();

    var animatedFloatingButton = AnimatedFloatingButton(
      visible: widget.scrollVisible,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      elevation: widget.elevation,
      onLongPress: _toggleChildren,
      callback: (_open || widget.onPress == null) ? _toggleChildren : widget.onPress,
      child: child,
      shape: widget.fabMenuBorder
    );

    return Positioned(
      left: widget.marginLeft + 16,
      bottom: widget.marginBottom,
      right: widget.marginRight,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          /*children: List.from(fabChildren)
            ..add(
              Container(
                margin: EdgeInsets.only(top: 8.0, right: 2.0),
                child: animatedFloatingButton,
              ),
            ),*/
          children: <Widget> [
            SizedBox(height: kToolbarHeight + 40),
            Visibility(
              visible: _open,
              child: Expanded(
                child: ListView(
                  children: List.from(fabChildren),
                  reverse: true,
                ),
              ),
            ),
            Align(
              alignment: widget.fabAlignment,
              child: Container(
                padding: EdgeInsets.only(
                  left: widget.fabPaddingLeft,
                  right: widget.fabPaddingRight,
                  top: 8.0 + widget.fabPaddingTop,
                ),
                child: animatedFloatingButton,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      !widget.overlayVisible ? _renderOverlay() : Container(),
      _renderButton(),
    ];

    return Stack(
      alignment: Alignment.bottomRight,
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: children,
    );
  }
}
