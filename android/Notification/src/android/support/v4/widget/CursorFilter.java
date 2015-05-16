package android.support.v4.widget;

import android.database.Cursor;
import android.widget.Filter;
import android.widget.Filter.FilterResults;

class CursorFilter extends Filter
{
  CursorFilterClient mClient;

  CursorFilter(CursorFilterClient paramCursorFilterClient)
  {
    this.mClient = paramCursorFilterClient;
  }

  public CharSequence convertResultToString(Object paramObject)
  {
    CursorFilterClient localCursorFilterClient = this.mClient;
    Cursor localCursor = (Cursor)paramObject;
    return localCursorFilterClient.convertToString(paramObject);
  }

  protected Filter.FilterResults performFiltering(CharSequence paramCharSequence)
  {
    Cursor localCursor = this.mClient.runQueryOnBackgroundThread(paramCharSequence);
    Filter.FilterResults localFilterResults = new Filter.FilterResults();
    if (localCursor != null)
    {
      int i = localCursor.getCount();
      localFilterResults.count = i;
    }
    for (localFilterResults.values = localCursor; ; localFilterResults.values = null)
    {
      return localFilterResults;
      localFilterResults.count = null;
    }
  }

  protected void publishResults(CharSequence paramCharSequence, Filter.FilterResults paramFilterResults)
  {
    Cursor localCursor1 = this.mClient.getCursor();
    if ((paramFilterResults.values != null) && (paramFilterResults.values != localCursor1))
    {
      CursorFilterClient localCursorFilterClient = this.mClient;
      Cursor localCursor2 = (Cursor)paramFilterResults.values;
      localCursorFilterClient.changeCursor(localCursor2);
    }
  }

  abstract interface CursorFilterClient
  {
    public abstract void changeCursor(Cursor paramCursor);

    public abstract CharSequence convertToString(Cursor paramCursor);

    public abstract Cursor getCursor();

    public abstract Cursor runQueryOnBackgroundThread(CharSequence paramCharSequence);
  }
}