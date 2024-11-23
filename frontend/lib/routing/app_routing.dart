import 'package:frontend/screens/home_screen/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouting {
  // static names
  static const home = '/';
  // static const variable = "/location"

  static final router = GoRouter(
    initialLocation: home,
    routes: <GoRoute>[
      GoRoute(
          name: home,
          path: home,
          builder: (context, state) => const HomeScreen(),
          routes: const [
            /*GoRoute(
              name: variable,
              path: variable
              builder: (context, state) => VariableScreen(state.params['location']))*/
          ])
    ],
  );
}
