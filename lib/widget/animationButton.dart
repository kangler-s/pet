/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-15 19:45:38
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-15 20:40:16
 * @FilePath: /pet/lib/widget/animationButton.dart
 */
import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  final String? title;
  final String? image;
  final double? width;
  final double? height;
  VoidCallback onTap;

  BouncingButton(
      {super.key,
      this.image,
      this.width,
      this.height,
      this.title,
      required this.onTap});

  @override
  State<BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: widget.onTap,
      child: Transform.scale(
        scale: _scale,
        child: widget.image?.length != null ? _imageButtonUI : _textButtonUI,
      ),
    );
  }

  Widget get _textButtonUI => Container(
        height: widget.height ?? 50,
        width: widget.width ?? 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 30.0,
              offset: Offset(0.0, 30.0),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA7BFE8),
              Color(0xFF6190E8),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'tap!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget get _imageButtonUI => Container(
        child: Image.asset(widget.image!),
      );
}
