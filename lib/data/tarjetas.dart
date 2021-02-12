

import 'package:stripe_app/model/tarjeta_credito.dart';

final List<TarjetaCredito> tarjetas = <TarjetaCredito>[

  TarjetaCredito(
    cardNumberHidden: '4242',
    cardNumber: '4242424242424242',
    brand: 'visa',
    cvv: '213',
    expiracyDate: '01/25',
    cardHolderName: 'Efrain May'
  ),

  TarjetaCredito(
    cardNumberHidden: '5555',
    cardNumber: '5555555555554444',
    brand: 'mastercard',
    cvv: '213',
    expiracyDate: '01/25',
    cardHolderName: 'Elioenai May'
  ),

  TarjetaCredito(
    cardNumberHidden: '3782',
    cardNumber: '378282246310005',
    brand: 'american express',
    cvv: '2134',
    expiracyDate: '01/25',
    cardHolderName: 'Bitia May'
  ),
];