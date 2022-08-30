import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwoti/domain_layer/abstracts/repositories/base_repository.dart';

import 'data_layer/network/garden_net_client.dart';
import 'data_layer/providers/garden_provider.dart';
import 'data_layer/repositories/garden_repository.dart';
import 'domain_layer/cubits/quote_cubit.dart';
import 'presentation_layer/screens/quote_screen.dart';

void main() {
  runApp(MyApp(
    // repository: StormRepository(
    //   provider: StormProvider(
    //     StormNetClient(),
    //   ),
    // ),
    repository: GardenRepository(
      provider: GardenProvider(
        GardenNetClient(),
      ),
    ),
  ));
}

/// The application widget
class MyApp extends StatelessWidget {
  /// The repository responsible for getting all the data
  final BaseRepository repository;

  /// Creates the [MyApp]
  const MyApp({
    Key? key,
    required this.repository,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<QuoteCubit>(
            create: (context) => QuoteCubit(
              repository: repository,
            )..load(),
          ),
        ],
        child: const QuoteScreen(),
      ),
    );
  }
}
