import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/controllers/sp_helper.dart';
import 'package:heelingtouchproject/main.dart';
import 'package:heelingtouchproject/model/Ads.dart';
import 'package:heelingtouchproject/model/chat.dart';
import 'package:heelingtouchproject/model/consultations.dart';
import 'package:heelingtouchproject/model/messege.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/model/user_model.dart';
import 'package:heelingtouchproject/model/videos.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/articles.dart';
import '../model/notification.dart';
import '../model/story.dart';
import 'dart:math' as math;

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUserToDB(
    String userID,
    String username,
    String phoneNumber,
    String address,
    String age,
  ) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Patient.json';
      List<UserModel> users = await getAllUsers();

      if (users.isEmpty) {
        http.Response res = await http.post(Uri.parse(uri),
            body: json.encode({
              'userID': userID,
              'patient_username': username,
              'patient_phone_number': phoneNumber,
              'patient_address': address,
              'patient_age': age,
              'patient_image': imageUrl
            }));
        // await getUser();

        log('response from empty check ${res.body}');
      } else {
        List<String> list = [];
        for (int i = 0; i <= users.length - 1; i++) {
          //   // userID = users[i].userID;

          if (users[i].userID == userID) {
            list.add(users[i].userID);
            log("this patient has been added before");
            // break;
          }
        }
        if (list.isEmpty) {
          http.Response res = await http.post(Uri.parse(uri),
              body: json.encode({
                'userID': userID,
                'patient_username': username,
                'patient_phone_number': phoneNumber,
                'patient_address': address,
                'patient_age': age,
                'patient_image': imageUrl
              }));
        }
      }
    } catch (err) {
      log('error: $err');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> usersList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Patient.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((userID, userData) {
        // log(userID);
        usersList.add(UserModel(
            id: userID,
            userID: userData['userID'],
            phone: userData['patient_phone_number'],
            username: userData['patient_username'],
            address: userData['patient_address'],
            age: userData['patient_age'],
            // password: userData['patient_password'],
            imageUrl: userData['patient_image']));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('error from patient: $err');
    }
    return usersList;
  }

  String? userName;
  String? img;
  String? phone;
  Future<UserModel> getUser() async {
    UserModel? usersList;
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Patient.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((userID, userData) {
        log(userData['userID']);
        log("User id ==================================${AuthHelper.authHelper.firebaseAuth.currentUser!.uid}");
        if (userData['userID'] ==
            AuthHelper.authHelper.firebaseAuth.currentUser!.uid) {
          usersList = UserModel(
              id: userID,
              userID: userData['userID'],
              phone: userData['patient_phone_number'],
              username: userData['patient_username'],
              address: userData['patient_address'],
              age: userData['patient_age'],
              // passwordcvfdd: userData['patient_password'],
              imageUrl: userData['patient_image']);
          userName = userData['patient_username'];
          img = userData['patient_image'];
          phone = "+970${userData['patient_phone_number']}";
        } else {
          log("nooooooooooooo any data");
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('error from patient: $err');
    }
    if (usersList == null) {
      return UserModel(
          id: "id",
          userID: "userID",
          phone: "phone",
          username: "username",
          address: "address",
          age: "age",
          imageUrl: "imageUrl");
    } else {
      return usersList!;
    }
  }

// ignore: non_constant_identifier_names
  Future<void> updatePatientData(
      String name, String address, String age, String userID) async {
    List<UserModel> therapists = await getAllUsers();
    late String id;
    log(therapists.length.toString());
    for (int i = 0; i <= therapists.length - 1; i++) {
      log(therapists.length.toString());
      String name1 = therapists[i].username;
      log(name);
      // log(name1);
      if (userID == therapists[i].userID) {
        id = therapists[i].id;
        log("therapist id id id id id id id= $id");
      }
    }
    try {
      log("therapist id= $id");
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Patient/$id.json';
      if (name == "" || address == "" || age == "" || imageUrl == "") {
        const SnackBar snackBar = SnackBar(
          content: Text(
            '???????? ???????? ????????????????',
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      } else {
        http.Response res = await http.patch(Uri.parse(uri),
            body: json.encode({
              'userID': userID,
              'patient_username': name,
              // 'patient_phone_number': phoneNumber,
              'patient_address': address,
              'patient_age': age,
              // 'patient_password': password,
              'patient_image': imageUrl
            }));
        res;
      }

      // log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      print('error: $err');
    }
  }

  Future<List<Therapist>> getAllThaerapits() async {
    List<Therapist> usersList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((userID, therapistData) {
        log(userID);
        usersList.add(Therapist(
            id: userID,
            therapistID: therapistData['userID'],
            fName: therapistData['full_name'],
            // lName: therapistData['family_name'],
            bio: therapistData['bio'],
            phonenumber: therapistData['mobile_number'],
            img: therapistData["img_profile"],
            status: therapistData["status"],
            email: therapistData["email"]));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr getAllThaerapits: $err');
    }
    return usersList;
  }

  Future<void> updateTherapistData(String email, String userID) async {
    List<Therapist> therapists = await getAllThaerapits();
    late String id;
    log(therapists.length.toString());
    for (int i = 0; i <= therapists.length - 1; i++) {
      log(therapists.length.toString());
      String email1 = therapists[i].email;
      log(email);
      log(email1);
      if (email == email1) {
        id = therapists[i].id;
        log("therapist id id id id id id id= $id");
      }
    }

    try {
      log("therapist id= $id");
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist/$id.json';
      http.Response res = await http.patch(Uri.parse(uri),
          body: json.encode({
            'userID': userID,
            // 'fName': newTherapist.fName,
            // 'lName': newTherapist.lName,
            // 'bio': newTherapist.bio,
            // 'phonenumber': newTherapist.phonenumber,
            // 'img': newTherapist.img,
            // 'status': newTherapist.status,
            // 'email': newTherapist.email
          }));
      res;

      // log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      print('error: $err');
    }
  }

  Future<void> updateTherapistProfileData(
    String userID,
    String fName,
    String lName,
    String bio,
    String phoneNumber,
  ) async {
    List<Therapist> therapists = await getAllThaerapits();
    late String id;
    log(therapists.length.toString());
    for (int i = 0; i <= therapists.length - 1; i++) {
      log(therapists.length.toString());
      String email1 = therapists[i].therapistID;
      // log(email);
      log(email1);
      if (userID == email1) {
        id = therapists[i].id;
        log("therapist id id id id id id id= $id");
      }
    }

    try {
      log("therapist id= $id");
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist/$id.json';
      http.Response res = await http
          .patch(Uri.parse(uri),
              body: json.encode({
                'userID': userID,
                'full_name': fName,
                // 'family_name': lName,
                'bio': bio,
                'mobile_number': phoneNumber,
                'img_profile': imageUrl,
                // 'status': newTherapist.status,
                // 'email': newTherapist.email
              }))
          .whenComplete(() {
        const SnackBar snackBar = SnackBar(
          content: Text(
            '?????? ?????????? ???????????? ??????????',
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      });

      res;

      // log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      print('error: $err');
    }
  }

  Future<List<Consultaion>> therapistConsultaions() async {
    List<Consultaion> consultaionList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Consultaions.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      List<UserModel> patients = await getAllUsers();

      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        String? name;
        String? img;
        log(categoryData['therapistID']);
        if (categoryData['therapistID'] ==
            AuthHelper.authHelper.firebaseAuth.currentUser!.uid) {
          for (int i = 0; i <= patients.length - 1; i++) {
            log(patients[i].username);
            if (categoryData['patientID'] == patients[i].userID) {
              name = patients[i].username;
              img = patients[i].imageUrl;
            }
          }
          consultaionList.add(Consultaion(
              categoryID,
              name!,
              img!,
              categoryData['year'],
              categoryData['month'],
              categoryData['day'],
              categoryData['hour']));
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr therapistConsultaions: $err');
    }
    return consultaionList;
  }

  Future<List<NeatCleanCalendarEvent>>
      therapistConsultaionsForCalender() async {
    List<NeatCleanCalendarEvent> consultaionList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Consultaions.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      List<UserModel> patients = await getAllUsers();

      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        late String name;
        late String img;
        if (categoryData['therapistID'] ==
            AuthHelper.authHelper.firebaseAuth.currentUser!.uid) {
          for (int i = 0; i <= patients.length - 1; i++) {
            if (categoryData['patientID'] == patients[i].userID) {
              name = patients[i].username;
              img = patients[i].imageUrl;
            }
          }
          consultaionList.add(NeatCleanCalendarEvent(
            name.toString(),
            startTime: DateTime(categoryData['year'], categoryData['month'],
                categoryData['day'], categoryData['hour']),
            endTime: DateTime(categoryData['year'], categoryData['month'],
                categoryData['day'], categoryData['hour'], 30),
            color: Colors
                .primaries[math.Random().nextInt(Colors.primaries.length)],
          ));
        }
      });

      log('responseeeeeeeeeeeeeeeee therapistConsultaionsForCalender${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr therapistConsultaionsForCallendr: $err');
    }
    return consultaionList;
  }

  Future<List<Consultaion>> patientConsultaions() async {
    List<Consultaion> consultaionList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Consultaions.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      List<Therapist> therapists = await getAllThaerapits();

      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        String? name;
        String? img;
        if (categoryData['patientID'] ==
            AuthHelper.authHelper.firebaseAuth.currentUser!.uid) {
          for (int i = 0; i <= therapists.length - 1; i++) {
            if (categoryData['therapistID'] == therapists[i].therapistID) {
              name = therapists[i].fName;
              img = therapists[i].img;
            }
          }

          consultaionList.add(Consultaion(
              categoryID,
              name.toString(),
              img.toString(),
              categoryData['year'],
              categoryData['month'],
              categoryData['day'],
              categoryData['hour']));
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('cons patient error: $err');
    }
    return consultaionList;
  }

  Future<void> addNotification(
    String therapistID,
    String patientID,
    String patientImage,
    String therapistImage,
    String patientName,
    String therapistName,
  ) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Notifications.json';
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            'therapistID': therapistID,
            'patientID': patientID,
            'pateintImage': patientImage,
            'therapistImage': therapistImage,
            'pateintName': patientName,
            'therapistName': therapistName,
            // 'content1': "?????? ?????? ???????? ??????????????",
            // 'content2': "?????? ?????? ???????? ???????? ?????????????? ????????!",
            'day': DateTime.now().day,
          }));

      log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr addStory: $err');
    }
  }

  Future<List<Notifications>> fetchNotifications() async {
    List<Notifications> storiesList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Notifications.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        if (AuthHelper.authHelper.firebaseAuth.currentUser!.uid ==
            categoryData['therapistID']) {
          storiesList.add(Notifications(
            id: categoryID,
            therapistID: categoryData['therapistID'],
            patientID: categoryData['patientID'],
            therapistImage: categoryData['therapistImage'],
            patientImage: categoryData['pateintImage'],
            therapistName: categoryData['therapistName'],
            patientName: categoryData['pateintName'],
            // content: categoryData["content2"],
            day: categoryData["day"],
          ));
          log("response from therapists Stories${res.body}");
        } else if (AuthHelper.authHelper.firebaseAuth.currentUser!.uid ==
            categoryData['patientID']) {
          storiesList.add(Notifications(
            id: categoryID,
            therapistID: categoryData['therapistID'],
            patientID: categoryData['patientID'],
            therapistImage: categoryData['therapistImage'],
            patientImage: categoryData['pateintImage'],
            therapistName: categoryData['therapistName'],
            patientName: categoryData['pateintName'],
            // content: categoryData["content1"],
            day: categoryData["day"],
          ));
          log("response from therapists Stories${res.body}");
        } else {
          log("there is no data");
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr in fetch therapist stories: $err');
    }
    return storiesList;
  }

  String imageUrl = "";
  Future<void> addStory(
    String therapistID,
    String description,
  ) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Stories.json';
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            'therapistID': therapistID,
            'description': description,
            'image': imageUrl,
          }));

      log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr addStory: $err');
    }
  }

  Future<List<Stroies>> fetchStoriesFuture() async {
    List<Stroies> storiesList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Stories.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        storiesList.add(Stroies(
          id: categoryID,
          therapistID: categoryData['therapistID'],
          description: categoryData['description'],
          imgs: categoryData["image"],
        ));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr fron fetching stories: $err');
    }
    return storiesList;
  }

  Future<List<Stroies>> fetchTherapistStoriesFuture(String therapistID) async {
    List<Stroies> storiesList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Stories.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        if (therapistID == categoryData['therapistID']) {
          storiesList.add(Stroies(
            id: categoryID,
            therapistID: categoryData['therapistID'],
            description: categoryData['description'],
            imgs: categoryData["image"],
          ));
          log("response from therapists Stories${res.body}");
        } else {
          log("there is no data");
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr in fetch therapist stories: $err');
    }
    return storiesList;
  }

  Future<List<Stroies>> SearchStories(String txt) async {
    List<Stroies> storiesList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Stories.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        if (categoryData["description"].contains(txt) == true) {
          storiesList.add(Stroies(
            id: categoryID,
            therapistID: categoryData['therapistID'],
            description: categoryData['description'],
            imgs: categoryData["image"],
          ));
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr SearchStories: $err');
    }
    return storiesList;
  }

  Future<List<Article>> fetchArticlesFuture() async {
    List<Article> articlesList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Article.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((articleID, articleData) {
        articlesList.add(Article(
          id: articleID,
          title: articleData['article_title'],
          description: articleData['article_description'],
          imgs: articleData["art_image"],
        ));
      });

      log('response of articles ${res.body}');
    } catch (err) {
      log('error of articles: $err');
    }
    return articlesList;
  }

  Future<List<Article>> searchArticles(String txt) async {
    List<Article> articlesList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Article.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((articleID, articleData) {
        if (articleData["article_title"].contains(txt) == true) {
          articlesList.add(Article(
            id: articleID,
            title: articleData['article_title'],
            description: articleData['article_description'],
            imgs: articleData["art_image"],
          ));
        }
      });

      log('response of articles ${res.body}');
    } catch (err) {
      log('error of articles: $err');
    }
    return articlesList;
  }

  Future<List<Video>> fetchVideosFuture() async {
    List<Video> videosList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Video.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((videoID, videoData) {
        videosList.add(Video(
            id: videoID,
            title: videoData['video_title'],
            description: videoData['video_description'],
            imgs: videoData["ved_image"],
            url: videoData["video_url"]));
      });

      log('response of videos ${res.body}');
    } catch (err) {
      log('error of videos: $err');
    }
    return videosList;
  }

  Future<List<Video>> searchVideos(String txt) async {
    List<Video> videosList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Video.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((videoID, videoData) {
        if (videoData["video_title"].contains(txt) == true) {
          videosList.add(Video(
              id: videoID,
              title: videoData['video_title'],
              description: videoData['video_description'],
              imgs: videoData["ved_image"],
              url: videoData["video_url"]));
        }
      });

      log('response of videos ${res.body}');
    } catch (err) {
      log('error of videos: $err');
    }
    return videosList;
  }

  Future<void> requestConsultaion(String userID, String therpistID, int year,
      int month, int day, int hour) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Consultaions.json';
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            // 'therapistID':therapistID,
            'patientID': userID,
            'year': year,
            'month': month,
            'day': day,
            'hour': hour,
            'type': "chat, call",
            'therapistID': therpistID
          }));

      log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr requestConsultaion: $err');
    }
  }

  Future<List<Ads>> fetchAdsFuture() async {
    List<Ads> adsList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Ads.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        adsList.add(Ads(
          img: categoryData["ads_image"],
        ));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
    return adsList;
  }

  Future<List<Therapist>> getTherapists() async {
    List<Therapist> therapistsList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      // final key = Key.fromSecureRandom(32);
      // final iv = IV.fromSecureRandom(16);
      // final encrypter = Encrypter(AES(key));

      extractedData.forEach((therapistID, therapistData) {
        therapistsList.add(Therapist(
            id: therapistID,
            therapistID: therapistData['userID'],
            fName: therapistData['full_name'],
            // lName: therapistData['family_name'],
            bio: therapistData['bio'],
            phonenumber: therapistData['mobile_number'],
            img: therapistData["img_profile"],
            status: therapistData["status"],
            email: therapistData["email"]));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('error from get therapist: $err');
    }
    return therapistsList;
  }

  Future<Therapist> getTherapist() async {
    Therapist? therapistsList;
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((therapistID, therapistData) {
        // log(userID);
        if (therapistData['userID'] ==
            AuthHelper.authHelper.firebaseAuth.currentUser!.uid) {
          therapistsList = Therapist(
              // therapistsList.add(Therapist(
              id: therapistID,
              therapistID: therapistData['userID'],
              fName: therapistData['full_name'],
              // lName: therapistData['family_name'],
              bio: therapistData['bio'],
              phonenumber: therapistData['mobile_number'],
              img: therapistData["img_profile"],
              status: therapistData["status"],
              email: therapistData["email"]);
          // fetchTherapistStoriesFuture(therapistData['userID']);
        } else {
          log("no data");
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('error from patient: $err');
    }
    return therapistsList!;
  }

  Future<List<Therapist>> searchTherapists(String txt) async {
    List<Therapist> therapistsList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((therapistID, therapistData) {
        if (therapistData['full_name'].contains(txt) == true) {
          therapistsList.add(Therapist(
              id: therapistID,
              therapistID: therapistData['userID'],
              fName: therapistData['full_name'],
              // lName: therapistData['family_name'],
              bio: therapistData['bio'],
              phonenumber: therapistData['mobile_number'],
              img: therapistData["img_profile"],
              status: therapistData["status"],
              email: therapistData["email"]));
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
    return therapistsList;
  }

  // Future<Therapist> getTherapist(String id) async {
  //   Therapist? therapist;
  //   try {
  //     String uri =
  //         'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist/$id.json';
  //     http.Response res = await http.get(
  //       Uri.parse(uri),
  //     );
  //     final Map<String, dynamic> responseData = json.decode(res.body);
  //     String therpistID = responseData['userID'];
  //     String fName = responseData['first_name'];
  //     String familyname = responseData['family_name'];
  //     String bio = responseData['bio'];
  //     String mobilenumber = responseData['mobile_number'];
  //     String imgprofile = responseData['img_profile'];
  //     bool status = responseData['status'];
  //     String password = "responseData['password']";
  //     therapist = Therapist(
  //         id: id,
  //         therapistID: therpistID,
  //         fName: fName,
  //         lName: familyname,
  //         bio: bio,
  //         phonenumber: mobilenumber,
  //         img: imgprofile,
  //         status: status,
  //         email: password);

  //     log('responseeeeeeeeeeeeeeeee${res.body}');
  //   } catch (err) {
  //     log('errorrrrrrrrrrrrrrrrrrr: $err');
  //   }
  //   return therapist!;
  // }

  Future<void> createChatRoom(
      String patientName,
      String therapistName,
      String patientImg,
      String therapistImg,
      int time,
      String therpistID,
      MessageModel messege,
      String phone,
      String therapistPhone) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Chat.json';
      List<MessageModel> messages = [];
      messages.add(messege);
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            'patientID': AuthHelper.authHelper.getUserId(),
            'patientName': patientName,
            'therapistName': therapistName,
            'patientImg': patientImg,
            'therapistImg': therapistImg,
            'time': time,
            'patientNumber': phone,
            'therapistNumber': therapistPhone,
            'messges': messages,
            'therapistID': therpistID
          }));
      log('patiennnnnnnnnnnnnnnnnnnnnnnnnnnnt ${AuthHelper.authHelper.getUserId()}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
  }

  Future<List<ChatRoom>> fetchChats() async {
    List<ChatRoom> chatList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Chat.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        if (categoryData['therapistID'] ==
                AuthHelper.authHelper.firebaseAuth.currentUser!.uid ||
            categoryData['patientID'] ==
                AuthHelper.authHelper.firebaseAuth.currentUser!.uid) {
          chatList.add(ChatRoom(
              id: categoryID,
              messages: (categoryData['messges'] as List<dynamic>),
              therapistID: categoryData['therapistID'],
              patientID: categoryData['patientID'],
              patientName: categoryData['patientName'],
              therapistName: categoryData['therapistName'],
              patientImg: categoryData['patientImg'],
              therapistImg: categoryData['therapistImg'],
              patientPhone: categoryData['patientNumber'],
              therapistPhone: categoryData['therapistNumber'],
              time: categoryData['time']));
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('error in fetching chats: $err');
    }
    return chatList;
  }

  Future<List<MessageModel>> fetchmessages() async {
    List<MessageModel> messagesList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Chat.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((categoryID, categoryData) {
        // int index = 1;
        if (categoryData['patientID'] == SpHelper.spHelper.getPatientID() &&
            categoryData['therapistID'] == SpHelper.spHelper.getTherapisID() &&
            categoryData['time'] == int.parse(SpHelper.spHelper.getTimeID())) {
          // log(categoryData['messges'].length.toString());
          for (int i = 0; i <= categoryData['messges'].length - 1; i++) {
            // if (categoryData['messges'][i] == 0) {
            log("lhhhkhhknhhhhhhh");
            // } else {
            messagesList.add(MessageModel(
                content: categoryData['messges'][i + 1]['content'],
                recieverId: categoryData['messges'][i + 1]['recieverId'],
                senderId: categoryData['messges'][i + 1]['senderId'],
                hour: categoryData['messges'][i + 1]['hour']));
            log("cccccccccccccccccc${categoryData['messges'][i + 1]['content']}");
            // }
          }
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('error in fetching messages: $err');
    }
    return messagesList;
  }

  Future<void> updatemessages(
      String content,
      String senderID,
      String receiverID,
      String patientID,
      String therapistID,
      String time) async {
    List<ChatRoom> chats = await fetchChats();
    late String id;
    log(chats.length.toString());
    for (int i = 0; i <= chats.length - 1; i++) {
      log(chats.length.toString());
      // String name1 = chats[i].username;
      // log(name);
      // log(name1);
      if (patientID == chats[i].patientID &&
          therapistID == chats[i].therapistID) {
        id = chats[i].id;
        log("therapist id id id id id id id= $id");
      }
    }
    try {
      log("therapist id= $id");
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Chat/$id.json';
      // List<MessageModel> messages = [];

      if (content == "" || senderID == "" || receiverID == "" || time == "") {
        const SnackBar snackBar = SnackBar(
          content: Text(
            '???????? ???????? ????????????????',
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.red,
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
      } else {
        // messages.add(MessageModel(
        //     content: content,
        //     recieverId: "recieverId",
        //     senderId: "senderId",
        //     hour: "hour"));
        http.Response res = await http.get(
          Uri.parse(uri),
        );
        Map<String, dynamic> map = json.decode(res.body);
        List<dynamic> data = map["messges"];
        data.add(MessageModel(
            content: content,
            recieverId: receiverID,
            senderId: senderID,
            hour: time));
        print(data[0]["content"]);
        res = await http.patch(Uri.parse(uri),
            body: json.encode({
              'messges': data,
              // 'patientID': name,
              // 'patient_phone_number': phoneNumber,
              // 'therapistID': address,
              // 'patient_age': age,
              // 'patient_password': password,
              // 'patient_image': imageUrl
            }));

        res;
      }

      // log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      print('error from update messages: $err');
    }
  }

  //  isRequested = false;
  uploadImage() async {
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      // ignore: deprecated_member_use
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      // if (image) {
      // print('fileeeeeeeeeeeeeeeeeeeeeeee${file.toString()}');
      // String filename = basename(_image.path);
      await Firebase.initializeApp();
      final _storage = FirebaseStorage.instance;
      // Reference storageReference = _storage.ref().child("image/$file");
      // final UploadTask uploadTask = storageReference.putFile(file);
      // final TaskSnapshot downloadUrl = (await uploadTask);
      log('imageUrllllllllllllllllll');
      Reference reference = _storage.ref().child("image/$file");

      final TaskSnapshot snapshot = await reference.putFile(file);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      // final String url = await storageReference.getDownloadURL();

      imageUrl = downloadUrl;
      // if (imageUrl == "") {
      //   isRequested = false;
      // } else {
      //   isRequested = true;
      // }
      log('imageUrllllllllllllllllll$downloadUrl');
      // } else {
      //   log('No Path Received');
      // }
    } else {
      log('Grant Permissions and try again');
    }
  }
}
