package android.support.v4.util;

import dalvik.annotation.Signature;

@Signature({"<E:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
public class SparseArrayCompat
{
  private static final Object DELETED = new Object();
  private boolean mGarbage = null;
  private int[] mKeys;
  private int mSize;
  private Object[] mValues;

  public SparseArrayCompat()
  {
    this(10);
  }

  public SparseArrayCompat(int paramInt)
  {
    int i = idealIntArraySize(paramInt);
    int[] arrayOfInt = new int[paramInt];
    this.mKeys = arrayOfInt;
    Object[] arrayOfObject = new Object[paramInt];
    this.mValues = arrayOfObject;
    this.mSize = null;
  }

  private static int binarySearch(int[] paramArrayOfInt, int paramInt1, int paramInt2, int paramInt3)
  {
    int i = paramInt1 + paramInt2;
    int j = paramInt1 + -1;
    while (i - j > 1)
    {
      int k = (i + j) / 2;
      if (paramArrayOfInt[k] < paramInt3)
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
      if (paramArrayOfInt[i] == paramInt3)
        continue;
      i ^= -1;
    }
  }

  private void gc()
  {
    int i = this.mSize;
    int j = 0;
    int[] arrayOfInt = this.mKeys;
    Object[] arrayOfObject = this.mValues;
    Object localObject1 = null;
    while (localObject1 < i)
    {
      Object localObject2 = arrayOfObject[localObject1];
      Object localObject3 = DELETED;
      if (localObject2 != localObject3)
      {
        if (localObject1 != j)
        {
          int k = arrayOfInt[localObject1];
          arrayOfInt[j] = k;
          arrayOfObject[j] = localObject2;
        }
        j++;
      }
      localObject1++;
    }
    this.mGarbage = null;
    this.mSize = j;
  }

  static int idealByteArraySize(int paramInt)
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

  static int idealIntArraySize(int paramInt)
  {
    return idealByteArraySize(paramInt * 4) / 4;
  }

  @Signature({"(ITE;)V"})
  public void append(int paramInt, Object paramObject)
  {
    int i = 0;
    if (this.mSize != 0)
    {
      int[] arrayOfInt1 = this.mKeys;
      int j = this.mSize;
      int k;
      k--;
      int m = arrayOfInt1[j];
      if (paramInt <= m)
        put(paramInt, paramObject);
    }
    while (true)
    {
      return;
      if (this.mGarbage)
      {
        int n = this.mSize;
        int i1 = this.mKeys.length;
        if (n >= i1)
          gc();
      }
      int i2 = this.mSize;
      int i3 = this.mKeys.length;
      if (i2 >= i3)
      {
        int i4 = idealIntArraySize(i2 + 1);
        int[] arrayOfInt2 = new int[i4];
        Object[] arrayOfObject1 = new Object[i4];
        int[] arrayOfInt3 = this.mKeys;
        int i5 = this.mKeys.length;
        System.arraycopy(arrayOfInt3, i, arrayOfInt2, i, i5);
        Object[] arrayOfObject2 = this.mValues;
        int i6 = this.mValues.length;
        System.arraycopy(arrayOfObject2, i, arrayOfObject1, i, i6);
        this.mKeys = arrayOfInt2;
        this.mValues = arrayOfObject1;
      }
      this.mKeys[i2] = paramInt;
      this.mValues[i2] = paramObject;
      int i7 = i2 + 1;
      this.mSize = i7;
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

  public void delete(int paramInt)
  {
    int[] arrayOfInt = this.mKeys;
    int i = this.mSize;
    int j = binarySearch(arrayOfInt, 0, i, paramInt);
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

  @Signature({"(I)TE;"})
  public Object get(int paramInt)
  {
    return get(paramInt, null);
  }

  @Signature({"(ITE;)TE;"})
  public Object get(int paramInt, Object paramObject)
  {
    int[] arrayOfInt = this.mKeys;
    int i = this.mSize;
    int j = binarySearch(arrayOfInt, 0, i, paramInt);
    if (j >= 0)
    {
      Object localObject1 = this.mValues[j];
      Object localObject2 = DELETED;
      if (localObject1 != localObject2)
        break label49;
    }
    while (true)
    {
      return paramObject;
      label49: paramObject = this.mValues[j];
    }
  }

  public int indexOfKey(int paramInt)
  {
    if (this.mGarbage)
      gc();
    int[] arrayOfInt = this.mKeys;
    int i = this.mSize;
    return binarySearch(arrayOfInt, 0, i, paramInt);
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

  public int keyAt(int paramInt)
  {
    if (this.mGarbage)
      gc();
    return this.mKeys[paramInt];
  }

  @Signature({"(ITE;)V"})
  public void put(int paramInt, Object paramObject)
  {
    int i = 0;
    int[] arrayOfInt1 = this.mKeys;
    int j = this.mSize;
    int k = binarySearch(arrayOfInt1, i, j, paramInt);
    if (k >= 0)
      this.mValues[k] = paramObject;
    while (true)
    {
      return;
      k ^= -1;
      int m = this.mSize;
      if (k < m)
      {
        Object localObject1 = this.mValues[k];
        Object localObject2 = DELETED;
        if (localObject1 == localObject2)
        {
          this.mKeys[k] = paramInt;
          this.mValues[k] = paramObject;
          continue;
        }
      }
      if (this.mGarbage)
      {
        int n = this.mSize;
        int i1 = this.mKeys.length;
        if (n >= i1)
        {
          gc();
          int[] arrayOfInt2 = this.mKeys;
          int i2 = this.mSize;
          k = binarySearch(arrayOfInt2, i, i2, paramInt) ^ 0xFFFFFFFF;
        }
      }
      int i3 = this.mSize;
      int i4 = this.mKeys.length;
      int i6;
      if (i3 >= i4)
      {
        int i5 = this.mSize;
        i6++;
        int i7 = idealIntArraySize(i5);
        int[] arrayOfInt3 = new int[i7];
        Object[] arrayOfObject1 = new Object[i7];
        int[] arrayOfInt4 = this.mKeys;
        int i8 = this.mKeys.length;
        System.arraycopy(arrayOfInt4, i, arrayOfInt3, i, i8);
        Object[] arrayOfObject2 = this.mValues;
        int i9 = this.mValues.length;
        System.arraycopy(arrayOfObject2, i, arrayOfObject1, i, i9);
        this.mKeys = arrayOfInt3;
        this.mValues = arrayOfObject1;
      }
      if (this.mSize - k != 0)
      {
        int[] arrayOfInt5 = this.mKeys;
        int[] arrayOfInt6 = this.mKeys;
        int i10 = k + 1;
        int i11 = this.mSize - k;
        System.arraycopy(arrayOfInt5, k, arrayOfInt6, i10, i11);
        Object[] arrayOfObject3 = this.mValues;
        Object[] arrayOfObject4 = this.mValues;
        int i12 = k + 1;
        int i13 = this.mSize - k;
        System.arraycopy(arrayOfObject3, k, arrayOfObject4, i12, i13);
      }
      this.mKeys[k] = paramInt;
      this.mValues[k] = paramObject;
      int i14 = this.mSize;
      i6++;
      this.mSize = i14;
    }
  }

  public void remove(int paramInt)
  {
    delete(paramInt);
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

  public void removeAtRange(int paramInt1, int paramInt2)
  {
    int i = this.mSize;
    int j = paramInt1 + paramInt2;
    int k = Math.min(i, j);
    for (int m = paramInt1; m < k; m++)
      removeAt(m);
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