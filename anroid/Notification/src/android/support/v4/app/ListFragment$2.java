package android.support.v4.app;

import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import dalvik.annotation.Signature;

class ListFragment$2
  implements AdapterView.OnItemClickListener
{
  @Signature({"(", "Landroid/widget/AdapterView", "<*>;", "Landroid/view/View;", "IJ)V"})
  public void onItemClick(AdapterView paramAdapterView, View paramView, int paramInt, long paramLong)
  {
    ListFragment localListFragment = this.this$0;
    ListView localListView = (ListView)paramAdapterView;
    View localView = paramView;
    int i = paramInt;
    long l = paramLong;
    localListFragment.onListItemClick(localListView, localView, i, l);
  }
}