import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/api/api_bloc.dart';
import 'package:sample_flutter/bloc/api/api_event.dart';
import 'package:sample_flutter/bloc/api/api_state.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/model/model_list_airline.dart';

class MainFragmentContainer extends StatefulWidget {
  const MainFragmentContainer({super.key});

  @override
  _MainFragmentContainerState createState() => _MainFragmentContainerState();
}

class _MainFragmentContainerState extends State<MainFragmentContainer> {
  int selectedPosition = -1;
  final ApiBloc _apiBloc = ApiBloc();
  int page = 0;
  int size = 10;

  @override
  void initState() {
    _apiBloc.add(GetAirlineList(page: page, size: size));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => _apiBloc,
        child: BlocConsumer<ApiBloc, ApiState>(
            buildWhen: (context, state) {
              return state is ApiLoaded;
            },
            builder: (context, state) {
              if (state is ApiLoading) {
                return _buildLoading();
              } else if (state is ApiLoaded) {
                return _buildContentView(context, state.listAirline);
              } else if (state is ApiError) {
                return _buildEmptyView();
              } else {
                return _buildEmptyView();
              }
            },
            listenWhen: (context, state) {
              return state is ApiError;
            },
            listener: (context, state) {
              if (state is ApiError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            }
        ),
      ),
    );
  }

  // if list is not exist, show this view
  Widget _buildEmptyView() => Container();

  // if list is still loading, show this view
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  // if list is exist, show this view
  Widget _buildContentView(BuildContext context, ListAirline listAirline) {
    return Column(
      children: [
        _buildBodyList(listAirline)
      ],
    );
  }

  Widget _buildBodyList(ListAirline listAirline) {
    return Flexible(
      flex: 1,
      child: Container(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: listAirline.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image(
                      width: 50,
                      image: NetworkImage(listAirline.data![index].airline![0].logo.toString()),
                    ),
                    tileColor: selectedPosition == index ? ColorConstant.blue : null,
                    title: Text(listAirline.data![index].name.toString()),
                    subtitle: Text(listAirline.data![index].airline![0].name.toString()),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
      ),
      );
  }
}
