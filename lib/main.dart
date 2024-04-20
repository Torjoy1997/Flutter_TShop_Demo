import 'package:ecommerce_demo/config/local_store/local_storage.dart';
import 'package:ecommerce_demo/config/provider/bloc_provider.dart';
import 'package:ecommerce_demo/config/provider/mybloc_observer.dart';
import 'package:ecommerce_demo/config/routes/app_routes.dart';

import 'package:ecommerce_demo/firebase_options.dart';
import 'package:firebase_authentication_repository/authentication_repository.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/theme/theme.dart';
import 'package:flutter/material.dart';

import 'features/cart/repos/cart.dart';

import 'features/store/repos/store.dart';

part 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyGlobalObserver();
  await LocalStorageService.init();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (_) => AuthRepository(),
      ),
      RepositoryProvider.value(value: AppProvidersAndRepos.productRepository),
      RepositoryProvider(create: (_) => StoreRepository()),
      RepositoryProvider(create: (_) => CartRepository()),
      RepositoryProvider.value(value: AppProvidersAndRepos.addressRepository)
    ],
    child: MyApp(
      appRouter: AppRouter(),
    ),
  ));
}
