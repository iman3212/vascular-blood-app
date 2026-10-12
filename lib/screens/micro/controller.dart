import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:image/image.dart' as img;
import 'package:vascular_blood/storage/getx.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/connectionTimeout.dart';
import 'package:vascular_blood/screens/micro/utils.dart';

//HTTP CODE FOR WHITE CAMERA 
// class MicroController extends GetxController {
//   final Maincontroller controller = Get.put(Maincontroller(), permanent: true);

//   RxList<int> imageData = <int>[].obs;
//   RxBool successfullImage = false.obs;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   RxBool isButtonEnabled = true.obs;

//   late File imgFile;
//   Timer? timeoutTimer;

//   late Socket _socket;
//   late StreamController<Image> imageStreamController; // Changed to Image
//   List<int> _buffer = [];
//   late img.Image _currentImage;

//   @override
//   void onInit() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//     imageStreamController = StreamController<Image>();
//     connectToServer();
//     // start();
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     //_socket.close();
//       _socket.destroy();
//     imageStreamController.close();
//     super.dispose();
//   }

//   void connectToServer() async {
//     try {
//      // _socket = await Socket.connect('192.168.4.1', 81);
//       _socket = await Socket.connect('192.168.1.1', 8080);
//       _socket.listen(
//         _handleStreamData,
//         onDone: _onDone,
//         onError: _onError,
//         cancelOnError: true,
//       );
//       _sendGetRequest();
//     } catch (e) {
//       ConnectionTimeoutDialog().showConnectionTimeoutDialog(onRetry: () {
//         Get.back();
//         connectToServer();
//       }, onCancel: () {
//         Get.back();
//       });
//     }
//   }

//   void _sendGetRequest() {
//     String request =
//           "GET /?action=stream HTTP/1.1\r\nHost: 192.168.1.1\r\nConnection: keep-alive\r\n\r\n";
//        // "GET /stream HTTP/1.1\r\nHost: 192.168.4.1\r\nConnection: keep-alive\r\n\r\n";
//     _socket.add(Uint8List.fromList(request.codeUnits));
//   }

//   void _handleStreamData(Uint8List data) {
//     print(data);
//     print('.........................................');
//     _buffer.addAll(data);

//     while (_buffer.isNotEmpty) {
//       int start = _findStartOfImage();
//       if (start == -1 || _buffer.length < start + 2) return;

//       int end = _findEndOfImage(start);
//       if (end == -1 || _buffer.length < end + 2) return;

//       List<int> jpegData = _buffer.sublist(start, end + 2);
//       _buffer = _buffer.sublist(end + 2);

//       img.Image? image = img.decodeImage(Uint8List.fromList(jpegData));

//       if (image != null) {
//         _currentImage = image;
//         imageData.value = jpegData;

//         Image imgWidget =
//             Image.memory(Uint8List.fromList(jpegData), gaplessPlayback: true);
//             if (!imageStreamController.isClosed) {
//         imageStreamController.add(imgWidget);
//       }
//         // imageStreamController.add(imgWidget);
//       }
//     }
//   }

//   int _findStartOfImage() {
//     for (int i = 0; i < _buffer.length - 1; i++) {
//       if (_buffer[i] == 0xFF && _buffer[i + 1] == 0xD8) {
//         return i;
//       }
//     }
//     return -1;
//   }

//   int _findEndOfImage(int start) {
//     for (int i = start + 2; i < _buffer.length - 1; i++) {
//       if (_buffer[i] == 0xFF && _buffer[i + 1] == 0xD9) {
//         return i;
//       }
//     }
//     return -1;
//   }

//   void _onDone() {
//     _socket.close();
//     imageStreamController.close();
//   }

//   void _onError(error) {
//     print("Error: $error");
//   }

//   Future<void> createImageFile() async {
//     if (!isButtonEnabled.value) return;
//     isButtonEnabled.value = false;

//     final directory = await getTemporaryDirectory();
//     final filepath =
//         '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//     imgFile = File(filepath);

//     if (imageData.isNotEmpty) {
//       _playAudio();
//       successfullImage.value = true;
//       await Future.delayed(const Duration(seconds: 2));

//       Logger().i("Writing ${imageData.length} bytes to file at: $filepath");
//       imgFile.writeAsBytesSync(imageData);

//       if (controller.capturedImages[0] == null) {
//         controller.capturedImages[0] = imgFile;
//         dispose();
//         SystemChrome.setPreferredOrientations([
//           DeviceOrientation.landscapeRight,
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ]);
//         Get.offNamed('/guid', arguments: imgFile);
//       } else if (controller.capturedImages[1] == null) {
//         dispose();
//         SystemChrome.setPreferredOrientations([
//           DeviceOrientation.landscapeRight,
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ]);
//         controller.capturedImages[1] = imgFile;
//         Get.offNamed(Routes.checkSecound, arguments: imgFile);
//       } else if (controller.capturedImages[0] != null &&
//           controller.capturedImages[1] != null) {
//         controller.capturedImages.value =
//             List<File?>.filled(2, null, growable: false);
//         controller.capturedImages[0] = imgFile;
//         Get.offNamed('/guid');
//         Logger().e("Unexpectedly both list indices are full!");
//       }
//     } else {
//       Logger().e("No valid image data available to write.");
//       isButtonEnabled.value = true;
//     }
//   }

//   Future<void> _playAudio() async {
//     await _audioPlayer.play(AssetSource('sounds/camera-shutter1.mp3'));
//   }
// }


//UDP CODE FOR MICROSCOPE IN HITECH (DOCTOR MICROSCOPE IN CANADA IS DIFFERENT !)
class MicroController extends GetxController {
    final MainController controller = Get.put(MainController(), permanent: true);

  
  RxList<int> imageData = <int>[].obs;
  RxBool successfullImage = false.obs;
  final AudioPlayer _audioPlayer = AudioPlayer();

  RxBool isButtonEnabled = true.obs;

  late File imgFile;

  void start() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      udpClient();
    });
  }

  @override
  void onInit() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    start();
    super.onInit();
  }

  Future<void> createImageFile() async {

    if (!isButtonEnabled.value) return;
    isButtonEnabled.value = false;

    final directory = await getTemporaryDirectory();
    final filepath = '${directory.path}/${Random().nextInt(99999)}.jpg';
    imgFile = File(filepath);
    final img = Uint8List.fromList(imageData);

    if (img.length > 0) {
      _playAudio();
      successfullImage.value = true;
      await Future.delayed(const Duration(seconds: 2));

      Logger().i("Writing ${img.length} bytes to file at: $filepath");
      imgFile.writeAsBytesSync(img);
      if (controller.capturedImages[0] == null) {

         controller.capturedImages[0] = imgFile;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        Get.offNamed('/guid',
            arguments: imgFile); // Navigate to the result page
        //First image saved in index 0
      } else if (controller.capturedImages[1] == null) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
 controller.capturedImages[1] = imgFile;
         Get.offNamed(Routes.checkSecound ,arguments: imgFile);
        //secound image saved in index 1
      } else if (controller.capturedImages[0] != null && controller.capturedImages[1] != null) {
        controller.capturedImages.value = List<File?>.filled(2, null, growable: false);
        controller.capturedImages[0] = imgFile;
        Get.offNamed('/checksec');
        Logger().e(
            "unexpectedly both list index are full !"); // Navigate to the result page
      }
    } else {
      // If imageData is not available, exit from function
      Logger().e("No valid image data available to write.");
      isButtonEnabled.value = true;
      createImageFile();
    }
  }

  void udpClient() {
    InternetAddress address = InternetAddress('192.168.1.1');
    int port = 7080;

    RawDatagramSocket.bind(InternetAddress.anyIPv4, port)
        .then((RawDatagramSocket socket) {
      List<int> dataToSend = [32, 54];

      // Sending data
      socket.send(dataToSend, address, port);

      UdpReceiveParser parser = UdpReceiveParser();

      // Receiving data
      socket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = socket.receive();
          if (datagram != null) {
            List<int>? result = parser.parse(datagram.data);
            if (result != null) {
              imageData.value = result;
              
            }
          }
        }
      });
    }).catchError((error) {
       ConnectionTimeoutDialog().showConnectionTimeoutDialog(
        onRetry: () {
           Get.back();
          udpClient(); // Retry logic
           
        },
        onCancel: () {
          Get.back();
        },
      );
    });
  }

//  Function to play the audio from assets
  Future<void> _playAudio() async {
    await _audioPlayer.play(
        AssetSource('sounds/camera-shutter.mp3')); // Audio file in assets
  }
}

