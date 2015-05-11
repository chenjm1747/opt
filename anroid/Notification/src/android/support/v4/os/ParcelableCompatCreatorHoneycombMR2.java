package android.support.v4.os;

import android.os.Parcel;
import android.os.Parcelable.ClassLoaderCreator;
import dalvik.annotation.Signature;

@Signature({"<T:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;", "Landroid/os/Parcelable$ClassLoaderCreator", "<TT;>;"})
class ParcelableCompatCreatorHoneycombMR2
  implements Parcelable.ClassLoaderCreator
{

  @Signature({"Landroid/support/v4/os/ParcelableCompatCreatorCallbacks", "<TT;>;"})
  private final ParcelableCompatCreatorCallbacks mCallbacks;

  @Signature({"(", "Landroid/support/v4/os/ParcelableCompatCreatorCallbacks", "<TT;>;)V"})
  public ParcelableCompatCreatorHoneycombMR2(ParcelableCompatCreatorCallbacks paramParcelableCompatCreatorCallbacks)
  {
    this.mCallbacks = paramParcelableCompatCreatorCallbacks;
  }

  @Signature({"(", "Landroid/os/Parcel;", ")TT;"})
  public Object createFromParcel(Parcel paramParcel)
  {
    return this.mCallbacks.createFromParcel(paramParcel, null);
  }

  @Signature({"(", "Landroid/os/Parcel;", "Ljava/lang/ClassLoader;", ")TT;"})
  public Object createFromParcel(Parcel paramParcel, ClassLoader paramClassLoader)
  {
    return this.mCallbacks.createFromParcel(paramParcel, paramClassLoader);
  }

  @Signature({"(I)[TT;"})
  public Object[] newArray(int paramInt)
  {
    return this.mCallbacks.newArray(paramInt);
  }
}