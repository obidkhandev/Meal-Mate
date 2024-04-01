import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_mate/data/local/storage_repository.dart';
import 'package:meal_mate/screens/countries/local_auth/auth_2.dart';
import 'package:meal_mate/utils/style/app_text_style.dart';

class LocalPasswordScreen extends StatefulWidget {
  @override
  _LocalPasswordScreenState createState() => _LocalPasswordScreenState();
}

class _LocalPasswordScreenState extends State<LocalPasswordScreen> {
  List<bool> buttonTapped = List.generate(10, (index) => false);
  List<String> selectedButtons = [];

  void onButtonTap(int index) {
    setState(() {
      if (selectedButtons.length < 4) {
        selectedButtons.add(index.toString());
        buttonTapped[index] = true;
      }
    });
  }

  void onButtonTapRemove() {
    setState(() {
      if (selectedButtons.length <= 4) {
        selectedButtons.remove(selectedButtons.last);
        buttonTapped[selectedButtons.length] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Password Screen'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => Icon(
                selectedButtons.length > index ? Icons.lock : Icons.lock_open,
                color:
                    selectedButtons.length > index ? Colors.green : Colors.red,
              ),
            ),
          ),
          SizedBox(height: 100),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30),
              itemCount: 9,
              // reverse: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30,
                mainAxisSpacing: 20,
                mainAxisExtent: 80,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    onButtonTap(index);
                  },
                  child: Text(
                    '${index + 1}',
                    style: AppTextStyle.recolateBold
                        .copyWith(color: Colors.white, fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  List<String> lastPass = StorageRepository.getStringList(key: "my_password");
                  if (selectedButtons.length == 4)  {
                    await StorageRepository.setListString(key: "my_password", values: selectedButtons);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LocalPasswordScreenSecond()));
                  } else {
                    print("Siz hali to'liq kiritmadingiz");
                  }
                },
                child: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: 60,
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  onButtonTap(0);
                },
                child: Text(
                  '0',
                  style: AppTextStyle.recolateBold
                      .copyWith(color: Colors.white, fontSize: 40),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  onButtonTapRemove();
                },
                child: Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                  size: 60,
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
