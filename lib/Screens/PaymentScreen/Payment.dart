import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/BigText.dart';
import 'package:resturantapp/widgets/SmallText.dart';

import '../../widgets/Button.dart';
import 'PaymentInputField.dart';

class PaymentDialogue extends StatelessWidget {
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimension.Height30),
                topRight: Radius.circular(Dimension.Height30))),
        padding: EdgeInsets.symmetric(
            horizontal: Dimension.Width30, vertical: Dimension.Height30 / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const BigText(
              text: 'Payment Information',
            ),
            SizedBox(height: Dimension.Height10),
            SmallText(
              color: Colors.grey,
              text: 'Add Your Card Details',
            ),
            SizedBox(height: Dimension.Height10 * 2),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimension.Width10),
                    child: SmallText(
                      color: Colors.black,
                      text: "Name on card",
                    ),
                  ),
                ),
                SizedBox(height: Dimension.Height10),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimension.Width10),
                    child: SmallText(
                      color: Colors.black,
                      text: "Expiry",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimension.Height10),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Paymentinputfield(
                    type: TextInputType.name,
                    textEditingController: cardNameController,
                  ),
                ),
                SizedBox(width: Dimension.Height10),
                Expanded(
                  flex: 4,
                  child: Paymentinputfield(
                    type: TextInputType.name,
                    textEditingController: expiryController,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimension.Height10 * 2),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimension.Width10),
                    child: SmallText(
                      color: Colors.black,
                      text: "Card Number",
                    ),
                  ),
                ),
                SizedBox(width: Dimension.Height10),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimension.Width10),
                    child: SmallText(
                      color: Colors.black,
                      text: "CVV",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimension.Height10),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Paymentinputfield(
                    type: TextInputType.name,
                    textEditingController: cardNumberController,
                  ),
                ),
                SizedBox(width: Dimension.Height10),
                Expanded(
                  flex: 4,
                  child: Paymentinputfield(
                    type: TextInputType.name,
                    textEditingController: cvvController,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimension.Height10 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.mainColor,
                      minimumSize: Size(Dimension.PaymentBtnWidth,
                          Dimension.PaymentBtnHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(
                    width: Dimension.Width10 *
                        2), // Add some spacing between the buttons
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Dimension.PaymentBtnWidth,
                          Dimension.PaymentBtnHeight),
                      foregroundColor: Colors.white,
                      shadowColor: Colors.black,
                      backgroundColor: AppColors.mainColor, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
