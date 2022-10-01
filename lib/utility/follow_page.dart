import 'package:flutter/material.dart';
import 'package:mns_management/modals/followup_modal.dart';
import 'package:mns_management/utility/string.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum FollowUpColumn { sno, branchName, customerName, ifscCode, gst, action }

int index = 0;
List<DataGridRow> dataGridRows = [];
List<FollowupModel> dataget = [];

class FollowUpDataSource extends DataGridSource {
  @override
  List<DataGridRow> get rows => dataGridRows;
  FollowUpDataSource({required List<FollowupModel> orderData}) {
    orderData != null
        ? dataGridRows = orderData
            .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
                  DataGridCell(
                      columnName: "branch_name", value: dataGridRow.customerId),
                  DataGridCell<String>(
                      columnName: "customer_name",
                      value: dataGridRow.customerName?.customerName ??
                          nodatafound),
                  DataGridCell<String>(
                      columnName: "ifsc_code", value: dataGridRow.description),
                  DataGridCell<String>(
                      columnName: "gst", value: dataGridRow.email),
                ]))
            .toList()
        : const Center(child: Text(nodatafound));
  }

  @override
  DataGridRowAdapter buildRow(
    DataGridRow row,
  ) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.visible,
          maxLines: 2,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.visible,
          maxLines: 2,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.visible,
          maxLines: 2,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.visible,
          maxLines: 2,
        ),
      ),
    ]);
  }
}
