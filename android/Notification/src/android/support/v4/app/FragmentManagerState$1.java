package android.support.v4.app;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

@Signature({"Ljava/lang/Object;", "Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/FragmentManagerState;", ">;"})
final class FragmentManagerState$1
  implements Parcelable.Creator
{
  public FragmentManagerState createFromParcel(Parcel paramParcel)
  {
    return new FragmentManagerState(paramParcel);
  }

  public FragmentManagerState[] newArray(int paramInt)
  {
    return new FragmentManagerState[paramInt];
  }
}