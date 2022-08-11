import 'package:flutter/material.dart';

class Guidelines extends StatelessWidget {
  const Guidelines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 215, 202, 21),
      appBar: AppBar(
        title: const Text('Guidelines'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'Make sure your body fits for donation',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1),
              ),
              Container(
                height: sz.height,
                decoration: const BoxDecoration(
                  // color: Colors.purple
                  // gradient: LinearGradient(
                  //     colors: [
                  //       Color(0xFF3366FF),
                  //       Color(0xFF00CCFF),
                  //     ],
                  //     end: FractionalOffset(0.0, 0.0),
                  //     begin: FractionalOffset(1.0, 0.0),
                  //     stops: [0.0, 1.0],
                  //     tileMode: TileMode.clamp),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(    
                      color: const Color.fromARGB(255, 245, 115, 115),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pulse',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 181, 12, 0),
                                  letterSpacing: 1.3),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                              'The pulse rate of the donor should be normal (60 to 100 beats per minute)',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[850], letterSpacing: 1.3),
                            )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: sz.height*.05),
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(    
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 245, 115, 115),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Body\ntemperature',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 181, 12, 0), letterSpacing: 1.3),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                              'Normal body temperature is  98.6°F (37°C)',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[850], letterSpacing: 1.3),
                            )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: sz.height*.05),
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(    
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 245, 115, 115),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Haemoglobin',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 181, 12, 0), letterSpacing: 1.3),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                              ' It should not be less than 12.5 grams per deciliter',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[850], letterSpacing: 1.3),
                            )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: sz.height*.05),
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(    
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 245, 115, 115),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Blood Pressure',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 181, 12, 0)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                              'Systolic and diastolic blood pressure should be within normal range (120/80 mm Hg)',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[850], letterSpacing: 1.3),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
