# A way to get username from http requests on windows environment!

> NOTE: this implementation is a transcript from java at this link:  https://www.rgagnon.com/javadetails/java-0441.html

## Features

Now, when you are working with ldap, you can get user information from http requests and after you can query ldap to get more user informations from dart!

# Installing

Add `ntlm request` to your pubspec.yaml file:

```yaml
dependencies:
  ntlm_request: 
```

Import `ntlm request` in files that it will be used:

```dart
import 'package:ntlm_request/ntlm_request.dart';
```

## Getting started

Just create an instance of `ntlm request` inside a route and start using it.
Note that the return type of this is an object. I decided to not return a Response
object directly to avoid fixing another package here. This way you can use any http
packages you want, just insert the results into your response statusCode and headers!
```dart
    // inside your http route....
      RetType ret = ntlm.proccessRequest(req.headers);

      if (ret.statusCode != 200) {
        return Response(ret.statusCode, headers: ret.headers);
      }
      if (ret.statusCode == 200 && ret.userName!.isNotEmpty) {
        return Response.ok(ret.userName);
      }
```

## Usage

```dart
  final appRouter = Router();

  appRouter.get('/api/getUserDetails', (Request req) async {
    NtlmRequest ntlm = NtlmRequest();
    RetType ret;
    try {
      ret = ntlm.proccessRequest(req.headers);

      if (ret.statusCode != 200) {
        return Response(ret.statusCode, headers: ret.headers);
      }
      if (ret.statusCode == 200 && ret.userName!.isNotEmpty) {
        return Response.ok(ret.userName);
      }
    } catch (e) {
      log(e.toString());
    }
    return Response(401,
        headers: {'error': 'ntlm user not identified in request header!'});
  });
```

## Additional information

**Show some ❤️ and star the repo to support the project**

