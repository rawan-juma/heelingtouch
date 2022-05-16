import 'package:flutter/material.dart';
import 'package:heelingtouchproject/therapist/chat_details.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Story2Item extends StatelessWidget {
  String id;
  String description;
  String img;
  Story2Item(this.id, this.description, this.img, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, appProvider, x) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatDetails()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 17.h,
              child: Card(
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 15.h,
                            width: 28.w,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 230, 230, 230),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(img),
                                )),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Visibility(
                            visible: true,
                            child: SizedBox(
                              width: 60.w,
                              child: Text(
                                description,
                                style: const TextStyle(
                                  color: Color(0xff1D1D1D),
                                ),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // SizedBox(
                      //   width: 40.w,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
