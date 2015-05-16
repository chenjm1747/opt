package android.support.v4.content;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.os.Looper;
import dalvik.annotation.Signature;
import java.util.ArrayList;
import java.util.HashMap;

public class LocalBroadcastManager
{
  private static final boolean DEBUG = false;
  static final int MSG_EXEC_PENDING_BROADCASTS = 1;
  private static final String TAG = "LocalBroadcastManager";
  private static LocalBroadcastManager mInstance;
  private static final Object mLock = new Object();

  @Signature({"Ljava/util/HashMap", "<", "Ljava/lang/String;", "Ljava/util/ArrayList", "<", "Landroid/support/v4/content/LocalBroadcastManager$ReceiverRecord;", ">;>;"})
  private final HashMap mActions;
  private final Context mAppContext;
  private final Handler mHandler;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/content/LocalBroadcastManager$BroadcastRecord;", ">;"})
  private final ArrayList mPendingBroadcasts;

  @Signature({"Ljava/util/HashMap", "<", "Landroid/content/BroadcastReceiver;", "Ljava/util/ArrayList", "<", "Landroid/content/IntentFilter;", ">;>;"})
  private final HashMap mReceivers;

  private LocalBroadcastManager(Context paramContext)
  {
    HashMap localHashMap1 = new HashMap();
    this.mReceivers = localHashMap1;
    HashMap localHashMap2 = new HashMap();
    this.mActions = localHashMap2;
    ArrayList localArrayList = new ArrayList();
    this.mPendingBroadcasts = localArrayList;
    this.mAppContext = paramContext;
    Looper localLooper = paramContext.getMainLooper();
    LocalBroadcastManager.1 local1 = new LocalBroadcastManager.1(this, localLooper);
    this.mHandler = local1;
  }

  private void executePendingBroadcasts()
  {
    BroadcastRecord[] arrayOfBroadcastRecord = null;
    while (true)
    {
      Object localObject3;
      synchronized (this.mReceivers)
      {
        ArrayList localArrayList = this.mPendingBroadcasts;
        int k = localArrayList.size();
        if (k <= 0)
          return;
        arrayOfBroadcastRecord = new BroadcastRecord[k];
        this.mPendingBroadcasts.toArray(arrayOfBroadcastRecord);
        localArrayList = this.mPendingBroadcasts;
        localArrayList.clear();
        localObject3 = null;
        int i = arrayOfBroadcastRecord.length;
        if (localObject3 >= i)
          break;
        BroadcastRecord localBroadcastRecord = arrayOfBroadcastRecord[localObject3];
        int m = null;
        int j = localBroadcastRecord.receivers.size();
        if (m < j)
        {
          BroadcastReceiver localBroadcastReceiver = ((ReceiverRecord)localBroadcastRecord.receivers.get(m)).receiver;
          ??? = this.mAppContext;
          Intent localIntent = localBroadcastRecord.intent;
          localBroadcastReceiver.onReceive((Context)???, localIntent);
          m++;
        }
      }
      localObject3++;
    }
  }

  public static LocalBroadcastManager getInstance(Context paramContext)
  {
    synchronized (mLock)
    {
      LocalBroadcastManager localLocalBroadcastManager = mInstance;
      if (localLocalBroadcastManager == null)
      {
        Context localContext = paramContext.getApplicationContext();
        localLocalBroadcastManager = new LocalBroadcastManager(localContext);
        mInstance = localLocalBroadcastManager;
      }
      localLocalBroadcastManager = mInstance;
      return localLocalBroadcastManager;
    }
  }

  public void registerReceiver(BroadcastReceiver paramBroadcastReceiver, IntentFilter paramIntentFilter)
  {
    synchronized (this.mReceivers)
    {
      ReceiverRecord localReceiverRecord = new ReceiverRecord(paramBroadcastReceiver);
      Object localObject1 = this.mReceivers;
      ArrayList localArrayList1 = (ArrayList)((HashMap)localObject1).get(paramBroadcastReceiver);
      if (localArrayList1 == null)
      {
        localArrayList1 = new ArrayList(1);
        localObject1 = this.mReceivers;
        ((HashMap)localObject1).put(paramBroadcastReceiver, localArrayList1);
      }
      localArrayList1.add(paramIntentFilter);
      for (Object localObject3 = 0; ; localObject3++)
      {
        localObject1 = paramIntentFilter.countActions();
        if (localObject3 >= localObject1)
          break;
        String str = paramIntentFilter.getAction(localObject3);
        localObject1 = this.mActions;
        ArrayList localArrayList2 = (ArrayList)((HashMap)localObject1).get(str);
        if (localArrayList2 == null)
        {
          localArrayList2 = new ArrayList(1);
          localObject1 = this.mActions;
          ((HashMap)localObject1).put(str, localArrayList2);
        }
        localArrayList2.add(localReceiverRecord);
      }
      return;
    }
  }

  // ERROR //
  public boolean sendBroadcast(Intent paramIntent)
  {
    // Byte code:
    //   0: aload_0
    //   1: getfield 58	android/support/v4/content/LocalBroadcastManager:mReceivers	Ljava/util/HashMap;
    //   4: astore_2
    //   5: aload_2
    //   6: monitorenter
    //   7: aload_1
    //   8: invokevirtual 161	android/content/Intent:getAction	()Ljava/lang/String;
    //   11: astore_3
    //   12: aload_0
    //   13: getfield 67	android/support/v4/content/LocalBroadcastManager:mAppContext	Landroid/content/Context;
    //   16: invokevirtual 165	android/content/Context:getContentResolver	()Landroid/content/ContentResolver;
    //   19: astore 4
    //   21: aload_1
    //   22: aload 4
    //   24: invokevirtual 169	android/content/Intent:resolveTypeIfNeeded	(Landroid/content/ContentResolver;)Ljava/lang/String;
    //   27: astore 5
    //   29: aload_1
    //   30: invokevirtual 173	android/content/Intent:getData	()Landroid/net/Uri;
    //   33: astore 6
    //   35: aload_1
    //   36: invokevirtual 176	android/content/Intent:getScheme	()Ljava/lang/String;
    //   39: astore 7
    //   41: aload_1
    //   42: invokevirtual 180	android/content/Intent:getCategories	()Ljava/util/Set;
    //   45: astore 8
    //   47: aload_1
    //   48: invokevirtual 183	android/content/Intent:getFlags	()I
    //   51: bipush 8
    //   53: iand
    //   54: istore 4
    //   56: iload 4
    //   58: ifeq +297 -> 355
    //   61: iconst_1
    //   62: istore 9
    //   64: aload 9
    //   66: ifnull +88 -> 154
    //   69: ldc 21
    //   71: astore 4
    //   73: new 185	java/lang/StringBuilder
    //   76: dup
    //   77: invokespecial 186	java/lang/StringBuilder:<init>	()V
    //   80: astore 10
    //   82: ldc 188
    //   84: astore 11
    //   86: aload 10
    //   88: aload 11
    //   90: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   93: aload 5
    //   95: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   98: astore 12
    //   100: ldc 194
    //   102: astore 13
    //   104: aload 12
    //   106: aload 13
    //   108: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   111: aload 7
    //   113: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   116: astore 14
    //   118: ldc 196
    //   120: astore 15
    //   122: aload 14
    //   124: aload 15
    //   126: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   129: astore 16
    //   131: aload_1
    //   132: astore 17
    //   134: aload 16
    //   136: aload 17
    //   138: invokevirtual 199	java/lang/StringBuilder:append	(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   141: invokevirtual 202	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   144: astore 18
    //   146: aload 4
    //   148: aload 18
    //   150: invokestatic 208	android/util/Log:v	(Ljava/lang/String;Ljava/lang/String;)I
    //   153: pop
    //   154: aload_0
    //   155: getfield 60	android/support/v4/content/LocalBroadcastManager:mActions	Ljava/util/HashMap;
    //   158: astore 4
    //   160: aload_1
    //   161: invokevirtual 161	android/content/Intent:getAction	()Ljava/lang/String;
    //   164: astore 19
    //   166: aload 4
    //   168: aload 19
    //   170: invokevirtual 134	java/util/HashMap:get	(Ljava/lang/Object;)Ljava/lang/Object;
    //   173: checkcast 62	java/util/ArrayList
    //   176: astore 20
    //   178: aload 20
    //   180: ifnull +537 -> 717
    //   183: aload 9
    //   185: ifnull +45 -> 230
    //   188: ldc 21
    //   190: astore 4
    //   192: new 185	java/lang/StringBuilder
    //   195: dup
    //   196: invokespecial 186	java/lang/StringBuilder:<init>	()V
    //   199: astore 21
    //   201: ldc 210
    //   203: astore 22
    //   205: aload 21
    //   207: aload 22
    //   209: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   212: aload 20
    //   214: invokevirtual 199	java/lang/StringBuilder:append	(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   217: invokevirtual 202	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   220: astore 23
    //   222: aload 4
    //   224: aload 23
    //   226: invokestatic 208	android/util/Log:v	(Ljava/lang/String;Ljava/lang/String;)I
    //   229: pop
    //   230: aconst_null
    //   231: astore 24
    //   233: iconst_0
    //   234: istore 25
    //   236: aload 20
    //   238: invokevirtual 89	java/util/ArrayList:size	()I
    //   241: astore 4
    //   243: iload 25
    //   245: iload 4
    //   247: if_icmpge +358 -> 605
    //   250: aload 20
    //   252: iload 25
    //   254: invokevirtual 103	java/util/ArrayList:get	(I)Ljava/lang/Object;
    //   257: checkcast 9	android/support/v4/content/LocalBroadcastManager$ReceiverRecord
    //   260: astore 26
    //   262: aload 9
    //   264: ifnull +56 -> 320
    //   267: ldc 21
    //   269: astore 4
    //   271: new 185	java/lang/StringBuilder
    //   274: dup
    //   275: invokespecial 186	java/lang/StringBuilder:<init>	()V
    //   278: astore 27
    //   280: ldc 212
    //   282: astore 28
    //   284: aload 27
    //   286: aload 28
    //   288: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   291: astore 29
    //   293: aload 26
    //   295: getfield 215	android/support/v4/content/LocalBroadcastManager$ReceiverRecord:filter	Landroid/content/IntentFilter;
    //   298: astore 30
    //   300: aload 29
    //   302: aload 30
    //   304: invokevirtual 199	java/lang/StringBuilder:append	(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   307: invokevirtual 202	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   310: astore 31
    //   312: aload 4
    //   314: aload 31
    //   316: invokestatic 208	android/util/Log:v	(Ljava/lang/String;Ljava/lang/String;)I
    //   319: pop
    //   320: aload 26
    //   322: getfield 218	android/support/v4/content/LocalBroadcastManager$ReceiverRecord:broadcasting	Z
    //   325: istore 4
    //   327: iload 4
    //   329: ifeq +32 -> 361
    //   332: aload 9
    //   334: ifnull +15 -> 349
    //   337: ldc 21
    //   339: astore 4
    //   341: aload 4
    //   343: ldc 220
    //   345: invokestatic 208	android/util/Log:v	(Ljava/lang/String;Ljava/lang/String;)I
    //   348: pop
    //   349: iinc 25 1
    //   352: goto -116 -> 236
    //   355: aconst_null
    //   356: astore 9
    //   358: goto -294 -> 64
    //   361: aload 26
    //   363: getfield 215	android/support/v4/content/LocalBroadcastManager$ReceiverRecord:filter	Landroid/content/IntentFilter;
    //   366: astore 4
    //   368: aload 4
    //   370: aload_3
    //   371: aload 5
    //   373: aload 7
    //   375: aload 6
    //   377: aload 8
    //   379: ldc 21
    //   381: invokevirtual 224	android/content/IntentFilter:match	(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;Ljava/util/Set;Ljava/lang/String;)I
    //   384: astore 32
    //   386: iload 32
    //   388: iflt +103 -> 491
    //   391: aload 9
    //   393: ifnull +56 -> 449
    //   396: ldc 21
    //   398: astore 4
    //   400: new 185	java/lang/StringBuilder
    //   403: dup
    //   404: invokespecial 186	java/lang/StringBuilder:<init>	()V
    //   407: astore 33
    //   409: ldc 226
    //   411: astore 34
    //   413: aload 33
    //   415: aload 34
    //   417: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   420: astore 35
    //   422: iload 32
    //   424: invokestatic 231	java/lang/Integer:toHexString	(I)Ljava/lang/String;
    //   427: astore 36
    //   429: aload 35
    //   431: aload 36
    //   433: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   436: invokevirtual 202	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   439: astore 37
    //   441: aload 4
    //   443: aload 37
    //   445: invokestatic 208	android/util/Log:v	(Ljava/lang/String;Ljava/lang/String;)I
    //   448: pop
    //   449: aload 24
    //   451: ifnonnull +12 -> 463
    //   454: new 62	java/util/ArrayList
    //   457: dup
    //   458: invokespecial 63	java/util/ArrayList:<init>	()V
    //   461: astore 24
    //   463: aload 24
    //   465: aload 26
    //   467: invokevirtual 145	java/util/ArrayList:add	(Ljava/lang/Object;)Z
    //   470: pop
    //   471: iconst_1
    //   472: istore 4
    //   474: aload 26
    //   476: iload 4
    //   478: putfield 218	android/support/v4/content/LocalBroadcastManager$ReceiverRecord:broadcasting	Z
    //   481: goto -132 -> 349
    //   484: astore 4
    //   486: aload_2
    //   487: monitorexit
    //   488: aload 4
    //   490: athrow
    //   491: aload 9
    //   493: ifnull -144 -> 349
    //   496: iload 32
    //   498: tableswitch	default:+30 -> 528, -4:+86->584, -3:+79->577, -2:+93->591, -1:+100->598
    //   529: <illegal opcode>
    //   530: astore 38
    //   532: ldc 21
    //   534: astore 4
    //   536: new 185	java/lang/StringBuilder
    //   539: dup
    //   540: invokespecial 186	java/lang/StringBuilder:<init>	()V
    //   543: astore 39
    //   545: ldc 235
    //   547: astore 40
    //   549: aload 39
    //   551: aload 40
    //   553: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   556: aload 38
    //   558: invokevirtual 192	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   561: invokevirtual 202	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   564: astore 41
    //   566: aload 4
    //   568: aload 41
    //   570: invokestatic 208	android/util/Log:v	(Ljava/lang/String;Ljava/lang/String;)I
    //   573: pop
    //   574: goto -225 -> 349
    //   577: ldc 237
    //   579: astore 38
    //   581: goto -49 -> 532
    //   584: ldc 239
    //   586: astore 38
    //   588: goto -56 -> 532
    //   591: ldc 241
    //   593: astore 38
    //   595: goto -63 -> 532
    //   598: ldc 243
    //   600: astore 38
    //   602: goto -70 -> 532
    //   605: aload 24
    //   607: ifnull +110 -> 717
    //   610: iconst_0
    //   611: istore 25
    //   613: aload 24
    //   615: invokevirtual 89	java/util/ArrayList:size	()I
    //   618: astore 4
    //   620: iload 25
    //   622: iload 4
    //   624: if_icmpge +27 -> 651
    //   627: aload 24
    //   629: iload 25
    //   631: invokevirtual 103	java/util/ArrayList:get	(I)Ljava/lang/Object;
    //   634: checkcast 9	android/support/v4/content/LocalBroadcastManager$ReceiverRecord
    //   637: astore 4
    //   639: aload 4
    //   641: aconst_null
    //   642: putfield 218	android/support/v4/content/LocalBroadcastManager$ReceiverRecord:broadcasting	Z
    //   645: iinc 25 1
    //   648: goto -35 -> 613
    //   651: aload_0
    //   652: getfield 65	android/support/v4/content/LocalBroadcastManager:mPendingBroadcasts	Ljava/util/ArrayList;
    //   655: astore 4
    //   657: aload_1
    //   658: astore 42
    //   660: new 6	android/support/v4/content/LocalBroadcastManager$BroadcastRecord
    //   663: dup
    //   664: aload 42
    //   666: aload 24
    //   668: invokespecial 246	android/support/v4/content/LocalBroadcastManager$BroadcastRecord:<init>	(Landroid/content/Intent;Ljava/util/ArrayList;)V
    //   671: astore 43
    //   673: aload 4
    //   675: aload 43
    //   677: invokevirtual 145	java/util/ArrayList:add	(Ljava/lang/Object;)Z
    //   680: pop
    //   681: aload_0
    //   682: getfield 80	android/support/v4/content/LocalBroadcastManager:mHandler	Landroid/os/Handler;
    //   685: iconst_1
    //   686: invokevirtual 252	android/os/Handler:hasMessages	(I)Z
    //   689: astore 4
    //   691: iload 4
    //   693: ifne +16 -> 709
    //   696: aload_0
    //   697: getfield 80	android/support/v4/content/LocalBroadcastManager:mHandler	Landroid/os/Handler;
    //   700: astore 4
    //   702: aload 4
    //   704: iconst_1
    //   705: invokevirtual 255	android/os/Handler:sendEmptyMessage	(I)Z
    //   708: pop
    //   709: iconst_1
    //   710: istore 4
    //   712: aload_2
    //   713: monitorexit
    //   714: aload 4
    //   716: ireturn
    //   717: aload_2
    //   718: monitorexit
    //   719: aconst_null
    //   720: astore 4
    //   722: goto -8 -> 714
    //
    // Exception table:
    //   from	to	target	type
    //   7	488	484	finally
    //   528	719	484	finally
  }

  public void sendBroadcastSync(Intent paramIntent)
  {
    if (sendBroadcast(paramIntent))
      executePendingBroadcasts();
  }

  public void unregisterReceiver(BroadcastReceiver paramBroadcastReceiver)
  {
    synchronized (this.mReceivers)
    {
      Object localObject1 = this.mReceivers;
      ArrayList localArrayList1 = (ArrayList)((HashMap)localObject1).remove(paramBroadcastReceiver);
      if (localArrayList1 == null)
        return;
      for (Object localObject3 = 0; ; localObject3++)
      {
        localObject1 = localArrayList1.size();
        if (localObject3 >= localObject1)
          break;
        IntentFilter localIntentFilter = (IntentFilter)localArrayList1.get(localObject3);
        for (Object localObject4 = null; ; localObject4++)
        {
          localObject1 = localIntentFilter.countActions();
          if (localObject4 >= localObject1)
            break;
          String str = localIntentFilter.getAction(localObject4);
          localObject1 = this.mActions;
          ArrayList localArrayList2 = (ArrayList)((HashMap)localObject1).get(str);
          if (localArrayList2 == null)
            continue;
          for (Object localObject5 = null; ; localObject5++)
          {
            localObject1 = localArrayList2.size();
            if (localObject5 >= localObject1)
              break;
            localObject1 = ((ReceiverRecord)localArrayList2.get(localObject5)).receiver;
            if (localObject1 != paramBroadcastReceiver)
              continue;
            localArrayList2.remove(localObject5);
            localObject5--;
          }
          localObject1 = localArrayList2.size();
          if (localObject1 > 0)
            continue;
          localObject1 = this.mActions;
          ((HashMap)localObject1).remove(str);
        }
      }
    }
  }

  class BroadcastRecord
  {

    @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/content/LocalBroadcastManager$ReceiverRecord;", ">;"})
    final ArrayList receivers;

    @Signature({"(", "Landroid/content/Intent;", "Ljava/util/ArrayList", "<", "Landroid/support/v4/content/LocalBroadcastManager$ReceiverRecord;", ">;)V"})
    BroadcastRecord(ArrayList arg2)
    {
      Object localObject;
      this.receivers = localObject;
    }
  }

  class ReceiverRecord
  {
    boolean broadcasting;
    final BroadcastReceiver receiver;

    ReceiverRecord(BroadcastReceiver arg2)
    {
      Object localObject;
      this.receiver = localObject;
    }

    public String toString()
    {
      StringBuilder localStringBuilder = new StringBuilder(128);
      localStringBuilder.append("Receiver{");
      BroadcastReceiver localBroadcastReceiver = this.receiver;
      localStringBuilder.append(localBroadcastReceiver);
      localStringBuilder.append(" filter=");
      IntentFilter localIntentFilter = LocalBroadcastManager.this;
      localStringBuilder.append(localIntentFilter);
      localStringBuilder.append("}");
      return localStringBuilder.toString();
    }
  }
}