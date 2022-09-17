import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myglow/common/widgets/error.dart';
import 'package:myglow/firebase_options.dart';
import 'package:myglow/router.dart';
import 'package:myglow/mobile_layout_screen.dart';
import 'common/utils/colors.dart';
import 'common/widgets/loader.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/landing/screens/landing_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Glow',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
        data: (user) {
          if (user == null) {
            return const LandingScreen();
          } else {
            return const MobileLayoutScreen();
          }
        },
        loading: () => const Loader(),
        error: (err, trace){
          return ErrorScreen(
              error: err.toString(),
          );
        }
      ),
    );
  }

}


//        ResponsiveLayout
//         mobileScreenLayout: MobileLayoutScreen(),
//         webScreenLayout: WebLayoutScreen(),


