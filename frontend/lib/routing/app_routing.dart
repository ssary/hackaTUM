import 'package:frontend/screens/create_activity/create_activity_screen.dart';
import 'package:frontend/screens/home_screen/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouting {
  // static names
  static const home = '/';
  static const createActivity = '/create-activity';
  // static const variable = "/location"

  static final router = GoRouter(
    initialLocation: home,
    routes: <GoRoute>[
      GoRoute(
          name: home,
          path: home,
          builder: (context, state) => const HomeScreen(),
          routes: [
            /*GoRoute(
              name: variable,
              path: variable
              builder: (context, state) => VariableScreen(state.params['location']))*/

            GoRoute(
                name: createActivity,
                path: createActivity,
                builder: (context, state) => const CreateActivityScreen())
          ])
    ],
  );
}
