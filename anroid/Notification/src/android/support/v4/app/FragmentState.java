package android.support.v4.app;

import Z;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import dalvik.annotation.Signature;

final class FragmentState
  implements Parcelable
{

  @Signature({"Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/FragmentState;", ">;"})
  public static final Parcelable.Creator CREATOR = new FragmentState.1();
  final Bundle mArguments;
  final String mClassName;
  final int mContainerId;
  final boolean mDetached;
  final int mFragmentId;
  final boolean mFromLayout;
  final int mIndex;
  Fragment mInstance;
  final boolean mRetainInstance;
  Bundle mSavedFragmentState;
  final String mTag;

  public FragmentState(Parcel paramParcel)
  {
    Object localObject4 = paramParcel.readString();
    this.mClassName = ((String)localObject4);
    localObject4 = paramParcel.readInt();
    this.mIndex = localObject4;
    localObject4 = paramParcel.readInt();
    if (localObject4 != 0)
    {
      localObject4 = localObject1;
      this.mFromLayout = ((Z)localObject4);
      localObject4 = paramParcel.readInt();
      this.mFragmentId = localObject4;
      localObject4 = paramParcel.readInt();
      this.mContainerId = localObject4;
      localObject4 = paramParcel.readString();
      this.mTag = ((String)localObject4);
      localObject4 = paramParcel.readInt();
      if (localObject4 == 0)
        break label151;
      localObject4 = localObject1;
      label102: this.mRetainInstance = ((Z)localObject4);
      if (paramParcel.readInt() == 0)
        break label157;
    }
    while (true)
    {
      this.mDetached = ((Z)localObject1);
      Bundle localBundle1 = paramParcel.readBundle();
      this.mArguments = localBundle1;
      Bundle localBundle2 = paramParcel.readBundle();
      this.mSavedFragmentState = localBundle2;
      return;
      localObject4 = localObject3;
      break;
      label151: localObject4 = localObject3;
      break label102;
      label157: Object localObject2 = localObject3;
    }
  }

  public FragmentState(Fragment paramFragment)
  {
    String str1 = paramFragment.getClass().getName();
    this.mClassName = str1;
    int i = paramFragment.mIndex;
    this.mIndex = i;
    boolean bool1 = paramFragment.mFromLayout;
    this.mFromLayout = bool1;
    int j = paramFragment.mFragmentId;
    this.mFragmentId = j;
    int k = paramFragment.mContainerId;
    this.mContainerId = k;
    String str2 = paramFragment.mTag;
    this.mTag = str2;
    boolean bool2 = paramFragment.mRetainInstance;
    this.mRetainInstance = bool2;
    boolean bool3 = paramFragment.mDetached;
    this.mDetached = bool3;
    Bundle localBundle = paramFragment.mArguments;
    this.mArguments = localBundle;
  }

  public int describeContents()
  {
    return null;
  }

  public Fragment instantiate(FragmentActivity paramFragmentActivity, Fragment paramFragment)
  {
    Object localObject = this.mInstance;
    if (localObject != null);
    for (localObject = this.mInstance; ; localObject = this.mInstance)
    {
      return localObject;
      localObject = this.mArguments;
      if (localObject != null)
      {
        localObject = this.mArguments;
        ClassLoader localClassLoader1 = paramFragmentActivity.getClassLoader();
        ((Bundle)localObject).setClassLoader(localClassLoader1);
      }
      localObject = this.mClassName;
      Bundle localBundle1 = this.mArguments;
      localObject = Fragment.instantiate(paramFragmentActivity, (String)localObject, localBundle1);
      this.mInstance = ((Fragment)localObject);
      localObject = this.mSavedFragmentState;
      if (localObject != null)
      {
        localObject = this.mSavedFragmentState;
        ClassLoader localClassLoader2 = paramFragmentActivity.getClassLoader();
        ((Bundle)localObject).setClassLoader(localClassLoader2);
        localObject = this.mInstance;
        Bundle localBundle2 = this.mSavedFragmentState;
        ((Fragment)localObject).mSavedFragmentState = localBundle2;
      }
      localObject = this.mInstance;
      int i = this.mIndex;
      ((Fragment)localObject).setIndex(i, paramFragment);
      localObject = this.mInstance;
      boolean bool1 = this.mFromLayout;
      ((Fragment)localObject).mFromLayout = bool1;
      this.mInstance.mRestored = true;
      localObject = this.mInstance;
      int j = this.mFragmentId;
      ((Fragment)localObject).mFragmentId = j;
      localObject = this.mInstance;
      int k = this.mContainerId;
      ((Fragment)localObject).mContainerId = k;
      localObject = this.mInstance;
      String str1 = this.mTag;
      ((Fragment)localObject).mTag = str1;
      localObject = this.mInstance;
      boolean bool2 = this.mRetainInstance;
      ((Fragment)localObject).mRetainInstance = bool2;
      localObject = this.mInstance;
      boolean bool3 = this.mDetached;
      ((Fragment)localObject).mDetached = bool3;
      localObject = this.mInstance;
      FragmentManagerImpl localFragmentManagerImpl = paramFragmentActivity.mFragments;
      ((Fragment)localObject).mFragmentManager = localFragmentManagerImpl;
      FragmentManagerImpl.DEBUG = (Z)localObject;
      if (localObject == null)
        continue;
      localObject = "FragmentManager";
      StringBuilder localStringBuilder = new StringBuilder().append("Instantiated fragment ");
      Fragment localFragment = this.mInstance;
      String str2 = localFragment;
      Log.v((String)localObject, str2);
    }
  }

  public void writeToParcel(Parcel paramParcel, int paramInt)
  {
    int i = 1;
    int j = 0;
    String str1 = this.mClassName;
    paramParcel.writeString(str1);
    int k = this.mIndex;
    paramParcel.writeInt(k);
    int m = this.mFromLayout;
    int i1;
    if (m != 0)
    {
      m = i;
      paramParcel.writeInt(m);
      int n = this.mFragmentId;
      paramParcel.writeInt(n);
      n = this.mContainerId;
      paramParcel.writeInt(n);
      String str2 = this.mTag;
      paramParcel.writeString(str2);
      i1 = this.mRetainInstance;
      if (i1 == 0)
        break label149;
      i1 = i;
      label99: paramParcel.writeInt(i1);
      if (!this.mDetached)
        break label156;
    }
    while (true)
    {
      paramParcel.writeInt(i);
      Bundle localBundle1 = this.mArguments;
      paramParcel.writeBundle(localBundle1);
      Bundle localBundle2 = this.mSavedFragmentState;
      paramParcel.writeBundle(localBundle2);
      return;
      i1 = j;
      break;
      label149: i1 = j;
      break label99;
      label156: i = j;
    }
  }
}