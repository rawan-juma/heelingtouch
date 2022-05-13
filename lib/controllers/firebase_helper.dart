import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:heelingtouchproject/model/therapist.dart';
import 'package:heelingtouchproject/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
      log('errorrrrrrrrrrrrrrrrrrr: $err');
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
    String description,
  ) async {
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Stories.json';
      http.Response res = await http.post(Uri.parse(uri),
          body: json.encode({
            // 'therapistID':therapistID,
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

  Future<List<Therapist>> getTherapists() async {
    List<Therapist> therapistsList = [];
    try {
      String uri =
          'https://heelingtouchproject-default-rtdb.firebaseio.com/Physiotherapist.json';
      http.Response res = await http.get(
        Uri.parse(uri),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      extractedData.forEach((therapistID, therapistData) {
        therapistsList.add(Therapist(
          id: therapistID,
          fName: therapistData['first_name'],
          lName: therapistData['family_name'],
          image: therapistData["img_profile"],
        ));
      });

      log('responseeeeeeeeeeeeeeeee${res.body}');
    } catch (err) {
      log('errorrrrrrrrrrrrrrrrrrr: $err');
    }
    return therapistsList;
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
