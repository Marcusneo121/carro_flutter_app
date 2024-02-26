import 'dart:io';

class CarImages {
  File? carMainPic;
  File? carImageOne;
  File? carImageTwo;
  File? carImageThree;
  File? carImageFour;

  CarImages({
    this.carMainPic,
    this.carImageOne,
    this.carImageTwo,
    this.carImageThree,
    this.carImageFour,
  });

  CarImages.fromJson(Map<String, dynamic> json) {
    carMainPic = json['car_main_pic'];
    carImageOne = json['car_image_one'];
    carImageTwo = json['car_image_two'];
    carImageThree = json['car_image_three'];
    carImageFour = json['car_image_four'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_main_pic'] = carMainPic;
    data['car_image_one'] = carImageOne;
    data['car_image_two'] = carImageTwo;
    data['car_image_three'] = carImageThree;
    data['car_image_four'] = carImageFour;
    return data;
  }
}
