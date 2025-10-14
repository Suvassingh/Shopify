import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "shopify-1ac61",
        "private_key_id": "0789a136950248ea103b617cab32306970160368",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQDOzSiCTbtsflIW\n9iqx8Dm+etI5OTItvZos++pWsbrYbpgfeDFOKpj7AgY1aITuywDIuE+R8SbsEKMT\n60CgIyockP9FwMUHNZLkqcs7/3suWAa1YFk84deaj+NzXEzQKJuyOyE+FfrX15at\ngL4PnmjT/Jvy/oCvmdcY734zLbBarRtylZfTr0NhiZeZTGYMR7xECHTWk+YmODkA\nflLiiiD3a6yi80q6REsIYX1AzYRDZNLNxLYCVaTAdQV2L7vh+MbLCBqelYHmUMkJ\nEnq57EdZN8eUlS97dkEdSuPrYJbNL75uhBgaTP0VrIXoa+0ujxN9OAm0T/qCtqs0\nlXUlmlmXAgMBAAECggEABxzLPeAKiCq4DA4fXctTURfMTyeGcEhLGyz23FB0iqkT\nFlH98CBK7qcdK40StVvKBR1Br1VJ72iLE05OBLPw6Nab0PxWSm8vRCoK0V9yDx/7\n6xULPKrPzYMRYZBVG/upjzG1bPs4i1/g0MrSvprGJDRV8L+MEX4LBdKG1p/Fpvip\nWvgMudhF34XHSKSa5H4o8fkaDC20UkpiA6fBYaF7r16ZnQMDwb7mjiE0Ax9JcLZm\njg3X92wjLB673XFNwA+hTUFqUuzEsoevgZT60LV1Sy5zqKcNthavlIWeWxkaWThY\n8Edc8gX3woSbSPAOykuTWSQRQH0U46QuhREEtYfeMQKBgQDo7qidnMYXRBtMM1Wg\npRSAyoaPimaghuCkVET8FmgXNqcTGSYAUGawfAt5f3dkWxuABTpYcql45rzSZ1gn\nv9k7oO6KDuzcnNhPANXKpKp6c0Tpl9eeTZspfxvveHzgNgU0Uys8eOfvIe4n9d0M\nhZqgLns/UYe0FuaujgdJWQf7KwKBgQDjSAZz+tROcCdU5Au4yPuk26Gx0NyTiTp4\ngGjsVTwC13NlHD5TL6PffDxUlZNkR7VNvAB7ZsX/wPh8LkiQki3tMYOxO30TTuD2\nXguT85uGaJcAnbXNeMVSxG+X6qjxnP46FAtCmZFfq+wL/1pvubj6J4GvvvfSCY+v\nRvoX+Xt1RQKBgGsObY7rJBxDYCx4l41a8f5zlr7YRGzZMNw2IvKdtb+djdJ4R3/z\ndA7/JCL2U8BbI1uGi5dlM8Dug7BMcTbrtQLz506qp3CJ4d0FrD0Ty4q1+eFGuYH3\ndy3uTr+UaAiAq4muA/wqMac1uAjDtpHvwe6HDnw+k5lQwTtO6chrVAC7An95oRHS\n/2iekWZ7B48+VFBW6TKe9icUzVt9ITsFPpfe7W3TrkmsOtJ3xwSCP4mhIL7l2rZn\nU5iiRaK00hADTjdFuDnBnxRQQOYi8jE//B4+z7n/mmawjvEKWhVeNzYyFtH2QsPD\n4GrryBWKVh0PrVRQitPcOVZmELfUFSfBrMFlAoGAC8xn0lMKikCcdX57u1VjpiIJ\n5eVYTucbGX+DxA57QEw/bEb6kKkyCCJRfIgjOIr1Mvg6aKqBWrJKjuOuHsAVthBO\nA1n5M/QM9KBs6iwvkix0S3/xTXMV9SAYHd04OQl5Dft7UN+uPok2X/dcE4Zhgevs\nWYoHRsJikUsa1ctOVhA=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@shopify-1ac61.iam.gserviceaccount.com",
        "client_id": "100878538253469633813",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40shopify-1ac61.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
