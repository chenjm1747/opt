package android.support.v4.app;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

@Signature({"Ljava/lang/Object;", "Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/FragmentTabHost$SavedState;", ">;"})
final class FragmentTabHost$SavedState$1
  implements Parcelable.Creator
{
  public FragmentTabHost.SavedState createFromParcel(Parcel paramParcel)
  {
    return new FragmentTabHost.SavedState(paramParcel, null);
  }

  public FragmentTabHost.SavedState[] newArray(int paramInt)
  {
    return new FragmentTabHost.SavedState[paramInt];
  }
}