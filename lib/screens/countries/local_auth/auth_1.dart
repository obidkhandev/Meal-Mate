import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_mate/data/local/storage_repository.dart';
import 'package:meal_mate/screens/countries/countries_screen.dart';
import 'package:meal_mate/screens/countries/local_auth/auth_2.dart';
import 'package:meal_mate/utils/style/app_text_style.dart';

class LocalPasswordScreen extends StatefulWidget {
  const LocalPasswordScreen({super.key});

  @override
  _LocalPasswordScreenState createState() => _LocalPasswordScreenState();
}

class _LocalPasswordScreenState extends State<LocalPasswordScreen> {
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _validatePassword() async {
    List<String> lastPass = StorageRepository.getStringList(key: "my_password");
    print(selectedButtons);
    if(lastPass.isEmpty){
      StorageRepository.setListString(key: "my_password", values: selectedButtons);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LocalPasswordScreenSecond()));
      return;
    }

    if (selectedButtons.length == 4 && lastPass.isNotEmpty) {
      if (lastPass.isNotEmpty && listEquals(selectedButtons, lastPass)) {
        selectedButtons.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CountriesScreen()));
      } else {
        _showSnackBar('Sizning parolingiz xato');
        selectedButtons.clear();
        setState(() {

        });
      }
    } else {
      selectedButtons.clear();
      _showSnackBar('Siz Parolni to\'liq kiritmadingiz');
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Security screen',style: TextStyle(color: Colors.white,fontSize: 24),),
        centerTitle: true,
      ),
      body: SafeArea(

        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('Enter your passcode',style: TextStyle(color: Colors.white,fontSize: 18),),
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
            const  SizedBox(height: 80),
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
                  text: "next", onTap: _validatePassword),
               Items(text: '0', onTap: (){
                 onButtonTap(0);
               }),
               Items(
                   fontSize: 24,
                   text: "del", onTap: onButtonTapRemove)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double fontSize;
  const Items({super.key, required this.text, required this.onTap, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 76,
        width: 76,
        padding: EdgeInsets.all(10),
        // margin: Edg,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Text(
          text,
          style: AppTextStyle.recolateBold.copyWith(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
