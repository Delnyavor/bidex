import 'dart:convert';

dynamic decode(String response) {
  return jsonDecode(response)["data"];
}

String parseApiError(String responseBody) {
  return (jsonDecode(responseBody) as Map<String, dynamic>)["data"]["error"];
}
