import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sample_flutter/bloc/api/api_bloc.dart';
import 'package:sample_flutter/bloc/api/api_event.dart';
import 'package:sample_flutter/bloc/api/api_state.dart';
import 'package:sample_flutter/constants/colorconstant.dart';
import 'package:sample_flutter/model/model_data_airline.dart';
import 'package:sample_flutter/model/model_list_airline.dart';

class MainFragmentContainer extends StatefulWidget {
  const MainFragmentContainer({super.key});

  @override
  _MainFragmentContainerState createState() => _MainFragmentContainerState();
}

class _MainFragmentContainerState extends State<MainFragmentContainer> {
  int selectedPosition = -1;
  final ApiBloc _apiBloc = ApiBloc();
  static int _page = 0;
  static const _size = 10;

  final List<Data>? _dataAirline = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _apiBloc.add(GetAirlineList(page: _page, size: _size));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                if(_dataAirline?.isNotEmpty == true) {
                  // remove circular progress
                  _dataAirline?.removeAt((_dataAirline?.length ?? 0) - 1);
                }

                state.listAirline.data?.asMap().forEach((key, value) {
                  _dataAirline?.add(value);
                });
                _dataAirline?.add(Data()); // for circular item at the end of list

                print("current list: ${_dataAirline?.length}");
                print("current page: ${_page}");

                return _buildContentView(context, _dataAirline);
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
  Widget _buildContentView(BuildContext context, List<Data>? listAirline) {
    return Column(
      children: [
        _buildBodyList(listAirline)
      ],
    );
  }

  Widget _buildBodyList(List<Data>? listAirline) {
    return Flexible(
      flex: 1,
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
              const Duration(seconds: 0), () {
                setState(() {
                  _page = 0;
                  _dataAirline?.clear();
                  _apiBloc.add(GetAirlineList(page: _page, size: _size));
                });
              }
          );
        },
        child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: listAirline?.length ?? 0,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              if(listAirline![index].sId == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListTile(
                  leading: Image(
                    width: 50,
                    image: NetworkImage(listAirline![index].airline![0].logo.toString()),
                  ),
                  tileColor: selectedPosition == index ? ColorConstant.blue : null,
                  title: Text(listAirline[index].name.toString()),
                  subtitle: Text(listAirline[index].airline![0].name.toString()),
                );
              }
            },
            controller: _scrollController..addListener(() {
              if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
                setState(() {
                  _page = _page + 1;
                  _apiBloc.add(GetAirlineList(page: _page, size: _size));
                });
              }
            }),
          ),
        ),
      ),
    );
  }
}
