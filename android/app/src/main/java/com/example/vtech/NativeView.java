package com.example.vtech;

import android.content.Context;
import android.content.pm.ActivityInfo;
import android.graphics.Color;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.TextView;
import android.view.WindowManager;
import android.widget.RelativeLayout;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.DefaultLifecycleObserver;

import com.tutk.IOTC.Camera;
import com.tutk.IOTC.MyCamera;
import com.tutk.IOTC.QRCodeDecoder;
import com.tutk.IOTC.monitor.VideoMonitor;
import com.tutk.IOTC.Camera;
import com.tutk.IOTC.MyCamera;

import io.flutter.plugin.platform.PlatformView;
import java.util.Map;
import java.util.Calendar;
import android.view.Gravity;

class NativeView implements PlatformView, DefaultLifecycleObserver, MyCamera.IMyCameraListener {
    private final String mUid = "M7Y9CUL71NS5Z6HZ111A";
    private final String mPwd = "5FBwz4j5";

    private static final int CAMERA_MAX_LIMITS = 10;
    private RelativeLayout myLayout;
    private VideoMonitor videoMonitor;
    private QRCodeDecoder qRCodeDecoder = new QRCodeDecoder();
    private MyCamera myCamera = null;
    private TextView textView;
    long loadingTime = 0;

    NativeView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        myLayout = new RelativeLayout(context);
        myLayout.setBackgroundColor(Color.BLACK);

        videoMonitor = new VideoMonitor(context);
        myLayout.addView(videoMonitor);

        textView = new TextView(context);
        textView.setTextSize(30);
        textView.setGravity(Gravity.BOTTOM);
    }

    private void init(){
        Log.i("message", "init camera");
        Camera.setMaxCameraLimit(CAMERA_MAX_LIMITS);
        MyCamera.init();
        loadingTime = Calendar.getInstance().getTimeInMillis();

        myCamera = new MyCamera("device", mUid, "admin", mPwd);
        myCamera.registerMyCameraListener(this);
        myCamera.connectCamera();
        myCamera.startShow(Camera.DEFAULT_AV_CHANNEL, false, true);
        myCamera.startListening(Camera.DEFAULT_AV_CHANNEL, true);
        videoMonitor.attachCamera(myCamera, Camera.DEFAULT_AV_CHANNEL);
    }

    @NonNull
    @Override
    public View getView() {
        if (myCamera == null) init();
        return myLayout;
    }

    @Override
    public void dispose() {
        Log.i("message", "native view disposed");
        if (myCamera != null) {
            myCamera.unregisterMyCameraListener(this);
            myCamera.stopSpeaking(Camera.DEFAULT_AV_CHANNEL);
            myCamera.stopListening(Camera.DEFAULT_AV_CHANNEL);
            myCamera.stopShow(Camera.DEFAULT_AV_CHANNEL);
            videoMonitor.deattachCamera();
            myCamera.disconnect();
        }

        MyCamera.uninit();
    }

    @Override
    public void cameraStateConnecting(Camera camera) {
        Log.i("message", "cameraStateConnecting");
    }

    @Override
    public void cameraStateConnected(Camera camera) {
        Log.i("message", "cameraStateConnected");
        videoMonitor.getLayoutParams().height = myLayout.getLayoutParams().width * 9 / 16;
        videoMonitor.requestLayout();

        loadingTime = Calendar.getInstance().getTimeInMillis() - loadingTime;
        textView.setText("Connected in " + String.valueOf(loadingTime / 1000.000) + "s");
        myLayout.addView(textView);
    }

    @Override
    public void cameraStateUnknownDevice(Camera camera) {
        Log.i("message", "cameraStateUnknownDevice");
    }

    @Override
    public void cameraStateConnectFailed(Camera camera) {
        Log.i("message", "cameraStateConnectFailed");
    }

    @Override
    public void cameraStateTimeout(Camera camera) {
        Log.i("message", "cameraStateTimeout");
    }

    @Override
    public void cameraStateWrongPassword(Camera camera) {
        Log.i("message", "cameraStateWrongPassword");
    }

    @Override
    public void cameraStateDisconnected(final Camera camera) {
        Log.i("message", "cameraStateDisconnected");
    }


}