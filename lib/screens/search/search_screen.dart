import 'package:meal_mate/screens/search/widget/search_delegate.dart';

import '../../utils/tools/file_importer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(
                Icons.search,
                size: 26,
              ))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          Text(
            "Categories",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
          ),
          SizedBox(height: 20,),
          SizedBox(
            height: height(context) * 8,
            width: double.infinity,
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                mainAxisExtent: 80,
              ),
              itemBuilder: (context, index) {
                return OnTap(
                  onTap: () {},
                  child: Container(
                    height: 80.h,
                    width: 130.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/image 1.png"),
                      ),
                    ),
                    child: Text(
                      "Food $index",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
