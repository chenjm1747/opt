package android.support.v4.util;

import dalvik.annotation.Signature;
import java.util.LinkedHashMap;
import java.util.Map;

@Signature({"<K:", "Ljava/lang/Object;", "V:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
public class LruCache
{
  private int createCount;
  private int evictionCount;
  private int hitCount;

  @Signature({"Ljava/util/LinkedHashMap", "<TK;TV;>;"})
  private final LinkedHashMap map;
  private int maxSize;
  private int missCount;
  private int putCount;
  private int size;

  public LruCache(int paramInt)
  {
    if (paramInt <= 0)
      throw new IllegalArgumentException("maxSize <= 0");
    this.maxSize = paramInt;
    LinkedHashMap localLinkedHashMap = new LinkedHashMap(0, 1061158912, true);
    this.map = localLinkedHashMap;
  }

  @Signature({"(TK;TV;)I"})
  private int safeSizeOf(Object paramObject1, Object paramObject2)
  {
    int i = sizeOf(paramObject1, paramObject2);
    if (i < 0)
    {
      String str = "Negative size: " + paramObject1 + "=" + paramObject2;
      throw new IllegalStateException(str);
    }
    return i;
  }

  @Signature({"(TK;)TV;"})
  protected Object create(Object paramObject)
  {
    return null;
  }

  /** @deprecated */
  public final int createCount()
  {
    monitorenter;
    try
    {
      int i = this.createCount;
      monitorexit;
      return i;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  @Signature({"(ZTK;TV;TV;)V"})
  protected void entryRemoved(boolean paramBoolean, Object paramObject1, Object paramObject2, Object paramObject3)
  {
  }

  public final void evictAll()
  {
    trimToSize(-1);
  }

  /** @deprecated */
  public final int evictionCount()
  {
    monitorenter;
    try
    {
      int i = this.evictionCount;
      monitorexit;
      return i;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  @Signature({"(TK;)TV;"})
  public final Object get(Object paramObject)
  {
    if (paramObject == null)
      throw new NullPointerException("key == null");
    monitorenter;
    while (true)
    {
      Object localObject3;
      int n;
      try
      {
        LinkedHashMap localLinkedHashMap1 = this.map;
        localObject3 = localLinkedHashMap1.get(paramObject);
        if (localObject3 == null)
          continue;
        int i = this.hitCount;
        i++;
        this.hitCount = i;
        monitorexit;
        Object localObject4 = localObject3;
        return localObject4;
        i = this.missCount;
        i++;
        this.missCount = i;
        monitorexit;
        localObject4 = create(paramObject);
        if (localObject4 == null)
        {
          n = 0;
          continue;
        }
      }
      finally
      {
        monitorexit;
      }
      monitorenter;
      try
      {
        int j = this.createCount;
        j++;
        this.createCount = j;
        LinkedHashMap localLinkedHashMap2 = this.map;
        localObject3 = localLinkedHashMap2.put(paramObject, n);
        if (localObject3 != null)
        {
          localLinkedHashMap2 = this.map;
          localLinkedHashMap2.put(paramObject, localObject3);
        }
        while (true)
        {
          monitorexit;
          if (localObject3 == null)
            break label189;
          localLinkedHashMap2 = null;
          entryRemoved(localLinkedHashMap2, paramObject, n, localObject3);
          Object localObject5 = localObject3;
          break;
          int k = this.size;
          int i1 = safeSizeOf(paramObject, localObject5);
          k += i1;
          this.size = k;
        }
      }
      finally
      {
        monitorexit;
      }
      label189: int m = this.maxSize;
      trimToSize(m);
    }
  }

  /** @deprecated */
  public final int hitCount()
  {
    monitorenter;
    try
    {
      int i = this.hitCount;
      monitorexit;
      return i;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  /** @deprecated */
  public final int maxSize()
  {
    monitorenter;
    try
    {
      int i = this.maxSize;
      monitorexit;
      return i;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  /** @deprecated */
  public final int missCount()
  {
    monitorenter;
    try
    {
      int i = this.missCount;
      monitorexit;
      return i;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  @Signature({"(TK;TV;)TV;"})
  public final Object put(Object paramObject1, Object paramObject2)
  {
    if ((paramObject1 == null) || (paramObject2 == null))
      throw new NullPointerException("key == null || value == null");
    monitorenter;
    try
    {
      int i = this.putCount;
      i++;
      this.putCount = i;
      i = this.size;
      int k = safeSizeOf(paramObject1, paramObject2);
      i += k;
      this.size = i;
      LinkedHashMap localLinkedHashMap = this.map;
      Object localObject2 = localLinkedHashMap.put(paramObject1, paramObject2);
      if (localObject2 != null)
      {
        int j = this.size;
        int m = safeSizeOf(paramObject1, localObject2);
        j -= m;
        this.size = j;
      }
      monitorexit;
      if (localObject2 != null)
        entryRemoved(null, paramObject1, localObject2, paramObject2);
      int n = this.maxSize;
      trimToSize(n);
      return localObject2;
    }
    finally
    {
      monitorexit;
    }
    throw localObject1;
  }

  /** @deprecated */
  public final int putCount()
  {
    monitorenter;
    try
    {
      int i = this.putCount;
      monitorexit;
      return i;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  @Signature({"(TK;)TV;"})
  public final Object remove(Object paramObject)
  {
    if (paramObject == null)
      throw new NullPointerException("key == null");
    monitorenter;
    try
    {
      LinkedHashMap localLinkedHashMap = this.map;
      Object localObject2 = localLinkedHashMap.remove(paramObject);
      if (localObject2 != null)
      {
        int i = this.size;
        int j = safeSizeOf(paramObject, localObject2);
        i -= j;
        this.size = i;
      }
      monitorexit;
      if (localObject2 != null)
        entryRemoved(null, paramObject, localObject2, null);
      return localObject2;
    }
    finally
    {
      monitorexit;
    }
    throw localObject1;
  }

  /** @deprecated */
  public final int size()
  {
    monitorenter;
    try
    {
      int i = this.size;
      monitorexit;
      return i;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  @Signature({"(TK;TV;)I"})
  protected int sizeOf(Object paramObject1, Object paramObject2)
  {
    return 1;
  }

  /** @deprecated */
  @Signature({"()", "Ljava/util/Map", "<TK;TV;>;"})
  public final Map snapshot()
  {
    monitorenter;
    try
    {
      LinkedHashMap localLinkedHashMap1 = this.map;
      LinkedHashMap localLinkedHashMap2 = new LinkedHashMap(localLinkedHashMap1);
      monitorexit;
      return localLinkedHashMap2;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  /** @deprecated */
  public final String toString()
  {
    int i = 0;
    monitorenter;
    try
    {
      int j = this.hitCount;
      int k = this.missCount;
      int m = j + k;
      if (m != 0)
      {
        j = this.hitCount * 100;
        i = j / m;
      }
      Object[] arrayOfObject = new Object[4];
      Integer localInteger1 = Integer.valueOf(this.maxSize);
      arrayOfObject[0] = localInteger1;
      Integer localInteger2 = Integer.valueOf(this.hitCount);
      arrayOfObject[1] = localInteger2;
      Integer localInteger3 = Integer.valueOf(this.missCount);
      arrayOfObject[2] = localInteger3;
      Integer localInteger4 = Integer.valueOf(i);
      arrayOfObject[3] = localInteger4;
      String str = String.format("LruCache[maxSize=%d,hits=%d,misses=%d,hitRate=%d%%]", arrayOfObject);
      monitorexit;
      return str;
    }
    finally
    {
      localObject = finally;
      monitorexit;
    }
    throw localObject;
  }

  // ERROR //
  public void trimToSize(int paramInt)
  {
    // Byte code:
    //   0: aload_0
    //   1: monitorenter
    //   2: aload_0
    //   3: getfield 109	android/support/v4/util/LruCache:size	I
    //   6: istore_2
    //   7: iload_2
    //   8: iflt +24 -> 32
    //   11: aload_0
    //   12: getfield 45	android/support/v4/util/LruCache:map	Ljava/util/LinkedHashMap;
    //   15: invokevirtual 144	java/util/LinkedHashMap:isEmpty	()Z
    //   18: astore_2
    //   19: iload_2
    //   20: ifeq +62 -> 82
    //   23: aload_0
    //   24: getfield 109	android/support/v4/util/LruCache:size	I
    //   27: istore_2
    //   28: iload_2
    //   29: ifeq +53 -> 82
    //   32: new 53	java/lang/StringBuilder
    //   35: dup
    //   36: invokespecial 54	java/lang/StringBuilder:<init>	()V
    //   39: astore_3
    //   40: aload_0
    //   41: invokevirtual 148	java/lang/Object:getClass	()Ljava/lang/Class;
    //   44: invokevirtual 153	java/lang/Class:getName	()Ljava/lang/String;
    //   47: astore 4
    //   49: aload_3
    //   50: aload 4
    //   52: invokevirtual 60	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   55: ldc 155
    //   57: invokevirtual 60	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   60: invokevirtual 69	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   63: astore 5
    //   65: new 71	java/lang/IllegalStateException
    //   68: dup
    //   69: aload 5
    //   71: invokespecial 72	java/lang/IllegalStateException:<init>	(Ljava/lang/String;)V
    //   74: astore_2
    //   75: aload_2
    //   76: athrow
    //   77: astore_2
    //   78: aload_0
    //   79: monitorexit
    //   80: aload_2
    //   81: athrow
    //   82: aload_0
    //   83: getfield 109	android/support/v4/util/LruCache:size	I
    //   86: istore_2
    //   87: iload_2
    //   88: iload_1
    //   89: if_icmple +15 -> 104
    //   92: aload_0
    //   93: getfield 45	android/support/v4/util/LruCache:map	Ljava/util/LinkedHashMap;
    //   96: invokevirtual 144	java/util/LinkedHashMap:isEmpty	()Z
    //   99: astore_2
    //   100: iload_2
    //   101: ifeq +6 -> 107
    //   104: aload_0
    //   105: monitorexit
    //   106: return
    //   107: aload_0
    //   108: getfield 45	android/support/v4/util/LruCache:map	Ljava/util/LinkedHashMap;
    //   111: invokevirtual 159	java/util/LinkedHashMap:entrySet	()Ljava/util/Set;
    //   114: invokeinterface 165 1 0
    //   119: invokeinterface 171 1 0
    //   124: checkcast 173	java/util/Map$Entry
    //   127: astore 6
    //   129: aload 6
    //   131: invokeinterface 176 1 0
    //   136: astore 7
    //   138: aload 6
    //   140: invokeinterface 179 1 0
    //   145: astore 8
    //   147: aload_0
    //   148: getfield 45	android/support/v4/util/LruCache:map	Ljava/util/LinkedHashMap;
    //   151: aload 7
    //   153: invokevirtual 119	java/util/LinkedHashMap:remove	(Ljava/lang/Object;)Ljava/lang/Object;
    //   156: pop
    //   157: aload_0
    //   158: getfield 109	android/support/v4/util/LruCache:size	I
    //   161: istore_2
    //   162: aload_0
    //   163: aload 7
    //   165: aload 8
    //   167: invokespecial 111	android/support/v4/util/LruCache:safeSizeOf	(Ljava/lang/Object;Ljava/lang/Object;)I
    //   170: astore 9
    //   172: iload_2
    //   173: iload 9
    //   175: isub
    //   176: istore_2
    //   177: aload_0
    //   178: iload_2
    //   179: putfield 109	android/support/v4/util/LruCache:size	I
    //   182: aload_0
    //   183: getfield 87	android/support/v4/util/LruCache:evictionCount	I
    //   186: istore_2
    //   187: iinc 2 1
    //   190: aload_0
    //   191: iload_2
    //   192: putfield 87	android/support/v4/util/LruCache:evictionCount	I
    //   195: aload_0
    //   196: monitorexit
    //   197: iconst_1
    //   198: istore_2
    //   199: aload_0
    //   200: iload_2
    //   201: aload 7
    //   203: aload 8
    //   205: aconst_null
    //   206: invokevirtual 107	android/support/v4/util/LruCache:entryRemoved	(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V
    //   209: goto -209 -> 0
    //
    // Exception table:
    //   from	to	target	type
    //   2	80	77	finally
    //   82	197	77	finally
  }
}