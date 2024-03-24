
import '../../utils/tools/file_importer.dart';

class AddTabBar3 extends StatelessWidget {
  final TextEditingController stepsController;
  final FocusNode stepFocusNode;
  final Function() onTap;
  final Widget child;

  const AddTabBar3(
      {super.key,
      required this.stepsController,
      required this.stepFocusNode,
      required this.child,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 16.w,
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50.h,
                width: width(context) * 0.7,
                child: TextField(
                  controller: stepsController,
                  maxLines: null,
                  focusNode: stepFocusNode,
                  decoration: const InputDecoration(
                    hintText: "Add Steps",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                  onPressed: onTap,
                  icon: const Icon(Icons.check))
            ],
          ),
         child
        ],
      ),
    );
  }
}
