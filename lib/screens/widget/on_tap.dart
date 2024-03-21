import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/tools/file_importer.dart';

class OnTap extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isAnimated;
  const OnTap(
      {required this.onTap,
        required this.child,
        this.isAnimated = true,
        super.key});

  @override
  Widget build(BuildContext context) {
    return isAnimated ? ZoomTapAnimation(onTap: onTap, child: child) : child;
  }
}