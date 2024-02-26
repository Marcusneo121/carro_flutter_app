import 'dart:io';

class AddCar {
  String? carName;
  String? color;
  String? engineCapacity;
  String? yearMade;
  String? seat;
  String? location;
  File? carMainPic;
  File? carImageOne;
  File? carImageTwo;
  File? carImageThree;
  File? carImageFour;
  String? carPlate;
  String? price;
  DateTime? availableFromDate;
  DateTime? availableToDate;
  bool? isElectric;

  AddCar(
      {this.carName,
      this.color,
      this.engineCapacity,
      this.yearMade,
      this.seat,
      this.location,
      this.carMainPic,
      this.carImageOne,
      this.carImageTwo,
      this.carImageThree,
      this.carImageFour,
      this.carPlate,
      this.price,
      this.availableFromDate,
      this.availableToDate,
      this.isElectric});

  AddCar.fromJson(Map<String, dynamic> json) {
    carName = json['car_name'];
    color = json['color'];
    engineCapacity = json['engine_capacity'];
    yearMade = json['year_made'];
    seat = json['seat'];
    location = json['location'];
    carMainPic = json['car_main_pic'];
    carImageOne = json['car_image_one'];
    carImageTwo = json['car_image_two'];
    carImageThree = json['car_image_three'];
    carImageFour = json['car_image_four'];
    carPlate = json['car_plate'];
    price = json['price'];
    availableFromDate = json['available_from_date'];
    availableToDate = json['available_to_date'];
    isElectric = json['is_electric'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_name'] = carName;
    data['color'] = color;
    data['engine_capacity'] = engineCapacity;
    data['year_made'] = yearMade;
    data['seat'] = seat;
    data['location'] = location;
    data['car_main_pic'] = carMainPic;
    data['car_image_one'] = carImageOne;
    data['car_image_two'] = carImageTwo;
    data['car_image_three'] = carImageThree;
    data['car_image_four'] = carImageFour;
    data['car_plate'] = carPlate;
    data['price'] = price;
    data['available_from_date'] = availableFromDate;
    data['available_to_date'] = availableToDate;
    data['is_electric'] = isElectric;
    return data;
  }
}
