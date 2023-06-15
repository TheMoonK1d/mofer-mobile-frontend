import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart'; //Use this when image is not loaded
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;

import '../Utils/dialog.dart';
import 'login.dart';

class TransferPlant extends StatefulWidget {
  TransferPlant({Key? key, required this.name}) : super(key: key);
  String name;

  @override
  State<TransferPlant> createState() => _TransferPlantState();
}

int qnt = 1;
bool imageAdded = false;
String? plant_name;

class _TransferPlantState extends State<TransferPlant> {
  File? _imageFile;
  final _picker = ImagePicker();
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  Future<void> transferPlant() async {
    // Set the API endpoint URL
    Uri url = Uri.parse('http://192.168.1.4:5000/api/android/transferProduct');

    // Create the multipart request
    var request = http.MultipartRequest('POST', url);

    // Add the plant name, price, and quantity as fields
    request.fields['s_name'] = plant_name!;
    request.fields['price'] = "500";
    request.fields['quantity'] = "3";

    // Create a file stream from the image file
    var stream = http.ByteStream(_imageFile!.openRead());
    var length = await _imageFile!.length();

    // Create a multipart file from the image stream
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: _imageFile.toString());

    // Add the multipart file to the request
    request.files.add(multipartFile);

    // Set the Authorization header
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("Token");
    //String token = 'your_auth_token';
    request.headers['Authorization'] = '$token';

    // Send the request
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Request successful
        print('Data sent successfully!');
        // } else {
        //   // Request failed
        //   print('Failed to send data. Status code: ${response.statusCode}');
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          loadingDialog(context);
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Some thing went wrong try again'),
        ));
      }
    } catch (e) {
      // Request error
      print('Error occurred while sending data: $e');
    }
  }

  @override
  void initState() {
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    plant_name = widget.name;
    super.initState();
  }

  validate() {
    if (imageAdded) {
      debugPrint("${imageAdded.toString()} Image has been added");
      transferPlant();
    } else if (!imageAdded) {
      debugPrint("${imageAdded.toString()} Image has not been added");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You need to add an image first'),
      ));
    } else {
      debugPrint("Something went wrong");
    }
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';

        debugPrint("Test 1");
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'You need to authenticate to confirm transfering your plant, use any method you like',
        options: const AuthenticationOptions(
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        debugPrint("Test 2");
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
        debugPrint("Test 5");
      });
      return;
    }
    if (!mounted) {
      debugPrint("Test 3");
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    debugPrint(_authorized);
    if (_authorized == "Authorized") {
      debugPrint("It is working");
      debugPrint(imageAdded.toString());
      validate();
    } else {
      debugPrint("It is NOT working");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> _cancelAuthentication() async {
    //   await auth.stopAuthentication();
    //   setState(() => _isAuthenticating = false);
    // }

    Color navColor = ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.surfaceTint,
        0);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarColor: navColor,
        statusBarColor: navColor,
        systemNavigationBarDividerColor: navColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
        statusBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Transfer ${widget.name}",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                if (_imageFile == null)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 300,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.03)),
                      child: Center(
                        child: Text(
                          "Add your plant image",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 300,
                      width: 400,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ButtonBar(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: navColor.withOpacity(0.5),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.photo_camera_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async => _pickImageFromCamera(),
                          tooltip: 'Shoot picture',
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: navColor.withOpacity(0.5),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.photo_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async => _pickImageFromGallery(),
                          tooltip: 'Pick from gallery',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.03)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Quantity",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2),
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.exposure_minus_1_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {}),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.start,
                                  "1",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2),
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.plus_one_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {}),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Price",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Expanded(child: Container()),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: 50,
                              width: 175,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2),
                              ),
                              child: Center(
                                  child: TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                ),
                                decoration: InputDecoration(
                                    hintText: "1 ETB",
                                    hintStyle: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    border: InputBorder.none),
                              )),
                            )),
                      ],
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: authenticate,
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: const Color(0xff2a9d8f),
                          elevation: 20,
                          minimumSize: const Size(400, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          _isAuthenticating ? 'Cancel' : 'Finish Transfer',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageAdded = true;
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // imageAdded = true;
      // setState(() => this._imageFile = File(pickedFile.path));
      setState(() {
        imageAdded = true;
        _imageFile = File(pickedFile.path);
      });
    }
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
