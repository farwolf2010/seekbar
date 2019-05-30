package com.farwolf.seekbar.component;

import android.content.Context;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.support.annotation.NonNull;
import android.widget.SeekBar;

import com.farwolf.weex.annotation.WeexComponent;
import com.taobao.weex.WXSDKInstance;
import com.taobao.weex.ui.action.BasicComponentData;
import com.taobao.weex.ui.component.WXComponent;
import com.taobao.weex.ui.component.WXComponentProp;
import com.taobao.weex.ui.component.WXVContainer;

import java.util.HashMap;

@WeexComponent(name="seekbar")
public class WXSeekBar extends WXComponent<SeekBar> {

    public WXSeekBar(WXSDKInstance instance, WXVContainer parent, BasicComponentData basicComponentData) {
        super(instance, parent, basicComponentData);
    }

    @Override
    protected SeekBar initComponentHostView(@NonNull Context context) {
        SeekBar seekBar=new SeekBar(context);
//        seekBar.setProgress();
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                HashMap m=new HashMap();
                m.put("value",i);
                if(i>0)
                WXSeekBar.this.fireEvent("change",m);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
                WXSeekBar.this.fireEvent("start",new HashMap<String, Object>());
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                WXSeekBar.this.fireEvent("stop",new HashMap<String, Object>());
            }
        });
        return seekBar;
    }

    public void setSeekBarColor(SeekBar seekBar, int color){
        LayerDrawable layerDrawable = (LayerDrawable)
                seekBar.getProgressDrawable();
        Drawable dra=layerDrawable.getDrawable(2);
        dra.setColorFilter(color, PorterDuff.Mode.SRC);
        Drawable dra2=seekBar.getThumb();
        seekBar.getThumb().setColorFilter(color, PorterDuff.Mode.SRC_ATOP);
        seekBar.invalidate();
    }

    @WXComponentProp(name = "color")
    public void setColor(String color){
        setSeekBarColor(getHostView(), Color.parseColor(color));
    }

    @WXComponentProp(name = "progress")
    public void setProgress(int progress){
        getHostView().setProgress(progress);
    }

    @WXComponentProp(name = "max")
    public void setMax(int max){
        getHostView().setMax(max);
    }

    @WXComponentProp(name = "min")
    public void setMin(int min){
        getHostView().setMin(min);
    }


}
