import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:heelingtouchproject/controllers/auth_helper.dart';
import 'package:heelingtouchproject/model/Ads.dart';
import 'package:heelingtouchproject/model/messege.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/model/user_model.dart';
import 'package:heelingtouchproject/model/videos.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/articles.dart';
import '../model/story.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUserToDB(String userID, String username, String phoneNumber,
      String password) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Patient.json';
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            'userID': userID,
            'patient_username': username,
            'patient_phone_number': phoneNumber,
            'password': password
          }));

      log('responseeeeeeeeeeeeeee ${res.body}');
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
        log(userID);
        usersList.add(UserModel(
            id: userData['userID'],
            phone: userData['patient_phone_number'],
            username: userData['patient_username'],
            password: userData['password']));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
    return usersList;
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
            fName: therapistData['first_name'],
            lName: therapistData['family_name'],
            bio: therapistData['bio'],
            phonenumber: therapistData['mobile_number'],
            img: therapistData["img_profile"],
            status: therapistData["status"],
            email: therapistData["email"]));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
    return usersList;
  }

  Future<void> updateTherapistData(String email, String UserID) async {
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
    // final prodIndex = therapists.indexWhere((element) => element.id == id);
    // if(prodIndex >= 0 )
    // log('cart id=======$id');
    // if (id != null) {
    try {
      log("therapist id= $id");
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist/$id.json';
      http.Response res = await http.patch(Uri.parse(uri),
          body: json.encode({
            'userID': UserID,
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
    // } else {
    //   log('Null');
    // }
    // therapists[prodIndex] = newTherapist;
    // return newTherapist;
  }
  // addUserToFirestore(RegisterRequest registerRequest) async {
  //   try {
  //     // await firebaseFirestore.collection('Users').add(registerRequest.toMap());
  //     await firebaseFirestore
  //         .collection('patients')
  //         .doc(registerRequest.id)
  //         .set(registerRequest.toMap());
  //   } on Exception {
  //     // print(e);
  //   }
  // }

//   late String userName;
//   Future<UserModel> getUserFromFirestore(String userId) async {
//     DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//         await firebaseFirestore.collection('patients').doc(userId).get();
//     userName = UserModel.fromMap(documentSnapshot.data()!).username;

//     return UserModel.fromMap(documentSnapshot.data()!);
//   }

//   Future<List<UserModel>> getAllUsersFromFirestore() async {
//     QuerySnapshot querySnapshot =
//         await firebaseFirestore.collection('patients').get();
//     List docs = querySnapshot.docs;
//     List<UserModel> users =
//         docs.map((e) => UserModel.fromMap(e.data())).toList();

//     return users;
//   }

//   updateProfile(UserModel userModel) async {
//     await firebaseFirestore
//         .collection('patients')
//         .doc(userModel.id)
//         .update(userModel.toMap());
//   }

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
      log('errorrrrrrrrrrrrrrrrrrr: $err');
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
      log('errorrrrrrrrrrrrrrrrrrr: $err');
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
        }
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
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
      log('errorrrrrrrrrrrrrrrrrrr: $err');
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
            // imgs: videoData["art_image"],
            url: videoData["video_url"]));
      });

      log('response of videos ${res.body}');
    } catch (err) {
      log('error of videos: $err');
    }
    return videosList;
  }

  Future<void> requestConsultaion(String userID, String therpistID) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Consultaions.json';
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            // 'therapistID':therapistID,
            'patientID': userID,
            'date': "3:00",
            'type': "chat",
            'therapistID': therpistID
          }));

      log('responseeeeeeeeeeeeeee ${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
  }

  Future<List<Ads>> fetchConsultaions() async {
    List<Ads> adsList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Consultaions.json';
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
            fName: therapistData['first_name'],
            lName: therapistData['family_name'],
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
        if (therapistData['first_name'].contains(txt) == true) {
          therapistsList.add(Therapist(
              id: therapistID,
              therapistID: therapistData['userID'],
              fName: therapistData['first_name'],
              lName: therapistData['family_name'],
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

  Future<Therapist> getTherapist(String id) async {
    Therapist therapist = Therapist(
        id: id,
        therapistID: "idd",
        fName: "fName",
        lName: "lName",
        bio: "bio",
        phonenumber: "phonenumber",
        img: "img",
        status: true,
        email: "password");
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist/$id.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final Map<String, dynamic> responseData = json.decode(res.body);
      String therpistID = responseData['userID'];
      String fName = responseData['first_name'];
      String familyname = responseData['family_name'];
      String bio = responseData['bio'];
      String mobilenumber = responseData['mobile_number'];
      String imgprofile = responseData['img_profile'];
      bool status = responseData['status'];
      String password = "responseData['password']";
      therapist = Therapist(
          id: id,
          therapistID: therpistID,
          fName: fName,
          lName: familyname,
          bio: bio,
          phonenumber: mobilenumber,
          img: imgprofile,
          status: status,
          email: password);

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
    return therapist;
  }

  Future<void> CreateChatRoom(
      String time, String therpistID, MessageModel messege) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Chat.json';
      List<MessageModel> messages = [];
      messages.add(messege);
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            'patientID': AuthHelper.authHelper.getUserId(),
            'time': time,
            'messges': messages,
            'therapistID': therpistID
          }));
      log('patiennnnnnnnnnnnnnnnnnnnnnnnnnnnt ${AuthHelper.authHelper.getUserId()}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
  }

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
      Reference reference = _storage.ref().child("$file");

      final TaskSnapshot snapshot = await reference.putFile(file);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      // final String url = await storageReference.getDownloadURL();

      imageUrl = downloadUrl;
      log('imageUrllllllllllllllllll$downloadUrl');
      // } else {
      //   log('No Path Received');
      // }
    } else {
      log('Grant Permissions and try again');
    }
  }
}
