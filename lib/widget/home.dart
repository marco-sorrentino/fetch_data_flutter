import 'package:fetch_data_flutter/bloc/user_app_bloc.dart';
import 'package:fetch_data_flutter/bloc/user_app_event.dart';
import 'package:fetch_data_flutter/bloc/user_app_state.dart';
import 'package:fetch_data_flutter/models/user_model.dart';
import 'package:fetch_data_flutter/repo/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("The BLoC App"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          "${userList[index].first_name} ${userList[index].last_name}"),
                      subtitle: Text(userList[index].email),
                      leading: Text(userList[index].id.toString()),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
