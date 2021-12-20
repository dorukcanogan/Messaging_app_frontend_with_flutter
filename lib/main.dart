import 'package:flutter/material.dart';
import 'package:the_project/routes/singInUp/sign_in.dart';
import 'package:the_project/routes/welcome/welcome_screen.dart';
import 'package:the_project/utils/theme.dart';
import 'package:the_project/utils/style.dart';
import 'package:the_project/utils/color.dart';
import 'package:the_project/model/post.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

/*
class Wrapper extends StatelessWidget {

  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MyApp();

      /*
      FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError) {
          print('Cannot connect to firebase: '+snapshot.error.toString());
          return MaterialApp(home: NoFirebaseView());
        }
        if(snapshot.connectionState == ConnectionState.done) {
          print('Firebase connected');
          return MyApp();
        }

        return MaterialApp(home: LoadingView());
      },
    ); */
  }
}
*/


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        home: Welcome()
    );
  }
}



class NoFirebaseView extends StatelessWidget {
  const NoFirebaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
                'Cannot connect to server',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold)
            )
        )
    );
  }
}


class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            )
        )
    );
  }
}


