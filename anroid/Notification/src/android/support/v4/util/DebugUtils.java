package android.support.v4.util;

public class DebugUtils
{
  public static void buildShortClassTag(Object paramObject, StringBuilder paramStringBuilder)
  {
    if (paramObject == null)
      paramStringBuilder.append("null");
    while (true)
    {
      return;
      String str1 = paramObject.getClass().getSimpleName();
      if ((str1 == null) || (str1.length() <= 0))
      {
        str1 = paramObject.getClass().getName();
        int i = str1.lastIndexOf('.');
        if (i > 0)
        {
          int j = i + 1;
          str1 = str1.substring(j);
        }
      }
      paramStringBuilder.append(str1);
      paramStringBuilder.append('{');
      String str2 = Integer.toHexString(System.identityHashCode(paramObject));
      paramStringBuilder.append(str2);
    }
  }
}