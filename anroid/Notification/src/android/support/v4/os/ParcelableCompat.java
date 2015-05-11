package android.support.v4.os;

import android.os.Build.VERSION;
import android.os.Parcel;
import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

public class ParcelableCompat
{
  @Signature({"<T:", "Ljava/lang/Object;", ">(", "Landroid/support/v4/os/ParcelableCompatCreatorCallbacks", "<TT;>;)", "Landroid/os/Parcelable$Creator", "<TT;>;"})
  public static Parcelable.Creator newCreator(ParcelableCompatCreatorCallbacks paramParcelableCompatCreatorCallbacks)
  {
    if (Build.VERSION.SDK_INT >= 13)
      ParcelableCompatCreatorHoneycombMR2Stub.instantiate(paramParcelableCompatCreatorCallbacks);
    return new CompatCreator();
  }

  @Signature({"<T:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;", "Landroid/os/Parcelable$Creator", "<TT;>;"})
  class CompatCreator
    implements Parcelable.Creator
  {
    @Signature({"(", "Landroid/support/v4/os/ParcelableCompatCreatorCallbacks", "<TT;>;)V"})
    public CompatCreator()
    {
    }

    @Signature({"(", "Landroid/os/Parcel;", ")TT;"})
    public Object createFromParcel(Parcel paramParcel)
    {
      return ParcelableCompat.this.createFromParcel(paramParcel, null);
    }

    @Signature({"(I)[TT;"})
    public Object[] newArray(int paramInt)
    {
      return ParcelableCompat.this.newArray(paramInt);
    }
  }
}