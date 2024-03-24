import '../../utils/tools/file_importer.dart';



class AddTabBar2 extends StatelessWidget {
  final TextEditingController ingredientController;
  final FocusNode ingFocusNode;
  final Function() onTap;
  final Widget child;

  const AddTabBar2({super.key, required this.ingredientController, required this.ingFocusNode, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50.h,
              width: width(context) * 0.7,
              child: TextField(
                controller: ingredientController,
                maxLines: 1,
                focusNode: ingFocusNode,
                decoration: const InputDecoration(
                  hintText: "Add Ingredient",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.check))
          ],
        ),
       child,
      ],
    );
  }
}
