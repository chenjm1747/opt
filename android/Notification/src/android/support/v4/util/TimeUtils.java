package android.support.v4.util;

import java.io.PrintWriter;

public class TimeUtils
{
  public static final int HUNDRED_DAY_FIELD_LEN = 19;
  private static final int SECONDS_PER_DAY = 86400;
  private static final int SECONDS_PER_HOUR = 3600;
  private static final int SECONDS_PER_MINUTE = 60;
  private static char[] sFormatStr;
  private static final Object sFormatSync = new Object();

  static
  {
    sFormatStr = new char[24];
  }

  private static int accumField(int paramInt1, int paramInt2, boolean paramBoolean, int paramInt3)
  {
    int i = 99;
    if (paramInt1 <= i)
    {
      if (paramBoolean)
      {
        i = 3;
        if (paramInt3 < i);
      }
    }
    else
      i = paramInt2 + 3;
    while (true)
    {
      return i;
      i = 9;
      if (paramInt1 <= i)
      {
        if (paramBoolean)
        {
          i = 2;
          if (paramInt3 < i);
        }
      }
      else
      {
        i = paramInt2 + 2;
        continue;
      }
      if ((paramBoolean) || (paramInt1 > 0))
      {
        i = paramInt2 + 1;
        continue;
      }
      Object localObject = null;
    }
  }

  public static void formatDuration(long paramLong1, long paramLong2, PrintWriter paramPrintWriter)
  {
    if (paramLong1 == 0L)
      paramLong2.print("--");
    while (true)
    {
      return;
      formatDuration(paramLong1 - ???, paramLong2, 0);
    }
  }

  public static void formatDuration(long paramLong, PrintWriter paramPrintWriter)
  {
    PrintWriter paramPrintWriter;
    formatDuration(paramLong, ???, 0);
  }

  public static void formatDuration(long paramLong, PrintWriter paramPrintWriter, int arg3)
  {
    synchronized (sFormatSync)
    {
      int i = formatDurationLocked(paramLong, paramPrintWriter);
      char[] arrayOfChar = sFormatStr;
      String str = new String(arrayOfChar, 0, i);
      ???.print(str);
      return;
    }
  }

  public static void formatDuration(long paramLong, StringBuilder paramStringBuilder)
  {
    StringBuilder paramStringBuilder = sFormatSync;
    monitorenter;
    int i = 0;
    try
    {
      int j = formatDurationLocked(paramLong, i);
      char[] arrayOfChar = sFormatStr;
      ???.append(arrayOfChar, 0, j);
      monitorexit;
      return;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  private static int formatDurationLocked(long paramLong, int paramInt)
  {
    // Byte code:
    //   0: getstatic 27	android/support/v4/util/TimeUtils:sFormatStr	[C
    //   3: arraylength
    //   4: istore_2
    //   5: iload_1
    //   6: istore_3
    //   7: iload_2
    //   8: iload_3
    //   9: if_icmpge +11 -> 20
    //   12: iload_1
    //   13: newarray char
    //   15: astore_2
    //   16: aload_2
    //   17: putstatic 27	android/support/v4/util/TimeUtils:sFormatStr	[C
    //   20: getstatic 27	android/support/v4/util/TimeUtils:sFormatStr	[C
    //   23: astore 4
    //   25: ldc2_w 32
    //   28: lstore 5
    //   30: lload_0
    //   31: lload 5
    //   33: lcmp
    //   34: lstore_2
    //   35: iload_2
    //   36: ifne +42 -> 78
    //   39: iconst_0
    //   40: istore 7
    //   42: iinc 1 255
    //   45: iload_1
    //   46: istore 8
    //   48: iload 7
    //   50: iload 8
    //   52: if_icmpge +15 -> 67
    //   55: bipush 32
    //   57: istore_2
    //   58: aload 4
    //   60: iload 7
    //   62: iload_2
    //   63: castore
    //   64: goto -19 -> 45
    //   67: aload 4
    //   69: iload 7
    //   71: bipush 48
    //   73: castore
    //   74: iconst_1
    //   75: istore_2
    //   76: iload_2
    //   77: ireturn
    //   78: ldc2_w 32
    //   81: lstore 5
    //   83: lload_0
    //   84: lload 5
    //   86: lcmp
    //   87: lstore_2
    //   88: iload_2
    //   89: ifle +297 -> 386
    //   92: bipush 43
    //   94: istore 9
    //   96: lload_0
    //   97: ldc2_w 62
    //   100: lrem
    //   101: l2i
    //   102: istore 10
    //   104: lload_0
    //   105: ldc2_w 62
    //   108: ldiv
    //   109: l2d
    //   110: invokestatic 69	java/lang/Math:floor	(D)D
    //   113: astore 11
    //   115: dload 5
    //   117: d2i
    //   118: istore 12
    //   120: iconst_0
    //   121: istore 13
    //   123: iconst_0
    //   124: istore 14
    //   126: iconst_0
    //   127: istore 15
    //   129: ldc 10
    //   131: istore_2
    //   132: iload 12
    //   134: iload_2
    //   135: if_icmple +22 -> 157
    //   138: iload 12
    //   140: ldc 10
    //   142: idiv
    //   143: istore 13
    //   145: ldc 10
    //   147: iload 13
    //   149: imul
    //   150: istore_2
    //   151: iload 12
    //   153: iload_2
    //   154: isub
    //   155: istore 12
    //   157: sipush 3600
    //   160: istore_2
    //   161: iload 12
    //   163: iload_2
    //   164: if_icmple +24 -> 188
    //   167: iload 12
    //   169: sipush 3600
    //   172: idiv
    //   173: istore 14
    //   175: iload 14
    //   177: sipush 3600
    //   180: imul
    //   181: istore_2
    //   182: iload 12
    //   184: iload_2
    //   185: isub
    //   186: istore 12
    //   188: bipush 60
    //   190: istore_2
    //   191: iload 12
    //   193: iload_2
    //   194: if_icmple +22 -> 216
    //   197: iload 12
    //   199: bipush 60
    //   201: idiv
    //   202: istore 15
    //   204: iload 15
    //   206: bipush 60
    //   208: imul
    //   209: istore_2
    //   210: iload 12
    //   212: iload_2
    //   213: isub
    //   214: istore 12
    //   216: iconst_0
    //   217: istore 7
    //   219: iload_1
    //   220: ifeq +196 -> 416
    //   223: iconst_1
    //   224: istore_2
    //   225: iconst_0
    //   226: istore 16
    //   228: iload 13
    //   230: iload_2
    //   231: aconst_null
    //   232: iload 16
    //   234: invokestatic 71	android/support/v4/util/TimeUtils:accumField	(IIZI)I
    //   237: astore 17
    //   239: iconst_1
    //   240: istore 11
    //   242: iload 17
    //   244: ifle +152 -> 396
    //   247: iconst_1
    //   248: istore_2
    //   249: iconst_2
    //   250: istore 16
    //   252: iload 14
    //   254: iload 11
    //   256: aload_2
    //   257: iload 16
    //   259: invokestatic 71	android/support/v4/util/TimeUtils:accumField	(IIZI)I
    //   262: astore_2
    //   263: iload 17
    //   265: iload_2
    //   266: iadd
    //   267: istore 17
    //   269: iconst_1
    //   270: istore 11
    //   272: iload 17
    //   274: ifle +127 -> 401
    //   277: iconst_1
    //   278: istore_2
    //   279: iconst_2
    //   280: istore 16
    //   282: iload 15
    //   284: iload 11
    //   286: aload_2
    //   287: iload 16
    //   289: invokestatic 71	android/support/v4/util/TimeUtils:accumField	(IIZI)I
    //   292: astore_2
    //   293: iload 17
    //   295: iload_2
    //   296: iadd
    //   297: istore 17
    //   299: iconst_1
    //   300: istore 11
    //   302: iload 17
    //   304: ifle +102 -> 406
    //   307: iconst_1
    //   308: istore_2
    //   309: iload 12
    //   311: iload 11
    //   313: aload_2
    //   314: iconst_2
    //   315: invokestatic 71	android/support/v4/util/TimeUtils:accumField	(IIZI)I
    //   318: astore_2
    //   319: iload 17
    //   321: iload_2
    //   322: iadd
    //   323: istore 17
    //   325: iconst_2
    //   326: istore 11
    //   328: iconst_1
    //   329: istore 16
    //   331: iload 17
    //   333: ifle +78 -> 411
    //   336: iconst_3
    //   337: istore_2
    //   338: iload 10
    //   340: iload 11
    //   342: iload 16
    //   344: iload_2
    //   345: invokestatic 71	android/support/v4/util/TimeUtils:accumField	(IIZI)I
    //   348: astore_2
    //   349: iinc 2 1
    //   352: iload 17
    //   354: iload_2
    //   355: iadd
    //   356: istore 17
    //   358: iload_1
    //   359: istore 18
    //   361: iload 17
    //   363: iload 18
    //   365: if_icmpge +51 -> 416
    //   368: bipush 32
    //   370: istore_2
    //   371: aload 4
    //   373: iload 7
    //   375: iload_2
    //   376: castore
    //   377: iinc 7 1
    //   380: iinc 17 1
    //   383: goto -25 -> 358
    //   386: bipush 45
    //   388: istore 9
    //   390: lload_0
    //   391: lneg
    //   392: lstore_0
    //   393: goto -297 -> 96
    //   396: aconst_null
    //   397: astore_2
    //   398: goto -149 -> 249
    //   401: aconst_null
    //   402: astore_2
    //   403: goto -124 -> 279
    //   406: aconst_null
    //   407: astore_2
    //   408: goto -99 -> 309
    //   411: iconst_0
    //   412: istore_2
    //   413: goto -75 -> 338
    //   416: aload 4
    //   418: iload 7
    //   420: iload 9
    //   422: castore
    //   423: iinc 7 1
    //   426: iload 7
    //   428: istore 19
    //   430: iload_1
    //   431: ifeq +258 -> 689
    //   434: iconst_1
    //   435: istore 20
    //   437: bipush 100
    //   439: istore_2
    //   440: aload 4
    //   442: iload 13
    //   444: iload_2
    //   445: iload 7
    //   447: aconst_null
    //   448: iconst_0
    //   449: invokestatic 75	android/support/v4/util/TimeUtils:printField	([CICIZI)I
    //   452: astore 7
    //   454: bipush 104
    //   456: istore 21
    //   458: iload 19
    //   460: istore 22
    //   462: iload 7
    //   464: iload 22
    //   466: if_icmpeq +229 -> 695
    //   469: iconst_1
    //   470: istore 23
    //   472: aload 20
    //   474: ifnull +227 -> 701
    //   477: iconst_2
    //   478: istore 24
    //   480: aload 4
    //   482: astore 25
    //   484: iload 14
    //   486: istore 26
    //   488: iload 7
    //   490: istore 27
    //   492: aload 25
    //   494: iload 26
    //   496: iload 21
    //   498: iload 27
    //   500: aload 23
    //   502: iload 24
    //   504: invokestatic 75	android/support/v4/util/TimeUtils:printField	([CICIZI)I
    //   507: astore 7
    //   509: bipush 109
    //   511: istore 21
    //   513: iload 19
    //   515: istore 28
    //   517: iload 7
    //   519: iload 28
    //   521: if_icmpeq +186 -> 707
    //   524: iconst_1
    //   525: istore 23
    //   527: aload 20
    //   529: ifnull +184 -> 713
    //   532: iconst_2
    //   533: istore 24
    //   535: aload 4
    //   537: astore 29
    //   539: iload 15
    //   541: istore 30
    //   543: iload 7
    //   545: istore 31
    //   547: aload 29
    //   549: iload 30
    //   551: iload 21
    //   553: iload 31
    //   555: aload 23
    //   557: iload 24
    //   559: invokestatic 75	android/support/v4/util/TimeUtils:printField	([CICIZI)I
    //   562: astore 7
    //   564: bipush 115
    //   566: istore 21
    //   568: iload 19
    //   570: istore 32
    //   572: iload 7
    //   574: iload 32
    //   576: if_icmpeq +143 -> 719
    //   579: iconst_1
    //   580: istore 23
    //   582: aload 20
    //   584: ifnull +141 -> 725
    //   587: iconst_2
    //   588: istore 24
    //   590: aload 4
    //   592: astore 33
    //   594: iload 12
    //   596: istore 34
    //   598: iload 7
    //   600: istore 35
    //   602: aload 33
    //   604: iload 34
    //   606: iload 21
    //   608: iload 35
    //   610: aload 23
    //   612: iload 24
    //   614: invokestatic 75	android/support/v4/util/TimeUtils:printField	([CICIZI)I
    //   617: astore 7
    //   619: bipush 109
    //   621: istore 21
    //   623: iconst_1
    //   624: istore 23
    //   626: aload 20
    //   628: ifnull +103 -> 731
    //   631: iload 19
    //   633: istore 36
    //   635: iload 7
    //   637: iload 36
    //   639: if_icmpeq +92 -> 731
    //   642: iconst_3
    //   643: istore 24
    //   645: aload 4
    //   647: astore 37
    //   649: iload 10
    //   651: istore 38
    //   653: iload 7
    //   655: istore 39
    //   657: aload 37
    //   659: iload 38
    //   661: iload 21
    //   663: iload 39
    //   665: iload 23
    //   667: iload 24
    //   669: invokestatic 75	android/support/v4/util/TimeUtils:printField	([CICIZI)I
    //   672: astore 40
    //   674: aload 4
    //   676: iload 7
    //   678: bipush 115
    //   680: castore
    //   681: iload 7
    //   683: iconst_1
    //   684: iadd
    //   685: istore_2
    //   686: goto -610 -> 76
    //   689: aconst_null
    //   690: astore 20
    //   692: goto -255 -> 437
    //   695: aconst_null
    //   696: astore 23
    //   698: goto -226 -> 472
    //   701: iconst_0
    //   702: istore 24
    //   704: goto -224 -> 480
    //   707: aconst_null
    //   708: astore 23
    //   710: goto -183 -> 527
    //   713: iconst_0
    //   714: istore 24
    //   716: goto -181 -> 535
    //   719: aconst_null
    //   720: astore 23
    //   722: goto -140 -> 582
    //   725: iconst_0
    //   726: istore 24
    //   728: goto -138 -> 590
    //   731: iconst_0
    //   732: istore 24
    //   734: goto -89 -> 645
  }

  private static int printField(char[] paramArrayOfChar, int paramInt1, char paramChar, int paramInt2, boolean paramBoolean, int paramInt3)
  {
    if ((paramBoolean) || (paramInt1 > 0))
    {
      int i = paramInt2;
      if (((paramBoolean) && (paramInt3 >= 3)) || (paramInt1 > 99))
      {
        int j = paramInt1 / 100;
        int k = (char)(j + 48);
        paramArrayOfChar[paramInt2] = k;
        paramInt2++;
        int m = j * 100;
        paramInt1 -= m;
      }
      if (((paramBoolean) && (paramInt3 >= 2)) || (paramInt1 > 9) || (i != paramInt2))
      {
        int n = paramInt1 / 10;
        int i1 = (char)(n + 48);
        paramArrayOfChar[paramInt2] = i1;
        paramInt2++;
        int i2 = n * 10;
        paramInt1 -= i2;
      }
      int i3 = (char)(paramInt1 + 48);
      paramArrayOfChar[paramInt2] = i3;
      paramInt2++;
      paramArrayOfChar[paramInt2] = paramChar;
      paramInt2++;
    }
    return paramInt2;
  }
}