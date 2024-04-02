import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meal_mate/data/local/storage_repository.dart';
import 'package:meal_mate/screens/countries/countries_screen.dart';
import 'package:meal_mate/screens/countries/local_auth/auth_1.dart';
import 'package:meal_mate/utils/style/app_text_style.dart';

class LocalPasswordScreenSecond extends StatefulWidget {
  const LocalPasswordScreenSecond({Key? key}) : super(key: key);

  @override
  _LocalPasswordScreenSecondState createState() => _LocalPasswordScreenSecondState();
}

class _LocalPasswordScreenSecondState extends State<LocalPasswordScreenSecond> {
  List<String> selectedButtons = [];

  void onButtonTap(int index) {
    setState(() {
      if (selectedButtons.length < 4) {
        selectedButtons.add(index.toString());
      }
    });
  }

  void onButtonTapRemove() {
    setState(() {
      if (selectedButtons.isNotEmpty) {
        selectedButtons.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Security screen',style: TextStyle(color: Colors.white,fontSize: 24),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text('Enter your check passcode',style: TextStyle(color: Colors.white,fontSize: 18),),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
                  (index) => Icon(
                Icons.circle,
                color: selectedButtons.length > index ? Colors.green : Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 80),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30,
                mainAxisSpacing: 20,
                mainAxisExtent: 80,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Items(text: '${index+1}', onTap: (){
                  onButtonTap(index);
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             Items(
               fontSize: 24,
               text: 'next', onTap: () {
               List<String> lastPass = StorageRepository.getStringList(key: "my_password");
               if (lastPass.isNotEmpty && listEquals(selectedButtons, lastPass)) {
                 selectedButtons.clear();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CountriesScreen()));
               } else {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     content: Text('Sizning parolingiz xato'),
                   ),
                 );
                 selectedButtons.clear();
                 setState(() {});
               }
             },),
              Items(text: "0", onTap: (){
                onButtonTap(0);
              }),
             Items(
                 fontSize: 24,
                 text: "del", onTap: (){
               onButtonTapRemove();
             })
            ],
          ),
        ],
      ),
    );
  }
}