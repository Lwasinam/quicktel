import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.orange,
                    // Color(0xffA412),
                    BlendMode.softLight,
                  ),
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover)),
        ),
        NiceCurve(),
        GradientBackGround()
      ]),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    ));
  }
}

class GradientBackGround extends StatelessWidget {
  const GradientBackGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 410,
      child: Container(
        padding: EdgeInsets.only(left: 80, right: 80),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            titleWidget(),
            SizedBox(
              height: 10,
            ),
            infoWidget(),
            SizedBox(
              height: 50,
            ),
            getStartedButton()
          ],
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.orange,
                Color(0xff083E88),
              ]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}

class NiceCurve extends StatelessWidget {
  const NiceCurve({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 350,
      left: 130,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
            ),
            color: Colors.blue.withOpacity(0.6)),
      ),
    );
  }
}

class titleWidget extends StatelessWidget {
  const titleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Ti',
          style: TextStyle(
              color: Colors.orange,
              fontFamily: "Montserrat",
              fontSize: 40),
          children: <TextSpan>[
            TextSpan(
              text: 'mart',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontSize: 40),
            ),
          ]),
    );
  }
}

class infoWidget extends StatelessWidget {
  const infoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}

class getStartedButton extends StatelessWidget {
  const getStartedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        child: Text('Get Started',
            style: TextStyle(
              color: Colors.orange,
            )),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          primary: Colors.white,
          textStyle: TextStyle(
            color: Colors.orange,
            fontSize: 20,
          ),
          elevation: 5,
        ),
        onPressed: () {
         Navigator.pushNamed(context, '/signup');
        },
      ),
    );
  }
}
