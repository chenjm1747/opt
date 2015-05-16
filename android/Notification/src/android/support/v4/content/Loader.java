package android.support.v4.content;

import android.content.Context;
import android.database.ContentObserver;
import android.os.Handler;
import android.support.v4.util.DebugUtils;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;

@Signature({"<D:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
public class Loader
{
  boolean mAbandoned = null;
  boolean mContentChanged = null;
  Context mContext;
  int mId;

  @Signature({"Landroid/support/v4/content/Loader$OnLoadCompleteListener", "<TD;>;"})
  OnLoadCompleteListener mListener;
  boolean mReset = true;
  boolean mStarted = null;

  public Loader(Context paramContext)
  {
    Context localContext = paramContext.getApplicationContext();
    this.mContext = localContext;
  }

  public void abandon()
  {
    this.mAbandoned = true;
    onAbandon();
  }

  @Signature({"(TD;)", "Ljava/lang/String;"})
  public String dataToString(Object paramObject)
  {
    StringBuilder localStringBuilder = new StringBuilder(64);
    DebugUtils.buildShortClassTag(paramObject, localStringBuilder);
    localStringBuilder.append("}");
    return localStringBuilder.toString();
  }

  @Signature({"(TD;)V"})
  public void deliverResult(Object paramObject)
  {
    if (this.mListener != null)
      this.mListener.onLoadComplete(this, paramObject);
  }

  public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
  {
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mId=");
    int i = this.mId;
    paramPrintWriter.print(i);
    paramPrintWriter.print(" mListener=");
    OnLoadCompleteListener localOnLoadCompleteListener = this.mListener;
    paramPrintWriter.println(localOnLoadCompleteListener);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mStarted=");
    boolean bool1 = this.mStarted;
    paramPrintWriter.print(bool1);
    paramPrintWriter.print(" mContentChanged=");
    boolean bool2 = this.mContentChanged;
    paramPrintWriter.print(bool2);
    paramPrintWriter.print(" mAbandoned=");
    boolean bool3 = this.mAbandoned;
    paramPrintWriter.print(bool3);
    paramPrintWriter.print(" mReset=");
    boolean bool4 = this.mReset;
    paramPrintWriter.println(bool4);
  }

  public void forceLoad()
  {
    onForceLoad();
  }

  public Context getContext()
  {
    return this.mContext;
  }

  public int getId()
  {
    return this.mId;
  }

  public boolean isAbandoned()
  {
    return this.mAbandoned;
  }

  public boolean isReset()
  {
    return this.mReset;
  }

  public boolean isStarted()
  {
    return this.mStarted;
  }

  protected void onAbandon()
  {
  }

  public void onContentChanged()
  {
    if (this.mStarted)
      forceLoad();
    while (true)
    {
      return;
      this.mContentChanged = true;
    }
  }

  protected void onForceLoad()
  {
  }

  protected void onReset()
  {
  }

  protected void onStartLoading()
  {
  }

  protected void onStopLoading()
  {
  }

  @Signature({"(I", "Landroid/support/v4/content/Loader$OnLoadCompleteListener", "<TD;>;)V"})
  public void registerListener(int paramInt, OnLoadCompleteListener paramOnLoadCompleteListener)
  {
    if (this.mListener != null)
      throw new IllegalStateException("There is already a listener registered");
    this.mListener = paramOnLoadCompleteListener;
    this.mId = paramInt;
  }

  public void reset()
  {
    onReset();
    this.mReset = true;
    this.mStarted = null;
    this.mAbandoned = null;
    this.mContentChanged = null;
  }

  public final void startLoading()
  {
    this.mStarted = true;
    this.mReset = null;
    this.mAbandoned = null;
    onStartLoading();
  }

  public void stopLoading()
  {
    this.mStarted = null;
    onStopLoading();
  }

  public boolean takeContentChanged()
  {
    boolean bool = this.mContentChanged;
    this.mContentChanged = null;
    return bool;
  }

  public String toString()
  {
    StringBuilder localStringBuilder = new StringBuilder(64);
    DebugUtils.buildShortClassTag(this, localStringBuilder);
    localStringBuilder.append(" id=");
    int i = this.mId;
    localStringBuilder.append(i);
    localStringBuilder.append("}");
    return localStringBuilder.toString();
  }

  @Signature({"(", "Landroid/support/v4/content/Loader$OnLoadCompleteListener", "<TD;>;)V"})
  public void unregisterListener(OnLoadCompleteListener paramOnLoadCompleteListener)
  {
    if (this.mListener == null)
      throw new IllegalStateException("No listener register");
    if (this.mListener != paramOnLoadCompleteListener)
      throw new IllegalArgumentException("Attempting to unregister the wrong listener");
    this.mListener = null;
  }

  @Signature({"<D:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
  public abstract interface OnLoadCompleteListener
  {
    @Signature({"(", "Landroid/support/v4/content/Loader", "<TD;>;TD;)V"})
    public abstract void onLoadComplete(Loader paramLoader, Object paramObject);
  }

  public final class ForceLoadContentObserver extends ContentObserver
  {
    public ForceLoadContentObserver()
    {
      super();
    }

    public boolean deliverSelfNotifications()
    {
      return true;
    }

    public void onChange(boolean paramBoolean)
    {
      Loader.this.onContentChanged();
    }
  }
}