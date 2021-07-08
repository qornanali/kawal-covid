class Fixtures {
  static String getIndonesiaSummaryJson() {
    return "[{\"name\":\"Indonesia\",\"positif\":\"2,256,851\",\"sembuh\":\"1,915,147\",\"meninggal\":\"60,027\","
        "\"dirawat\":\"281,677\"}]";
  }

  static String getProvinceSummariesJson() {
    return "[{\"attributes\":{"
        "\"FID\":11,\"Kode_Provi\":31,\"Provinsi\":\"DKI Jakarta\",\"Kasus_Posi\":406205,\"Kasus_Semb\":393166,\"Kasus_Meni\":6625}},"
        "{\"attributes\":{"
        "\"FID\":12,\"Kode_Provi\":32,\"Provinsi\":\"Jawa Barat\",\"Kasus_Posi\":277553,\"Kasus_Semb\":243650,\"Kasus_Meni\":3678}}]";
  }
}
