/*
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_app/core/network/api_service.dart';
import 'package:meal_app/features/home/data/repo/home_repo_impl.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<api_service>(api_service(Dio()));
  getIt.registerSingleton<Home_repo_imp>(Home_repo_imp(getIt.get<api_service>()));
}

 */