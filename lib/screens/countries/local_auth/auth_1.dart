import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/screens/countries/countries_screen.dart';
import 'package:meal_mate/screens/countries/local_auth/auth_2.dart';
import 'package:meal_mate/utils/style/app_text_style.dart';


import 'cubit/auth_cubit.dart';
import 'cubit/auth_cubit_state.dart';

class LocalPasswordScreen extends StatelessWidget {
  final LocalPasswordScreenCubit _cubit = LocalPasswordScreenCubit();

  LocalPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child:
              BlocBuilder<LocalPasswordScreenCubit, LocalPasswordScreenState>(
            builder: (context, state) {
              if (state is LocalPasswordScreenNavSecond) {
                return LocalPasswordScreenSecond();
              } else if (state is LocalPasswordScreenSuccess) {
                return CountriesScreen();
              } else {
                return buildPasswordScreen(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildPasswordScreen(BuildContext context) {
    return Column(
      children: [
        Text(
          'Security screen',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        const SizedBox(height: 40),
        const Text('Enter your passcode',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => Icon(
              Icons.circle,
              color: BlocProvider.of<LocalPasswordScreenCubit>(context)
                          .selectedButtons
                          .length >
                      index
                  ? Colors.green
                  : Colors.grey,
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
              return Items(
                  text: '${index + 1}',
                  onTap: () =>
                      BlocProvider.of<LocalPasswordScreenCubit>(context)
                          .onButtonTap(index));
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Items(
                fontSize: 24,
                text: "next",
                onTap: () => BlocProvider.of<LocalPasswordScreenCubit>(context)
                    .validatePassword()),
            Items(
                text: '0',
                onTap: () => BlocProvider.of<LocalPasswordScreenCubit>(context)
                    .onButtonTap(0),
            ),
            Items(
                fontSize: 24,
                text: "del",
                onTap: BlocProvider.of<LocalPasswordScreenCubit>(context)
                    .onButtonTapRemove),
          ],
        ),
      ],
    );
  }
}

class Items extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double fontSize;

  const Items(
      {super.key, required this.text, required this.onTap, this.fontSize = 32});

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
          style: AppTextStyle.recolateBold
              .copyWith(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
