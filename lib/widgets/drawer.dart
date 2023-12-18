import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/firebase/firebase_auth.dart';
import 'package:task_app/screens/account_page.dart';
import 'package:task_app/screens/home.dart';

import 'package:task_app/switch_bloc/switch_bloc.dart';
import 'package:task_app/task_bloc/task_bloc.dart';
import 'package:task_app/widgets/welcome.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // This will remove the border
          ),
          child: Column(
            children: [
              const DrawerHeader(
                  child: Icon(
                Icons.person,
                size: 64,
              )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('H O M E'),
                        trailing: Text(
                          ' ${state.tasks.length} Tasks',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountPage()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('P R O F I L E'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AuthenticationProvider().signOut().then((value) {
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const WelcomePage()),
                            (_) => false);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('L O G O U T'),
                  ),
                ),
              ),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Switch(
                      value: state.switchValue,
                      onChanged: (newValue) {
                        newValue
                            ? context.read<SwitchBloc>().add(SwitchOnEvent())
                            : context.read<SwitchBloc>().add(SwitchOffEvent());
                      });
                },
              ),
            ],
          )),
    );
  }
}
