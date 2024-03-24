import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_mate/data/model/category_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/main_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/category_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/ingredient_view_model.dart';
import 'package:meal_mate/screens/add_screen/view_model/steps_view_model.dart';
import 'package:meal_mate/screens/widget/add_tab_bar2.dart';
import 'package:meal_mate/screens/widget/add_tab_bar3.dart';

import '../../utils/tools/file_importer.dart';
import '../widget/add_tab_bar1.dart';

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

  void _insertDefaultCategory() async {
    try {
      final categoryViewModel = context.read<CategoryViewModel>();
      await categoryViewModel.insertCategory(
        CategoryModel(
          categoryId: '', // Assign a default ID here or generate one
          category: "everyday",
        ),
        context,
      );
    } catch (e) {
      print('Error inserting default category: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insertDefaultCategory();
    });
  }

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
                  final categoryEnum = CategoryEnum.values[activeIndex];
                  final categoryViewModel = context.read<CategoryViewModel>();

// Create a new FoodModel
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
                    categoryId: categoryViewModel.categoryId ?? '', // Use categoryId from categoryViewModel
                  );

// Check if categoryId is not empty before proceeding
                  if (foodModel.categoryId.isNotEmpty && FoodModel.canAddToDB(foodModel)) {
                    Future.microtask(() {
                      return myAnimatedSnackBar(context, "Muvaffaqqiyatli qo'shildi");
                    });
                    context.read<ProductsViewModel>().insertProducts(foodModel, context);
                    context.read<IngredientViewModel>().gapList();
                    context.read<StepsViewModel>().gapList();
                    Navigator.pop(context);
                  } else {
                    myAnimatedSnackBar(context, "Muvaffaqqiyatli qo'shildi");
                    debugPrint('Category ID is empty');
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
                      AddTabBar(
                        titleController: titleController,
                        minuteController: minuteController,
                        hourController: hourController,
                        descriptionController: descriptionController,
                      ),
                      AddTabBar2(
                        ingredientController: ingredientController,
                        ingFocusNode: ingFocusNode,
                        onTap: () {
                          if (ingredientController.text.isNotEmpty) {
                            context
                                .read<IngredientViewModel>()
                                .insertToList(ingredientController.text);
                            ingFocusNode.unfocus();
                            ingredientController.text = '';
                          } else {
                            myAnimatedSnackBar(context,
                                "Yangi ingrediend qo'shish uchun yozing");
                          }
                        },
                        child:  Consumer(
                          builder: (context, viewModel, child) {
                            return context
                                .watch<IngredientViewModel>()
                                .ingredientItem.isEmpty
                                ? const Center(
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
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text(
                                        context
                                            .watch<IngredientViewModel>()
                                            .ingredientItem[index],
                                      ),
                                    );
                                  },
                                ),
                            );
                          },
                        ),
                      ),
                      AddTabBar3(
                        stepsController: stepsController,
                        stepFocusNode: stepFocusNode,
                        onTap: () {
                          if (stepsController.text.isNotEmpty) {
                            context
                                .read<StepsViewModel>()
                                .insertToList(stepsController.text);
                            stepFocusNode.unfocus();
                            stepsController.text = '';
                          } else {
                            myAnimatedSnackBar(
                                context, "Yangi qadam qo'shish uchun yozing");
                          }
                        },
                        child: Consumer(
                          builder: (context, viewModel, child) {
                            return context
                                    .watch<StepsViewModel>()
                                    .stepsItem
                                    .isEmpty
                                ? const Center(
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
