package android.support.v4.app;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

@Signature({"Ljava/lang/Object;", "Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/FragmentState;", ">;"})
final class FragmentState$1
  implements Parcelable.Creator
{
  public FragmentState createFromParcel(Parcel paramParcel)
  {
    return new FragmentState(paramParcel);
  }

  public FragmentState[] newArray(int paramInt)
  {
    return new FragmentState[paramInt];
  }
}