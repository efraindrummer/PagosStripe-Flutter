

import 'package:meta/meta.dart';
import 'package:stripe_app/model/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {

  //Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String _secretKey     = 'sk_test_51IKD4sJ0GPbdxhhR6TegWFho799JXnETXTecXDAXE71ZF8F67O4RgCYGyb53yLrpyOPUNZgDI5nXaW4kJK8UtcWg00PGGrlEHw';
  String _apiKey        = 'pk_test_51IKD4sJ0GPbdxhhRUZa4hqjKKttpH9TblaXINS3si0IUICFZYG9oQjdp3DejLjkFaXPX5YdIXoMo5MOwpY7CabXz000X9i7L7g';

  void init(){
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: 'test',
        merchantId: 'test'
      )
    );
  }
  
  Future pagarConTarjetaExistente({
    @required String amount,
    @required String currency,
    @required CreditCard card,
  }) async {

  }

  Future<StripeCustomResponse> pagarConNuevaTarjeta({
    @required String amount,
    @required String currency,
  }) async {

    try {

      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      //Crear los intentos

      return StripeCustomResponse( ok: true );
      
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future pagarApplePayGooglePay({
    @required String amount,
    @required String currency,
  }) async {

  }

  Future _crearPaymentIntent({
    @required String amount,
    @required String currency,
  }) async {
    
  }

  Future _realizarPago({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async {
    
  }
  
}