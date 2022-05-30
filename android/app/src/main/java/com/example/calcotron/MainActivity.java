package com.example.calcotron;

import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.flutter.java/parse";
    private Parser parser;
    private double xvalues=0;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("Parser")) {
                                try {
                                    parser=new Parser("x+3");
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                Node node=BinaryTree.root;
                                BinaryTree.value=xvalues;
                                double yvalues=BinaryTree.evaluate(node);
                                result.success("("+xvalues+"|"+yvalues+")");
//                                result.success("Hi from Java");
                            }
                        }
                );
    }
}
