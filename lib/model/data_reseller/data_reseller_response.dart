class DataResellerResponse {
  bool success;
  String messsage;
  List<DataReseller> data;

  DataResellerResponse({
    required this.success,
    required this.messsage,
    required this.data,
  });

  factory DataResellerResponse.fromJson(Map<String, dynamic> json) =>
      DataResellerResponse(
        success: json["success"],
        messsage: json["messsage"],
        data: List<DataReseller>.from(
          json["data"].map((x) => DataReseller.fromJson(x)),
        ),
      );
}

class DataReseller {
  String mMstGepd;
  String namaGepd;
  String mMstEpd;
  String namaEpd;
  String mBranchId;
  String mName;

  DataReseller({
    required this.mMstGepd,
    required this.namaGepd,
    required this.mMstEpd,
    required this.namaEpd,
    required this.mBranchId,
    required this.mName,
  });

  factory DataReseller.fromJson(Map<String, dynamic> json) => DataReseller(
    mMstGepd: json["m_mst_gepd"],
    namaGepd: json["NamaGEPD"],
    mMstEpd: json["m_mst_epd"],
    namaEpd: json["NamaEPD"],
    mBranchId: json["m_branch_id"],
    mName: json["m_name"],
  );
}
