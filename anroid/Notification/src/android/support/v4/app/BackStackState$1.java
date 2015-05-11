package android.support.v4.app;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

@Signature({"Ljava/lang/Object;", "Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/BackStackState;", ">;"})
final class BackStackState$1
  implements Parcelable.Creator
{
  public BackStackState createFromParcel(Parcel paramParcel)
  {
    return new BackStackState(paramParcel);
  }

  public BackStackState[] newArray(int paramInt)
  {
    return new BackStackState[paramInt];
  }
}