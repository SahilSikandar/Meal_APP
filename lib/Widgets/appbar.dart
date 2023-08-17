import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AdvancedDrawerController controller;
  final String title;
  const CustomAppBar({required this.controller, required this.title, Key? key})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    print('CustomAppBar - Title: $title');
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.lato().fontFamily),
      ),
      leading: IconButton(
        onPressed: _handleMenuButtonPressed,
        icon: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: controller,
          builder: (_, value, __) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: Icon(
                value.visible ? Icons.clear : Icons.menu,
                key: ValueKey<bool>(value.visible),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    controller.showDrawer();
  }
}
