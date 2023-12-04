import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/user.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constant.BASE_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/user')
  Future<void> register(@Body() User user);

  @POST("/user/checkemailexist/{email}")
  Future<Map<String, String>> checkEmailExists(@Path("email") String email);
}
