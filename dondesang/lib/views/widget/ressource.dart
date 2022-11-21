import 'package:flutter/cupertino.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 150,
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(125),
          child: const Image(
            image: AssetImage('assets/images/dond.png'),
          ),
        ),
      ),
    );
  }
}
