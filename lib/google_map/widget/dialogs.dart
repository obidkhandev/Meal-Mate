import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import '../../data/model/place_model.dart';

addressDetailDialog({
  required BuildContext context,
  required ValueChanged<PlaceModel> placeModel,
  required String placeCategory,
  required double lat,
  required double long,
  required String currentPlaceName,
}) {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController podezController = TextEditingController();
  final TextEditingController stageController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController orenterController = TextEditingController();
  final TextEditingController placeNameController = TextEditingController();
  List<String> splitPlaceName = currentPlaceName.split(',');
  splitPlaceName.removeRange(0, 2);
  splitPlaceName.forEach((element) {
    addressController.text += element;
    addressController.text += " ";
  });

  showModalBottomSheet(

      context: context,
      isScrollControlled: true,

      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Container(
            height: 500.h,
            width: double.infinity,
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Adress to delivery", style: AppTextStyle.recolateMedium),
                SizedBox(height: 10.h),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                      labelText: "Address", border: UnderlineInputBorder()),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: width(context) / 3 - 20,
                      child: TextField(
                        controller: podezController,
                        decoration: InputDecoration(
                            hintText: "Entrance", border: UnderlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: width(context) / 3 - 20,
                      child: TextField(
                        controller: stageController,
                        decoration: InputDecoration(
                            hintText: "Stage", border: UnderlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: width(context) / 3 - 20,
                      child: TextField(
                        controller: flatController,
                        decoration: InputDecoration(
                            hintText: "Flat", border: UnderlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: orenterController,
                  decoration: InputDecoration(
                    hintText: "Orient address",
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {
                      placeModel.call(
                        PlaceModel(
                          entrance: podezController.text,
                          flatNumber: flatController.text,
                          orientAddress: orenterController.text,
                          placeCategory: placeCategory,
                         lat: lat,
                         long: long,
                          placeName: addressController.text,
                          stage: stageController.text,
                        ),
                      );



                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Save Place",
                      style: AppTextStyle.recolateBold
                          .copyWith(fontSize: 18, color: Colors.white),
                    ))
              ],
            ),
          ),
        );
      });
}
