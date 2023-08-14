import 'package:get/get.dart'; // Importing the Get package for state management.
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart'; // Importing the package for audio querying.
import 'package:permission_handler/permission_handler.dart'; // Importing the package for handling permissions.

class PlayerController extends GetxController {
  final audioQuery =
      OnAudioQuery(); // Creating an instance of the audio query class.

  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var duration = "".obs;
  var position = "".obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit(); // Calling the parent class's onInit method.

    checkPermission(); // Calling the custom method to check and request storage permission.
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  playSong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  changeDuration(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  // Custom method to check and request storage permission.
  checkPermission() async {
    var permission =
        await Permission.storage.request(); // Requesting storage permission.

    if (permission.isGranted) {
      // If the permission is granted
      // Querying songs using the audio query instance with specific options.
    } else {
      // If permission is not granted:
      checkPermission(); // Recursively call the checkPermission method again until permission is granted.
    }
  }
}
