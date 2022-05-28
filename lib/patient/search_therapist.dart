import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heelingtouchproject/widgets/therapist_item.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_provider.dart';

// ignore: must_be_immutable
class SearchTherapist extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  SearchTherapist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, x) {
      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 8.h,
              centerTitle: true,
              title: Container(
                width: double.infinity,
                height: 5.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  controller: appProvider.searchController,
                  onSubmitted: (controller) {
                    appProvider.search();
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          appProvider.searchController.clear();
                        },
                      ),
                      hintText: 'بحث',
                      border: InputBorder.none),
                ),
              ),
              backgroundColor: const Color(0xff2FA09C),
              elevation: 0,
              // shadowColor: Colors.grey[100],
              automaticallyImplyLeading: false,
              leadingWidth: 10.w,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  // appProvider.search();
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
            body: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: appProvider.searchedTherapists.map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${e.fName} ${e.lName}"),
                      ),
                      Divider(
                        height: 2.h,
                      )
                    ],
                  );
                }).toList()),
          ));
    });
  }
}
