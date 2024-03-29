import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../view_model/map_view_model.dart';

class MapTypeItem extends StatelessWidget {
  const MapTypeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: PopupMenuButton(
              padding: const EdgeInsets.all(0),
              splashRadius: 50,
              icon: const Icon(Icons.map, color: Colors.deepPurple),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text("Normal"),
                    onTap: () {
                      context
                          .read<MapsViewModel>()
                          .changeMapType(MapType.normal);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Hybrid"),
                    onTap: () {
                      context
                          .read<MapsViewModel>()
                          .changeMapType(MapType.hybrid);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Satellite"),
                    onTap: () {
                      context
                          .read<MapsViewModel>()
                          .changeMapType(MapType.satellite);
                    },
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }
}

class MapCategoryItem extends StatefulWidget {
  final Widget myShowModalBottomSheet;

  const MapCategoryItem({super.key, required this.myShowModalBottomSheet});


  @override
  State<MapCategoryItem> createState() => _MapCategoryItemState();
}

class _MapCategoryItemState extends State<MapCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: PopupMenuButton(
              padding: const EdgeInsets.all(0),
              splashRadius: 50,
              icon: const Icon(Icons.category_outlined,
                  color: Colors.purpleAccent),
              surfaceTintColor: Colors.blue,
              // : Colors.white,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text("First Icon"),
                    onTap: () {
                      context
                          .read<MapsViewModel>()
                          .changeMapIcon("assets/icons/inital_map_icon.png");
                      setState(() {});
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Home"),
                    onTap: () {
                      context.read<MapsViewModel>().changeMapIcon(
                          "assets/icons/9090616a-95e2-457b-ac24-1ed2c7e01c51.png");
                    showModalBottomSheet(context: context, builder: (context){
                      return widget.myShowModalBottomSheet;
                    }
                    );
                      setState(() {});
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Work"),
                    onTap: () {
                      context.read<MapsViewModel>().changeMapIcon(
                          "assets/icons/fee230f4-943c-4de9-bf03-e435b5a3bbeb.png");
                      showModalBottomSheet(context: context, builder: (context){
                        return widget.myShowModalBottomSheet;
                      }
                      );

                      },
                  ),
                  PopupMenuItem(
                    child: const Text("Other"),
                    onTap: () {
                      context.read<MapsViewModel>().changeMapIcon(
                          "assets/icons/89ccd7ea-e18d-41c9-86ed-d0b08327fee4.png");
                      showModalBottomSheet(context: context, builder: (context){
                        return widget.myShowModalBottomSheet;
                      }
                      );
                    },
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }
}
