import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ArticleItem extends StatelessWidget {
  late String title;
  late String description;
  late String img;
  ArticleItem(this.title, this.description, this.img, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      // child: Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 250, horizontal: 15),
        height: 20.h,
        width: 95.w,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color(0xff2FA09C),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(img),
            )),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              colors: [
                // Colors.yellow.w,
                Color.fromARGB(255, 109, 109, 109),
                Color.fromARGB(26, 233, 233, 233),
              ],
              begin: FractionalOffset(1.0, 1.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
