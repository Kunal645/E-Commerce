import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService{

  get(String endPoint) async {
    var url = Uri.parse(endPoint);
    var response = await http.get(url);
    var data = returnResponse(response);
    return data;
  }

  post(String endPoint, var body) async {
    var url = Uri.parse(endPoint);
    var response = await http.post(url,body: body);
    var data = returnResponse(response);
    return data;
  }

  put(String endPoint, var body) async {
    var url = Uri.parse(endPoint);
    var response = await http.put(url,body: body);
    var data = returnResponse(response);
    return data;
  }


  returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        return json.decode(response.body);
      default:
        throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

}