import 'dart:typed_data';

class UdpReceiveParser {
  List<int> frameBuffer = [];
  int frameId = 0;
  int pkgNum = 0;
  Uint8List? headData;

  List<int>? parse(Uint8List bArr) {
    try {
      if (frameBuffer.length > 101376 || frameId != bArr[0]) {
        frameBuffer.clear();
        pkgNum = 0;
      }

      pkgNum++;
      frameId = bArr[0];
      bool z = bArr[1] == 1;

      frameBuffer = [...frameBuffer, ...bArr.sublist(4)];
      // frameBuffer.setAll(frameBuffer.length, bArr.sublist(4));

      if (z && bArr[2] == pkgNum) {
        return frameBuffer;
      }
    } catch (e) {
      print(e.toString());
    }
    // Add this part 
    return null;
  }
  
}
