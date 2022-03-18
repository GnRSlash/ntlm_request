import 'package:ntlm_request/ntlm_request.dart';

void main() {
  // final appRouter = Router();

  // appRouter.get('/api/getUserDetails', (Request req) async {
  //   NtlmRequest ntlm = NtlmRequest();
  //   RetType ret;
  //   try {
  //     ret = ntlm.proccessRequest(req.headers);

  //     if (ret.statusCode != 200) {
  //       return Response(ret.statusCode, headers: ret.headers);
  //     }
  //     if (ret.statusCode == 200 && ret.userName!.isNotEmpty) {
  //       return Response.ok(ret.userName);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return Response(401,
  //       headers: {'error': 'ntlm user not identified in request header!'});
  // });
}
