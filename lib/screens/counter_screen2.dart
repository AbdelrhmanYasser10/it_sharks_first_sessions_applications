import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcb_test_project/screens/counter_screen1.dart';

import '../cubits/counter_cubit/counter_cubit.dart';

class Counter2 extends StatelessWidget {
  const Counter2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<CounterCubit, CounterState>(
            listener: (context, state) {
            },
            builder: (context, state) {
              var cubit = CounterCubit.get(context);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.increment();
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                  Text(
                    "${cubit.counter}",
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.decrement();
                    },
                    icon: Icon(
                      Icons.remove,
                    ),
                  ),
                ],
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("GO to screen1"),
          ),
        ],
      ),
    );
  }
}
