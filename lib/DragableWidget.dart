import 'dart:math';
import 'package:flutter/material.dart';

enum SlideDirection { left, right }

class DrageableWidget extends StatefulWidget {
  const DrageableWidget({
    super.key,
    required this.child,
    this.onPressed,
    required this.isEnabled,
    this.onSlideOut,
  });

  final Widget child;
  final ValueChanged<SlideDirection>? onSlideOut;
  final VoidCallback? onPressed;
  final bool isEnabled;

  @override
  State<DrageableWidget> createState() => _DragableWidgetState();
}

class _DragableWidgetState extends State<DrageableWidget> with SingleTickerProviderStateMixin {
  late AnimationController restoreController;
  Size? screenSize; // Change to nullable type
  final _widgetKey = GlobalKey();
  Offset startOffset = Offset.zero;
  Offset panOffset = Offset.zero;
  Size size = Size.zero;
  double angle = 0;

  // Now we need to figure out while user make the slide
  bool itWasMadeSlide = false;
  double get outSizeLimit => size.width * 0.65;

  void onPanStart(DragStartDetails details) {
    if (!restoreController.isAnimating) {
      setState(() {
        startOffset = details.globalPosition;
      });
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (!restoreController.isAnimating) {
      setState(() {
        panOffset = details.globalPosition - startOffset;
        angle = currentAngle;
      });
    }
  }

  void onPanEnd(DragEndDetails details) {
    if (restoreController.isAnimating || screenSize == null) {
      return; // Ensure screenSize is not null
    }

    final velocityX = details.velocity.pixelsPerSecond.dx;
    final positionX = currentPosition.dx;

    if (velocityX < -1000 || positionX < -outSizeLimit) {
      itWasMadeSlide = widget.onSlideOut != null;
      widget.onSlideOut?.call(SlideDirection.left);
    }

    if (velocityX > 1000 || positionX > (screenSize!.width - outSizeLimit)) { // Safely access screenSize
      itWasMadeSlide = widget.onSlideOut != null;
      widget.onSlideOut?.call(SlideDirection.right);
    }
    restoreController.forward();
  }

  void restoreAnimationListener() {
    if (restoreController.isCompleted) {
      restoreController.reset();
      panOffset = Offset.zero;
      itWasMadeSlide = false;
      angle = 0;
      setState(() {});
    }
  }

  double get currentAngle {
    if (screenSize == null || size == Size.zero) {
      return 0; // Ensure values are initialized before calculation
    }

    return currentPosition.dx < 0
        ? (pi * 0.2) * currentPosition.dx / size.width
        : currentPosition.dx + size.width > screenSize!.width
        ? (pi * 0.2) *
        (currentPosition.dx + size.width - screenSize!.width) /
        size.width
        : 0;
  }

  Offset get currentPosition {
    final renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  }

  void getChildSize() {
    size = (_widgetKey.currentContext?.findRenderObject() as RenderBox?)?.size ?? Size.zero;
  }

  @override
  void initState() {
    restoreController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..addListener(restoreAnimationListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        screenSize = MediaQuery.of(context).size; // Initialize screenSize in setState
        getChildSize();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    restoreController
      ..removeListener(restoreAnimationListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      key: _widgetKey,
      child: widget.child,
    );

    if (!widget.isEnabled) return child;
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: AnimatedBuilder(
        animation: restoreController,
        builder: (context, child) {
          final value = 1 - restoreController.value;
          return Transform.translate(
            offset: panOffset * value,
            child: Transform.rotate(angle: angle * (itWasMadeSlide ? 1 : value),
                child: child), // Apply angle rotation
          );
        },
        child: child,
      ),
    );
  }
}
