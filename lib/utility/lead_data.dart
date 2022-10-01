import 'package:flutter/material.dart';
import 'package:mns_management/modals/leaddata_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum LeadColumn { id, clientRefNo, clientRefName, customer, branchName }

class LeadDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;
  LeadDataSource({required List<LeadListModel> leadData}) {
    dataGridRows = leadData
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell(columnName: "id", value: dataGridRow.id),
              DataGridCell(
                  columnName: "customer_id", value: dataGridRow.customerId),
              DataGridCell<String>(
                  columnName: "company_name", value: dataGridRow.customerName),
              DataGridCell<String>(
                  columnName: "proforma_invoice_id",
                  value: dataGridRow.country),
              DataGridCell<String>(
                  columnName: "Delivery Type", value: dataGridRow.city),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          // overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          // overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          // overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          // overflow: TextOverflow.visible,
        ),
      ),
    ]);
  }
}
