package android.support.v4.content;

import android.content.ContentResolver;
import android.content.Context;
import android.database.ContentObserver;
import android.database.Cursor;
import android.net.Uri;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.Arrays;

@Signature({"Landroid/support/v4/content/AsyncTaskLoader", "<", "Landroid/database/Cursor;", ">;"})
public class CursorLoader extends AsyncTaskLoader
{
  Cursor mCursor;

  @Signature({"Landroid/support/v4/content/Loader", "<", "Landroid/database/Cursor;", ">.Force", "LoadContentObserver;"})
  final Loader.ForceLoadContentObserver mObserver;
  String[] mProjection;
  String mSelection;
  String[] mSelectionArgs;
  String mSortOrder;
  Uri mUri;

  public CursorLoader(Context paramContext)
  {
    super(paramContext);
    Loader.ForceLoadContentObserver localForceLoadContentObserver = new Loader.ForceLoadContentObserver(this);
    this.mObserver = localForceLoadContentObserver;
  }

  public CursorLoader(Context paramContext, Uri paramUri, String[] paramArrayOfString1, String paramString1, String[] paramArrayOfString2, String paramString2)
  {
    super(paramContext);
    Loader.ForceLoadContentObserver localForceLoadContentObserver = new Loader.ForceLoadContentObserver(this);
    this.mObserver = localForceLoadContentObserver;
    this.mUri = paramUri;
    this.mProjection = paramArrayOfString1;
    this.mSelection = paramString1;
    this.mSelectionArgs = paramArrayOfString2;
    this.mSortOrder = paramString2;
  }

  public void deliverResult(Cursor paramCursor)
  {
    if (isReset())
      if (paramCursor != null)
        paramCursor.close();
    while (true)
    {
      return;
      Cursor localCursor = this.mCursor;
      this.mCursor = paramCursor;
      if (isStarted())
        super.deliverResult(paramCursor);
      if ((localCursor == null) || (localCursor == paramCursor) || (localCursor.isClosed()))
        continue;
      localCursor.close();
    }
  }

  public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
  {
    super.dump(paramString, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mUri=");
    Uri localUri = this.mUri;
    paramPrintWriter.println(localUri);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mProjection=");
    String str1 = Arrays.toString(this.mProjection);
    paramPrintWriter.println(str1);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mSelection=");
    String str2 = this.mSelection;
    paramPrintWriter.println(str2);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mSelectionArgs=");
    String str3 = Arrays.toString(this.mSelectionArgs);
    paramPrintWriter.println(str3);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mSortOrder=");
    String str4 = this.mSortOrder;
    paramPrintWriter.println(str4);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mCursor=");
    Cursor localCursor = this.mCursor;
    paramPrintWriter.println(localCursor);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("mContentChanged=");
    boolean bool = this.mContentChanged;
    paramPrintWriter.println(bool);
  }

  public String[] getProjection()
  {
    return this.mProjection;
  }

  public String getSelection()
  {
    return this.mSelection;
  }

  public String[] getSelectionArgs()
  {
    return this.mSelectionArgs;
  }

  public String getSortOrder()
  {
    return this.mSortOrder;
  }

  public Uri getUri()
  {
    return this.mUri;
  }

  public Cursor loadInBackground()
  {
    ContentResolver localContentResolver = getContext().getContentResolver();
    Uri localUri = this.mUri;
    String[] arrayOfString1 = this.mProjection;
    String str1 = this.mSelection;
    String[] arrayOfString2 = this.mSelectionArgs;
    String str2 = this.mSortOrder;
    Cursor localCursor = localContentResolver.query(localUri, arrayOfString1, str1, arrayOfString2, str2);
    if (localCursor != null)
    {
      localCursor.getCount();
      Loader.ForceLoadContentObserver localForceLoadContentObserver = this.mObserver;
      registerContentObserver(localCursor, localForceLoadContentObserver);
    }
    return localCursor;
  }

  public void onCanceled(Cursor paramCursor)
  {
    if ((paramCursor != null) && (!paramCursor.isClosed()))
      paramCursor.close();
  }

  protected void onReset()
  {
    super.onReset();
    onStopLoading();
    if ((this.mCursor != null) && (!this.mCursor.isClosed()))
      this.mCursor.close();
    this.mCursor = null;
  }

  protected void onStartLoading()
  {
    if (this.mCursor != null)
    {
      Cursor localCursor = this.mCursor;
      deliverResult(localCursor);
    }
    if ((takeContentChanged()) || (this.mCursor == null))
      forceLoad();
  }

  protected void onStopLoading()
  {
    cancelLoad();
  }

  void registerContentObserver(Cursor paramCursor, ContentObserver paramContentObserver)
  {
    Loader.ForceLoadContentObserver localForceLoadContentObserver = this.mObserver;
    paramCursor.registerContentObserver(localForceLoadContentObserver);
  }

  public void setProjection(String[] paramArrayOfString)
  {
    this.mProjection = paramArrayOfString;
  }

  public void setSelection(String paramString)
  {
    this.mSelection = paramString;
  }

  public void setSelectionArgs(String[] paramArrayOfString)
  {
    this.mSelectionArgs = paramArrayOfString;
  }

  public void setSortOrder(String paramString)
  {
    this.mSortOrder = paramString;
  }

  public void setUri(Uri paramUri)
  {
    this.mUri = paramUri;
  }
}