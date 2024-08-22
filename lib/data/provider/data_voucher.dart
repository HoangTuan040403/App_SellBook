
import 'package:doan_cuahangbansach/data/model/voucher.dart';

createDataList(int amount)
{
  List<Voucher> lstVoucher = [];
  for(int i=1; i <= amount; i++){
    lstVoucher.add(Voucher(
      id:i,
      titleVoucher:"Voucher $i",
      valueVoucher: i/100,
      descVoucher: "Voucher"
    ));
  }
  return lstVoucher;
}