import '../../utils/tools/file_importer.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, RouteName.addRecipe);
      },child: Icon(Icons.add,color: AppColors.primary,),),
      // body: ,
    );
  }
}
