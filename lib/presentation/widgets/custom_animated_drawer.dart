import 'package:flutter/material.dart';

class CustomAnimatedDrawer extends StatefulWidget {
  final Widget content;
 
  const CustomAnimatedDrawer({
    super.key, 
    required this.content,
  });

  @override
  State<CustomAnimatedDrawer> createState() => _CustomAnimatedDrawerState();
}

class _CustomAnimatedDrawerState extends State<CustomAnimatedDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 250)
    );
  }

  Widget _buildDrawer() {
    return const Column(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage('https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_expert_academy/dicoding-icon.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: Icon(Icons.movie),
          title: Text('Movies'),
        ),
        ListTile(
          leading: Icon(Icons.save_alt),
          title: Text('Watchlist'),
        ),
      ],
    );
  }

  void toggle() => _animationController.isDismissed
    ? _animationController.forward()
    : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);
      
          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        }
      ),
    );
  }
}