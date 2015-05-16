package android.support.v4.app;

import android.widget.ListView;

class ListFragment$1
  implements Runnable
{
  public void run()
  {
    ListView localListView1 = this.this$0.mList;
    ListView localListView2 = this.this$0.mList;
    localListView1.focusableViewAvailable(localListView2);
  }
}