import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_mate/data/model/category_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/main_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/category_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/ingredient_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/steps_view_model.dart';

import '../../utils/tools/file_importer.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController stepsController = TextEditingController();
  int activeIndex = 0;

  FocusNode ingFocusNode = FocusNode();
  FocusNode stepFocusNode = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    hourController.dispose();
    minuteController.dispose();
    descriptionController.dispose();
    stepsController.dispose();
    ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Discover",
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: TextButton(
                onPressed: () {
                  final categoryViewModel = context.read<CategoryViewModel>();
                  final categoryEnum = CategoryEnum.values[activeIndex];

// Insert category
                  categoryViewModel.insertCategory(
                    CategoryModel(
                      categoryId: '', // Pass the appropriate categoryId
                      category: categoryEnum.name,
                    ),
                    context,
                  );

// Create FoodModel instance
                  final foodModel = FoodModel(
                    docId: '',
                    userEmail: context.read<AuthViewModel>().getUser!.email!,
                    userName: context.read<AuthViewModel>().getUser!.displayName!,
                    timestamp: "${hourController.text}:${minuteController.text}",
                    foodDescription: descriptionController.text,
                    stepsList: Provider.of<StepsViewModel>(context, listen: false).stepsItem ?? [],
                    imageUrl: "https://i.pinimg.com/originals/20/63/25/206325d9203e6b3c5b79cfc5202ce046.jpg",
                    difficultly: "easy",
                    ingredientList: Provider.of<IngredientViewModel>(context, listen: false).ingredientItem ?? [],
                    title: titleController.text,
                    categoryId: categoryViewModel.categoryId,
                  );

// Check if FoodModel can be added to the database
                  if (FoodModel.canAddToDB(foodModel)) {
                    context.read<ProductsViewModel>().insertProducts(foodModel, context);
                    context.read<IngredientViewModel>().gapList();
                    context.read<StepsViewModel>().gapList();
                    myAnimatedSnackBar(context, "Muvaffaqqiyatli qo'shildi");
                    // Navigator.pop(context);
                  } else {
                    myAnimatedSnackBar(context, "Siz nimadurni kiritmadingiz");
                  }

                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

            ),
          ],
        ),
        body: SizedBox(
          height: height(context) * 0.9,
          width: double.infinity,
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  tabs: [
                    Tab(
                      child: Text("Intro"),
                    ),
                    Tab(
                      child: Text("Ingredients"),
                    ),
                    Tab(
                      child: Text("Steps"),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                                hintText: "Title",
                                border: UnderlineInputBorder()),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Cook Time",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50.h,
                                width: width(context) / 2.8,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: hourController,
                                  decoration: InputDecoration(
                                      hintText: "hour",
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                                width: width(context) / 2.8,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: minuteController,
                                  decoration: const InputDecoration(
                                      hintText: "minute",
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 200.h,
                            width: double.infinity,
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://i.pinimg.com/originals/20/63/25/206325d9203e6b3c5b79cfc5202ce046.jpg"),
                              ),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextField(
                            controller: descriptionController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "description",
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: CategoryEnum.values.length,
                                itemBuilder: (context, index) {
                                  return OnTap(
                                    onTap: () {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: 45.h,
                                      // width: 30.w,
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: activeIndex == index
                                            ? AppColors.primary
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(14.sp),
                                        border: Border.all(
                                            color: activeIndex == index
                                                ? AppColors.primary
                                                : Colors.grey),
                                      ),
                                      child:
                                          Text(CategoryEnum.values[index].name),
                                    ),
                                  );
                                }),
                          ),
                          Text(
                            "Easy",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 16.w),
                        child: Column(
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
                                    decoration: InputDecoration(
                                      hintText: "Add Ingredient",
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (ingredientController
                                          .text.isNotEmpty) {
                                        context
                                            .read<IngredientViewModel>()
                                            .insertToList(
                                                ingredientController.text);
                                        ingFocusNode.unfocus();
                                        ingredientController.text = '';
                                      } else {
                                        myAnimatedSnackBar(context,
                                            "Yangi ingrediend qo'shish uchun yozing");
                                      }
                                    },
                                    icon: Icon(Icons.check))
                              ],
                            ),
                            Consumer(
                              builder: (context, viewModel, child) {
                                return context
                                            .watch<IngredientViewModel>()
                                            .ingredientItem
                                            .length ==
                                        0
                                    ? Center(
                                        child: Text(
                                            "Siz hali hech nima kiritmadingiz"),
                                      )
                                    : SizedBox(
                                        height: height(context) * .6,
                                        child: ListView.builder(
                                          // reverse: true,
                                          itemCount: context
                                              .watch<IngredientViewModel>()
                                              .ingredientItem
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              title: Text(
                                                context
                                                    .watch<
                                                        IngredientViewModel>()
                                                    .ingredientItem[index],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 16.w,
                        ),
                        child: Column(
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
                                    decoration: InputDecoration(
                                      hintText: "Add Steps",
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (stepsController.text.isNotEmpty) {
                                        context
                                            .read<StepsViewModel>()
                                            .insertToList(stepsController.text);
                                        stepFocusNode.unfocus();
                                        stepsController.text = '';
                                      } else {
                                        myAnimatedSnackBar(context,
                                            "Yangi qadam qo'shish uchun yozing");
                                      }
                                    },
                                    icon: Icon(Icons.check))
                              ],
                            ),
                            Consumer(
                              builder: (context, viewModel, child) {
                                return context
                                            .watch<StepsViewModel>()
                                            .stepsItem
                                            .length ==
                                        0
                                    ? Center(
                                        child: Text(
                                            "Siz hali hech nima kiritmadingiz"),
                                      )
                                    : SizedBox(
                                        height: height(context) * .6,
                                        child: ListView.builder(
                                          // reverse: true,
                                          itemCount: context
                                              .watch<StepsViewModel>()
                                              .stepsItem
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              title: Text(
                                                context
                                                    .watch<StepsViewModel>()
                                                    .stepsItem[index],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
