import 'package:flutter/material.dart';
import 'package:the_project/routes/singInUp/sign_in.dart';
import 'package:the_project/utils/style.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  //final CameraDescription camera;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Spacer(flex: 2),
              Image(image: AssetImage('assets/su_logo.jpeg'),height: 100,),
              Spacer(flex: 3),
              Text(
                "Welcome to SUCHAT \nmessaging app",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Freedom talk the people among SU family!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.64),
                ),
              ),
              Spacer(flex: 3),
              FittedBox(
                child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Skip",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.8),
                          ),
                        ),
                        SizedBox(width: defaultPadding / 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.8),
                        )
                      ],
                    )),
              ),
              Spacer(flex: 1)
            ],
          ),
        ),
      ),
    );
  }
}