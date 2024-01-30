class Car {
  int? id;
  int? userId;
  String? carName;
  String? color;
  String? engineCapacity;
  String? yearMade;
  String? seat;
  String? location;
  String? carMainPic;
  String? carImageOne;
  String? carImageTwo;
  String? carImageThree;
  String? carImageFour;
  String? carPlate;
  String? price;
  String? availableToDate;
  String? availableFromDate;
  String? createdAt;
  String? updatedAt;

  Car(
      {this.id,
      this.userId,
      this.carName,
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
      this.availableToDate,
      this.availableFromDate,
      this.createdAt,
      this.updatedAt});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
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
    availableToDate = json['available_to_date'];
    availableFromDate = json['available_from_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
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
    data['available_to_date'] = availableToDate;
    data['available_from_date'] = availableFromDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}