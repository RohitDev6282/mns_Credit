import 'package:flutter/material.dart';
import 'package:mns_management/modals/marketing_modal.dart';
import 'package:mns_management/utility/string.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum HomeColumn {
  orderId,
  compnayName,
  customerName,
  branchName,
  reportType,
}

class MarketOrderListDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;
  MarketOrderListDataSource({required List<MarketingOrderModel> orderData}) {
    dataGridRows = orderData
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell(
                  columnName: "customer_id",
                  value: dataGridRow.receiptnumber ?? nodatafound),
              DataGridCell<String>(
                  columnName: "company_name",
                  value: dataGridRow.companyName ?? nodatafound),
              DataGridCell<String>(
                  columnName: "customer_name",
                  value: dataGridRow.getcustomer?.customerName ?? nodatafound),
              DataGridCell<String>(
                  columnName: "branch_name",
                  value: dataGridRow.getBranch?.branchName ?? nodatafound),
              DataGridCell<String>(
                  columnName: "report_type",
                  value: dataGridRow.getreportName?.reportType ?? nodatafound),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          row.getCells()[0].value.toString(),
          maxLines: 2,
          overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          row.getCells()[1].value.toString(),
          maxLines: 2,
          overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          row.getCells()[2].value,
          maxLines: 2,
          overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          row.getCells()[3].value.toString(),
          maxLines: 2,
          overflow: TextOverflow.visible,
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.visible,
          maxLines: 2,
        ),
      ),
    ]);
  }
}
