package android.support.v4.util;

import J;
import dalvik.annotation.Signature;

@Signature({"<E:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;", "Ljava/lang/Cloneable;"})
public class LongSparseArray
  implements Cloneable
{
  private static final Object DELETED = new Object();
  private boolean mGarbage = null;
  private long[] mKeys;
  private int mSize;
  private Object[] mValues;

  public LongSparseArray()
  {
    this(10);
  }

  public LongSparseArray(int paramInt)
  {
    int i = idealLongArraySize(paramInt);
    int j = paramInt;
    this.mKeys = j;
    Object[] arrayOfObject = new Object[paramInt];
    this.mValues = arrayOfObject;
    this.mSize = null;
  }

  private static int binarySearch(long[] paramArrayOfLong, int paramInt1, int paramInt2, long paramLong)
  {
    int i = paramInt1 + paramInt2;
    int j = paramInt1 + -1;
    while (i - j > 1)
    {
      int k = (i + j) / 2;
      if (paramArrayOfLong[k] < paramLong)
      {
        j = k;
        continue;
      }
      i = k;
    }
    int m = paramInt1 + paramInt2;
    if (i == m)
      i = paramInt1 + paramInt2 ^ 0xFFFFFFFF;
    while (true)
    {
      return i;
      if (paramArrayOfLong[i] == paramLong)
        continue;
      i ^= -1;
    }
  }

  private void gc()
  {
    int i = this.mSize;
    int j = 0;
    long[] arrayOfLong = this.mKeys;
    Object[] arrayOfObject = this.mValues;
    for (int k = 0; k < i; k++)
    {
      Object localObject1 = arrayOfObject[k];
      Object localObject2 = DELETED;
      if (localObject1 == localObject2)
        continue;
      if (k != j)
      {
        long l = arrayOfLong[k];
        arrayOfLong[j] = l;
        arrayOfObject[j] = localObject1;
        arrayOfObject[k] = null;
      }
      j++;
    }
    this.mGarbage = null;
    this.mSize = j;
  }

  public static int idealByteArraySize(int paramInt)
  {
    int i = 1;
    for (int j = 4; ; j++)
    {
      if (j < 32)
      {
        int k = i << j;
        int m;
        m -= 12;
        if (paramInt > k)
          continue;
        paramInt = (i << j) + -12;
      }
      return paramInt;
    }
  }

  public static int idealLongArraySize(int paramInt)
  {
    return idealByteArraySize(paramInt * 8) / 8;
  }

  @Signature({"(JTE;)V"})
  public void append(long paramLong, Object paramObject)
  {
    paramObject = 0;
    if (this.mSize != 0)
    {
      long[] arrayOfLong1 = this.mKeys;
      int i = this.mSize;
      int j;
      j--;
      long l = arrayOfLong1[i];
      if (paramLong <= l)
        put(paramLong, ???);
    }
    while (true)
    {
      return;
      if (this.mGarbage)
      {
        int k = this.mSize;
        int m = this.mKeys.length;
        if (k >= m)
          gc();
      }
      int n = this.mSize;
      int i1 = this.mKeys.length;
      if (n >= i1)
      {
        int i2 = idealLongArraySize(n + 1);
        int i3 = i2;
        Object[] arrayOfObject1 = new Object[i2];
        long[] arrayOfLong2 = this.mKeys;
        int i4 = this.mKeys.length;
        System.arraycopy(arrayOfLong2, paramObject, i3, paramObject, i4);
        Object[] arrayOfObject2 = this.mValues;
        int i5 = this.mValues.length;
        System.arraycopy(arrayOfObject2, paramObject, arrayOfObject1, paramObject, i5);
        this.mKeys = i3;
        this.mValues = arrayOfObject1;
      }
      this.mKeys[n] = paramLong;
      this.mValues[n] = ???;
      int i6 = n + 1;
      this.mSize = i6;
    }
  }

  public void clear()
  {
    Object localObject = null;
    int i = this.mSize;
    Object[] arrayOfObject = this.mValues;
    for (int j = 0; j < i; j++)
      arrayOfObject[j] = null;
    this.mSize = localObject;
    this.mGarbage = localObject;
  }

  @Signature({"()", "Landroid/support/v4/util/LongSparseArray", "<TE;>;"})
  public LongSparseArray clone()
  {
    int i = 0;
    try
    {
      LongSparseArray localLongSparseArray = (LongSparseArray)super.clone();
      long[] arrayOfLong = (long[])this.mKeys.clone();
      localLongSparseArray.mKeys = arrayOfLong;
      Object[] arrayOfObject = (Object[])this.mValues.clone();
      localLongSparseArray.mValues = arrayOfObject;
      label42: return localLongSparseArray;
    }
    catch (CloneNotSupportedException localCloneNotSupportedException)
    {
      break label42;
    }
  }

  public void delete(long paramLong)
  {
    long[] arrayOfLong = this.mKeys;
    int i = this.mSize;
    int j = binarySearch(arrayOfLong, 0, i, paramLong);
    if (j >= 0)
    {
      Object localObject1 = this.mValues[j];
      Object localObject2 = DELETED;
      if (localObject1 != localObject2)
      {
        Object[] arrayOfObject = this.mValues;
        Object localObject3 = DELETED;
        arrayOfObject[j] = localObject3;
        this.mGarbage = true;
      }
    }
  }

  @Signature({"(J)TE;"})
  public Object get(long paramLong)
  {
    return get(paramLong, null);
  }

  @Signature({"(JTE;)TE;"})
  public Object get(long paramLong, Object paramObject)
  {
    // Byte code:
    //   0: aload_0
    //   1: getfield 40	android/support/v4/util/LongSparseArray:mKeys	[J
    //   4: astore 4
    //   6: aload_0
    //   7: getfield 44	android/support/v4/util/LongSparseArray:mSize	I
    //   10: istore 5
    //   12: aload 4
    //   14: iconst_0
    //   15: iload 5
    //   17: lload_1
    //   18: invokestatic 85	android/support/v4/util/LongSparseArray:binarySearch	([JIIJ)I
    //   21: astore 6
    //   23: iload 6
    //   25: iflt +24 -> 49
    //   28: aload_0
    //   29: getfield 42	android/support/v4/util/LongSparseArray:mValues	[Ljava/lang/Object;
    //   32: iload 6
    //   34: aaload
    //   35: astore 7
    //   37: getstatic 29	android/support/v4/util/LongSparseArray:DELETED	Ljava/lang/Object;
    //   40: astore 8
    //   42: aload 7
    //   44: aload 8
    //   46: if_icmpne +5 -> 51
    //   49: aload_2
    //   50: areturn
    //   51: aload_0
    //   52: getfield 42	android/support/v4/util/LongSparseArray:mValues	[Ljava/lang/Object;
    //   55: iload 6
    //   57: aaload
    //   58: astore_2
    //   59: goto -10 -> 49
  }

  public int indexOfKey(long paramLong)
  {
    if (this.mGarbage)
      gc();
    long[] arrayOfLong = this.mKeys;
    int i = this.mSize;
    return binarySearch(arrayOfLong, 0, i, paramLong);
  }

  @Signature({"(TE;)I"})
  public int indexOfValue(Object paramObject)
  {
    if (this.mGarbage)
      gc();
    Object localObject = null;
    int j = this.mSize;
    if (localObject < j)
      if (this.mValues[localObject] != paramObject);
    while (true)
    {
      return localObject;
      localObject++;
      break;
      int i = -1;
    }
  }

  public long keyAt(int paramInt)
  {
    if (this.mGarbage)
      gc();
    return this.mKeys[paramInt];
  }

  @Signature({"(JTE;)V"})
  public void put(long paramLong, Object paramObject)
  {
    paramObject = 0;
    long[] arrayOfLong1 = this.mKeys;
    int i = this.mSize;
    int j = binarySearch(arrayOfLong1, paramObject, i, paramLong);
    if (j >= 0)
      this.mValues[j] = ???;
    while (true)
    {
      return;
      j ^= -1;
      int k = this.mSize;
      if (j < k)
      {
        Object localObject1 = this.mValues[j];
        Object localObject2 = DELETED;
        if (localObject1 == localObject2)
        {
          this.mKeys[j] = paramLong;
          this.mValues[j] = ???;
          continue;
        }
      }
      if (this.mGarbage)
      {
        int m = this.mSize;
        int n = this.mKeys.length;
        if (m >= n)
        {
          gc();
          long[] arrayOfLong2 = this.mKeys;
          int i1 = this.mSize;
          j = binarySearch(arrayOfLong2, paramObject, i1, paramLong) ^ 0xFFFFFFFF;
        }
      }
      int i2 = this.mSize;
      int i3 = this.mKeys.length;
      int i5;
      if (i2 >= i3)
      {
        int i4 = this.mSize;
        i5++;
        int i6 = idealLongArraySize(i4);
        int i7 = i6;
        Object[] arrayOfObject1 = new Object[i6];
        long[] arrayOfLong3 = this.mKeys;
        int i8 = this.mKeys.length;
        System.arraycopy(arrayOfLong3, paramObject, i7, paramObject, i8);
        Object[] arrayOfObject2 = this.mValues;
        int i9 = this.mValues.length;
        System.arraycopy(arrayOfObject2, paramObject, arrayOfObject1, paramObject, i9);
        this.mKeys = i7;
        this.mValues = arrayOfObject1;
      }
      if (this.mSize - j != 0)
      {
        long[] arrayOfLong4 = this.mKeys;
        long[] arrayOfLong5 = this.mKeys;
        int i10 = j + 1;
        int i11 = this.mSize - j;
        System.arraycopy(arrayOfLong4, j, arrayOfLong5, i10, i11);
        Object[] arrayOfObject3 = this.mValues;
        Object[] arrayOfObject4 = this.mValues;
        int i12 = j + 1;
        int i13 = this.mSize - j;
        System.arraycopy(arrayOfObject3, j, arrayOfObject4, i12, i13);
      }
      this.mKeys[j] = paramLong;
      this.mValues[j] = ???;
      int i14 = this.mSize;
      i5++;
      this.mSize = i14;
    }
  }

  public void remove(long paramLong)
  {
    delete(paramLong);
  }

  public void removeAt(int paramInt)
  {
    Object localObject1 = this.mValues[paramInt];
    Object localObject2 = DELETED;
    if (localObject1 != localObject2)
    {
      Object[] arrayOfObject = this.mValues;
      Object localObject3 = DELETED;
      arrayOfObject[paramInt] = localObject3;
      this.mGarbage = true;
    }
  }

  @Signature({"(ITE;)V"})
  public void setValueAt(int paramInt, Object paramObject)
  {
    if (this.mGarbage)
      gc();
    this.mValues[paramInt] = paramObject;
  }

  public int size()
  {
    if (this.mGarbage)
      gc();
    return this.mSize;
  }

  @Signature({"(I)TE;"})
  public Object valueAt(int paramInt)
  {
    if (this.mGarbage)
      gc();
    return this.mValues[paramInt];
  }
}