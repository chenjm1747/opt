package android.support.v4.os;

import android.os.Parcelable.Creator;
import dalvik.annotation.Signature;

class ParcelableCompatCreatorHoneycombMR2Stub
{
  @Signature({"<T:", "Ljava/lang/Object;", ">(", "Landroid/support/v4/os/ParcelableCompatCreatorCallbacks", "<TT;>;)", "Landroid/os/Parcelable$Creator", "<TT;>;"})
  static Parcelable.Creator instantiate(ParcelableCompatCreatorCallbacks paramParcelableCompatCreatorCallbacks)
  {
    return new ParcelableCompatCreatorHoneycombMR2(paramParcelableCompatCreatorCallbacks);
  }
}