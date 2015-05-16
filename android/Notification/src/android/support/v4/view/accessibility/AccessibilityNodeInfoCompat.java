package android.support.v4.view.accessibility;

import android.graphics.Rect;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.view.View;
import dalvik.annotation.Signature;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class AccessibilityNodeInfoCompat
{
  public static final int ACTION_ACCESSIBILITY_FOCUS = 64;
  public static final String ACTION_ARGUMENT_HTML_ELEMENT_STRING = "ACTION_ARGUMENT_HTML_ELEMENT_STRING";
  public static final String ACTION_ARGUMENT_MOVEMENT_GRANULARITY_INT = "ACTION_ARGUMENT_MOVEMENT_GRANULARITY_INT";
  public static final int ACTION_CLEAR_ACCESSIBILITY_FOCUS = 128;
  public static final int ACTION_CLEAR_FOCUS = 2;
  public static final int ACTION_CLEAR_SELECTION = 8;
  public static final int ACTION_CLICK = 16;
  public static final int ACTION_FOCUS = 1;
  public static final int ACTION_LONG_CLICK = 32;
  public static final int ACTION_NEXT_AT_MOVEMENT_GRANULARITY = 256;
  public static final int ACTION_NEXT_HTML_ELEMENT = 1024;
  public static final int ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY = 512;
  public static final int ACTION_PREVIOUS_HTML_ELEMENT = 2048;
  public static final int ACTION_SCROLL_BACKWARD = 8192;
  public static final int ACTION_SCROLL_FORWARD = 4096;
  public static final int ACTION_SELECT = 4;
  public static final int FOCUS_ACCESSIBILITY = 2;
  public static final int FOCUS_INPUT = 1;
  private static final AccessibilityNodeInfoImpl IMPL;
  public static final int MOVEMENT_GRANULARITY_CHARACTER = 1;
  public static final int MOVEMENT_GRANULARITY_LINE = 4;
  public static final int MOVEMENT_GRANULARITY_PAGE = 16;
  public static final int MOVEMENT_GRANULARITY_PARAGRAPH = 8;
  public static final int MOVEMENT_GRANULARITY_WORD = 2;
  private final Object mInfo;

  static
  {
    if (Build.VERSION.SDK_INT >= 16)
      IMPL = new AccessibilityNodeInfoJellybeanImpl();
    while (true)
    {
      return;
      if (Build.VERSION.SDK_INT >= 14)
      {
        IMPL = new AccessibilityNodeInfoIcsImpl();
        continue;
      }
      IMPL = new AccessibilityNodeInfoStubImpl();
    }
  }

  public AccessibilityNodeInfoCompat(Object paramObject)
  {
    this.mInfo = paramObject;
  }

  public static AccessibilityNodeInfoCompat obtain()
  {
    return wrapNonNullInstance(IMPL.obtain());
  }

  public static AccessibilityNodeInfoCompat obtain(AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = paramAccessibilityNodeInfoCompat.mInfo;
    return wrapNonNullInstance(localAccessibilityNodeInfoImpl.obtain(localObject));
  }

  public static AccessibilityNodeInfoCompat obtain(View paramView)
  {
    return wrapNonNullInstance(IMPL.obtain(paramView));
  }

  public static AccessibilityNodeInfoCompat obtain(View paramView, int paramInt)
  {
    return wrapNonNullInstance(IMPL.obtain(paramView, paramInt));
  }

  static AccessibilityNodeInfoCompat wrapNonNullInstance(Object paramObject)
  {
    AccessibilityNodeInfoCompat localAccessibilityNodeInfoCompat;
    if (paramObject != null)
      localAccessibilityNodeInfoCompat = new AccessibilityNodeInfoCompat(paramObject);
    while (true)
    {
      return localAccessibilityNodeInfoCompat;
      int i = 0;
    }
  }

  public void addAction(int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.addAction(localObject, paramInt);
  }

  public void addChild(View paramView)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.addChild(localObject, paramView);
  }

  public void addChild(View paramView, int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.addChild(localObject, paramView, paramInt);
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
      AccessibilityNodeInfoCompat localAccessibilityNodeInfoCompat = (AccessibilityNodeInfoCompat)paramObject;
      if (this.mInfo == null)
      {
        if (localAccessibilityNodeInfoCompat.mInfo == null)
          continue;
        localObject1 = localObject2;
        continue;
      }
      Object localObject3 = this.mInfo;
      Object localObject4 = localAccessibilityNodeInfoCompat.mInfo;
      if (localObject3.equals(localObject4))
        continue;
      Object localObject1 = localObject2;
    }
  }

  @Signature({"(", "Ljava/lang/String;", ")", "Ljava/util/List", "<", "Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;", ">;"})
  public List findAccessibilityNodeInfosByText(String paramString)
  {
    ArrayList localArrayList = new ArrayList();
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject1 = this.mInfo;
    List localList = localAccessibilityNodeInfoImpl.findAccessibilityNodeInfosByText(localObject1, paramString);
    int i = localList.size();
    for (int j = 0; j < i; j++)
    {
      Object localObject2 = localList.get(j);
      AccessibilityNodeInfoCompat localAccessibilityNodeInfoCompat = new AccessibilityNodeInfoCompat(localObject2);
      localArrayList.add(localAccessibilityNodeInfoCompat);
    }
    return localArrayList;
  }

  public AccessibilityNodeInfoCompat findFocus(int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return wrapNonNullInstance(localAccessibilityNodeInfoImpl.findFocus(localObject, paramInt));
  }

  public AccessibilityNodeInfoCompat focusSearch(int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return wrapNonNullInstance(localAccessibilityNodeInfoImpl.focusSearch(localObject, paramInt));
  }

  public int getActions()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getActions(localObject);
  }

  public void getBoundsInParent(Rect paramRect)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.getBoundsInParent(localObject, paramRect);
  }

  public void getBoundsInScreen(Rect paramRect)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.getBoundsInScreen(localObject, paramRect);
  }

  public AccessibilityNodeInfoCompat getChild(int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return wrapNonNullInstance(localAccessibilityNodeInfoImpl.getChild(localObject, paramInt));
  }

  public int getChildCount()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getChildCount(localObject);
  }

  public CharSequence getClassName()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getClassName(localObject);
  }

  public CharSequence getContentDescription()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getContentDescription(localObject);
  }

  public Object getInfo()
  {
    return this.mInfo;
  }

  public int getMovementGranularities()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getMovementGranularities(localObject);
  }

  public CharSequence getPackageName()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getPackageName(localObject);
  }

  public AccessibilityNodeInfoCompat getParent()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return wrapNonNullInstance(localAccessibilityNodeInfoImpl.getParent(localObject));
  }

  public CharSequence getText()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getText(localObject);
  }

  public int getWindowId()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.getWindowId(localObject);
  }

  public int hashCode()
  {
    Object localObject = this.mInfo;
    if (localObject == null);
    for (localObject = null; ; localObject = this.mInfo.hashCode())
      return localObject;
  }

  public boolean isAccessibilityFocused()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isAccessibilityFocused(localObject);
  }

  public boolean isCheckable()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isCheckable(localObject);
  }

  public boolean isChecked()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isChecked(localObject);
  }

  public boolean isClickable()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isClickable(localObject);
  }

  public boolean isEnabled()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isEnabled(localObject);
  }

  public boolean isFocusable()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isFocusable(localObject);
  }

  public boolean isFocused()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isFocused(localObject);
  }

  public boolean isLongClickable()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isLongClickable(localObject);
  }

  public boolean isPassword()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isPassword(localObject);
  }

  public boolean isScrollable()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isScrollable(localObject);
  }

  public boolean isSelected()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isSelected(localObject);
  }

  public boolean isVisibleToUser()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.isVisibleToUser(localObject);
  }

  public boolean performAction(int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.performAction(localObject, paramInt);
  }

  public boolean performAction(int paramInt, Bundle paramBundle)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    return localAccessibilityNodeInfoImpl.performAction(localObject, paramInt, paramBundle);
  }

  public void recycle()
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.recycle(localObject);
  }

  public void setAccessibilityFocused(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setAccessibilityFocused(localObject, paramBoolean);
  }

  public void setBoundsInParent(Rect paramRect)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setBoundsInParent(localObject, paramRect);
  }

  public void setBoundsInScreen(Rect paramRect)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setBoundsInScreen(localObject, paramRect);
  }

  public void setCheckable(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setCheckable(localObject, paramBoolean);
  }

  public void setChecked(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setChecked(localObject, paramBoolean);
  }

  public void setClassName(CharSequence paramCharSequence)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setClassName(localObject, paramCharSequence);
  }

  public void setClickable(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setClickable(localObject, paramBoolean);
  }

  public void setContentDescription(CharSequence paramCharSequence)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setContentDescription(localObject, paramCharSequence);
  }

  public void setEnabled(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setEnabled(localObject, paramBoolean);
  }

  public void setFocusable(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setFocusable(localObject, paramBoolean);
  }

  public void setFocused(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setFocused(localObject, paramBoolean);
  }

  public void setLongClickable(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setLongClickable(localObject, paramBoolean);
  }

  public void setMovementGranularities(int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setMovementGranularities(localObject, paramInt);
  }

  public void setPackageName(CharSequence paramCharSequence)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setPackageName(localObject, paramCharSequence);
  }

  public void setParent(View paramView)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setParent(localObject, paramView);
  }

  public void setParent(View paramView, int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setParent(localObject, paramView, paramInt);
  }

  public void setPassword(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setPassword(localObject, paramBoolean);
  }

  public void setScrollable(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setScrollable(localObject, paramBoolean);
  }

  public void setSelected(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setSelected(localObject, paramBoolean);
  }

  public void setSource(View paramView)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setSource(localObject, paramView);
  }

  public void setSource(View paramView, int paramInt)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setSource(localObject, paramView, paramInt);
  }

  public void setText(CharSequence paramCharSequence)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setText(localObject, paramCharSequence);
  }

  public void setVisibleToUser(boolean paramBoolean)
  {
    AccessibilityNodeInfoImpl localAccessibilityNodeInfoImpl = IMPL;
    Object localObject = this.mInfo;
    localAccessibilityNodeInfoImpl.setVisibleToUser(localObject, paramBoolean);
  }

  class AccessibilityNodeInfoJellybeanImpl extends AccessibilityNodeInfoCompat.AccessibilityNodeInfoIcsImpl
  {
    public void addChild(Object paramObject, View paramView, int paramInt)
    {
      AccessibilityNodeInfoCompatJellyBean.addChild(paramObject, paramView, paramInt);
    }

    public Object findFocus(Object paramObject, int paramInt)
    {
      return AccessibilityNodeInfoCompatJellyBean.findFocus(paramObject, paramInt);
    }

    public Object focusSearch(Object paramObject, int paramInt)
    {
      return AccessibilityNodeInfoCompatJellyBean.focusSearch(paramObject, paramInt);
    }

    public int getMovementGranularities(Object paramObject)
    {
      return AccessibilityNodeInfoCompatJellyBean.getMovementGranularities(paramObject);
    }

    public boolean isAccessibilityFocused(Object paramObject)
    {
      return AccessibilityNodeInfoCompatJellyBean.isAccessibilityFocused(paramObject);
    }

    public boolean isVisibleToUser(Object paramObject)
    {
      return AccessibilityNodeInfoCompatJellyBean.isVisibleToUser(paramObject);
    }

    public Object obtain(View paramView, int paramInt)
    {
      return AccessibilityNodeInfoCompatJellyBean.obtain(paramView, paramInt);
    }

    public boolean performAction(Object paramObject, int paramInt, Bundle paramBundle)
    {
      return AccessibilityNodeInfoCompatJellyBean.performAction(paramObject, paramInt, paramBundle);
    }

    public void setAccessibilityFocused(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatJellyBean.setAccesibilityFocused(paramObject, paramBoolean);
    }

    public void setMovementGranularities(Object paramObject, int paramInt)
    {
      AccessibilityNodeInfoCompatJellyBean.setMovementGranularities(paramObject, paramInt);
    }

    public void setParent(Object paramObject, View paramView, int paramInt)
    {
      AccessibilityNodeInfoCompatJellyBean.setParent(paramObject, paramView, paramInt);
    }

    public void setSource(Object paramObject, View paramView, int paramInt)
    {
      AccessibilityNodeInfoCompatJellyBean.setSource(paramObject, paramView, paramInt);
    }

    public void setVisibleToUser(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatJellyBean.setVisibleToUser(paramObject, paramBoolean);
    }
  }

  class AccessibilityNodeInfoIcsImpl extends AccessibilityNodeInfoCompat.AccessibilityNodeInfoStubImpl
  {
    public void addAction(Object paramObject, int paramInt)
    {
      AccessibilityNodeInfoCompatIcs.addAction(paramObject, paramInt);
    }

    public void addChild(Object paramObject, View paramView)
    {
      AccessibilityNodeInfoCompatIcs.addChild(paramObject, paramView);
    }

    @Signature({"(", "Ljava/lang/Object;", "Ljava/lang/String;", ")", "Ljava/util/List", "<", "Ljava/lang/Object;", ">;"})
    public List findAccessibilityNodeInfosByText(Object paramObject, String paramString)
    {
      return AccessibilityNodeInfoCompatIcs.findAccessibilityNodeInfosByText(paramObject, paramString);
    }

    public int getActions(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getActions(paramObject);
    }

    public void getBoundsInParent(Object paramObject, Rect paramRect)
    {
      AccessibilityNodeInfoCompatIcs.getBoundsInParent(paramObject, paramRect);
    }

    public void getBoundsInScreen(Object paramObject, Rect paramRect)
    {
      AccessibilityNodeInfoCompatIcs.getBoundsInScreen(paramObject, paramRect);
    }

    public Object getChild(Object paramObject, int paramInt)
    {
      return AccessibilityNodeInfoCompatIcs.getChild(paramObject, paramInt);
    }

    public int getChildCount(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getChildCount(paramObject);
    }

    public CharSequence getClassName(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getClassName(paramObject);
    }

    public CharSequence getContentDescription(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getContentDescription(paramObject);
    }

    public CharSequence getPackageName(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getPackageName(paramObject);
    }

    public Object getParent(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getParent(paramObject);
    }

    public CharSequence getText(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getText(paramObject);
    }

    public int getWindowId(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.getWindowId(paramObject);
    }

    public boolean isCheckable(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isCheckable(paramObject);
    }

    public boolean isChecked(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isChecked(paramObject);
    }

    public boolean isClickable(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isClickable(paramObject);
    }

    public boolean isEnabled(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isEnabled(paramObject);
    }

    public boolean isFocusable(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isFocusable(paramObject);
    }

    public boolean isFocused(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isFocused(paramObject);
    }

    public boolean isLongClickable(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isLongClickable(paramObject);
    }

    public boolean isPassword(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isPassword(paramObject);
    }

    public boolean isScrollable(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isScrollable(paramObject);
    }

    public boolean isSelected(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.isSelected(paramObject);
    }

    public Object obtain()
    {
      return AccessibilityNodeInfoCompatIcs.obtain();
    }

    public Object obtain(View paramView)
    {
      return AccessibilityNodeInfoCompatIcs.obtain(paramView);
    }

    public Object obtain(Object paramObject)
    {
      return AccessibilityNodeInfoCompatIcs.obtain(paramObject);
    }

    public boolean performAction(Object paramObject, int paramInt)
    {
      return AccessibilityNodeInfoCompatIcs.performAction(paramObject, paramInt);
    }

    public void recycle(Object paramObject)
    {
      AccessibilityNodeInfoCompatIcs.recycle(paramObject);
    }

    public void setBoundsInParent(Object paramObject, Rect paramRect)
    {
      AccessibilityNodeInfoCompatIcs.setBoundsInParent(paramObject, paramRect);
    }

    public void setBoundsInScreen(Object paramObject, Rect paramRect)
    {
      AccessibilityNodeInfoCompatIcs.setBoundsInScreen(paramObject, paramRect);
    }

    public void setCheckable(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setCheckable(paramObject, paramBoolean);
    }

    public void setChecked(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setChecked(paramObject, paramBoolean);
    }

    public void setClassName(Object paramObject, CharSequence paramCharSequence)
    {
      AccessibilityNodeInfoCompatIcs.setClassName(paramObject, paramCharSequence);
    }

    public void setClickable(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setClickable(paramObject, paramBoolean);
    }

    public void setContentDescription(Object paramObject, CharSequence paramCharSequence)
    {
      AccessibilityNodeInfoCompatIcs.setContentDescription(paramObject, paramCharSequence);
    }

    public void setEnabled(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setEnabled(paramObject, paramBoolean);
    }

    public void setFocusable(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setFocusable(paramObject, paramBoolean);
    }

    public void setFocused(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setFocused(paramObject, paramBoolean);
    }

    public void setLongClickable(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setLongClickable(paramObject, paramBoolean);
    }

    public void setPackageName(Object paramObject, CharSequence paramCharSequence)
    {
      AccessibilityNodeInfoCompatIcs.setPackageName(paramObject, paramCharSequence);
    }

    public void setParent(Object paramObject, View paramView)
    {
      AccessibilityNodeInfoCompatIcs.setParent(paramObject, paramView);
    }

    public void setPassword(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setPassword(paramObject, paramBoolean);
    }

    public void setScrollable(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setScrollable(paramObject, paramBoolean);
    }

    public void setSelected(Object paramObject, boolean paramBoolean)
    {
      AccessibilityNodeInfoCompatIcs.setSelected(paramObject, paramBoolean);
    }

    public void setSource(Object paramObject, View paramView)
    {
      AccessibilityNodeInfoCompatIcs.setSource(paramObject, paramView);
    }

    public void setText(Object paramObject, CharSequence paramCharSequence)
    {
      AccessibilityNodeInfoCompatIcs.setText(paramObject, paramCharSequence);
    }
  }

  class AccessibilityNodeInfoStubImpl
    implements AccessibilityNodeInfoCompat.AccessibilityNodeInfoImpl
  {
    public void addAction(Object paramObject, int paramInt)
    {
    }

    public void addChild(Object paramObject, View paramView)
    {
    }

    public void addChild(Object paramObject, View paramView, int paramInt)
    {
    }

    @Signature({"(", "Ljava/lang/Object;", "Ljava/lang/String;", ")", "Ljava/util/List", "<", "Ljava/lang/Object;", ">;"})
    public List findAccessibilityNodeInfosByText(Object paramObject, String paramString)
    {
      return Collections.emptyList();
    }

    public Object findFocus(Object paramObject, int paramInt)
    {
      return null;
    }

    public Object focusSearch(Object paramObject, int paramInt)
    {
      return null;
    }

    public int getActions(Object paramObject)
    {
      return null;
    }

    public void getBoundsInParent(Object paramObject, Rect paramRect)
    {
    }

    public void getBoundsInScreen(Object paramObject, Rect paramRect)
    {
    }

    public Object getChild(Object paramObject, int paramInt)
    {
      return null;
    }

    public int getChildCount(Object paramObject)
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

    public int getMovementGranularities(Object paramObject)
    {
      return null;
    }

    public CharSequence getPackageName(Object paramObject)
    {
      return null;
    }

    public Object getParent(Object paramObject)
    {
      return null;
    }

    public CharSequence getText(Object paramObject)
    {
      return null;
    }

    public int getWindowId(Object paramObject)
    {
      return null;
    }

    public boolean isAccessibilityFocused(Object paramObject)
    {
      return null;
    }

    public boolean isCheckable(Object paramObject)
    {
      return null;
    }

    public boolean isChecked(Object paramObject)
    {
      return null;
    }

    public boolean isClickable(Object paramObject)
    {
      return null;
    }

    public boolean isEnabled(Object paramObject)
    {
      return null;
    }

    public boolean isFocusable(Object paramObject)
    {
      return null;
    }

    public boolean isFocused(Object paramObject)
    {
      return null;
    }

    public boolean isLongClickable(Object paramObject)
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

    public boolean isSelected(Object paramObject)
    {
      return null;
    }

    public boolean isVisibleToUser(Object paramObject)
    {
      return null;
    }

    public Object obtain()
    {
      return null;
    }

    public Object obtain(View paramView)
    {
      return null;
    }

    public Object obtain(View paramView, int paramInt)
    {
      return null;
    }

    public Object obtain(Object paramObject)
    {
      return null;
    }

    public boolean performAction(Object paramObject, int paramInt)
    {
      return null;
    }

    public boolean performAction(Object paramObject, int paramInt, Bundle paramBundle)
    {
      return null;
    }

    public void recycle(Object paramObject)
    {
    }

    public void setAccessibilityFocused(Object paramObject, boolean paramBoolean)
    {
    }

    public void setBoundsInParent(Object paramObject, Rect paramRect)
    {
    }

    public void setBoundsInScreen(Object paramObject, Rect paramRect)
    {
    }

    public void setCheckable(Object paramObject, boolean paramBoolean)
    {
    }

    public void setChecked(Object paramObject, boolean paramBoolean)
    {
    }

    public void setClassName(Object paramObject, CharSequence paramCharSequence)
    {
    }

    public void setClickable(Object paramObject, boolean paramBoolean)
    {
    }

    public void setContentDescription(Object paramObject, CharSequence paramCharSequence)
    {
    }

    public void setEnabled(Object paramObject, boolean paramBoolean)
    {
    }

    public void setFocusable(Object paramObject, boolean paramBoolean)
    {
    }

    public void setFocused(Object paramObject, boolean paramBoolean)
    {
    }

    public void setLongClickable(Object paramObject, boolean paramBoolean)
    {
    }

    public void setMovementGranularities(Object paramObject, int paramInt)
    {
    }

    public void setPackageName(Object paramObject, CharSequence paramCharSequence)
    {
    }

    public void setParent(Object paramObject, View paramView)
    {
    }

    public void setParent(Object paramObject, View paramView, int paramInt)
    {
    }

    public void setPassword(Object paramObject, boolean paramBoolean)
    {
    }

    public void setScrollable(Object paramObject, boolean paramBoolean)
    {
    }

    public void setSelected(Object paramObject, boolean paramBoolean)
    {
    }

    public void setSource(Object paramObject, View paramView)
    {
    }

    public void setSource(Object paramObject, View paramView, int paramInt)
    {
    }

    public void setText(Object paramObject, CharSequence paramCharSequence)
    {
    }

    public void setVisibleToUser(Object paramObject, boolean paramBoolean)
    {
    }
  }

  abstract interface AccessibilityNodeInfoImpl
  {
    public abstract void addAction(Object paramObject, int paramInt);

    public abstract void addChild(Object paramObject, View paramView);

    public abstract void addChild(Object paramObject, View paramView, int paramInt);

    @Signature({"(", "Ljava/lang/Object;", "Ljava/lang/String;", ")", "Ljava/util/List", "<", "Ljava/lang/Object;", ">;"})
    public abstract List findAccessibilityNodeInfosByText(Object paramObject, String paramString);

    public abstract Object findFocus(Object paramObject, int paramInt);

    public abstract Object focusSearch(Object paramObject, int paramInt);

    public abstract int getActions(Object paramObject);

    public abstract void getBoundsInParent(Object paramObject, Rect paramRect);

    public abstract void getBoundsInScreen(Object paramObject, Rect paramRect);

    public abstract Object getChild(Object paramObject, int paramInt);

    public abstract int getChildCount(Object paramObject);

    public abstract CharSequence getClassName(Object paramObject);

    public abstract CharSequence getContentDescription(Object paramObject);

    public abstract int getMovementGranularities(Object paramObject);

    public abstract CharSequence getPackageName(Object paramObject);

    public abstract Object getParent(Object paramObject);

    public abstract CharSequence getText(Object paramObject);

    public abstract int getWindowId(Object paramObject);

    public abstract boolean isAccessibilityFocused(Object paramObject);

    public abstract boolean isCheckable(Object paramObject);

    public abstract boolean isChecked(Object paramObject);

    public abstract boolean isClickable(Object paramObject);

    public abstract boolean isEnabled(Object paramObject);

    public abstract boolean isFocusable(Object paramObject);

    public abstract boolean isFocused(Object paramObject);

    public abstract boolean isLongClickable(Object paramObject);

    public abstract boolean isPassword(Object paramObject);

    public abstract boolean isScrollable(Object paramObject);

    public abstract boolean isSelected(Object paramObject);

    public abstract boolean isVisibleToUser(Object paramObject);

    public abstract Object obtain();

    public abstract Object obtain(View paramView);

    public abstract Object obtain(View paramView, int paramInt);

    public abstract Object obtain(Object paramObject);

    public abstract boolean performAction(Object paramObject, int paramInt);

    public abstract boolean performAction(Object paramObject, int paramInt, Bundle paramBundle);

    public abstract void recycle(Object paramObject);

    public abstract void setAccessibilityFocused(Object paramObject, boolean paramBoolean);

    public abstract void setBoundsInParent(Object paramObject, Rect paramRect);

    public abstract void setBoundsInScreen(Object paramObject, Rect paramRect);

    public abstract void setCheckable(Object paramObject, boolean paramBoolean);

    public abstract void setChecked(Object paramObject, boolean paramBoolean);

    public abstract void setClassName(Object paramObject, CharSequence paramCharSequence);

    public abstract void setClickable(Object paramObject, boolean paramBoolean);

    public abstract void setContentDescription(Object paramObject, CharSequence paramCharSequence);

    public abstract void setEnabled(Object paramObject, boolean paramBoolean);

    public abstract void setFocusable(Object paramObject, boolean paramBoolean);

    public abstract void setFocused(Object paramObject, boolean paramBoolean);

    public abstract void setLongClickable(Object paramObject, boolean paramBoolean);

    public abstract void setMovementGranularities(Object paramObject, int paramInt);

    public abstract void setPackageName(Object paramObject, CharSequence paramCharSequence);

    public abstract void setParent(Object paramObject, View paramView);

    public abstract void setParent(Object paramObject, View paramView, int paramInt);

    public abstract void setPassword(Object paramObject, boolean paramBoolean);

    public abstract void setScrollable(Object paramObject, boolean paramBoolean);

    public abstract void setSelected(Object paramObject, boolean paramBoolean);

    public abstract void setSource(Object paramObject, View paramView);

    public abstract void setSource(Object paramObject, View paramView, int paramInt);

    public abstract void setText(Object paramObject, CharSequence paramCharSequence);

    public abstract void setVisibleToUser(Object paramObject, boolean paramBoolean);
  }
}