package android.support.v4.app;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

@Signature({"Ljava/lang/Object;", "Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/Fragment$SavedState;", ">;"})
final class Fragment$SavedState$1
  implements Parcelable.Creator
{
  public Fragment.SavedState createFromParcel(Parcel paramParcel)
  {
    return new Fragment.SavedState(paramParcel, null);
  }

  public Fragment.SavedState[] newArray(int paramInt)
  {
    return new Fragment.SavedState[paramInt];
  }
}