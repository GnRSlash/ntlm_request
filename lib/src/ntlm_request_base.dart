import 'dart:convert';

/// get user from http request
class NtlmRequest {
  RetType proccessRequest(Map<String, String> headers) {
    RetType defaultRet = RetType(statusCode: 200, headers: {});
    String? auth = headers["Authorization"];

    if (auth == null) {
      return RetType(statusCode: 401, headers: {'WWW-Authenticate': 'NTLM'});
    }
    if (auth.startsWith('NTLM ')) {
      List<int> msg = base64.decode(auth.substring(5));
      int off = 0, length, offset;
      List<int> range;

      if (msg[8] == 1) {
        off = 18;

        int z = 0;
        List<int> msg1 = utf8.encode('NTLMSSP') +
            [
              z,
              2,
              z,
              z,
              z,
              z,
              z,
              z,
              z,
              40,
              z,
              z,
              z,
              1,
              130,
              z,
              z,
              z,
              2,
              2,
              2,
              z,
              z,
              z,
              z,
              z,
              z,
              z,
              z,
              z,
              z,
              z,
              z
            ];

        return RetType(
            statusCode: 401,
            headers: {'WWW-Authenticate': 'NTLM ' + base64.encode(msg1)});
      } else if (msg[8] == 3) {
        off = 30;
        length = msg[off + 17] * 256 + msg[off + 16];
        offset = msg[off + 19] * 256 + msg[off + 18];
        range = msg.getRange(offset, offset + length).toList();
        range.removeWhere((element) => element == 0);
        defaultRet.hostName = String.fromCharCodes(range);
      } else {
        return defaultRet;
      }

      length = msg[off + 1] * 256 + msg[off];
      offset = msg[off + 3] * 256 + msg[off + 2];
      range = msg.getRange(offset, offset + length).toList();
      range.removeWhere((element) => element == 0);
      defaultRet.userDomain = String.fromCharCodes(range);
      length = msg[off + 9] * 256 + msg[off + 8];
      offset = msg[off + 11] * 256 + msg[off + 10];
      range = msg.getRange(offset, offset + length).toList();
      range.removeWhere((element) => element == 0);

      defaultRet.userName = String.fromCharCodes(range);
    }
    return defaultRet;
  }
}

class RetType {
  int statusCode;
  Map<String, String> headers;
  String? hostName;
  String? userName;
  String? userDomain;

  RetType({
    required this.statusCode,
    required this.headers,
    this.hostName,
    this.userName,
    this.userDomain,
  });
}
