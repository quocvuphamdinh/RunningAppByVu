import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/models/user.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constant.BASE_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  //user
  @POST('/user')
  Future<HttpResponse<void>> register(@Body() User user);

  @GET("/user/{userName}-{passWord}")
  Future<HttpResponse<User>> login(
      @Path("userName") String userName, @Path("passWord") String passWord);

  @POST("/user/checkemailexist/{email}")
  Future<HttpResponse<Map<String, String>>> checkEmailExists(
      @Path("email") String email);

  @GET("/user/checkemail/{userName}")
  Future<HttpResponse<User>> checkEmailAccount(
      @Path("userName") String userName);

  @POST("/user/checkotpcode/{otp}")
  Future<HttpResponse<Map<String, String>>> checkOTPCode(
      @Path("otp") String otpCode);

  @PUT("/user/resetpassword")
  Future<HttpResponse<Map<String, String>>> resetPassword(@Body() User user);

  //run
  @GET("/run/{userId}")
  Future<HttpResponse<List<Run>>> getRuns(@Path("userId") int userId);

  @POST("/run/{userId}/{userActivitesId}")
  Future<HttpResponse<void>> insertRun(@Body() Run run,
      @Path("userId") int userId, @Path("userActivitesId") int userActivitesId);
}
