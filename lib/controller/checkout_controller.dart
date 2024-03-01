import 'package:get/get.dart';

class CheckoutController extends GetxController{

  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;

  RxInt paymentMethod = 0.obs;

}