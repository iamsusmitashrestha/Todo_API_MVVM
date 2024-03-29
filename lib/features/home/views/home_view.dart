import 'package:Todo_API_MVVM/common/widgets/k_error.dart';
import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:Todo_API_MVVM/features/home/models/todo.dart';
import 'package:Todo_API_MVVM/features/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => locator<HomeViewModel>(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("My Todos"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: model.logout,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: model.addTodo,
        ),
        body: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.hasError
                ? KError(
                    error: model.modelError,
                    onRetry: model.getTodo,
                  )
                : model.todos.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/add-todo.svg',
                              width: MediaQuery.of(context).size.width * 0.3,
                              fit: BoxFit.cover,
                            ),
                            mHeightSpan,
                            Text(
                              "No Todo Found!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          model.getTodo();
                        },
                        child: ListView.separated(
                          padding: sPagePadding,
                          itemCount: model.todos.length,
                          separatorBuilder: (context, index) => sHeightSpan,
                          itemBuilder: (context, index) {
                            Todo todo = model.todos[index];
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(todo.text),
                                subtitle: Text(
                                  "${todo.dateTime}",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                trailing: model.busy(index)
                                    ? CircularProgressIndicator()
                                    : IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () =>
                                            model.deleteTodo(index),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}
