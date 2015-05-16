package android.support.v4.app;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

final class FragmentManagerState
  implements Parcelable
{

  @Signature({"Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/FragmentManagerState;", ">;"})
  public static final Parcelable.Creator CREATOR = new FragmentManagerState.1();
  FragmentState[] mActive;
  int[] mAdded;
  BackStackState[] mBackStack;

  public FragmentManagerState()
  {
  }

  public FragmentManagerState(Parcel paramParcel)
  {
    Parcelable.Creator localCreator1 = FragmentState.CREATOR;
    FragmentState[] arrayOfFragmentState = (FragmentState[])paramParcel.createTypedArray(localCreator1);
    this.mActive = arrayOfFragmentState;
    int[] arrayOfInt = paramParcel.createIntArray();
    this.mAdded = arrayOfInt;
    Parcelable.Creator localCreator2 = BackStackState.CREATOR;
    BackStackState[] arrayOfBackStackState = (BackStackState[])paramParcel.createTypedArray(localCreator2);
    this.mBackStack = arrayOfBackStackState;
  }

  public int describeContents()
  {
    return null;
  }

  public void writeToParcel(Parcel paramParcel, int paramInt)
  {
    FragmentState[] arrayOfFragmentState = this.mActive;
    paramParcel.writeTypedArray(arrayOfFragmentState, paramInt);
    int[] arrayOfInt = this.mAdded;
    paramParcel.writeIntArray(arrayOfInt);
    BackStackState[] arrayOfBackStackState = this.mBackStack;
    paramParcel.writeTypedArray(arrayOfBackStackState, paramInt);
  }
}