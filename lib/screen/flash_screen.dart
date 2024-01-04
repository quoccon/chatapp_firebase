import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_controller);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1,0),
      end: const Offset(1,0),
    ).animate(_controller);
    
    _controller.addListener(() {
      if(_controller.status == AnimationStatus.completed){

      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context,child){
              return Transform.translate(
                offset: _slideAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Image.asset('images/conversation.png'),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}

