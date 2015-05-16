package android.support.v4.os;

import android.os.Parcel;
import dalvik.annotation.Signature;

@Signature({"<T:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
public abstract interface ParcelableCompatCreatorCallbacks
{
  @Signature({"(", "Landroid/os/Parcel;", "Ljava/lang/ClassLoader;", ")TT;"})
  public abstract Object createFromParcel(Parcel paramParcel, ClassLoader paramClassLoader);

  @Signature({"(I)[TT;"})
  public abstract Object[] newArray(int paramInt);
}