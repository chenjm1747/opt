package android.support.v4.app;

import android.os.Bundle;
import android.support.v4.content.Loader;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public abstract class LoaderManager
{
  public static void enableDebugLogging(boolean paramBoolean)
  {
    boolean bool = LoaderManagerImpl.DEBUG;
  }

  public abstract void destroyLoader(int paramInt);

  public abstract void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString);

  @Signature({"<D:", "Ljava/lang/Object;", ">(I)", "Landroid/support/v4/content/Loader", "<TD;>;"})
  public abstract Loader getLoader(int paramInt);

  public boolean hasRunningLoaders()
  {
    return null;
  }

  @Signature({"<D:", "Ljava/lang/Object;", ">(I", "Landroid/os/Bundle;", "Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<TD;>;)", "Landroid/support/v4/content/Loader", "<TD;>;"})
  public abstract Loader initLoader(int paramInt, Bundle paramBundle, LoaderCallbacks paramLoaderCallbacks);

  @Signature({"<D:", "Ljava/lang/Object;", ">(I", "Landroid/os/Bundle;", "Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<TD;>;)", "Landroid/support/v4/content/Loader", "<TD;>;"})
  public abstract Loader restartLoader(int paramInt, Bundle paramBundle, LoaderCallbacks paramLoaderCallbacks);

  @Signature({"<D:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
  public abstract interface LoaderCallbacks
  {
    @Signature({"(I", "Landroid/os/Bundle;", ")", "Landroid/support/v4/content/Loader", "<TD;>;"})
    public abstract Loader onCreateLoader(int paramInt, Bundle paramBundle);

    @Signature({"(", "Landroid/support/v4/content/Loader", "<TD;>;TD;)V"})
    public abstract void onLoadFinished(Loader paramLoader, Object paramObject);

    @Signature({"(", "Landroid/support/v4/content/Loader", "<TD;>;)V"})
    public abstract void onLoaderReset(Loader paramLoader);
  }
}