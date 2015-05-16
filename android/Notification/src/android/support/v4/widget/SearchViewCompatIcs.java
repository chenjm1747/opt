package android.support.v4.widget;

import android.content.Context;
import android.view.View;
import android.widget.SearchView;

class SearchViewCompatIcs
{
  public static View newSearchView(Context paramContext)
  {
    return new MySearchView();
  }

  public static void setImeOptions(View paramView, int paramInt)
  {
    ((SearchView)paramView).setImeOptions(paramInt);
  }

  public static void setInputType(View paramView, int paramInt)
  {
    ((SearchView)paramView).setInputType(paramInt);
  }

  public class MySearchView extends SearchView
  {
    public MySearchView()
    {
      super();
    }

    public void onActionViewCollapsed()
    {
      setQuery("", null);
      super.onActionViewCollapsed();
    }
  }
}