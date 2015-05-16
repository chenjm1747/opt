package android.support.v4.database;

import android.text.TextUtils;

public class DatabaseUtilsCompat
{
  public static String[] appendSelectionArgs(String[] paramArrayOfString1, String[] paramArrayOfString2)
  {
    int i = 0;
    String[] arrayOfString;
    if ((paramArrayOfString1 == null) || (paramArrayOfString1.length == 0))
      arrayOfString = paramArrayOfString2;
    while (true)
    {
      return arrayOfString;
      int j = paramArrayOfString1.length;
      int k = paramArrayOfString2.length;
      arrayOfString = new String[j + k];
      int m = paramArrayOfString1.length;
      System.arraycopy(paramArrayOfString1, i, arrayOfString, i, m);
      int n = paramArrayOfString1.length;
      int i1 = paramArrayOfString2.length;
      System.arraycopy(paramArrayOfString2, i, arrayOfString, n, i1);
    }
  }

  public static String concatenateWhere(String paramString1, String paramString2)
  {
    if (TextUtils.isEmpty(paramString1));
    while (true)
    {
      return paramString2;
      if (TextUtils.isEmpty(paramString2))
      {
        paramString2 = paramString1;
        continue;
      }
      paramString2 = "(" + paramString1 + ") AND (" + paramString2 + ")";
    }
  }
}