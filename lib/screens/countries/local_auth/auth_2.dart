import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/tools/file_importer.dart';
import '../countries_screen.dart';
import 'auth_1.dart';
import 'cubit/auth_cubit_state.dart';

class LocalPasswordScreenSecond extends StatelessWidget {
  final LocalPasswordScreenSecondCubit _cubit = LocalPasswordScreenSecondCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Security screen',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<LocalPasswordScreenSecondCubit, LocalPasswordScreenSecondState>(
          builder: (context, state) {
            if (state is LocalPasswordScreenSecondSuccess) {
              return const CountriesScreen();
            } else {
              return buildPasswordScreen(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildPasswordScreen(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text('Enter your check passcode', style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
                (index) => Icon(
              Icons.circle,
              color: _cubit.selectedButtons.length > index ? Colors.green : Colors.grey,
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
              return Items(text: '${index + 1}', onTap: () => _cubit.onButtonTap(index));
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Items(
              fontSize: 24,
              text: 'next',
              onTap: () => _cubit.validatePassword(),
            ),
            Items(text: '0', onTap: () => _cubit.onButtonTap(0)),
            Items(fontSize: 24, text: "del", onTap: () => _cubit.onButtonTapRemove()),
          ],
        ),
      ],
    );
  }
}
