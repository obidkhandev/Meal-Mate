import 'package:flutter/material.dart';
import 'package:meal_mate/data/model/place_category.dart';
import 'package:meal_mate/google_map/ui/ui.dart';
import 'package:meal_mate/google_map/ui/uptade_map.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'package:provider/provider.dart';

import '../view_model/addresses_view_model.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("May Addresses"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<AddressesViewModel>(
              builder: (context, viewModel, child) {
                return viewModel.getLoader
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(children: [
                        ...List.generate(viewModel.myAddresses.length, (index) {
                          var myAddress = viewModel.myAddresses[index];
                          IconData icon = getIcon(myAddress.placeCategory);
                          List<String> splitPlaceName =
                              myAddress.placeName.split(' ');
                          String placeName = '';
                          splitPlaceName.removeRange(0, 1);
                          splitPlaceName.forEach((element) {
                            placeName += element;
                            placeName += " ";
                          });

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateAddressScreen(
                                      placeModel: myAddress,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              margin: const EdgeInsets.all(12),
                              height: 80.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(3, 3),
                                      color: Colors.black12,
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                    )
                                  ]),
                              child: Row(
                                children: [
                                  Icon(
                                    icon,
                                    size: 36,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                    width: width(context) * 0.7,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${myAddress.placeCategory}\n",
                                            style: AppTextStyle.recolateMedium
                                                .copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text: placeName,
                                            style: AppTextStyle.recolateMedium
                                                .copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ]);
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GoogleMapsScreen();
                    },
                  ),
                );
              },
              child: Text("Yangi address qo'shish"))
        ],
      ),
    );
  }
}
