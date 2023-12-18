import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/switch_bloc/switch_bloc.dart';
import 'package:task_app/services/app_theme.dart';
import 'package:task_app/widgets/welcome.dart';
import 'task_bloc/task_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>(
            create: (context) => TaskBloc()..add(TaskStarted()),
          ),
          BlocProvider(
            create: (context) => SwitchBloc(),
          ),
        ],
        child: BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Task App',
              theme: state.switchValue
                  ? AppThemes.appThemeData[AppTheme.lightTheme]
                  : AppThemes.appThemeData[AppTheme.darkTheme],
              home: const WelcomePage(),
            );
          },
        ));
  }
}
