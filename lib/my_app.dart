part of 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required AppRouter appRouter})
      : _appRouter = appRouter;

  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Firebase E-commerce Demo',
        themeMode: ThemeMode.system,
        theme: TheAppTheme.lightTheme,
        darkTheme: TheAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.router);
  }
}
