package android.support.v4.app;

import I;
import Z;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import android.util.Log;
import dalvik.annotation.Signature;
import java.util.ArrayList;

final class BackStackState
  implements Parcelable
{

  @Signature({"Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/BackStackState;", ">;"})
  public static final Parcelable.Creator CREATOR = new BackStackState.1();
  final int mBreadCrumbShortTitleRes;
  final CharSequence mBreadCrumbShortTitleText;
  final int mBreadCrumbTitleRes;
  final CharSequence mBreadCrumbTitleText;
  final int mIndex;
  final String mName;
  final int[] mOps;
  final int mTransition;
  final int mTransitionStyle;

  public BackStackState(Parcel paramParcel)
  {
    int[] arrayOfInt = paramParcel.createIntArray();
    this.mOps = arrayOfInt;
    int i = paramParcel.readInt();
    this.mTransition = i;
    int j = paramParcel.readInt();
    this.mTransitionStyle = j;
    String str = paramParcel.readString();
    this.mName = str;
    int k = paramParcel.readInt();
    this.mIndex = k;
    int m = paramParcel.readInt();
    this.mBreadCrumbTitleRes = m;
    CharSequence localCharSequence1 = (CharSequence)TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(paramParcel);
    this.mBreadCrumbTitleText = localCharSequence1;
    int n = paramParcel.readInt();
    this.mBreadCrumbShortTitleRes = n;
    CharSequence localCharSequence2 = (CharSequence)TextUtils.CHAR_SEQUENCE_CREATOR.createFromParcel(paramParcel);
    this.mBreadCrumbShortTitleText = localCharSequence2;
  }

  public BackStackState(FragmentManagerImpl paramFragmentManagerImpl, BackStackRecord paramBackStackRecord)
  {
    Object localObject1 = null;
    int i;
    for (BackStackRecord.Op localOp = paramBackStackRecord.mHead; localOp != null; localOp = localOp.next)
    {
      localObject2 = localOp.removed;
      if (localObject2 == null)
        continue;
      localObject2 = localOp.removed.size();
      i = localObject1 + localObject2;
    }
    Object localObject2 = new int[paramBackStackRecord.mNumOp * 7 + i];
    this.mOps = ((I)localObject2);
    boolean bool = paramBackStackRecord.mAddToBackStack;
    if (!bool)
      throw new IllegalStateException("Not on back stack");
    localOp = paramBackStackRecord.mHead;
    int m = 0;
    int n = m;
    if (localOp != null)
    {
      Object localObject3 = this.mOps;
      m = n + 1;
      int i1 = localOp.cmd;
      localObject3[n] = i1;
      int[] arrayOfInt3 = this.mOps;
      n = m + 1;
      localObject3 = localOp.fragment;
      int j;
      if (localObject3 != null)
        j = localOp.fragment.mIndex;
      while (true)
      {
        arrayOfInt3[m] = j;
        int[] arrayOfInt4 = this.mOps;
        m = n + 1;
        int i2 = localOp.enterAnim;
        j[n] = arrayOfInt3;
        int[] arrayOfInt5 = this.mOps;
        n = m + 1;
        int i3 = localOp.exitAnim;
        j[m] = arrayOfInt3;
        int[] arrayOfInt6 = this.mOps;
        m = n + 1;
        int i4 = localOp.popEnterAnim;
        j[n] = arrayOfInt3;
        int[] arrayOfInt7 = this.mOps;
        n = m + 1;
        int i5 = localOp.popExitAnim;
        j[m] = arrayOfInt3;
        if (localOp.removed == null)
          break;
        int i6 = localOp.removed.size();
        int[] arrayOfInt1 = this.mOps;
        m = n + 1;
        arrayOfInt1[n] = i6;
        int i7 = null;
        n = m;
        while (true)
          if (i7 < i6)
          {
            arrayOfInt3 = this.mOps;
            m = n + 1;
            int k = ((Fragment)localOp.removed.get(i7)).mIndex;
            arrayOfInt3[n] = k;
            i7++;
            n = m;
            continue;
            k = -1;
            break;
          }
        m = n;
      }
      while (true)
      {
        localOp = localOp.next;
        n = m;
        break;
        int[] arrayOfInt2 = this.mOps;
        m = n + 1;
        arrayOfInt3 = null;
        arrayOfInt2[n] = arrayOfInt3;
      }
    }
    int i8 = paramBackStackRecord.mTransition;
    this.mTransition = i8;
    int i9 = paramBackStackRecord.mTransitionStyle;
    this.mTransitionStyle = i9;
    String str = paramBackStackRecord.mName;
    this.mName = str;
    int i10 = paramBackStackRecord.mIndex;
    this.mIndex = i10;
    int i11 = paramBackStackRecord.mBreadCrumbTitleRes;
    this.mBreadCrumbTitleRes = i11;
    CharSequence localCharSequence1 = paramBackStackRecord.mBreadCrumbTitleText;
    this.mBreadCrumbTitleText = localCharSequence1;
    int i12 = paramBackStackRecord.mBreadCrumbShortTitleRes;
    this.mBreadCrumbShortTitleRes = i12;
    CharSequence localCharSequence2 = paramBackStackRecord.mBreadCrumbShortTitleText;
    this.mBreadCrumbShortTitleText = localCharSequence2;
  }

  public int describeContents()
  {
    return null;
  }

  public BackStackRecord instantiate(FragmentManagerImpl paramFragmentManagerImpl)
  {
    int i = 1;
    BackStackRecord localBackStackRecord = new BackStackRecord(paramFragmentManagerImpl);
    Object localObject1 = null;
    for (int k = 0; ; k++)
    {
      int m = this.mOps.length;
      if (localObject1 >= m)
        break;
      BackStackRecord.Op localOp = new BackStackRecord.Op();
      int[] arrayOfInt1 = this.mOps;
      int i5 = localObject1 + 1;
      int n = arrayOfInt1[localObject1];
      localOp.cmd = n;
      FragmentManagerImpl.DEBUG = n;
      if (n != 0)
      {
        localObject2 = "FragmentManager";
        StringBuilder localStringBuilder1 = new StringBuilder().append("Instantiate ").append(localBackStackRecord).append(" op #").append(k).append(" base fragment #");
        int i6 = this.mOps[i5];
        String str1 = i6;
        Log.v((String)localObject2, str1);
      }
      Object localObject2 = this.mOps;
      int j = i5 + 1;
      int i7 = localObject2[i5];
      Fragment localFragment1;
      if (i7 >= 0)
      {
        localObject2 = paramFragmentManagerImpl.mActive;
        localFragment1 = (Fragment)((ArrayList)localObject2).get(i7);
      }
      Object localObject3;
      for (localOp.fragment = localFragment1; ; localOp.fragment = ((Fragment)localObject3))
      {
        localObject2 = this.mOps;
        i5 = j + 1;
        int i1 = localObject2[j];
        localOp.enterAnim = i1;
        int[] arrayOfInt2 = this.mOps;
        j = i5 + 1;
        int i2 = arrayOfInt2[i5];
        localOp.exitAnim = i2;
        int[] arrayOfInt3 = this.mOps;
        i5 = j + 1;
        int i3 = arrayOfInt3[j];
        localOp.popEnterAnim = i3;
        int[] arrayOfInt4 = this.mOps;
        j = i5 + 1;
        int i4 = arrayOfInt4[i5];
        localOp.popExitAnim = i4;
        localObject3 = this.mOps;
        i5 = j + 1;
        int i8 = localObject3[j];
        if (i8 <= 0)
          break;
        localObject3 = new ArrayList(i8);
        localOp.removed = ((ArrayList)localObject3);
        Object localObject4 = null;
        while (localObject4 < i8)
        {
          FragmentManagerImpl.DEBUG = (Z)localObject3;
          if (localObject3 != null)
          {
            localObject3 = "FragmentManager";
            StringBuilder localStringBuilder2 = new StringBuilder().append("Instantiate ").append(localBackStackRecord).append(" set remove fragment #");
            int i9 = this.mOps[i5];
            String str2 = i9;
            Log.v((String)localObject3, str2);
          }
          localObject3 = paramFragmentManagerImpl.mActive;
          int[] arrayOfInt5 = this.mOps;
          j = i5 + 1;
          int i10 = arrayOfInt5[i5];
          Fragment localFragment2 = (Fragment)((ArrayList)localObject3).get(i10);
          localObject3 = localOp.removed;
          ((ArrayList)localObject3).add(localFragment2);
          localObject4++;
          i5 = j;
        }
        localObject3 = null;
      }
      j = i5;
      localBackStackRecord.addOp(localOp);
    }
    int i11 = this.mTransition;
    localBackStackRecord.mTransition = i11;
    int i12 = this.mTransitionStyle;
    localBackStackRecord.mTransitionStyle = i12;
    String str3 = this.mName;
    localBackStackRecord.mName = str3;
    int i13 = this.mIndex;
    localBackStackRecord.mIndex = i13;
    localBackStackRecord.mAddToBackStack = i;
    int i14 = this.mBreadCrumbTitleRes;
    localBackStackRecord.mBreadCrumbTitleRes = i14;
    CharSequence localCharSequence1 = this.mBreadCrumbTitleText;
    localBackStackRecord.mBreadCrumbTitleText = localCharSequence1;
    int i15 = this.mBreadCrumbShortTitleRes;
    localBackStackRecord.mBreadCrumbShortTitleRes = i15;
    CharSequence localCharSequence2 = this.mBreadCrumbShortTitleText;
    localBackStackRecord.mBreadCrumbShortTitleText = localCharSequence2;
    localBackStackRecord.bumpBackStackNesting(i);
    return (BackStackRecord)(BackStackRecord)localBackStackRecord;
  }

  public void writeToParcel(Parcel paramParcel, int paramInt)
  {
    int[] arrayOfInt = this.mOps;
    paramParcel.writeIntArray(arrayOfInt);
    int i = this.mTransition;
    paramParcel.writeInt(i);
    int j = this.mTransitionStyle;
    paramParcel.writeInt(j);
    String str = this.mName;
    paramParcel.writeString(str);
    int k = this.mIndex;
    paramParcel.writeInt(k);
    int m = this.mBreadCrumbTitleRes;
    paramParcel.writeInt(m);
    TextUtils.writeToParcel(this.mBreadCrumbTitleText, paramParcel, 0);
    int n = this.mBreadCrumbShortTitleRes;
    paramParcel.writeInt(n);
    TextUtils.writeToParcel(this.mBreadCrumbShortTitleText, paramParcel, 0);
  }
}