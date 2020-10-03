import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/home/home.dart';

class SelectPlan extends StatefulWidget {
  final String courseName, image, price;
  SelectPlan({Key key, this.courseName, this.image, this.price})
      : super(key: key);
  @override
  _SelectPlanState createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String courseName = widget.courseName;
    String courseImage = widget.image;
    String coursePrice = widget.price;

    thanksDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 200.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      border: Border.all(color: textColor, width: 1.0),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 40.0,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Thanks for purchasing!",
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          );
        },
      );

      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        });
      });
    }

    paymentMethodDialog() {
      int selectedRadioPayment = 0;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, setState) {
              setSelectedRadioPayment(int val) {
                setState(() {
                  selectedRadioPayment = val;
                });
              }

              return Dialog(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: 400.0,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Choose payment method",
                        style: TextStyle(
                          fontFamily: 'Signika Negative',
                          fontSize: 21.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: width - 40.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 0,
                          groupValue: selectedRadioPayment,
                          title: Text(
                            "Credit / Debit Card",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          onChanged: (val) {
                            setSelectedRadioPayment(val);
                          },
                          activeColor: textColor,
                          secondary: Image(
                            image: AssetImage(
                              'assets/payment_icon/card.png',
                            ),
                            height: 45.0,
                            width: 45.0,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      ),
                      Container(
                        width: width - 40.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 3,
                          groupValue: selectedRadioPayment,
                          title: Text(
                            "PayPal",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          onChanged: (val) {
                            setSelectedRadioPayment(val);
                          },
                          activeColor: textColor,
                          secondary: Image(
                            image: AssetImage(
                              'assets/payment_icon/paypal.png',
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      ),
                      Container(
                        width: width - 40.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 4,
                          groupValue: selectedRadioPayment,
                          title: Text(
                            "Google Wallet",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          onChanged: (val) {
                            setSelectedRadioPayment(val);
                          },
                          activeColor: textColor,
                          secondary: Image(
                            image: AssetImage(
                              'assets/payment_icon/google_wallet.png',
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              thanksDialog();
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: textColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }

    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 305.0,
              pinned: true,
              forceElevated: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: iconColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: Container(
                        width: width,
                        height: 328.0,
                        padding: EdgeInsets.all(20.0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(courseImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        width: width,
                        height: 328.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: Container(
                        height: 130.0,
                        width: width,
                        padding: EdgeInsets.all(15.0),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              courseName,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Signika Negative',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    paymentMethodDialog();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20.0, left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 1.5,
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'All-Access Pass',
                            style: TextStyle(
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'You will get unlimit access to every class you want for a year. All lessons for you auto-renews annually.',
                            style: TextStyle(
                              fontFamily: 'Signika Negative',
                              fontSize: 17.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '\$499.99/ year',
                            style: TextStyle(
                              fontFamily: 'Signika Negative',
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    paymentMethodDialog();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20.0, left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 1.5,
                          spreadRadius: 1.5,
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'This Class Only',
                            style: TextStyle(
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'A good choice for who want to learn a single class for a long time.',
                            style: TextStyle(
                              fontFamily: 'Signika Negative',
                              fontSize: 17.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '\$$coursePrice/ once',
                            style: TextStyle(
                              fontFamily: 'Signika Negative',
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}
