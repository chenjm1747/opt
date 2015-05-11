package android.support.v4.view;

import android.os.Parcel;
import android.support.v4.os.ParcelableCompatCreatorCallbacks;
import dalvik.annotation.Signature;

@Signature({"Ljava/lang/Object;", "Landroid/support/v4/os/ParcelableCompatCreatorCallbacks", "<", "Landroid/support/v4/view/ViewPager$SavedState;", ">;"})
final class ViewPager$SavedState$1
  implements ParcelableCompatCreatorCallbacks
{
  public ViewPager.SavedState createFromParcel(Parcel paramParcel, ClassLoader paramClassLoader)
  {
    return new ViewPager.SavedState(paramParcel, paramClassLoader);
  }

  public ViewPager.SavedState[] newArray(int paramInt)
  {
    return new ViewPager.SavedState[paramInt];
  }
}