import 'package:flutter/material.dart';
import 'package:meal_mate/screens/auth/view_model/auth_view_model.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80.w,
        leading: CircleAvatar(),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hi Man\n",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextSpan(
                text: "What are you cooking today?",
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CookBooks",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 24.sp),
              ),
              Text("1/3", style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          SizedBox(
            height: 320.h,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: 315,
                    width: width(context) * 0.9,
                    // margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.green,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/Rectangle 13.png"),
                            ),
                          ),
                        ),
                        Text(
                          "Buku resep spesial antara",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 24),
                        ),
                        Text(
                          "Keep it easy with these simple but delicious recipes.",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("1.3 Likes",style:  Theme.of(context)
                                .textTheme
                                .labelMedium
                                ),
                            Container(
                              height: 30.h,
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              width: 2,
                              color: AppColors.borderShade400,
                            ),
                            Text("7 Recipes",style:  Theme.of(context)
                                .textTheme
                                .labelMedium),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
