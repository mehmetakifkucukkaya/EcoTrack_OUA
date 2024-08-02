

import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ScanController extends GetxController {

  @override
  void onInit() {
    initCamera();
    initTflite();
    super.onInit();
  }

  @override
  void dispose() {
    cameraController.dispose();
    initTflite();
    super.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;
  var isCameraInitialized = false.obs;
  var cameracount = 0;

  initCamera() async {
    if (await Permission.camera
        .request()
        .isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(
          cameras[0],
          ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420);
      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image)
        {
          cameracount++;
          if (cameracount%10==0) {
            cameracount=0;
            objecDetector(image);
          }
         update();
        });
      });
      isCameraInitialized.value = true;
      update();
    }
    else {
      Permission.camera.request();
      print("Permission denided");
    }
  }
initTflite() async {
  await Tflite.loadModel(
    model: "assets/mobilenet_v2.tflite",
    labels: "assets/labels.txt",
    numThreads: 1,
    isAsset: true,
    useGpuDelegate: false,
  );
}
  objecDetector(CameraImage image) async {
    var detector= await Tflite.runModelOnFrame(
        bytesList: image.planes.map((e)
        {
          return e.bytes;
        }).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 2,
        threshold: 0.5,
        asynch: true,
    );
    if (detector!=null) {
      log("object detected $detector");
    }
  }
}