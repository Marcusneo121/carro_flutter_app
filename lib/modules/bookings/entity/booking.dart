class Bookings {
  List<Booking>? data;
  String? message;

  Bookings({this.data, this.message});

  Bookings.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Booking>[];
      json['data'].forEach((v) {
        data!.add(Booking.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Booking {
  int? oriBargainId;
  int? id;
  int? transactionId;
  int? renterId;
  int? hostId;
  int? carId;
  String? bargainAmount;
  int? lastBargainUser;
  String? lastBargainAmount;
  int? daysOfRental;
  int? bargainStatusId;
  String? rentFromDate;
  String? rentToDate;
  String? createdAt;
  String? updatedAt;
  int? oriCarId;
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
  bool? isElectric;
  int? oriBargainStatusId;
  String? oriBargainName;
  String? name;

  Booking(
      {this.oriBargainId,
      this.id,
      this.transactionId,
      this.renterId,
      this.hostId,
      this.carId,
      this.bargainAmount,
      this.lastBargainUser,
      this.lastBargainAmount,
      this.daysOfRental,
      this.bargainStatusId,
      this.rentFromDate,
      this.rentToDate,
      this.createdAt,
      this.updatedAt,
      this.oriCarId,
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
      this.isElectric,
      this.oriBargainStatusId,
      this.oriBargainName,
      this.name});

  Booking.fromJson(Map<String, dynamic> json) {
    oriBargainId = json['ori_bargain_id'];
    id = json['id'];
    transactionId = json['transaction_id'];
    renterId = json['renter_id'];
    hostId = json['host_id'];
    carId = json['car_id'];
    bargainAmount = json['bargain_amount'];
    lastBargainUser = json['last_bargain_user'];
    lastBargainAmount = json['last_bargain_amount'];
    daysOfRental = json['days_of_rental'];
    bargainStatusId = json['bargain_status_id'];
    rentFromDate = json['rent_from_date'];
    rentToDate = json['rent_to_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    oriCarId = json['ori_car_id'];
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
    isElectric = json['is_electric'];
    oriBargainStatusId = json['ori_bargain_status_id'];
    oriBargainName = json['ori_bargain_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ori_bargain_id'] = oriBargainId;
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['renter_id'] = renterId;
    data['host_id'] = hostId;
    data['car_id'] = carId;
    data['bargain_amount'] = bargainAmount;
    data['last_bargain_user'] = lastBargainUser;
    data['last_bargain_amount'] = lastBargainAmount;
    data['days_of_rental'] = daysOfRental;
    data['bargain_status_id'] = bargainStatusId;
    data['rent_from_date'] = rentFromDate;
    data['rent_to_date'] = rentToDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['ori_car_id'] = oriCarId;
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
    data['is_electric'] = isElectric;
    data['ori_bargain_status_id'] = oriBargainStatusId;
    data['ori_bargain_name'] = oriBargainName;
    data['name'] = name;
    return data;
  }
}
