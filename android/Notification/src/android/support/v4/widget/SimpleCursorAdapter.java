package android.support.v4.widget;

import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class SimpleCursorAdapter extends ResourceCursorAdapter
{
  private CursorToStringConverter mCursorToStringConverter;
  protected int[] mFrom;
  String[] mOriginalFrom;
  private int mStringConversionColumn = -1;
  protected int[] mTo;
  private ViewBinder mViewBinder;

  @Deprecated
  public SimpleCursorAdapter(Context paramContext, int paramInt, Cursor paramCursor, String[] paramArrayOfString, int[] paramArrayOfInt)
  {
    super(paramContext, paramInt, paramCursor);
    this.mTo = paramArrayOfInt;
    this.mOriginalFrom = paramArrayOfString;
    findColumns(paramArrayOfString);
  }

  public SimpleCursorAdapter(Context paramContext, int paramInt1, Cursor paramCursor, String[] paramArrayOfString, int[] paramArrayOfInt, int paramInt2)
  {
    super(paramContext, paramInt1, paramCursor, paramInt2);
    this.mTo = paramArrayOfInt;
    this.mOriginalFrom = paramArrayOfString;
    findColumns(paramArrayOfString);
  }

  private void findColumns(String[] paramArrayOfString)
  {
    if (this.mCursor != null)
    {
      int i = paramArrayOfString.length;
      if ((this.mFrom == null) || (this.mFrom.length != i))
      {
        int[] arrayOfInt1 = new int[i];
        this.mFrom = arrayOfInt1;
      }
      for (int j = 0; j < i; j++)
      {
        int[] arrayOfInt2 = this.mFrom;
        Cursor localCursor = this.mCursor;
        String str = paramArrayOfString[j];
        int k = localCursor.getColumnIndexOrThrow(str);
        arrayOfInt2[j] = k;
      }
    }
    this.mFrom = null;
  }

  public void bindView(View paramView, Context paramContext, Cursor paramCursor)
  {
    ViewBinder localViewBinder = this.mViewBinder;
    int i = this.mTo.length;
    int[] arrayOfInt1 = this.mFrom;
    int[] arrayOfInt2 = this.mTo;
    Object localObject1 = null;
    if (localObject1 < i)
    {
      int j = arrayOfInt2[localObject1];
      Object localObject2 = paramView.findViewById(j);
      String str1;
      if (localObject2 != null)
      {
        boolean bool = null;
        if (localViewBinder != null)
        {
          int k = arrayOfInt1[localObject1];
          bool = localViewBinder.setViewValue((View)localObject2, paramCursor, k);
        }
        if (bool == null)
        {
          int m = arrayOfInt1[localObject1];
          str1 = paramCursor.getString(m);
          if (str1 == null)
            str1 = "";
          if (!(localObject2 instanceof TextView))
            break label144;
          localObject2 = (TextView)localObject2;
          setViewText((TextView)localObject2, str1);
        }
      }
      while (true)
      {
        localObject1++;
        break;
        label144: if (!(localObject2 instanceof ImageView))
          break label170;
        localObject2 = (ImageView)localObject2;
        setViewImage((ImageView)localObject2, str1);
      }
      label170: StringBuilder localStringBuilder = new StringBuilder();
      String str2 = localObject2.getClass().getName();
      String str3 = str2 + " is not a " + " view that can be bounds by this SimpleCursorAdapter";
      throw new IllegalStateException(str3);
    }
  }

  public void changeCursorAndColumns(Cursor paramCursor, String[] paramArrayOfString, int[] paramArrayOfInt)
  {
    this.mOriginalFrom = paramArrayOfString;
    this.mTo = paramArrayOfInt;
    super.changeCursor(paramCursor);
    String[] arrayOfString = this.mOriginalFrom;
    findColumns(arrayOfString);
  }

  public CharSequence convertToString(Cursor paramCursor)
  {
    Object localObject1 = this.mCursorToStringConverter;
    if (localObject1 != null)
      localObject1 = this.mCursorToStringConverter.convertToString(paramCursor);
    while (true)
    {
      return localObject1;
      int i = this.mStringConversionColumn;
      if (i > -1)
      {
        i = this.mStringConversionColumn;
        localObject2 = paramCursor.getString(i);
        continue;
      }
      Object localObject2 = super.convertToString(paramCursor);
    }
  }

  public CursorToStringConverter getCursorToStringConverter()
  {
    return this.mCursorToStringConverter;
  }

  public int getStringConversionColumn()
  {
    return this.mStringConversionColumn;
  }

  public ViewBinder getViewBinder()
  {
    return this.mViewBinder;
  }

  public void setCursorToStringConverter(CursorToStringConverter paramCursorToStringConverter)
  {
    this.mCursorToStringConverter = paramCursorToStringConverter;
  }

  public void setStringConversionColumn(int paramInt)
  {
    this.mStringConversionColumn = paramInt;
  }

  public void setViewBinder(ViewBinder paramViewBinder)
  {
    this.mViewBinder = paramViewBinder;
  }

  public void setViewImage(ImageView paramImageView, String paramString)
  {
    try
    {
      int i = Integer.parseInt(paramString);
      paramImageView.setImageResource(i);
      return;
    }
    catch (NumberFormatException localNumberFormatException)
    {
      while (true)
      {
        Uri localUri = Uri.parse(paramString);
        paramImageView.setImageURI(localUri);
      }
    }
  }

  public void setViewText(TextView paramTextView, String paramString)
  {
    paramTextView.setText(paramString);
  }

  public Cursor swapCursor(Cursor paramCursor)
  {
    Cursor localCursor = super.swapCursor(paramCursor);
    String[] arrayOfString = this.mOriginalFrom;
    findColumns(arrayOfString);
    return localCursor;
  }

  public abstract interface CursorToStringConverter
  {
    public abstract CharSequence convertToString(Cursor paramCursor);
  }

  public abstract interface ViewBinder
  {
    public abstract boolean setViewValue(View paramView, Cursor paramCursor, int paramInt);
  }
}