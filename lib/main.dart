import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwoti/domain_layer/abstracts/repositories/base_repository.dart';

import 'data_layer/network/garden_net_client.dart';
import 'data_layer/network/storm_net_client.dart';
import 'data_layer/providers/garden_provider.dart';
import 'data_layer/providers/storm_provider.dart';
import 'data_layer/repositories/garden_repository.dart';
import 'data_layer/repositories/storm_repository.dart';
import 'domain_layer/cubits/quote_cubit.dart';
import 'presentation_layer/screens/quote_screen.dart';

void main() {
  runApp(MyApp(repositories: [
    GardenRepository(
      provider: GardenProvider(
        GardenNetClient(),
      ),
    ),
    StormRepository(
      provider: StormProvider(
        StormNetClient(),
      ),
    ),
  ]));
}

/// The application widget
class MyApp extends StatelessWidget {
  /// The repositories responsible for getting all the data
  final List<BaseRepository> repositories;

  /// Creates the [MyApp]
  const MyApp({
    Key? key,
    required this.repositories,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<QuoteCubit>(
        create: (context) => QuoteCubit(
          repositories: repositories,
        )..load(),
        child: const QuoteScreen(),
      ),
    );
  }
}
