package android.support.v4.widget;

import android.content.Context;
import android.database.ContentObserver;
import android.database.Cursor;
import android.database.DataSetObserver;
import android.os.Handler;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.FilterQueryProvider;
import android.widget.Filterable;

public abstract class CursorAdapter extends BaseAdapter
  implements Filterable, CursorFilter.CursorFilterClient
{

  @Deprecated
  public static final int FLAG_AUTO_REQUERY = 1;
  public static final int FLAG_REGISTER_CONTENT_OBSERVER = 2;
  protected boolean mAutoRequery;
  protected ChangeObserver mChangeObserver;
  protected Context mContext;
  protected Cursor mCursor;
  protected CursorFilter mCursorFilter;
  protected DataSetObserver mDataSetObserver;
  protected boolean mDataValid;
  protected FilterQueryProvider mFilterQueryProvider;
  protected int mRowIDColumn;

  @Deprecated
  public CursorAdapter(Context paramContext, Cursor paramCursor)
  {
    init(paramContext, paramCursor, 1);
  }

  public CursorAdapter(Context paramContext, Cursor paramCursor, int paramInt)
  {
    init(paramContext, paramCursor, paramInt);
  }

  public CursorAdapter(Context paramContext, Cursor paramCursor, boolean paramBoolean)
  {
    if (paramBoolean);
    for (int i = 1; ; i = 2)
    {
      init(paramContext, paramCursor, i);
      return;
    }
  }

  public abstract void bindView(View paramView, Context paramContext, Cursor paramCursor);

  public void changeCursor(Cursor paramCursor)
  {
    Cursor localCursor = swapCursor(paramCursor);
    if (localCursor != null)
      localCursor.close();
  }

  public CharSequence convertToString(Cursor paramCursor)
  {
    if (paramCursor == null);
    for (String str = ""; ; str = paramCursor.toString())
      return str;
  }

  public int getCount()
  {
    boolean bool = this.mDataValid;
    if (bool)
    {
      localObject = this.mCursor;
      if (localObject == null);
    }
    for (Object localObject = this.mCursor.getCount(); ; localObject = null)
      return localObject;
  }

  public Cursor getCursor()
  {
    return this.mCursor;
  }

  public View getDropDownView(int paramInt, View paramView, ViewGroup paramViewGroup)
  {
    View localView;
    if (this.mDataValid)
    {
      this.mCursor.moveToPosition(paramInt);
      if (paramView == null)
      {
        Context localContext1 = this.mContext;
        Cursor localCursor1 = this.mCursor;
        localView = newDropDownView(localContext1, localCursor1, paramViewGroup);
        Context localContext2 = this.mContext;
        Cursor localCursor2 = this.mCursor;
        bindView(localView, localContext2, localCursor2);
      }
    }
    while (true)
    {
      return localView;
      localView = paramView;
      break;
      int i = 0;
    }
  }

  public Filter getFilter()
  {
    if (this.mCursorFilter == null)
    {
      CursorFilter localCursorFilter = new CursorFilter(this);
      this.mCursorFilter = localCursorFilter;
    }
    return this.mCursorFilter;
  }

  public FilterQueryProvider getFilterQueryProvider()
  {
    return this.mFilterQueryProvider;
  }

  public Object getItem(int paramInt)
  {
    boolean bool = this.mDataValid;
    Cursor localCursor;
    if (bool)
    {
      localCursor = this.mCursor;
      if (localCursor != null)
      {
        this.mCursor.moveToPosition(paramInt);
        localCursor = this.mCursor;
      }
    }
    while (true)
    {
      return localCursor;
      localCursor = null;
    }
  }

  public long getItemId(int paramInt)
  {
    long l = 0L;
    if ((this.mDataValid) && (this.mCursor != null) && (this.mCursor.moveToPosition(paramInt)))
    {
      Object localObject = this.mCursor;
      int i = this.mRowIDColumn;
      localObject = ((Cursor)localObject).getLong(i);
    }
    return l;
  }

  public View getView(int paramInt, View paramView, ViewGroup paramViewGroup)
  {
    if (!this.mDataValid)
      throw new IllegalStateException("this should only be called when the cursor is valid");
    if (!this.mCursor.moveToPosition(paramInt))
    {
      String str = "couldn't move cursor to position " + paramInt;
      throw new IllegalStateException(str);
    }
    Context localContext1;
    Cursor localCursor1;
    if (paramView == null)
    {
      localContext1 = this.mContext;
      localCursor1 = this.mCursor;
    }
    for (View localView = newView(localContext1, localCursor1, paramViewGroup); ; localView = paramView)
    {
      Context localContext2 = this.mContext;
      Cursor localCursor2 = this.mCursor;
      bindView(localView, localContext2, localCursor2);
      return localView;
    }
  }

  public boolean hasStableIds()
  {
    return true;
  }

  void init(Context paramContext, Cursor paramCursor, int paramInt)
  {
    int i = null;
    1 local1 = null;
    int j = 1;
    label31: label62: MyDataSetObserver localMyDataSetObserver;
    if ((paramInt & 0x1) == j)
    {
      paramInt |= 2;
      this.mAutoRequery = j;
      if (paramCursor == null)
        break label166;
      this.mCursor = paramCursor;
      this.mDataValid = j;
      this.mContext = paramContext;
      if (j == null)
        break label173;
      i = paramCursor.getColumnIndexOrThrow("_id");
      this.mRowIDColumn = i;
      if ((paramInt & 0x2) != 2)
        break label180;
      ChangeObserver localChangeObserver1 = new ChangeObserver();
      this.mChangeObserver = localChangeObserver1;
      localMyDataSetObserver = new MyDataSetObserver(local1);
    }
    for (this.mDataSetObserver = localMyDataSetObserver; ; this.mDataSetObserver = local1)
    {
      if (j != null)
      {
        if (this.mChangeObserver != null)
        {
          ChangeObserver localChangeObserver2 = this.mChangeObserver;
          paramCursor.registerContentObserver(localChangeObserver2);
        }
        if (this.mDataSetObserver != null)
        {
          DataSetObserver localDataSetObserver = this.mDataSetObserver;
          paramCursor.registerDataSetObserver(localDataSetObserver);
        }
      }
      return;
      this.mAutoRequery = i;
      break;
      label166: int k = i;
      break label31;
      label173: i = -1;
      break label62;
      label180: this.mChangeObserver = local1;
    }
  }

  @Deprecated
  protected void init(Context paramContext, Cursor paramCursor, boolean paramBoolean)
  {
    if (paramBoolean);
    for (int i = 1; ; i = 2)
    {
      init(paramContext, paramCursor, i);
      return;
    }
  }

  public View newDropDownView(Context paramContext, Cursor paramCursor, ViewGroup paramViewGroup)
  {
    return newView(paramContext, paramCursor, paramViewGroup);
  }

  public abstract View newView(Context paramContext, Cursor paramCursor, ViewGroup paramViewGroup);

  protected void onContentChanged()
  {
    if ((this.mAutoRequery) && (this.mCursor != null) && (!this.mCursor.isClosed()))
    {
      boolean bool = this.mCursor.requery();
      this.mDataValid = bool;
    }
  }

  public Cursor runQueryOnBackgroundThread(CharSequence paramCharSequence)
  {
    Object localObject = this.mFilterQueryProvider;
    if (localObject != null);
    for (localObject = this.mFilterQueryProvider.runQuery(paramCharSequence); ; localObject = this.mCursor)
      return localObject;
  }

  public void setFilterQueryProvider(FilterQueryProvider paramFilterQueryProvider)
  {
    this.mFilterQueryProvider = paramFilterQueryProvider;
  }

  public Cursor swapCursor(Cursor paramCursor)
  {
    Cursor localCursor1 = this.mCursor;
    int i;
    if (paramCursor == localCursor1)
      i = 0;
    while (true)
    {
      return i;
      Cursor localCursor2 = this.mCursor;
      if (localCursor2 != null)
      {
        if (this.mChangeObserver != null)
        {
          ChangeObserver localChangeObserver1 = this.mChangeObserver;
          localCursor2.unregisterContentObserver(localChangeObserver1);
        }
        if (this.mDataSetObserver != null)
        {
          DataSetObserver localDataSetObserver1 = this.mDataSetObserver;
          localCursor2.unregisterDataSetObserver(localDataSetObserver1);
        }
      }
      this.mCursor = paramCursor;
      if (paramCursor != null)
      {
        if (this.mChangeObserver != null)
        {
          ChangeObserver localChangeObserver2 = this.mChangeObserver;
          paramCursor.registerContentObserver(localChangeObserver2);
        }
        if (this.mDataSetObserver != null)
        {
          DataSetObserver localDataSetObserver2 = this.mDataSetObserver;
          paramCursor.registerDataSetObserver(localDataSetObserver2);
        }
        int j = paramCursor.getColumnIndexOrThrow("_id");
        this.mRowIDColumn = j;
        this.mDataValid = true;
        notifyDataSetChanged();
        continue;
      }
      this.mRowIDColumn = -1;
      this.mDataValid = null;
      notifyDataSetInvalidated();
    }
  }

  class MyDataSetObserver extends DataSetObserver
  {
    private MyDataSetObserver()
    {
    }

    public void onChanged()
    {
      CursorAdapter.this.mDataValid = true;
      CursorAdapter.this.notifyDataSetChanged();
    }

    public void onInvalidated()
    {
      CursorAdapter.this.mDataValid = null;
      CursorAdapter.this.notifyDataSetInvalidated();
    }
  }

  class ChangeObserver extends ContentObserver
  {
    public ChangeObserver()
    {
      super();
    }

    public boolean deliverSelfNotifications()
    {
      return true;
    }

    public void onChange(boolean paramBoolean)
    {
      CursorAdapter.this.onContentChanged();
    }
  }
}