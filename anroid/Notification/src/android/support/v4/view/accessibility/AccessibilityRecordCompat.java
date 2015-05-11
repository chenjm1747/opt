package android.support.v4.view.accessibility;

import android.os.Build.VERSION;
import android.os.Parcelable;
import android.view.View;
import dalvik.annotation.Signature;
import java.util.Collections;
import java.util.List;

public class AccessibilityRecordCompat
{
  private static final AccessibilityRecordImpl IMPL;
  private final Object mRecord;

  static
  {
    if (Build.VERSION.SDK_INT >= 16)
      IMPL = new AccessibilityRecordJellyBeanImpl();
    while (true)
    {
      return;
      if (Build.VERSION.SDK_INT >= 15)
      {
        IMPL = new AccessibilityRecordIcsMr1Impl();
        continue;
      }
      if (Build.VERSION.SDK_INT >= 14)
      {
        IMPL = new AccessibilityRecordIcsImpl();
        continue;
      }
      IMPL = new AccessibilityRecordStubImpl();
    }
  }

  public AccessibilityRecordCompat(Object paramObject)
  {
    this.mRecord = paramObject;
  }

  public static AccessibilityRecordCompat obtain()
  {
    Object localObject = IMPL.obtain();
    return new AccessibilityRecordCompat(localObject);
  }

  public static AccessibilityRecordCompat obtain(AccessibilityRecordCompat paramAccessibilityRecordCompat)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject1 = paramAccessibilityRecordCompat.mRecord;
    Object localObject2 = localAccessibilityRecordImpl.obtain(localObject1);
    return new AccessibilityRecordCompat(localObject2);
  }

  public boolean equals(Object paramObject)
  {
    int i = 1;
    Object localObject2 = null;
    if (this == paramObject);
    while (true)
    {
      return i;
      if (paramObject == null)
      {
        localObject1 = localObject2;
        continue;
      }
      Class localClass1 = getClass();
      Class localClass2 = paramObject.getClass();
      if (localClass1 != localClass2)
      {
        localObject1 = localObject2;
        continue;
      }
      AccessibilityRecordCompat localAccessibilityRecordCompat = (AccessibilityRecordCompat)paramObject;
      if (this.mRecord == null)
      {
        if (localAccessibilityRecordCompat.mRecord == null)
          continue;
        localObject1 = localObject2;
        continue;
      }
      Object localObject3 = this.mRecord;
      Object localObject4 = localAccessibilityRecordCompat.mRecord;
      if (localObject3.equals(localObject4))
        continue;
      Object localObject1 = localObject2;
    }
  }

  public int getAddedCount()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getAddedCount(localObject);
  }

  public CharSequence getBeforeText()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getBeforeText(localObject);
  }

  public CharSequence getClassName()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getClassName(localObject);
  }

  public CharSequence getContentDescription()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getContentDescription(localObject);
  }

  public int getCurrentItemIndex()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getCurrentItemIndex(localObject);
  }

  public int getFromIndex()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getFromIndex(localObject);
  }

  public Object getImpl()
  {
    return this.mRecord;
  }

  public int getItemCount()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getItemCount(localObject);
  }

  public int getMaxScrollX()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getMaxScrollX(localObject);
  }

  public int getMaxScrollY()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getMaxScrollY(localObject);
  }

  public Parcelable getParcelableData()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getParcelableData(localObject);
  }

  public int getRemovedCount()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getRemovedCount(localObject);
  }

  public int getScrollX()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getScrollX(localObject);
  }

  public int getScrollY()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getScrollY(localObject);
  }

  public AccessibilityNodeInfoCompat getSource()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getSource(localObject);
  }

  @Signature({"()", "Ljava/util/List", "<", "Ljava/lang/CharSequence;", ">;"})
  public List getText()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getText(localObject);
  }

  public int getToIndex()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getToIndex(localObject);
  }

  public int getWindowId()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.getWindowId(localObject);
  }

  public int hashCode()
  {
    Object localObject = this.mRecord;
    if (localObject == null);
    for (localObject = null; ; localObject = this.mRecord.hashCode())
      return localObject;
  }

  public boolean isChecked()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.isChecked(localObject);
  }

  public boolean isEnabled()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.isEnabled(localObject);
  }

  public boolean isFullScreen()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.isFullScreen(localObject);
  }

  public boolean isPassword()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.isPassword(localObject);
  }

  public boolean isScrollable()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    return localAccessibilityRecordImpl.isScrollable(localObject);
  }

  public void recycle()
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.recycle(localObject);
  }

  public void setAddedCount(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setAddedCount(localObject, paramInt);
  }

  public void setBeforeText(CharSequence paramCharSequence)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setBeforeText(localObject, paramCharSequence);
  }

  public void setChecked(boolean paramBoolean)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setChecked(localObject, paramBoolean);
  }

  public void setClassName(CharSequence paramCharSequence)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setClassName(localObject, paramCharSequence);
  }

  public void setContentDescription(CharSequence paramCharSequence)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setContentDescription(localObject, paramCharSequence);
  }

  public void setCurrentItemIndex(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setCurrentItemIndex(localObject, paramInt);
  }

  public void setEnabled(boolean paramBoolean)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setEnabled(localObject, paramBoolean);
  }

  public void setFromIndex(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setFromIndex(localObject, paramInt);
  }

  public void setFullScreen(boolean paramBoolean)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setFullScreen(localObject, paramBoolean);
  }

  public void setItemCount(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setItemCount(localObject, paramInt);
  }

  public void setMaxScrollX(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setMaxScrollX(localObject, paramInt);
  }

  public void setMaxScrollY(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setMaxScrollY(localObject, paramInt);
  }

  public void setParcelableData(Parcelable paramParcelable)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setParcelableData(localObject, paramParcelable);
  }

  public void setPassword(boolean paramBoolean)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setPassword(localObject, paramBoolean);
  }

  public void setRemovedCount(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setRemovedCount(localObject, paramInt);
  }

  public void setScrollX(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setScrollX(localObject, paramInt);
  }

  public void setScrollY(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setScrollY(localObject, paramInt);
  }

  public void setScrollable(boolean paramBoolean)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setScrollable(localObject, paramBoolean);
  }

  public void setSource(View paramView)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setSource(localObject, paramView);
  }

  public void setSource(View paramView, int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setSource(localObject, paramView, paramInt);
  }

  public void setToIndex(int paramInt)
  {
    AccessibilityRecordImpl localAccessibilityRecordImpl = IMPL;
    Object localObject = this.mRecord;
    localAccessibilityRecordImpl.setToIndex(localObject, paramInt);
  }

  class AccessibilityRecordJellyBeanImpl extends AccessibilityRecordCompat.AccessibilityRecordIcsMr1Impl
  {
    public void setSource(Object paramObject, View paramView, int paramInt)
    {
      AccessibilityRecordCompatJellyBean.setSource(paramObject, paramView, paramInt);
    }
  }

  class AccessibilityRecordIcsMr1Impl extends AccessibilityRecordCompat.AccessibilityRecordIcsImpl
  {
    public int getMaxScrollX(Object paramObject)
    {
      return AccessibilityRecordCompatIcsMr1.getMaxScrollX(paramObject);
    }

    public int getMaxScrollY(Object paramObject)
    {
      return AccessibilityRecordCompatIcsMr1.getMaxScrollY(paramObject);
    }

    public void setMaxScrollX(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcsMr1.setMaxScrollX(paramObject, paramInt);
    }

    public void setMaxScrollY(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcsMr1.setMaxScrollY(paramObject, paramInt);
    }
  }

  class AccessibilityRecordIcsImpl extends AccessibilityRecordCompat.AccessibilityRecordStubImpl
  {
    public int getAddedCount(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getAddedCount(paramObject);
    }

    public CharSequence getBeforeText(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getBeforeText(paramObject);
    }

    public CharSequence getClassName(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getClassName(paramObject);
    }

    public CharSequence getContentDescription(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getContentDescription(paramObject);
    }

    public int getCurrentItemIndex(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getCurrentItemIndex(paramObject);
    }

    public int getFromIndex(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getFromIndex(paramObject);
    }

    public int getItemCount(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getItemCount(paramObject);
    }

    public Parcelable getParcelableData(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getParcelableData(paramObject);
    }

    public int getRemovedCount(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getRemovedCount(paramObject);
    }

    public int getScrollX(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getScrollX(paramObject);
    }

    public int getScrollY(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getScrollY(paramObject);
    }

    public AccessibilityNodeInfoCompat getSource(Object paramObject)
    {
      return AccessibilityNodeInfoCompat.wrapNonNullInstance(AccessibilityRecordCompatIcs.getSource(paramObject));
    }

    @Signature({"(", "Ljava/lang/Object;", ")", "Ljava/util/List", "<", "Ljava/lang/CharSequence;", ">;"})
    public List getText(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getText(paramObject);
    }

    public int getToIndex(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getToIndex(paramObject);
    }

    public int getWindowId(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.getWindowId(paramObject);
    }

    public boolean isChecked(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.isChecked(paramObject);
    }

    public boolean isEnabled(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.isEnabled(paramObject);
    }

    public boolean isFullScreen(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.isFullScreen(paramObject);
    }

    public boolean isPassword(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.isPassword(paramObject);
    }

    public boolean isScrollable(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.isScrollable(paramObject);
    }

    public Object obtain()
    {
      return AccessibilityRecordCompatIcs.obtain();
    }

    public Object obtain(Object paramObject)
    {
      return AccessibilityRecordCompatIcs.obtain(paramObject);
    }

    public void recycle(Object paramObject)
    {
      AccessibilityRecordCompatIcs.recycle(paramObject);
    }

    public void setAddedCount(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setAddedCount(paramObject, paramInt);
    }

    public void setBeforeText(Object paramObject, CharSequence paramCharSequence)
    {
      AccessibilityRecordCompatIcs.setBeforeText(paramObject, paramCharSequence);
    }

    public void setChecked(Object paramObject, boolean paramBoolean)
    {
      AccessibilityRecordCompatIcs.setChecked(paramObject, paramBoolean);
    }

    public void setClassName(Object paramObject, CharSequence paramCharSequence)
    {
      AccessibilityRecordCompatIcs.setClassName(paramObject, paramCharSequence);
    }

    public void setContentDescription(Object paramObject, CharSequence paramCharSequence)
    {
      AccessibilityRecordCompatIcs.setContentDescription(paramObject, paramCharSequence);
    }

    public void setCurrentItemIndex(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setCurrentItemIndex(paramObject, paramInt);
    }

    public void setEnabled(Object paramObject, boolean paramBoolean)
    {
      AccessibilityRecordCompatIcs.setEnabled(paramObject, paramBoolean);
    }

    public void setFromIndex(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setFromIndex(paramObject, paramInt);
    }

    public void setFullScreen(Object paramObject, boolean paramBoolean)
    {
      AccessibilityRecordCompatIcs.setFullScreen(paramObject, paramBoolean);
    }

    public void setItemCount(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setItemCount(paramObject, paramInt);
    }

    public void setParcelableData(Object paramObject, Parcelable paramParcelable)
    {
      AccessibilityRecordCompatIcs.setParcelableData(paramObject, paramParcelable);
    }

    public void setPassword(Object paramObject, boolean paramBoolean)
    {
      AccessibilityRecordCompatIcs.setPassword(paramObject, paramBoolean);
    }

    public void setRemovedCount(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setRemovedCount(paramObject, paramInt);
    }

    public void setScrollX(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setScrollX(paramObject, paramInt);
    }

    public void setScrollY(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setScrollY(paramObject, paramInt);
    }

    public void setScrollable(Object paramObject, boolean paramBoolean)
    {
      AccessibilityRecordCompatIcs.setScrollable(paramObject, paramBoolean);
    }

    public void setSource(Object paramObject, View paramView)
    {
      AccessibilityRecordCompatIcs.setSource(paramObject, paramView);
    }

    public void setToIndex(Object paramObject, int paramInt)
    {
      AccessibilityRecordCompatIcs.setToIndex(paramObject, paramInt);
    }
  }

  class AccessibilityRecordStubImpl
    implements AccessibilityRecordCompat.AccessibilityRecordImpl
  {
    public int getAddedCount(Object paramObject)
    {
      return null;
    }

    public CharSequence getBeforeText(Object paramObject)
    {
      return null;
    }

    public CharSequence getClassName(Object paramObject)
    {
      return null;
    }

    public CharSequence getContentDescription(Object paramObject)
    {
      return null;
    }

    public int getCurrentItemIndex(Object paramObject)
    {
      return null;
    }

    public int getFromIndex(Object paramObject)
    {
      return null;
    }

    public int getItemCount(Object paramObject)
    {
      return null;
    }

    public int getMaxScrollX(Object paramObject)
    {
      return null;
    }

    public int getMaxScrollY(Object paramObject)
    {
      return null;
    }

    public Parcelable getParcelableData(Object paramObject)
    {
      return null;
    }

    public int getRemovedCount(Object paramObject)
    {
      return null;
    }

    public int getScrollX(Object paramObject)
    {
      return null;
    }

    public int getScrollY(Object paramObject)
    {
      return null;
    }

    public AccessibilityNodeInfoCompat getSource(Object paramObject)
    {
      return null;
    }

    @Signature({"(", "Ljava/lang/Object;", ")", "Ljava/util/List", "<", "Ljava/lang/CharSequence;", ">;"})
    public List getText(Object paramObject)
    {
      return Collections.emptyList();
    }

    public int getToIndex(Object paramObject)
    {
      return null;
    }

    public int getWindowId(Object paramObject)
    {
      return null;
    }

    public boolean isChecked(Object paramObject)
    {
      return null;
    }

    public boolean isEnabled(Object paramObject)
    {
      return null;
    }

    public boolean isFullScreen(Object paramObject)
    {
      return null;
    }

    public boolean isPassword(Object paramObject)
    {
      return null;
    }

    public boolean isScrollable(Object paramObject)
    {
      return null;
    }

    public Object obtain()
    {
      return null;
    }

    public Object obtain(Object paramObject)
    {
      return null;
    }

    public void recycle(Object paramObject)
    {
    }

    public void setAddedCount(Object paramObject, int paramInt)
    {
    }

    public void setBeforeText(Object paramObject, CharSequence paramCharSequence)
    {
    }

    public void setChecked(Object paramObject, boolean paramBoolean)
    {
    }

    public void setClassName(Object paramObject, CharSequence paramCharSequence)
    {
    }

    public void setContentDescription(Object paramObject, CharSequence paramCharSequence)
    {
    }

    public void setCurrentItemIndex(Object paramObject, int paramInt)
    {
    }

    public void setEnabled(Object paramObject, boolean paramBoolean)
    {
    }

    public void setFromIndex(Object paramObject, int paramInt)
    {
    }

    public void setFullScreen(Object paramObject, boolean paramBoolean)
    {
    }

    public void setItemCount(Object paramObject, int paramInt)
    {
    }

    public void setMaxScrollX(Object paramObject, int paramInt)
    {
    }

    public void setMaxScrollY(Object paramObject, int paramInt)
    {
    }

    public void setParcelableData(Object paramObject, Parcelable paramParcelable)
    {
    }

    public void setPassword(Object paramObject, boolean paramBoolean)
    {
    }

    public void setRemovedCount(Object paramObject, int paramInt)
    {
    }

    public void setScrollX(Object paramObject, int paramInt)
    {
    }

    public void setScrollY(Object paramObject, int paramInt)
    {
    }

    public void setScrollable(Object paramObject, boolean paramBoolean)
    {
    }

    public void setSource(Object paramObject, View paramView)
    {
    }

    public void setSource(Object paramObject, View paramView, int paramInt)
    {
    }

    public void setToIndex(Object paramObject, int paramInt)
    {
    }
  }

  abstract interface AccessibilityRecordImpl
  {
    public abstract int getAddedCount(Object paramObject);

    public abstract CharSequence getBeforeText(Object paramObject);

    public abstract CharSequence getClassName(Object paramObject);

    public abstract CharSequence getContentDescription(Object paramObject);

    public abstract int getCurrentItemIndex(Object paramObject);

    public abstract int getFromIndex(Object paramObject);

    public abstract int getItemCount(Object paramObject);

    public abstract int getMaxScrollX(Object paramObject);

    public abstract int getMaxScrollY(Object paramObject);

    public abstract Parcelable getParcelableData(Object paramObject);

    public abstract int getRemovedCount(Object paramObject);

    public abstract int getScrollX(Object paramObject);

    public abstract int getScrollY(Object paramObject);

    public abstract AccessibilityNodeInfoCompat getSource(Object paramObject);

    @Signature({"(", "Ljava/lang/Object;", ")", "Ljava/util/List", "<", "Ljava/lang/CharSequence;", ">;"})
    public abstract List getText(Object paramObject);

    public abstract int getToIndex(Object paramObject);

    public abstract int getWindowId(Object paramObject);

    public abstract boolean isChecked(Object paramObject);

    public abstract boolean isEnabled(Object paramObject);

    public abstract boolean isFullScreen(Object paramObject);

    public abstract boolean isPassword(Object paramObject);

    public abstract boolean isScrollable(Object paramObject);

    public abstract Object obtain();

    public abstract Object obtain(Object paramObject);

    public abstract void recycle(Object paramObject);

    public abstract void setAddedCount(Object paramObject, int paramInt);

    public abstract void setBeforeText(Object paramObject, CharSequence paramCharSequence);

    public abstract void setChecked(Object paramObject, boolean paramBoolean);

    public abstract void setClassName(Object paramObject, CharSequence paramCharSequence);

    public abstract void setContentDescription(Object paramObject, CharSequence paramCharSequence);

    public abstract void setCurrentItemIndex(Object paramObject, int paramInt);

    public abstract void setEnabled(Object paramObject, boolean paramBoolean);

    public abstract void setFromIndex(Object paramObject, int paramInt);

    public abstract void setFullScreen(Object paramObject, boolean paramBoolean);

    public abstract void setItemCount(Object paramObject, int paramInt);

    public abstract void setMaxScrollX(Object paramObject, int paramInt);

    public abstract void setMaxScrollY(Object paramObject, int paramInt);

    public abstract void setParcelableData(Object paramObject, Parcelable paramParcelable);

    public abstract void setPassword(Object paramObject, boolean paramBoolean);

    public abstract void setRemovedCount(Object paramObject, int paramInt);

    public abstract void setScrollX(Object paramObject, int paramInt);

    public abstract void setScrollY(Object paramObject, int paramInt);

    public abstract void setScrollable(Object paramObject, boolean paramBoolean);

    public abstract void setSource(Object paramObject, View paramView);

    public abstract void setSource(Object paramObject, View paramView, int paramInt);

    public abstract void setToIndex(Object paramObject, int paramInt);
  }
}