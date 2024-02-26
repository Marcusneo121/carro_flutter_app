import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/cars/add_car/entity/add_car.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

final dio = DioFactory();

class CarService {
  static Future<NormalApiResponse?> addCar(AddCar carData) async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/car',
        data: FormData.fromMap({
          "car_name": carData.carName.toString(),
          "color": carData.color.toString(),
          "engine_capacity": carData.engineCapacity.toString(),
          "year_made": carData.yearMade.toString(),
          "seat": carData.seat.toString(),
          "location": carData.location.toString(),
          "car_main_pic": await MultipartFile.fromFile(carData.carMainPic!.path,
              filename: carData.carMainPic!.path.split('/').last),
          "car_image_one": await MultipartFile.fromFile(
              carData.carImageOne!.path,
              filename: carData.carImageOne!.path.split('/').last),
          "car_image_two": await MultipartFile.fromFile(
              carData.carImageTwo!.path,
              filename: carData.carImageTwo!.path.split('/').last),
          "car_image_three": await MultipartFile.fromFile(
              carData.carImageThree!.path,
              filename: carData.carImageThree!.path.split('/').last),
          "car_image_four": await MultipartFile.fromFile(
              carData.carImageFour!.path,
              filename: carData.carImageFour!.path.split('/').last),
          "car_plate": carData.carPlate.toString(),
          "price": carData.price.toString(),
          "available_from_date": DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
              .format(carData.availableFromDate!),
          "available_to_date": DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
              .format(carData.availableToDate!),
          // "available_from_date":
          //     carData.availableFromDate?.toUtc().toIso8601String(),
          // "available_to_date":
          //     carData.availableToDate?.toUtc().toIso8601String(),
          "is_electric": carData.isElectric,
        }),
      );

      return NormalApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
  }
}
