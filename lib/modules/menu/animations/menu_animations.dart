import 'package:flutter/material.dart';

class MenuAnimations {
  static AnimationController createController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 600),
    );
  }

  static Animation<double> fade(AnimationController c) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: c, curve: Curves.easeOut),
    );
  }

  static Animation<Offset> slide(AnimationController c) {
    return Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: c, curve: Curves.easeOut),
    );
  }

  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slide = Tween<Offset>(
          begin: Offset(0.2, 0),
          end: Offset.zero,
        ).animate(animation);

        final fade = Tween<double>(begin: 0, end: 1).animate(animation);

        return SlideTransition(
          position: slide,
          child: FadeTransition(opacity: fade, child: child),
        );
      },
    );
  }
}
